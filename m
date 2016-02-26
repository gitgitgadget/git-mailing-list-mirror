From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git clone does not respect command line options
Date: Fri, 26 Feb 2016 02:59:48 -0500
Message-ID: <20160226075948.GA26994@sigill.intra.peff.net>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
 <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
 <20160226073444.GA26340@sigill.intra.peff.net>
 <CAMDzUty5oWjS=4kvvYL7XNCY=xHm3N=+kaeT_zTtpkaMakMrmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 08:59:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZDJb-0002vb-7u
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 08:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbcBZH7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 02:59:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:49876 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752160AbcBZH7v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 02:59:51 -0500
Received: (qmail 27493 invoked by uid 102); 26 Feb 2016 07:59:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 02:59:51 -0500
Received: (qmail 32511 invoked by uid 107); 26 Feb 2016 08:00:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 03:00:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 02:59:48 -0500
Content-Disposition: inline
In-Reply-To: <CAMDzUty5oWjS=4kvvYL7XNCY=xHm3N=+kaeT_zTtpkaMakMrmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287545>

On Fri, Feb 26, 2016 at 01:16:39PM +0530, Guilherme wrote:

> Is there any documentation on which variables are muli-valued?

There's no central registry. It's often mentioned in the documentation
for a particular config option, but it looks like the credential.*
config is not very clear about this.

There aren't very many of them. I think credential.* is one set. The
remote.*.fetch/push refspecs are another. I don't think there are any
others used by git itself, but I may just be forgetting them.

> git -c credential.helper="store --file=creds" config --get credential.helper
> 
> only returns one value.
> 
> How can i even know if there are multiple set. I mean someone might
> have just created an extra credential.helper in `--system` that I'm
> not expecting...

Right. The "git-config" program doesn't know about the semantics of
particular values (remember that in the early days, there were many
porcelains which built on top of git, and they could all store their own
config). Using "--get" implements "last one wins" semantics, which
is what most config variables want. You can use "--get-all" to see all
instances of a multi-valued variable.

The usability on all of this is obviously pretty horrible, but it's hard
to change at this point without breaking backwards compatibility.

-Peff
