From: Jeff King <peff@peff.net>
Subject: Re: Addendum to "MaintNotes"
Date: Thu, 22 Nov 2007 06:08:39 -0500
Message-ID: <20071122110838.GC10389@sigill.intra.peff.net>
References: <46dff0320711210511g7d9febf5k47b082cc13bb905a@mail.gmail.com> <7vhcjf9l1k.fsf@gitster.siamese.dyndns.org> <20071122103600.GA10389@sigill.intra.peff.net> <7vve7u5zoz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ping Yin <pkufranky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:09:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9vZ-0003Yy-Sd
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbXKVLIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbXKVLIn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:08:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4139 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbXKVLIl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:08:41 -0500
Received: (qmail 22379 invoked by uid 111); 22 Nov 2007 11:08:39 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 06:08:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 06:08:39 -0500
Content-Disposition: inline
In-Reply-To: <7vve7u5zoz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65787>

On Thu, Nov 22, 2007 at 02:42:20AM -0800, Junio C Hamano wrote:

> Heh, thanks.  I am hoping somebody do grammartical copyediting
> and throw back a patch to add it in Documentation/howto.

I just read it over and that was the only error I noticed (though there
might be conceptual errors or confusing things that others could point
out better -- I actually knew a lot of this information already. At
least I'm one extra pair of eyes).

Patch is below. Besides the intro, the diff from your original is:

@@ -90,7 +99,7 @@ by doing the following:
 
    This step is done with "git am".
 
-     $ git checkout maint    ;# or "git checkout maint"
+     $ git checkout master    ;# or "git checkout maint"
      $ git am -3 -s mailbox
      $ make test
 
@@ -168,7 +177,8 @@ by doing the following:
  - Update "What's cooking" message to review the updates to
    existing topics, newly added topics and graduated topics.
 
-   This step is helped with Meta/UWC script.
+   This step is helped with Meta/UWC script (where Meta/ contains
+   a checkout of the 'todo' branch).
 
  - Merge topics to 'next'.  For each branch whose tip is not
    merged to 'next', one of three things can happen:

-- >8 --
From: Junio C Hamano <gitster@pobox.com>

Add "how to maintain git" document. Foreward by Jeff King.

---
diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
new file mode 100644
index 0000000..159a0a3
--- /dev/null
+++ b/Documentation/howto/maintain-git.txt
@@ -0,0 +1,278 @@
+How to maintain git
+===================
+
+Imagine that git development is racing along as usual, when our friendly
+neighborhood maintainer is struck down by a wayward bus. Out of the
+hordes of suckers^W loyal developers, you have been tricked^W chosen to
+step up as the new maintainer. This howto will show you "how to" do it.
+
+-- >8 --
+The maintainer's git time is spent on three activities.
+
+ - Communication (60%)
+
+   Mailing list discussions on general design, fielding user
+   questions, diagnosing bug reports; reviewing, commenting on,
+   suggesting alternatives to, and rejecting patches.
+
+ - Integration (30%)
+
+   Applying new patches from the contributors while spotting and
+   correcting minor mistakes, shuffling the integration and
+   testing branches, pushing the results out, cutting the
+   release, and making announcements.
+
+ - Own development (10%)
+
+   Scratching my own itch and sending proposed patch series out.
+
+The policy on Integration is informally mentioned in "A Note
+from the maintainer" message, which is periodically posted to
+this mailing list after each feature release is made.
+
+The policy.
+
+ - Feature releases are numbered as vX.Y.Z and are meant to
+   contain bugfixes and enhancements in any area, including
+   functionality, performance and usability, without regression.
+
+ - Maintenance releases are numbered as vX.Y.Z.W and are meant
+   to contain only bugfixes for the corresponding vX.Y.Z feature
+   release and earlier maintenance releases vX.Y.Z.V (V < W).
+
+ - 'master' branch is used to prepare for the next feature
+   release. In other words, at some point, the tip of 'master'
+   branch is tagged with vX.Y.Z.
+
+ - 'maint' branch is used to prepare for the next maintenance
+   release.  After the feature release vX.Y.Z is made, the tip
+   of 'maint' branch is set to that release, and bugfixes will
+   accumulate on the branch, and at some point, the tip of the
+   branch is tagged with vX.Y.Z.1, vX.Y.Z.2, and so on.
+
+ - 'next' branch is used to publish changes (both enhancements
+   and fixes) that (1) have worthwhile goal, (2) are in a fairly
+   good shape suitable for everyday use, (3) but have not yet
+   demonstrated to be regression free.  New changes are tested
+   in 'next' before merged to 'master'.
+
+ - 'pu' branch is used to publish other proposed changes that do
+   not yet pass the criteria set for 'next'.
+
+ - The tips of 'master', 'maint' and 'next' branches will always
+   fast forward, to allow people to build their own
+   customization on top of them.
+
+ - Usually 'master' contains all of 'maint', 'next' contains all
+   of 'master' and 'pu' contains all of 'next'.
+
+ - The tip of 'master' is meant to be more stable than any
+   tagged releases, and the users are encouraged to follow it.
+
+ - The 'next' branch is where new action takes place, and the
+   users are encouraged to test it so that regressions and bugs
+   are found before new topics are merged to 'master'.
+
+
+A typical git day for the maintainer implements the above policy
+by doing the following:
+
+ - Scan mailing list and #git channel log.  Respond with review
+   comments, suggestions etc.  Kibitz.  Collect potentially
+   usable patches from the mailing list.  Patches about a single
+   topic go to one mailbox (I read my mail in Gnus, and type
+   \C-o to save/append messages in files in mbox format).
+
+ - Review the patches in the saved mailboxes.  Edit proposed log
+   message for typofixes and clarifications, and add Acks
+   collected from the list.  Edit patch to incorporate "Oops,
+   that should have been like this" fixes from the discussion.
+
+ - Classify the collected patches and handle 'master' and
+   'maint' updates:
+
+   - Obviously correct fixes that pertain to the tip of 'maint'
+     are directly applied to 'maint'.
+
+   - Obviously correct fixes that pertain to the tip of 'master'
+     are directly applied to 'master'.
+
+   This step is done with "git am".
+
+     $ git checkout master    ;# or "git checkout maint"
+     $ git am -3 -s mailbox
+     $ make test
+
+ - Merge downwards (maint->master):
+
+     $ git checkout master
+     $ git merge maint
+     $ make test
+
+ - Review the last issue of "What's cooking" message, review the
+   topics scheduled for merging upwards (topic->master and
+   topic->maint), and merge.
+
+     $ git checkout master    ;# or "git checkout maint"
+     $ git merge ai/topic     ;# or "git merge ai/maint-topic"
+     $ git log -p ORIG_HEAD.. ;# final review
+     $ git diff ORIG_HEAD..   ;# final review
+     $ make test              ;# final review
+     $ git branch -d ai/topic ;# or "git branch -d ai/maint-topic"
+
+ - Merge downwards (maint->master) if needed:
+
+     $ git checkout master
+     $ git merge maint
+     $ make test
+
+ - Merge downwards (master->next) if needed:
+
+     $ git checkout next
+     $ git merge master
+     $ make test
+
+ - Handle the remaining patches:
+
+   - Anything unobvious that is applicable to 'master' (in other
+     words, does not depend on anything that is still in 'next'
+     and not in 'master') is applied to a new topic branch that
+     is forked from the tip of 'master'.  This includes both
+     enhancements and unobvious fixes to 'master'.  A topic
+     branch is named as ai/topic where "ai" is typically
+     author's initial and "topic" is a descriptive name of the
+     topic (in other words, "what's the series is about").
+
+   - An unobvious fix meant for 'maint' is applied to a new
+     topic branch that is forked from the tip of 'maint'.  The
+     topic is named as ai/maint-topic.
+
+   - Changes that pertain to an existing topic are applied to
+     the branch, but:
+
+     - obviously correct ones are applied first;
+
+     - questionable ones are discarded or applied to near the tip;
+
+   - Replacement patches to an existing topic are accepted only
+     for commits not in 'next'.
+
+   The above except the "replacement" are all done with:
+
+     $ git am -3 -s mailbox
+
+   while patch replacement is often done by:
+
+     $ git format-patch ai/topic~$n..ai/topic ;# export existing
+
+   then replace some parts with the new patch, and reapplying:
+
+     $ git reset --hard ai/topic~$n
+     $ git am -3 -s 000*.txt
+
+   The full test suite is always run for 'maint' and 'master'
+   after patch application; for topic branches the tests are run
+   as time permits.
+
+ - Update "What's cooking" message to review the updates to
+   existing topics, newly added topics and graduated topics.
+
+   This step is helped with Meta/UWC script (where Meta/ contains
+   a checkout of the 'todo' branch).
+
+ - Merge topics to 'next'.  For each branch whose tip is not
+   merged to 'next', one of three things can happen:
+
+   - The commits are all next-worthy; merge the topic to next:
+
+     $ git checkout next
+     $ git merge ai/topic     ;# or "git merge ai/maint-topic"
+     $ make test
+
+   - The new parts are of mixed quality, but earlier ones are
+     next-worthy; merge the early parts to next:
+
+     $ git checkout next
+     $ git merge ai/topic~2   ;# the tip two are dubious
+     $ make test
+
+   - Nothing is next-worthy; do not do anything.
+
+ - Rebase topics that do not have any commit in next yet.  This
+   step is optional but sometimes is worth doing when an old
+   series that is not in next can take advantage of low-level
+   framework change that is merged to 'master' already.
+
+     $ git rebase master ai/topic
+
+   This step is helped with Meta/git-topic.perl script to
+   identify which topic is rebaseable.  There also is a
+   pre-rebase hook to make sure that topics that are already in
+   'next' are not rebased beyond the merged commit.
+
+ - Rebuild "pu" to merge the tips of topics not in 'next'.
+
+     $ git checkout pu
+     $ git reset --hard next
+     $ git merge ai/topic     ;# repeat for all remaining topics
+     $ make test
+
+   This step is helped with Meta/PU script
+
+ - Push four integration branches to a private repository at
+   k.org and run "make test" on all of them.
+
+ - Push four integration branches to /pub/scm/git/git.git at
+   k.org.  This triggers its post-update hook which:
+
+    (1) runs "git pull" in $HOME/git-doc/ repository to pull
+        'master' just pushed out;
+
+    (2) runs "make doc" in $HOME/git-doc/, install the generated
+        documentation in staging areas, which are separate
+        repositories that have html and man branches checked
+        out.
+
+    (3) runs "git commit" in the staging areas, and run "git
+        push" back to /pub/scm/git/git.git/ to update the html
+        and man branches.
+
+    (4) installs generated documentation to /pub/software/scm/git/docs/
+        to be viewed from http://www.kernel.org/
+
+ - Fetch html and man branches back from k.org, and push four
+   integration branches and the two documentation branches to
+   repo.or.cz
+
+
+Some observations to be made.
+
+ * Each topic is tested individually, and also together with
+   other topics cooking in 'next'.  Until it matures, none part
+   of it is merged to 'master'.
+
+ * A topic already in 'next' can get fixes while still in
+   'next'.  Such a topic will have many merges to 'next' (in
+   other words, "git log --first-parent next" will show many
+   "Merge ai/topic to next" for the same topic.
+
+ * An unobvious fix for 'maint' is cooked in 'next' and then
+   merged to 'master' to make extra sure it is Ok and then
+   merged to 'maint'.
+
+ * Even when 'next' becomes empty (in other words, all topics
+   prove stable and are merged to 'master' and "git diff master
+   next" shows empty), it has tons of merge commits that will
+   never be in 'master'.
+
+ * In principle, "git log --first-parent master..next" should
+   show nothing but merges (in practice, there are fixup commits
+   and reverts that are not merges).
+
+ * Commits near the tip of a topic branch that are not in 'next'
+   are fair game to be discarded, replaced or rewritten.
+   Commits already merged to 'next' will not be.
+
+ * Being in the 'next' branch is not a guarantee for a topic to
+   be included in the next feature release.  Being in the
+   'master' branch typically is.
