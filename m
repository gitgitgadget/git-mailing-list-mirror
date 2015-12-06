From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH/RFC 3/3] ls-files/dir: use is_git_repo to detect submodules
Date: Sun, 6 Dec 2015 17:59:26 +0100
Message-ID: <20151206165926.GI22288@inner.h.apk.li>
References: <1449252917-3877-1-git-send-email-a.krey@gmx.de> <1449252917-3877-3-git-send-email-a.krey@gmx.de> <20151205073744.GC21639@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 18:00:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5cfS-0001Xe-Uh
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 18:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbbLFQ7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 11:59:33 -0500
Received: from continuum.iocl.org ([217.140.74.2]:33049 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbbLFQ7c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 11:59:32 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tB6GxQH16331;
	Sun, 6 Dec 2015 17:59:26 +0100
Content-Disposition: inline
In-Reply-To: <20151205073744.GC21639@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282058>

On Sat, 05 Dec 2015 02:37:44 +0000, Jeff King wrote:
...
> Hrm. Weird. You'd think it would break with the existing code if I do
> this, then:
> 
...
> -		(cd a/b/c; git init) &&
> +		(cd a/b/c; git init && git commit --allow-empty -m foo) &&
>  		git config remote.origin.url ../foo/bar.git &&
>  		git submodule add ../bar/a/b/c ./a/b/c &&

I tried a -f here instead; did not work either.

I guess I will first wade through the other failures my 'fix'
causes to see the total damage.

...
> We know it is a git dir, but there is no sha1 for us to actually add as
> the gitlink entry.
> 
> If that is the case, then there is either some very tricky refactoring
> required,

Yes, it looks like the return code delivered need to be slightly different
dependent on the user.

> or what we are trying to do here is simply wrong. Maybe it
> would be simpler to just speed up resolve_gitlink_ref with a better data
> structure.

Which is what I did on square one, but now we already have a real fix
for git clean, and now it's even less advantageous the fix the consequence
(the submodule cache blowing up) instead of the cause (asking for it
in the first place).

I don't think we should let is_git_repository look for a valid(ish) HEAD.

Andreas

PS: I seem to not quite have send-email under control, the envelope from
    seems to made the patches not reach the mailing list (nor me in the CC).

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
