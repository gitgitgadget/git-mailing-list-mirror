Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D401DC433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 20:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B146160249
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 20:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhJWUe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 16:34:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50295 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhJWUe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 16:34:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B447916185F;
        Sat, 23 Oct 2021 16:32:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BShXDUyYcfHAcQuPyvOk4ho3qK4EMm0z1aRQdW
        lmiSE=; b=VFI0LYb176ctqIbz0vWHYb1kH7FyM1ri0ykEp8quJKZJXXO7b+GMyG
        j6BDqen2o4FZ4fuBJ3H4Wbspzdwh77SjmfwCg1BzU+BSGG8Xz1gPWqMlW2LH3Y7I
        KtgQvlRNj6lgTyysLLLyTqh4WfXl723+Ax8iFpeSaGjtE9Tq3cjNE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE24E16185E;
        Sat, 23 Oct 2021 16:32:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1BD4B16185D;
        Sat, 23 Oct 2021 16:32:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: SubmittingPatchs: clarify choice of base and testing
References: <cover.1634787555.git.me@ttaylorr.com>
        <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
        <211021.86ee8emx57.gmgdl@evledraar.gmail.com>
        <xmqqpmrykys9.fsf@gitster.g> <xmqqilxncwpr.fsf@gitster.g>
Date:   Sat, 23 Oct 2021 13:32:31 -0700
In-Reply-To: <xmqqilxncwpr.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        23 Oct 2021 13:28:16 -0700")
Message-ID: <xmqqa6izcwio.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59D47F22-3440-11EC-8599-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We encourage identifying what, among many topics on `next`, exact
topics a new work depends on, instead of building directly on
`next`.  Let's clarify this in the documentation.

Developers should know what they are building on top of, and be
aware of which part of the system is currently being worked on.
Encouraging them to make trial merges to `next` and `seen`
themselves will incentivize them to read others' changes and
understand them, eventually helping the developers to coordinate
among themselves and reviewing each others' changes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This, being a guide for those who submit their work, stops short
   of telling them to send reviews on others' patch that interacts
   with their work, but reading and understanding others' work is
   both necessary to make their own work to play well together with
   other topics, and to start reviewing others' work.

 Documentation/SubmittingPatches | 50 ++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index e409022d93..2de8f80dc5 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -19,8 +19,11 @@ change is relevant to.
   base your work on the tip of the topic.
 
 * A new feature should be based on `master` in general. If the new
-  feature depends on a topic that is in `seen`, but not in `master`,
-  base your work on the tip of that topic.
+  feature depends on other topics that are in `next`, but not in
+  `master`, fork a branch from the tip of `master`, merge these topics
+  to the branch, and work on that branch.  You can remind yourself of
+  how you prepared the base with `git log --first-parent master..`
+  easily by doing so.
 
 * Corrections and enhancements to a topic not yet in `master` should
   be based on the tip of that topic. If the topic has not been merged
@@ -28,10 +31,10 @@ change is relevant to.
   into the series.
 
 * In the exceptional case that a new feature depends on several topics
-  not in `master`, start working on `next` or `seen` privately and send
-  out patches for discussion. Before the final merge, you may have to
-  wait until some of the dependent topics graduate to `master`, and
-  rebase your work.
+  not in `master`, start working on `next` or `seen` privately and
+  send out patches only for discussion. Once your new feature starts
+  to stabilize, you would have to rebase it (see the "depends on other
+  topics" above).
 
 * Some parts of the system have dedicated maintainers with their own
   repositories (see the section "Subsystems" below).  Changes to
@@ -71,8 +74,13 @@ Make sure that you have tests for the bug you are fixing.  See
 [[tests]]
 When adding a new feature, make sure that you have new tests to show
 the feature triggers the new behavior when it should, and to show the
-feature does not trigger when it shouldn't.  After any code change, make
-sure that the entire test suite passes.
+feature does not trigger when it shouldn't.  After any code change,
+make sure that the entire test suite passes.  When fixing a bug, make
+sure you have new tests that breaks if somebody else breaks what you
+fixed by accident to avoid regression.  Also, try merging your work to
+'next' and 'seen' and make sure the tests still pass; topics by others
+that are still in flight may have unexpected interactions with what
+you are trying to do in your topic.
 
 Pushing to a fork of https://github.com/git/git will use their CI
 integration to test your changes on Linux, Mac and Windows. See the
@@ -144,8 +152,21 @@ without external resources. Instead of giving a URL to a mailing list
 archive, summarize the relevant points of the discussion.
 
 [[commit-reference]]
-If you want to reference a previous commit in the history of a stable
-branch, use the format "abbreviated hash (subject, date)", like this:
+
+There are a few reasons why you may want to refer to another commit in
+the "more stable" part of the history (i.e. on branches like `maint`,
+`master`, and `next`):
+
+. A commit that introduced the root cause of a bug you are fixing.
+
+. A commit that introduced a feature that is what you are enhancing.
+
+. A commit that conflicts with your work when you made a trial merge
+  of your work into `next` and `seen` for testing.
+
+When you reference a commit on a more stable branch (like `master`,
+`maint` and `next`), use the format "abbreviated hash (subject,
+date)", like this:
 
 ....
 	Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
@@ -260,8 +281,8 @@ or include any extra files which do not relate to what your patch
 is trying to achieve. Make sure to review
 your patch after generating it, to ensure accuracy.  Before
 sending out, please make sure it cleanly applies to the `master`
-branch head.  If you are preparing a work based on "next" branch,
-that is fine, but please mark it as such.
+branch head.  If you are preparing a work based on selected topics
+merged to `master`, please mark your patch as such.
 
 [[send-patches]]
 === Sending your patches.
@@ -365,7 +386,10 @@ Security mailing list{security-ml-ref}.
 Send your patch with "To:" set to the mailing list, with "cc:" listing
 people who are involved in the area you are touching (the `git
 contacts` command in `contrib/contacts/` can help to
-identify them), to solicit comments and reviews.
+identify them), to solicit comments and reviews.  Also, when you made
+trial merges of your topic to `next` and `seen`, you may have noticed
+work by others conflicting with your changes.  There is a good possibility
+that these people may know the area you are touching well.
 
 :current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
 :git-ml: footnote:[The mailing list: git@vger.kernel.org]
