From: James Pickens <jepicken@gmail.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD 
	was
Date: Sat, 17 Oct 2009 10:07:58 -0700
Message-ID: <885649360910171007p1115b4afq11d1755a2a46be4a@mail.gmail.com>
References: <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
	 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
	 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
	 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
	 <20091016143041.GA11821@atjola.homenet>
	 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
	 <20091017075551.GA5474@atjola.homenet>
	 <7vws2ue8yc.fsf@alter.siamese.dyndns.org>
	 <20091017084025.GC5474@atjola.homenet>
	 <7vaazqcry5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 19:08:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzClC-0003Hg-5l
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 19:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbZJQRHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 13:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752867AbZJQRHz
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 13:07:55 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:49708 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbZJQRHy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 13:07:54 -0400
Received: by gxk8 with SMTP id 8so3357421gxk.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2009 10:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zF2Bd8Z0Ffwuec8qkv4WDwYMKNW7vR+xk395olKeFbc=;
        b=C8e0C36Fb/povTK2nI3Rphk+re/2PCeF3Ge+BJFTYIrRBDDCuHoYqYxVvSwT8+QjGw
         shXKSJAfz9PUvfR9N+Wo+he2xrqSVPJwFpaSzqU8GvTQ+sTO4zXB9bnlNSgi5UntpYsd
         nZLS7ieyzwIzF6uT9Nqzn3wWuvM8TOPYCnXx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=H01V8cSFt7GKxBUsDMLZEQJOutuppSP6BK1ZU1HseXIdiRmP98+jU/bIomWMx8p3nr
         HTyiWRLMiR/BzbWY9V3c5tAsNOfYtIcGFvOhCCyTszNMCFiRUwBrzD6sy1fZfqKOf2Wa
         zbhUJGWiwhHUHfs97trv54DfFcMfyVb4BCWCM=
Received: by 10.101.95.6 with SMTP id x6mr2874586anl.108.1255799278603; Sat, 
	17 Oct 2009 10:07:58 -0700 (PDT)
In-Reply-To: <7vaazqcry5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130567>

On Sat, Oct 17, 2009, Junio C Hamano <gitster@pobox.com> wrote:
> As I already said many times (here and elsewhere), "up" is an inferior and
> more dangerous model we would be better off not following if we can.

I agree that the "up" model is inferior, but I have to say, "up" is one of the
most common things my users ask about.  It is very common for users to have some
work in progress that they aren't ready to commit, and they want to get up to
date with the latest code from the central repository.  Most of the time, they
haven't modified any files that have also been modified upstream, so all they
need is "git pull".  But once in a while, they will have modified the same file,
and the pull will be rejected, and they don't know what to do.

These are not sophisticated users, so telling them to commit first, then pull,
and rebase later on to clean up the history (since the work they committed
wasn't finished) is no good.  They don't care to preserve their exact state and
just want to get up to date with the central repo.

If they ask me what to do, I tell them that if they're ready to commit, do so,
otherwise use 'git stash; git pull; git stash pop'.  To a typical user, this
looks like Git is inferior since it requires 3 commands to do what only takes 1
command in CVS/SVN.  One of my users didn't ask, and I later found out that he
had been doing this:

$ git pull ;# rejected due to modifications in file1
$ mv file1 file1.bak
$ git checkout HEAD file1
$ git pull ;# rejected due to modifications in file2
$ mv file2 file2.bak
$ git checkout HEAD file2
$ git pull ;# ok
<manually merge file1.bak with file1>
<manually merge file2.bak with file2>

So I think an "scm up" like command is not an unreasonable thing to want.  There
is a valid, and fairly common, use case.  There are ways to get the same result
in Git, but they're cumbersome compared to just typing "scm up".  It shouldn't
be the default, but I think a lot of users would appreciate having it.

James
