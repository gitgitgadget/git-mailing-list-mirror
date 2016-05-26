From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] fetch: better alignment in ref summary
Date: Thu, 26 May 2016 01:18:21 -0400
Message-ID: <20160526051820.GE6756@sigill.intra.peff.net>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160522112019.26516-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 07:18:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5ngm-0000TI-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 07:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbcEZFSZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2016 01:18:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:44460 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750780AbcEZFSY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 01:18:24 -0400
Received: (qmail 7148 invoked by uid 102); 26 May 2016 05:18:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 01:18:24 -0400
Received: (qmail 17013 invoked by uid 107); 26 May 2016 05:18:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 01:18:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 01:18:21 -0400
Content-Disposition: inline
In-Reply-To: <20160522112019.26516-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295632>

On Sun, May 22, 2016 at 06:20:18PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> To make all "->" aligned, we may need to go through the ref list
> twice, or buffer the output and let column.c align it. Either way
> needs a lot more work than this.

I don't think a two-pass approach is _too_ bad. The trickiest thing is
that we handle the "prune" refs separately, even though they go in the
same status table.

However, I tried it, and the results looked much worse for my example
repo than yours. The problem is that I had one gigantic refname, and
that shoved the "->" and everything after far to the right, where they
wrapped to the next line.

Though the stair-stepping in your patch is funny, the output is easier
to read.

I do agree with Junio that we could probably improve the output quite a
bit by not showing each refname twice in the common case. I don't quite
find the "{ -> origin/}whatever" particularly pretty, but something lik=
e
that which keeps the variable bits at the end would make this problem
just go away.

> -#define REFCOL_WIDTH  10
> +static int REFCOL_WIDTH =3D 10;

This should probably go lower-case if it's not a preprocessor macro
anymore. I know it makes the diff a lot noisier, but I think it's worth
it.

-Peff
