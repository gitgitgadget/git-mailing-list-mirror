Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70891B86EC
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721422334; cv=none; b=TKnZe+1cqhBmNzjOzD/eaR6s422aaP6iH2ouxRJUhaAjYFv6VyPXmZflGcBCzUU2lJEUj8hk/neGvZ+uEbWugtMOkgxnpFbiIInCuidmE/4RmZMFNr61bXHIodNLgbvAJZmIyHUn9hILBJ/Y69FPG40iteYGktIfWkwjweAFC40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721422334; c=relaxed/simple;
	bh=CnisvNiyD3lCv8OFLqrDuUtwDs8h6Exrz4b9V/Vw1i4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GFxIt3i1dKfXAJ/kUXY6TwM3f/3wFA9AviHwGbe3xD56eZvOrx/PAb6JnUg3D4WbaJyzOcQhsVfOl0WvtVd9pMROuX847rYmUwAWEexXvhACcUAgoeHMBP76ZSNRiOhHsC71JuClnEUKkgimkXK+qoFNDuiI2rMEMSpEaWR5wwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hrct2VUb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hrct2VUb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7975B1A0E9;
	Fri, 19 Jul 2024 16:52:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CnisvNiyD3lCv8OFLqrDuUtwDs8h6Exrz4b9V/
	Vw1i4=; b=hrct2VUbnOIpYYDYSJ0hG2lRAmAZNemH9dWGkU2JndT/OHDw9JHFn4
	kRUPo3tFdvZee+ZQlsfH8BhY/5MghQFR14yd4s6due+0r3X5Tx4CprDTgFYCK9iM
	RxkGKej/ia62ymUS92B8ss15FxIRjCC8XLCZs5LEk/40OD7+9YYQw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 720CF1A0E8;
	Fri, 19 Jul 2024 16:52:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC2BD1A0E7;
	Fri, 19 Jul 2024 16:52:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,  Taylor Blau <me@ttaylorr.com>,
  Jeff King <peff@peff.net>
Subject: [PATCH 2/2] howto-maintain: update daily tasks
In-Reply-To: <xmqqikx1i024.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	19 Jul 2024 13:44:35 -0700")
References: <xmqqikx1i024.fsf@gitster.g>
Date: Fri, 19 Jul 2024 13:52:09 -0700
Message-ID: <xmqq1q3phzpi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C4E4D9D0-4610-11EF-B106-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Some "implementation details" of how I perform these integration
tasks day to day have changed since the document was originally
written.  Update to reflect the way things are currently done.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/howto/maintain-git.txt | 106 ++++++++++++++++-----------
 1 file changed, 63 insertions(+), 43 deletions(-)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 7219faf09f..41f54050f8 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -211,12 +211,12 @@ by doing the following:
    The initial round is done with:
 
      $ git checkout ai/topic ;# or "git checkout -b ai/topic master"
-     $ git am -sc3 mailbox
+     $ git am -sc3 --whitespace=warn mailbox
 
    and replacing an existing topic with subsequent round is done with:
 
      $ git checkout master...ai/topic ;# try to reapply to the same base
-     $ git am -sc3 mailbox
+     $ git am -sc3 --whitespace=warn mailbox
 
    to prepare the new round on a detached HEAD, and then
 
@@ -241,39 +241,59 @@ by doing the following:
    (trivial typofixes etc. are often squashed directly into the
    patches that need fixing, without being applied as a separate
    "SQUASH???" commit), so that they can be removed easily as needed.
+   The expectation is that the original author will make corrections
+   in a reroll.
 
+ - By now, new topic branches are created and existing topic
+   branches are updated.  The integration branches 'next', 'jch',
+   and 'seen' need to be updated to contain them.
 
- - Merge maint to master as needed:
+ - If there are topics that have been merged to 'master' and should
+   be merged to 'maint', merge them to 'maint', and update the
+   release notes to the next maintenance release.
 
-     $ git checkout master
-     $ git merge maint
-     $ make test
+ - Review the latest issue of "What's cooking" again.  Are topics
+   that have been sufficiently long in 'next' ready to be merged to
+   'master'?  Are topics we saw earlier and are in 'seen' now got
+   positive reviews and are ready to be merged to 'next'?
 
- - Merge master to next as needed:
+ - If there are topics that have been cooking in 'next' long enough
+   and should be merged to 'master', merge them to 'master', and
+   update the release notes to the next feature release.
 
-     $ git checkout next
-     $ git merge master
-     $ make test
+ - If there were patches directly made on 'maint', merge 'maint' to
+   'master'; make sure that the result is what you want.
 
- - Review the last issue of "What's cooking" again and see if topics
-   that are ready to be merged to 'next' are still in good shape
-   (e.g. has there any new issue identified on the list with the
-   series?)
+     $ git checkout master
+     $ git merge -m "Sync with 'maint'" --no-log maint
+     $ git log -p --first-parent ORIG_HEAD..
+     $ make test
 
