From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH/Preview/PATCH] update "howto maintain git"
Date: Tue, 27 Nov 2012 15:41:07 -0800
Message-ID: <7v8v9mlilo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:41:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUmP-0002P6-90
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883Ab2K0XlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:41:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59626 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755856Ab2K0XlL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:41:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85C52A0F3;
	Tue, 27 Nov 2012 18:41:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=m
	YFiLQkKd84W0we0xVsv9y/ocow=; b=ke7lkY8Vohd+84ld8L/hkK4ZrY9W930f4
	uYJPLpz70PK/ZgB725akdQTfHGRBzl3QBeA+3EWFnXyztWkt/J0NzIaJDuoqgUVp
	1ZJAgtkOK27x+6KBe3lVdsu/EMBrhIc+kezBhdzJeH3SUpes8A5JgNM1qPBih5nC
	hcGDDxH5Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=v/Wjtd6l8QipOayNiYySvsw/erlGNCCL8WVC4/UiBMsVsGve4HmDsxeQ
	B83hTQjTdG7x/Z+ao6aOE+BmO0rcQDDmSd4pm/kLOsvgMqmV0p6uQstKZzKfXscn
	g7gwuv/Aa1Yy3SWqkAe+TV2gM02yn3GP898Q2zydrrcaTYTqwLc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72927A0F1;
	Tue, 27 Nov 2012 18:41:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D6B6A0ED; Tue, 27 Nov 2012
 18:41:09 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB73F1EC-38EB-11E2-9CFE-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210632>

This is still incomplete without a documentation for two scripts,
Meta/Reintegrate and Meta/cook (both are found on my 'todo' branch
and meant to be checked out in the Meta subdirectory of git.git),
that are meant to help the maintainer workflow but can be used by
interested parties, but the old write-up of the procedure has become
really stale and no longer reflects the reality.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It would help greatly if Peff can point out parts that he found
   too sketchy to be useful, and even better fill these parts
   himself, based on the recent "interim maintainer" experience.

 Documentation/howto/maintain-git.txt | 176 +++++++++++++++++++++--------------
 1 file changed, 106 insertions(+), 70 deletions(-)

diff --git c/Documentation/howto/maintain-git.txt w/Documentation/howto/maintain-git.txt
index ea6e4a5..a5713b4 100644
--- c/Documentation/howto/maintain-git.txt
+++ w/Documentation/howto/maintain-git.txt
@@ -12,20 +12,20 @@ How to maintain Git
 
 The maintainer's git time is spent on three activities.
 
- - Communication (60%)
+ - Communication (45%)
 
    Mailing list discussions on general design, fielding user
    questions, diagnosing bug reports; reviewing, commenting on,
    suggesting alternatives to, and rejecting patches.
 
- - Integration (30%)
+ - Integration (50%)
 
    Applying new patches from the contributors while spotting and
    correcting minor mistakes, shuffling the integration and
    testing branches, pushing the results out, cutting the
    releases, and making announcements.
 
- - Own development (10%)
+ - Own development (5%)
 
    Scratching my own itch and sending proposed patch series out.
 
@@ -39,6 +39,9 @@ The policy.
    contain bugfixes and enhancements in any area, including
    functionality, performance and usability, without regression.
 
+ - One release cycle for a feature release is expected to last for
+   eight to ten weeks.
+
  - Maintenance releases are numbered as vX.Y.Z.W and are meant
    to contain only bugfixes for the corresponding vX.Y.Z feature
    release and earlier maintenance releases vX.Y.Z.V (V < W).
@@ -62,12 +65,15 @@ The policy.
  - 'pu' branch is used to publish other proposed changes that do
    not yet pass the criteria set for 'next'.
 
- - The tips of 'master', 'maint' and 'next' branches will always
-   fast-forward, to allow people to build their own
-   customization on top of them.
+ - The tips of 'master' and 'maint' branches will not be rewound to
+   allow people to build their own customization on top of them.
+   Early in a new development cycle, 'next' is rewound to the tip of
+   'master' once, but otherwise it will not be rewound until the end
+   of the cycle.
 
- - Usually 'master' contains all of 'maint', 'next' contains all
-   of 'master' and 'pu' contains all of 'next'.
+ - Usually 'master' contains all of 'maint' and 'next' contains all
+   of 'master'.  'pu' contains all the topics merged to 'next', but
+   is rebuilt directly on 'master'.
 
  - The tip of 'master' is meant to be more stable than any
    tagged releases, and the users are encouraged to follow it.
@@ -80,11 +86,15 @@ The policy.
 A typical git day for the maintainer implements the above policy
 by doing the following:
 
