From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] RFC: blame,cat-file --textconv: Don't assume mode
 is ``S_IFREF | 0664''
Date: Mon, 20 Sep 2010 14:21:28 -0400
Message-ID: <20100920182128.GB1790@sigill.intra.peff.net>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
 <7ab60e32582447ad792602ff405dcee464ef1414.1284830388.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Mon Sep 20 20:22:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxl0C-0008F5-F4
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 20:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071Ab0ITSVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 14:21:30 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45766 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757062Ab0ITSV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 14:21:29 -0400
Received: (qmail 26887 invoked by uid 111); 20 Sep 2010 18:21:29 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 20 Sep 2010 18:21:29 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Sep 2010 14:21:28 -0400
Content-Disposition: inline
In-Reply-To: <7ab60e32582447ad792602ff405dcee464ef1414.1284830388.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156647>

On Sat, Sep 18, 2010 at 09:25:06PM +0400, Kirill Smelkov wrote:

> Instead get the mode from either worktree, index, .git, or origin
> entries when blaming and pass it to textconv_object() as context.
> 
> The reason to do it is not to run textconv filters on symlinks.

I think this is absolutely a bug, and your solution is definitely in the
right direction. We obviously can't just ignore the mode when deciding
whether to textconv. I suspect there is similar breakage for S_IFGITLINK
files, though they are perhaps less likely in practice to match another
filetype's extension.

So all three patches look sane to me, with the caveat that I also don't
know the blame code very well.

I agree with Matthieu's points on cleaning up the commit messages, and
there is a small comment typo in this third patch:

> @@ -313,21 +315,23 @@ static struct origin *get_origin(struct scoreboard *sb,
>   * for an origin is also used to pass the blame for the entire file to
>   * the parent to detect the case where a child's blob is identical to
>   * that of its parent's.
> + *
> + * This also fills origin->mode for correspoinding tree path.

Typo: s/poind/pond

-Peff
