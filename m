Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48233C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CC222256
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcdXy0js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410304AbgJTWEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 18:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393572AbgJTWEz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 18:04:55 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CBCC0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 15:04:55 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id i39so131011qtb.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UDLWUKzqaDl8oVuTTUmAnUWHSdq4KI6bs093vuWnQnY=;
        b=XcdXy0jsEOJLaDtQXVyVePKFoS+/RJIskpdNhxuowM0EKj+X11FhEAmKMy09Ee04e9
         7mIk/Z4hCHcadC4RJiX9ae9kkAVd9Ud6YaXi80vw2kjrQQ+WiwWP/zDccqptXnJQ7GR5
         F5TVmEb65IBz2jplaBOGXIodWqs0k0f5YIFQ//T6F9YBumUQZgFeOHaRxUbgPdOfDR6Y
         hJEflO7toKNz2c2+3GIaN1GDxqh2F3dvHqSZtjEF20iSAwLSdE9puvHyL07JLHisq+Cz
         2+BKI/l5Ssw20ofLUGanwh4iv89mC4nbxeB8ErbvsusBgZeSmccAG5h6pXxGufZXqkZh
         6UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UDLWUKzqaDl8oVuTTUmAnUWHSdq4KI6bs093vuWnQnY=;
        b=d4wQ86vayTTrrkBph9Kbf9UzCY6mpOdYAd2bQZpMfIKuCmeOYfx/DbiFsMHTjfCbW+
         p0zXsE4a0i0LpIILDoYwI55LmJYvl4EOel0O5gZz24ESF6LlSVl0P2GS0dg01lEt0KhU
         hdv0dn0ivBPEEqJmxDYxFakibr/Kdz4BCYK7WLx6Pbomi7UUAEFJtTxCjuF6vNYcdgN5
         Ku8r5O6eFY0w2C5BDRyUTzrqMRpU+ui40D/ZxavHYhkrDoRWPy6McICc4l5keZ4f1W/T
         UCzRxNRMO1nyudIHF4sOG9nL49jxyQJVv/n2XS2N2XGs61ZhypzO3Uiq1PoS448bAruT
         HUEQ==
X-Gm-Message-State: AOAM531HTAmOnK5AXc4T1qriEoHcvFZ9v1o8hFDID48PyiiyfPSlVAMt
        gk7a5ol3YzR23KfA+qsVZf1H+Nvlg6WlEk1U1mqd0U188HCVvH7NITO91SN3X5QKnKmae1BQhjO
        YZxW8Vq2DcTF0uK9aGOqtmiBjsfzMG9x56YuO+YZ3Taf5nHnbQN6AAttpJ4wmnu70KS8W2kFBMn
        0G
X-Google-Smtp-Source: ABdhPJyMNRkk5fODCuPzevqBLmyYdIflkDfqTeS8xhXC8nUfMr7pdqSU1sr1KZ+3nIBidAqy0BdUikbCxxtTa9lwPWFi
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:48c6:: with SMTP id
 v6mr5713955qvx.11.1603231494655; Tue, 20 Oct 2020 15:04:54 -0700 (PDT)
Date:   Tue, 20 Oct 2020 15:04:52 -0700
In-Reply-To: <xmqqblgwa7s5.fsf@gitster.c.googlers.com>
Message-Id: <20201020220452.697760-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqblgwa7s5.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2] apply: when -R, also reverse list of sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A patch changing a symlink into a file is written with 2 sections (in
the code, represented as "struct patch"): firstly, the deletion of the
symlink, and secondly, the creation of the file. When applying that
patch with -R, the sections are reversed, so we get:

 (1) creation of a symlink, then
 (2) deletion of a file.

This causes an issue when the "deletion of a file" section is checked,
because Git observes that the so-called file is not a file but a
symlink, resulting in a "wrong type" error message.

What we want is:

 (1) deletion of a file, then
 (2) creation of a symlink.

In the code, this is reflected in the behavior of previous_patch() when
invoked from check_preimage() when the deletion is checked. Creation
then deletion means that when the deletion is checked, previous_patch()
returns the creation section, triggering a mode conflict resulting in
the "wrong type" error message. But deletion then creation means that
when the deletion is checked, previous_patch() returns NULL, so the
deletion mode is checked against lstat, which is what we want.

There are also other ways a patch can contain 2 sections referencing the
same file, for example, in 7a07841c0b ("git-apply: handle a patch that
touches the same path more than once better", 2008-06-27). "git apply
-R" fails in the same way, and this commit makes this case succeed.

Therefore, when building the list of sections, build them in reverse
order (by adding to the front of the list instead of the back) when -R
is passed.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
OK - updated the commit message and added a test for the use case Junio
described.
---
 apply.c                     | 9 +++++++--
 t/t4114-apply-typechange.sh | 7 +++++++
 t/t4127-apply-same-fn.sh    | 9 +++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 76dba93c97..359ceb632c 100644
--- a/apply.c
+++ b/apply.c
@@ -4699,8 +4699,13 @@ static int apply_patch(struct apply_state *state,
 			reverse_patches(patch);
 		if (use_patch(state, patch)) {
 			patch_stats(state, patch);
-			*listp = patch;
-			listp = &patch->next;
+			if (!list || !state->apply_in_reverse) {
+				*listp = patch;
+				listp = &patch->next;
+			} else {
+				patch->next = list;
+				list = patch;
+			}
 
 			if ((patch->new_name &&
 			     ends_with_path_components(patch->new_name,
diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
index ebadbc347f..da3e64f811 100755
--- a/t/t4114-apply-typechange.sh
+++ b/t/t4114-apply-typechange.sh
@@ -88,6 +88,13 @@ test_expect_success 'symlink becomes file' '
 	'
 test_debug 'cat patch'
 
+test_expect_success 'symlink becomes file, in reverse' '
+	git checkout -f foo-symlinked-to-bar &&
+	git diff-tree -p HEAD foo-back-to-file > patch &&
+	git checkout foo-back-to-file &&
+	git apply -R --index < patch
+	'
+
 test_expect_success 'binary file becomes symlink' '
 	git checkout -f foo-becomes-binary &&
 	git diff-tree -p --binary HEAD foo-symlinked-to-bar > patch &&
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index 972946c174..305b7e649e 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -32,6 +32,10 @@ test_expect_success 'apply same filename with independent changes' '
 
 test_expect_success 'apply same filename with overlapping changes' '
 	git reset --hard &&
+
+	# Store same_fn so that we can check apply -R in next test
+	cp same_fn same_fn1 &&
+
 	modify "s/^d/z/" same_fn &&
 	git diff > patch0 &&
 	git add same_fn &&
@@ -43,6 +47,11 @@ test_expect_success 'apply same filename with overlapping changes' '
 	test_cmp same_fn same_fn2
 '
 
+test_expect_success 'apply same filename with overlapping changes, in reverse' '
+	git apply -R patch0 &&
+	test_cmp same_fn same_fn1
+'
+
 test_expect_success 'apply same new filename after rename' '
 	git reset --hard &&
 	git mv same_fn new_fn &&
-- 
2.29.0.rc1.297.gfa9743e501-goog