- - Scan mailing list and #git channel log.  Respond with review
-   comments, suggestions etc.  Kibitz.  Collect potentially
-   usable patches from the mailing list.  Patches about a single
-   topic go to one mailbox (I read my mail in Gnus, and type
-   \C-o to save/append messages in files in mbox format).
+ - Scan mailing list.  Respond with review comments, suggestions
+   etc.  Kibitz.  Collect potentially usable patches from the
+   mailing list.  Patches about a single topic go to one mailbox (I
+   read my mail in Gnus, and type \C-o to save/append messages in
+   files in mbox format).
+
+ - Write his own patches to address issues raised on the list but
+   nobody has stepped up solving.  Send it out just like other
+   contributors do.
 
  - Review the patches in the saved mailboxes.  Edit proposed log
    message for typofixes and clarifications, and add Acks
@@ -100,28 +110,25 @@ by doing the following:
    - Obviously correct fixes that pertain to the tip of 'master'
      are directly applied to 'master'.
 
+   - Other topics are not handled in this step.
+
    This step is done with "git am".
 
      $ git checkout master    ;# or "git checkout maint"
      $ git am -3 -s mailbox
      $ make test
 
- - Merge downwards (maint->master):
-
-     $ git checkout master
-     $ git merge maint
-     $ make test
-
  - Review the last issue of "What's cooking" message, review the
    topics scheduled for merging upwards (topic->master and
-   topic->maint), and merge.
+   topic->maint), and merge.  Use "Meta/cook -w" script (see later)
+   to aid this step.
 
      $ git checkout master    ;# or "git checkout maint"
      $ git merge ai/topic     ;# or "git merge ai/maint-topic"
      $ git log -p ORIG_HEAD.. ;# final review
      $ git diff ORIG_HEAD..   ;# final review
      $ make test              ;# final review
-     $ git branch -d ai/topic ;# or "git branch -d ai/maint-topic"
+XXX  $ git branch -d ai/topic ;# or "git branch -d ai/maint-topic"
 
  - Merge downwards (maint->master) if needed:
 
@@ -142,9 +149,9 @@ by doing the following:
      and not in 'master') is applied to a new topic branch that
      is forked from the tip of 'master'.  This includes both
      enhancements and unobvious fixes to 'master'.  A topic
-     branch is named as ai/topic where "ai" is typically
-     author's initial and "topic" is a descriptive name of the
-     topic (in other words, "what's the series is about").
+     branch is named as ai/topic where "ai" is two-letter string
+     named after author's initial and "topic" is a descriptive name
+     of the topic (in other words, "what's the series is about").
 
    - An unobvious fix meant for 'maint' is applied to a new
      topic branch that is forked from the tip of 'maint'.  The
@@ -162,6 +169,7 @@ by doing the following:
 
    The above except the "replacement" are all done with:
 
+     $ git checkout ai/topic ;# or "git checkout -b ai/topic master"
      $ git am -3 -s mailbox
 
    while patch replacement is often done by:
@@ -170,6 +178,7 @@ by doing the following:
 
    then replace some parts with the new patch, and reapplying:
 
+     $ git checkout ai/topic
      $ git reset --hard ai/topic~$n
      $ git am -3 -s 000*.txt
 
@@ -177,80 +186,107 @@ by doing the following:
    after patch application; for topic branches the tests are run
    as time permits.
 
- - Update "What's cooking" message to review the updates to
-   existing topics, newly added topics and graduated topics.
+ - Review the last issue of "What's cooking" again and see if topics
+   that were scheduled to be merged to 'next' are still in good
+   shape (e.g. has there any new issue identified on the list with
+   the series?)
 
-   This step is helped with Meta/cook script (where Meta/ contains
-   a checkout of the 'todo' branch).
+ - Prepare 'jch' branch, which is used to represent somewhere
+   between 'master' and 'pu' and often mirrors 'next'.
+
+     $ Meta/Reintegrate master..pu >Meta/redo-jch.sh
+
+   The result is a script that lists topics to be merged in order to
+   rebuild 'pu' as the input to Meta/Reintegrate script.  Remove
+   later topics that should not be in 'next' yet.
 
  - Merge topics to 'next'.  For each branch whose tip is not
    merged to 'next', one of three things can happen:
 
-   - The commits are all next-worthy; merge the topic to next:
+   - The commits are all next-worthy; merge the topic to next;
+   - The new parts are of mixed quality, but earlier ones are
+     next-worthy; merge the early parts to next;
+   - Nothing is next-worthy; do not do anything.
 
