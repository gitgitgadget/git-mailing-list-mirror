From: Yann Dirson <ydirson@altern.org>
Subject: Use of "stg sync"
Date: Sun, 4 Feb 2007 15:42:33 +0100
Message-ID: <20070204144233.GP5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 15:43:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDiaf-00040t-QE
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 15:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbXBDOnc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 09:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbXBDOnc
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 09:43:32 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:49469 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbXBDOnb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 09:43:31 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 941A5279DC;
	Sun,  4 Feb 2007 15:43:30 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id C4E381F080; Sun,  4 Feb 2007 15:42:33 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38692>

Hi,

In the context of Debian packaging, I have a tree with an "upstream"
branch, and 2 stgit stack, one for maintainance ("etch") and one for
the next Debian version ("lenny").  I maintain them as stgit stacks to
be able to easily port changes to new upstream releases, and tag
debian revisions on the stack heads - so the ancestry of a revision to
the previous can only be tracked through stgit patch logs.

The recent history of those stack is a bit tricky, and that may not
help here: there was originally a single "debian" stack, and I had
already done some unreleased work in existing patches, when the need
for a bugfix release appeared.  So I cloned the "main" branch, and
reproduced the previous release by deleting the only patch that had
moved since the last release, and picking it from the relevant commit.

Then to make things more interresting I imported a new release on
"upstream", and rebased stack "lenny" onto this new release.

Then I wanted to integrate the bugfix from "etch" into "lenny".  So I
just tried to use "stg sync" on this patch.  It should be noted that
this particular patch is the one that adds the Debian packaging files
(as opposed to the other ones, which modify the upstream source
files).

Here is what I get.  I suppose that could have been expected, but that
looks nevertheless annoying...

tau-git$ stg sync -b etch debian
Checking for changes in the working directory... done
Synchronising "debian"...Error: File "debian/tau.files" added in branches but different
Error: File "debian/tau-racy.files" added in branches but different
Error: File "debian/rules" added in branches but different
Error: File "debian/changelog" added in branches but different
stg sync: GIT index merging failed (possible conflicts)

Traceback (most recent call last):
  File "/export/work/yann/git/stgit/stg", line 43, in ?
    main()
  File "/export/work/yann/git/stgit/stgit/main.py", line 268, in main
    command.func(parser, options, args)
  File "/export/work/yann/git/stgit/stgit/commands/sync.py", line 163, in func
    merge_patch(patch, p)
  File "/export/work/yann/git/stgit/stgit/commands/sync.py", line 96, in <lambda>
    merge_patch = lambda patch, pname: \
  File "/export/work/yann/git/stgit/stgit/commands/sync.py", line 58, in __branch_merge_patch
    git.merge(patch.get_bottom(), git.get_head(), patch.get_top())
  File "/export/work/yann/git/stgit/stgit/git.py", line 664, in merge
    raise GitException, 'GIT index merging failed (possible conflicts)'
stgit.git.GitException: GIT index merging failed (possible conflicts)

best regards,
-- 
Yann.