- - Prepare 'jch' branch, which is used to represent somewhere
-   between 'master' and 'seen' and often is slightly ahead of 'next'.
+ - Prepare to update the 'jch' branch, which is used to represent
+   somewhere between 'master' and 'seen' and often is slightly ahead
+   of 'next', and the 'seen' branch, which is used to hold the rest.
 
      $ Meta/Reintegrate master..jch >Meta/redo-jch.sh
 
    The result is a script that lists topics to be merged in order to
-   rebuild 'seen' as the input to Meta/Reintegrate script.  Remove
-   later topics that should not be in 'jch' yet.  Add a line that
-   consists of '### match next' before the name of the first topic
-   in the output that should be in 'jch' but not in 'next' yet.
+   rebuild the current 'jch'.  Do the same for 'seen'.
+
+ - Review the Meta/redo-jch.sh and Meta/redo-seen.sh scripts.  The
+   former should have a line '### match next'---the idea is that
+   merging the topics listed before the line on top of 'master'
+   should result in a tree identical to that of 'next'.
 
- - Now we are ready to start merging topics to 'next'.  For each
-   branch whose tip is not merged to 'next', one of three things can
-   happen:
+ - As newly created topics are usually merged near the tip of
+   'seen', add them to the end of the Meta/redo-seen.sh script.
+   Among the topics that were in 'seen', there may be ones that
+   are not quite ready for 'next' but are getting there.  Move
+   them from Meta/redo-seen.sh to the end of Meta/redo-jch.sh.
+   The expectation is that you'd use 'jch' as your daily driver
+   as the first guinea pig, so you should choose carefully.
+
+ - Now we are ready to start rebuilding 'jch' and merging topics to
+   'next'.  For each branch whose tip is not merged to 'next', one
+   of three things can happen:
 
    - The commits are all next-worthy; merge the topic to next;
    - The new parts are of mixed quality, but earlier ones are
@@ -284,10 +304,12 @@ by doing the following:
    If a topic that was already in 'next' gained a patch, the script
    would list it as "ai/topic~1".  To include the new patch to the
    updated 'next', drop the "~1" part; to keep it excluded, do not
-   touch the line.  If a topic that was not in 'next' should be
-   merged to 'next', add it at the end of the list.  Then:
+   touch the line.
+
+   If a topic that was not in 'next' should be merged to 'next', add
+   it before the '### match next' line.  Then:
 
-     $ git checkout -B jch master
+     $ git checkout --detach master
      $ sh Meta/redo-jch.sh -c1
 
    to rebuild the 'jch' branch from scratch.  "-c1" tells the script
@@ -299,26 +321,29 @@ by doing the following:
    reference to the variable under its old name), in which case
    prepare an appropriate merge-fix first (see appendix), and
    rebuild the 'jch' branch from scratch, starting at the tip of
-   'master'.
+   'master', this time without using "-c1" to merge all topics.
 
-   Then do the same to 'next'
+   Then do the same to 'next'.
 
      $ git checkout next
      $ sh Meta/redo-jch.sh -c1 -e
 
    The "-e" option allows the merge message that comes from the
    history of the topic and the comments in the "What's cooking" to
-   be edited.  The resulting tree should match 'jch' as the same set
-   of topics are merged on 'master'; otherwise there is a mismerge.
-   Investigate why and do not proceed until the mismerge is found
-   and rectified.
+   be edited.  The resulting tree should match 'jch^{/^### match next'}'
+   as the same set of topics are merged on 'master'; otherwise there
+   is a mismerge. Investigate why and do not proceed until the mismerge
+   is found and rectified.
 
-     $ git diff jch next
+   If 'master' was updated before you started redoing 'next', then
 
-   Then build the rest of 'jch':
+     $ git diff 'jch^{/^### match next}' next
 
-     $ git checkout jch
-     $ sh Meta/redo-jch.sh
+   would show differences that went into 'master' (which 'jch' has,
+   but 'next' does not yet---often it is updates to the release
+   notes).  Merge 'master' back to 'next' if that is the case.
+
+     $ git merge -m "Sync with 'master'" --no-log master
 
    When all is well, clean up the redo-jch.sh script with
 
@@ -328,12 +353,7 @@ by doing the following:
    merged to 'master'.  This may lose '### match next' marker;
    add it again to the appropriate place when it happens.
 
- - Rebuild 'seen'.
-
-     $ Meta/Reintegrate jch..seen >Meta/redo-seen.sh
-
-   Edit the result by adding new topics that are not still in 'seen'
-   in the script.  Then
+ - Rebuild 'seen' on top of 'jch'.
 
      $ git checkout -B seen jch
      $ sh Meta/redo-seen.sh
@@ -344,7 +364,7 @@ by doing the following:
 
    Double check by running
 
-     $ git branch --no-merged seen
+     $ git branch --no-merged seen '??/*'
 
    to see there is no unexpected leftover topics.
 
-- 
2.46.0-rc1-48-g0900f1888e