-     $ git checkout next
-     $ git merge ai/topic     ;# or "git merge ai/maint-topic"
-     $ make test
+   This step is aided with Meta/redo-jch.sh script created earlier.
+   If a topic that was already in 'next' gained a patch, the script
+   would list it as "ai/topic~1".  To include the new patch to the
+   updated 'next', drop the "~1" part; to keep it excluded, do not
+   touch the line.  If a topic that was not in 'next' should be
+   merged to 'next', add it at the end of the list.  Then:
 
-   - The new parts are of mixed quality, but earlier ones are
-     next-worthy; merge the early parts to next:
+     $ git checkout -B jch master
+     $ sh Meta/redo-jch.sh
+
+   to rebuild the 'jch' branch from scratch.
+
+   Then merge the same to 'next'
 
      $ git checkout next
-     $ git merge ai/topic~2   ;# the tip two are dubious
-     $ make test
+     $ git merge master ;# may turn out to be "already up to date"
+     $ sh Meta/redo-jch.sh -e
 
-   - Nothing is next-worthy; do not do anything.
+   The "-e" option allows the merge message that comes from the
+   history of the topic and the comments in the "What's cooking" to
+   be edited.  The resulting tree should match 'jch' as the same set
+   of topics are merged on 'master'; otherwise there is a mismerge.
 
- - [** OBSOLETE **] Optionally rebase topics that do not have any commit
-   in next yet, when they can take advantage of low-level framework
-   change that is merged to 'master' already.
+     $ git diff jch next
 
-     $ git rebase master ai/topic
+   When all is well, clean up the redo-jch.sh script with
 
-   This step is helped with Meta/git-topic.perl script to
-   identify which topic is rebaseable.  There also is a
-   pre-rebase hook to make sure that topics that are already in
-   'next' are not rebased beyond the merged commit.
+     $ sh Meta/redo-jch.sh -u
 
- - [** OBSOLETE **] Rebuild "pu" to merge the tips of topics not in 'next'.
+   This removes topics listed in the script that have already been
+   merged to 'master'.
 
-     $ git checkout pu
-     $ git reset --hard next
-     $ git merge ai/topic     ;# repeat for all remaining topics
-     $ make test
+ - Rebuild 'pu'.
+
+     $ Meta/Reintegrate master..pu >Meta/redo-pu.sh
+
+   Edit the result by adding new topics that are not still in 'pu'
+   in the script.  Then
 
-   This step is helped with Meta/PU script
+     $ git checkout -B pu jch
+     $ sh Meta/redo-pu.sh
+
+   When all is well, clean up the redo-pu.sh script with
+
+     $ sh Meta/redo-pu.sh -u
+
+ - Update "What's cooking" message to review the updates to
+   existing topics, newly added topics and graduated topics.
+
+   This step is helped with Meta/cook script (where Meta/ contains
+   a checkout of the 'todo' branch).
 
- - Push four integration branches to a private repository at
-   k.org and run "make test" on all of them.
+     $ Meta/cook
 
- - Push four integration branches to /pub/scm/git/git.git at
-   k.org.  This triggers its post-update hook which:
+   Look for lines enclosed in "<<" and ">>"; they hold contents from
+   old file that are replaced by this integration round.  After
+   verifying them, remove the old part.  Review the description for
+   each topic and update its doneness and plan as needed.  To review
+   the updated plan, run
 
-    (1) runs "git pull" in $HOME/git-doc/ repository to pull
-        'master' just pushed out;
+     $ Meta/cook -w
 
-    (2) runs "make doc" in $HOME/git-doc/, install the generated
-        documentation in staging areas, which are separate
-        repositories that have html and man branches checked
-        out.
+   which will pick up comments given to the topics, such as "Will
+   merge to 'next'", etc. (see Meta/cook script to learn what kind
+   of phrases are supported).
 
-    (3) runs "git commit" in the staging areas, and run "git
-        push" back to /pub/scm/git/git.git/ to update the html
-        and man branches.
+ - Rebuild all four (five) integration branches; Meta/Dothem script
+   may aid this step.
 
-    (4) installs generated documentation to /pub/software/scm/git/docs/
-        to be viewed from http://www.kernel.org/
+ - Rebuild documentation if the 'master' branch was updated;
+   Meta/dodoc.sh script may aid this step.
 
- - Fetch html and man branches back from k.org, and push four
-   integration branches and the two documentation branches to
-   repo.or.cz and other mirrors.
+ - Push four integration branches to public places.
 
 
 Some observations to be made.
 
  * Each topic is tested individually, and also together with
-   other topics cooking in 'next'.  Until it matures, none part
+   other topics cooking in 'next'.  Until it matures, no part
    of it is merged to 'master'.
 
  * A topic already in 'next' can get fixes while still in
