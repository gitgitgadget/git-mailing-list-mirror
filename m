Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46823C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5460207D8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOrxU6pN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgI1VUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgI1VUo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:20:44 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDC9C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:20:43 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 8so1878648pfx.6
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ArRG74YVlAnE8+mGrVb+N7gv1oQbiw/tz2JYzB4bPJg=;
        b=KOrxU6pND4CDHjqYqffuXTAZHA2ioJiigMiF+lxGws2y2x76eR28ixRrMwho0RXcgC
         Peg5fGVhce2YOFlyBX7AkC02rGjwl6gyrkZITfl6O+g+loHMq0OQUguCLXJ18nYDWrWl
         QQU8qnR+tmZz5hdDVeEa5RAQmia99HJzQGUKgz5+JOOUv6+bsN+DF18hEpwpGmDtKAUU
         hsA7VJU+aBzq+XBZs1BAJIatv4j+9DxVnXMeYZz6J4Z6K6OzVDrPAigp6OxJ83vTQiWj
         Q5zDn1cJ06KbQE9R7mTq3lMnT36E/CY1RBJwhKPM4/dXnxYB8UPVg21KjQjIdpp0hm15
         Qjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ArRG74YVlAnE8+mGrVb+N7gv1oQbiw/tz2JYzB4bPJg=;
        b=TXovAw869x9GlIn6CWkP9sUs++09LEa7/xPXtO1cgA5NziecQ8ufkDlogOSG673eqP
         XVtQORGN2OXAOq8SF3zK8xdYito5VI7F3I/+11ufaV6Yo13j5jUb5viVc0gEHw2ODh0k
         7zVoWcf0dOzbBmNKMhImVAAY6vWhrZyZyvmMQZAgYl4iJD4OHReGllvjhlKOKWUGJyEe
         xE8jB1jTr447thYOMq8vBzAIUNwhPx4180rRYXboiIAtGjB/ayS69uqxd6S5Ik/hyhAd
         ND680uRmuxhetUVMkzwUHUqa2/qj3q1U1XARXKvAhZORJ+4Eo3Y0r6rRRPBnFXcG1Ct1
         DAcg==
X-Gm-Message-State: AOAM530ytwHK6lkXA5TEw075oSi27ke7hHKABQ018CLhaeIkDLwYtJjm
        5/Uob6W/TqkGl6/APOboGBBDwUz1MJvAq26GjI3LFw6EnPtaMD1R9J+x3aYMc7mHKVjrE76SgYn
        gPgmoU01ntxFHfPGyE1zW/ic/oSKsFvmAGtAyU5JM2rsOumJLp8B3xdlqAaJEfWU8nplAq1JBG9
        G7
X-Google-Smtp-Source: ABdhPJwUIhS1nqBNIK99fh1Q1EwcOjWJ+jh6JIy3DXRFDwApolOjFGYW5OWnDcuAIKpiZ5xUJndnyMZ44c1wTFAt0MFH
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a62:bd0e:0:b029:142:2501:35e7 with
 SMTP id a14-20020a62bd0e0000b0290142250135e7mr1053507pff.71.1601328042646;
 Mon, 28 Sep 2020 14:20:42 -0700 (PDT)
Date:   Mon, 28 Sep 2020 14:20:38 -0700
Message-Id: <20200928212038.1625698-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH] apply: when -R, also reverse list of sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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

Therefore, when building the list of sections, build them in reverse
order (by adding to the front of the list instead of the back) when -R
is passed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I traced the different behavior in previous_patch() to what the
invocation of to_be_deleted() returns, but I couldn't figure out why it
returns false in the current-but-wrong-order case but true in the
future-and-correct-order case. I see that prepare_fn_table() sets
PATH_TO_BE_DELETED for deletions, but couldn't figure out where and when
it is set to something else. Further compounding my confusion,
conceptually, at the point of checking the deletion, both patches are
(in theory) "to be deleted". Any help in this is appreciated.
---
 apply.c                     | 9 +++++++--
 t/t4114-apply-typechange.sh | 7 +++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

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
-- 
2.28.0.709.gb0816b6eb0-goog

