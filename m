From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Sat, 8 Jan 2011 21:43:57 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101081902150.12031@debian>
References: <20110107104650.GA5399@pengutronix.de> <20110107194909.GB6175@sigill.intra.peff.net> <alpine.DEB.1.10.1101081449220.12031@debian> <20110108214011.GA4753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 09 03:44:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PblGK-0006if-Et
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 03:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab1AICoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 21:44:01 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61927 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1AICoA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 21:44:00 -0500
Received: by qwa26 with SMTP id 26so18854168qwa.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 18:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=u1Lll2TQTXJhWOIbVVkmaip9wenHDKoVHbQBxB5B0p8=;
        b=OUBBvxNEUE9qTLECbeZjgaTmkb5Sb8InSVq5eim5Brck6b2Q6/rg2FVcQd9tiHr21m
         rEJyPIGpKQduxyAGLplleDDXg3HNfo4OAjYdEbCGTGGJIFPgIy2xbI98gLUKp4+NSlpB
         2UOY1uSYnBufuDV5bFfWxRDqQKdnm0P0mRgq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=gNAycIitnrtYX5MMFRr4Gd8FXxBUKd5nVDLsTLKukGoG5UiyZSBCdzxA/RvhAqhPJ6
         kbz/sxuN0876WaehFAuAYBhnH8G0TGIGFTWiK59Kc/Yz0Qkr26gkwSPdKM690tX7xWpj
         rjI3nfE7QGpzgFs1+ILCP1n7GUrGsMZL409c4=
Received: by 10.224.11.71 with SMTP id s7mr26314800qas.13.1294541039929;
        Sat, 08 Jan 2011 18:43:59 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id p13sm16363411qcu.41.2011.01.08.18.43.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Jan 2011 18:43:59 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <20110108214011.GA4753@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164842>

On Sat, 8 Jan 2011, Jeff King wrote:

> On Sat, Jan 08, 2011 at 03:40:33PM -0500, Martin von Zweigbergk wrote:
> 
> > > Yeah, we generally resolve ambiguities in favor of the tag (and that
> > > warning comes from deep within get_sha1_basic). So the real bug here is
> > > that it still said "Switched to branch", which is totally wrong.
> > > 
> > > That being said, it probably would make more sense for "git checkout" to
> > > prefer branches to tags.
> > 
> > What was the rationale for generally favoring tags?
> 
> I don't recall hearing any specific argument, but it has always been
> that way from early on. I think it is from a vague sense of "tags are
> more important than branch tips because they are about marking specific
> points, not lines of development". But maybe other old-timers can say
> more.
> 
> I don't necessarily buy that argument; my only reasoning is that we
> should probably keep historic behavior.
> 
> > Why does that reasoning not apply to 'git checkout' too?
> 
> Because checkout has always been fundamentally about branches. It did
> end up growing sane behavior for "git checkout tag" (i.e., a detached
> HEAD), but branches are still the fundamental unit for most of its
> arguments.

I had a look at the history of the lines Junio mentioned in another
message on this thread (lookup_commit_reference_gently() and
setup_branch_path()). I don't understand the code, but just looking at
where the lines came from, they seem to have been there ever since
782c2d6 (Build in checkout, 2008-02-07). If that is correct (but
please check for yourselves), it seems like the broken checkout of
ambiguous references causes problems rarely enough that no one has
bothered to report it for almost two years. If it has been broken for
that long, it seems to me like we could resolve it whichever way makes
most sense, without much concern to how it used to work, no?

> > Btw, what exactly does "generally" mean, i.e. which other commands
> > don't favor tags? I know rebase is one example of a command that does
> > not favor tags.
> 
> It means "we favor tags in resolve_ref, which is the underlying
> machinery for most commands, so unless a command special-cases it, that
> will be the behavior, and I am too lazy to exhaustively search for such
> special cases".

Sensible definition :-). I was just hoping for an example where it
more obviously makes sense to favor branches. Maybe rebase is actually
one of the better examples.

> > The reason I'm asking is because I just happened to see in the rebase
> > code the other day that it will rebase a detached head if the <branch>
> > parameter is not "completely unqualified". For example 'git rebase
> > master heads/topic' or 'git rebase master refs/heads/topic' will not
> > update refs/heads/topic. I was trying to fix that by using 'git
> > rev-parse --symbolic-full-name' to parse <branch>. That seemed to work
> > fine until I saw this thread :-).
> 
> Heh. I think that would be an argument in favor of changing rev-parse's
> behavior.

I was hoping to do something like

head_name=$(git rev-parse --symbolic-full-name -q --verify "$1")
case "$head_name" in
refs/heads/*) ;;
*) head_name="detached HEAD" ;;
esac

plus setting another variable or two in each case. So even if 'git
rev-parse --symbolic-full-name' would return refs/tags/$name, it
wouldn't actually help here, since rebase currently favors
branches. In order to keep that behavior, I will need to add an extra
check before the above code.

It still feels like rev-parse should return refs/tags/$name, though.
