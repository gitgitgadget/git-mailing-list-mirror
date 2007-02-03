From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Sat, 3 Feb 2007 22:46:19 +0100
Message-ID: <20070203214619.GM5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth> <20070201234805.3313.20525.stgit@gandelf.nowhere.earth> <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com> <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net> <20070202224250.GF5362@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0702021501g2cb9bb6cocae0d706c8742868@mail.gmail.com> <b0943d9e0702021525o2379883aqaf27f874134668c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 22:47:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDSjQ-0004AE-DL
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 22:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbXBCVrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 16:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbXBCVrW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 16:47:22 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:56131 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbXBCVrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 16:47:15 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9D802AA7;
	Sat,  3 Feb 2007 22:47:14 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id AD3571F080; Sat,  3 Feb 2007 22:46:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0702021525o2379883aqaf27f874134668c5@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38611>

On Fri, Feb 02, 2007 at 11:25:28PM +0000, Catalin Marinas wrote:
> OK, tried again and 'stg pull' doesn't update the base with the last
> patch in the series ('stg rebase origin' updates it). I don't have
> anything set up in my gitconfig in this area.

So now that this particular problem has a fix, let's fix everything
related.

Since branch.*.merge accept local ref names, there is probably far
more to change that what I initially feared.

1. I guess we can continue to store local refs for those branches when
they mirror a remote one, but if we store something there without
storing a branch.*.remote to '.', git-fetch could confuse this local
ref with a ref from remote 'origin', since that's still the default.

2. branch.*.merge is not where we should read a parent branch from.
Even if we store that info there, the user could have put a remote ref
name there.  So if we want to keep a get_parent_branch() method we'll
have to store that info somewhere else, eg. branch.*.stgit.parentbranch.

3. we need get_parent_branch() to implement parent branch as default
arg to "stg rebase"

So (please correct me if necessary):

- always store local parent branch to branch.*.stgit.parentbranch
- never set branch.*.merge without setting branch.*.remote
- set them, with remote as '.' when dealing with local branch

Best regards,
-- 
Yann.
