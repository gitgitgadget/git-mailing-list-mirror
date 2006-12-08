X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Collection of stgit issues and wishes
Date: Fri, 8 Dec 2006 23:17:44 +0100
Message-ID: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 22:19:18 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33760>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gso3i-0005t3-2D for gcvg-git@gmane.org; Fri, 08 Dec
 2006 23:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947444AbWLHWTH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 17:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947447AbWLHWTG
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 17:19:06 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:59756 "EHLO
 smtp2-g19.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1947444AbWLHWTE (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 17:19:04 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp2-g19.free.fr (Postfix) with ESMTP id D80117CEC; Fri,
  8 Dec 2006 23:19:00 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id E138F2010;
 Fri,  8 Dec 2006 23:17:44 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Here is the remaining of my queue of stgit issues and ideas noted
in the last months.  A number of items in the "wishlist" section is
really here to spawn discussion.  Maybe some of them should end up
in the TODO list.

bugs:

- "show" still shows previous patch, after pushing resulted in empty patch
(after solving conflict, when "refresh" then has nothing to do)
- "stg import" leaves empty patch on the stack after failed patch application
- "push --undo" should restore series order
- "import --strip" is too eager (eg. eats numeric prefix when we only
want to strip a .diff suffix).  Probably better symetry with export
flags would be useful.
- "push" fails with "Unknown patch name:" when asked to push a patch
already applied
- "stg fold" usage does not tell what <file> is used for
- "patches -d" may be confused by files added then removed (below,
file added to platform-v0, removed in rm-junk, problem encountered on
2006-08-14, probably on 0.10):
|$ stg patches include/linux/mtd/nand.h.old
|platform-v0
|ieee-lct-bouton
|rm-junk
|$ stg patches include/linux/mtd/nand.h.old -d
|-------------------------------------------------------------------------------
|platform-v0
|-------------------------------------------------------------------------------
|Kernel for V0 platform
|---
|
|stg patches: ['git-diff-tree', '-p',
|'7a9c28b56f5f210e11632388ffb554ae2cb04492',
|'a8e874d6090bc6274cadcff64faf7cff151b9b5c', 'include/linux/mtd/nand.h.old']
|failed (fatal: ambiguous argument 'include/linux/mtd/nand.h.old': unknown
|revision or path not in the working tree.
|Use '--' to separate paths from revisions)

usability problems:

- "refresh" should display .git/conflicts if any ?
- patches/*/*.log branches could be better named as patchlogs/*/*
(easier to filter reliably)
- "stg show" should catch inexistant patch instead of saying "Unknown
revision: that-patch^{commit}"
- "clean" should give enough info for the user to locate any problem
(eg. conflict with files removed from revision control), eg. with a
"popping to ..." message
- "stg fold" should allow to pass -C<n> to git-apply: context mismatch
currently makes folding unnecessarily hard
|$ stg show d-lessdebug | filterdiff -#3 | stg fold
|Folding patch from stdin...stg fold: Patch does not apply cleanly
|$ stg show d-lessdebug | filterdiff -#3 | patch -p1
|patching file drivers/ieee1394/gp2lynx.c
|Hunk #1 succeeded at 2074 with fuzz 2 (offset -96 lines).
- "stg pick patch@branch" needs non-intuitive "stg push --undo" to cancel :
add "stg pick --undo ?"
- "stg pick --fold" needs even less-intuitive "stg push --undo && stg
push" or "stg status --reset"


wishlist and wild ideas:

- lacks syntax for "(n) patches before/after X"
- "stg goto <current>" causes IndexError exception
- needs series logging in addition to patch logging
- "stg pull --undo" to move the stack base back to previous place
(esp. useful after "push" detected a conflict we don't want to handle
right now)
- single-arg "stg rename" to rename current patch ?
- lacks undo for "pick --fold"
- "sink" or "burry" as opposite to "float" (possibly with a target
patch)
- lacks "pick --patch=XXX" to pick by name
- "stg clean" could take a list of patches, to allow being used in scripts
- "stg fold" lacks --reverse
- interactive merge tools could only be called automatically after
failed merge, instead of requiring not-so-intuitive "resolved -i"
- needs a config example to call ediff via gnuserv (possibly sending
several merges at a time, making use of the session registry)
- shortcuts (st -> status, etc.), possibly making use of the git alias
system ?
- "stg fold" should allow to run a merge (insert conflict markers, or
even just output a .rej patch somewhere)
- support for atomicity of complex transactions (stg begin/snapshot,
rollback, commit/finish - possibly with a transaction name so nesting would
just work)
- support for pure patch reordering when a move causes conflicts.
Maybe a way to start a transaction while declaring the patch range
which has to be reordered, ensuring that finalising the transaction
would end with the desired tree state unchanged.
- mark patches as deactivated (float above all unapplied ones), so
even "push -a" would not push them
- "stg diff" should allow to use diff flags like -w or -b (GIT_DIFF_OPTS
does not work)
