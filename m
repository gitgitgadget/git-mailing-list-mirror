Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC03C433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5016E64FD2
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhCJTpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhCJTos (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:44:48 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D79C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:44:48 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id v14so5161951pgq.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edTsZ60Zi8Uq977DHpqX32yiQmjeakSoKWVWgEQLZWg=;
        b=rH0Gxka8HfBSOnS9Q7r51/QZFnPwW+kDdFTBm1/jdtBpp/XL+XToX/1F4CqywzC2tw
         UWcqYeaLd0hoPsgfMoo1tP08YCGirzGaKWruh00vf0g9WafMHb+IbpL2MICx3byOMKpg
         OUi82YPW1XY1KypoGL3AdVfPTmxiHj7VLLf0Ku8DxugI1lkb6JEtU7iMxToU6eWwlKqD
         AbFtiTQmnnOpl3GbIZPyDiO0IRlPLWE6JHQfoT8TGJvPNO+67Fugq1Kt8G/wlEzbxTSO
         oe7G+M23lRG7W4t3kr5ZkROeMGGceuDj76Xz2m1YSiwTsANRG+Q/emsk/OCvo861lT+8
         oY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edTsZ60Zi8Uq977DHpqX32yiQmjeakSoKWVWgEQLZWg=;
        b=tNenq0MUK4WdbRtDJGkRNn+12L3tP4AYpRnRk21AursbB5c2Wpg1zy2Q4rqlVz8uv9
         OFtQSzv3Gpy5Mes4vnAbYW1tRoZkNOnQXVou+aNgFEFIp1lXJGoRAlxtUCHS89iyaSgC
         8YBetCsn9oSSjF9aXDDykmCBA2oyAoqXBlbqcW3emGmPxJYOo8Jrod7xOVYaj8UVBkYo
         GLXb92U82B6SoknF84CMhNN8ctA6xtiGIkhjluUL3aumlgWHWFCki1L9giB0dVWLHzxV
         gIbPxZ4rO8ZTuRNgzth2GvhrRL8JF7sflazAGvaot60DD4dTMFDUMx8xKRSsgDKln+Zw
         yvXw==
X-Gm-Message-State: AOAM533J7ujMl5XQfVO4IK4iNSEhb3SAZjpDTGvpb2m09bw8qXn4oexV
        4TbYFwd5zjjZTz8tuglIb64qY03JEZampw==
X-Google-Smtp-Source: ABdhPJwhONXF1Z48ztRtrCRihKjUNJ9iOl0BqXGqu23Xja+PI8tcqpys/OoBj4mYsHuQb19ar5b0Fg==
X-Received: by 2002:a63:5557:: with SMTP id f23mr4153696pgm.242.1615405488095;
        Wed, 10 Mar 2021 11:44:48 -0800 (PST)
Received: from localhost.localdomain ([2405:204:130f:1562:5082:417f:76e8:c75])
        by smtp.googlemail.com with ESMTPSA id p5sm296480pfq.56.2021.03.10.11.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:44:47 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v4 4/6] t7500: add tests for --fixup=[amend|reword] options
Date:   Thu, 11 Mar 2021 01:13:08 +0530
Message-Id: <20210310194306.32565-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7500-commit-template-squash-signoff.sh | 159 ++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 6d19ece05d..05e43a31d3 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -9,6 +9,8 @@ Tests for template, signoff, squash and -F functions.'
 
 . ./test-lib.sh
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
 commit_msg_is () {
 	expect=commit_msg_is.expect
 	actual=commit_msg_is.actual
@@ -279,6 +281,163 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
 
 extra"
 '
+get_commit_msg () {
+	rev="$1" &&
+	git log -1 --pretty=format:"%B" "$rev"
+}
+
+test_expect_success 'commit --fixup=amend: creates amend! commit' '
+	commit_for_rebase_autosquash_setup &&
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+
+	$(get_commit_msg HEAD~)
+
+	edited
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="edited" \
+			git commit --fixup=amend:HEAD~
+	) &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--fixup=amend: --only ignores staged changes' '
+	commit_for_rebase_autosquash_setup &&
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+
+	$(get_commit_msg HEAD~)
+
+	edited
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="edited" \
+			git commit --fixup=amend:HEAD~ --only
+	) &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual &&
+	test_cmp_rev HEAD@{1}^{tree} HEAD^{tree} &&
+	test_cmp_rev HEAD@{1} HEAD^ &&
+	test_expect_code 1 git diff --cached --exit-code &&
+	git cat-file blob :foo >actual &&
+	test_cmp foo actual
+'
+
+test_expect_success '--fixup=reword: ignores staged changes' '
+	commit_for_rebase_autosquash_setup &&
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+
+	$(get_commit_msg HEAD~)
+
+	edited
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="edited" \
+			git commit --fixup=reword:HEAD~
+	) &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual &&
+	test_cmp_rev HEAD@{1}^{tree} HEAD^{tree} &&
+	test_cmp_rev HEAD@{1} HEAD^ &&
+	test_expect_code 1 git diff --cached --exit-code &&
+	git cat-file blob :foo >actual &&
+	test_cmp foo actual
+'
+
+test_expect_success '--fixup=reword: error out with -m option' '
+	commit_for_rebase_autosquash_setup &&
+	echo "fatal: cannot combine -m with --fixup:reword" >expect &&
+	test_must_fail git commit --fixup=reword:HEAD~ -m "reword commit message" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--fixup=amend: error out with -m option' '
+	commit_for_rebase_autosquash_setup &&
+	echo "fatal: cannot combine -m with --fixup:amend" >expect &&
+	test_must_fail git commit --fixup=amend:HEAD~ -m "amend commit message" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'consecutive amend! commits remove amend! line from commit msg body' '
+	commit_for_rebase_autosquash_setup &&
+	cat >expected <<-EOF &&
+	amend! amend! $(git log -1 --format=%s HEAD~)
+
+	$(get_commit_msg HEAD~)
+
+	edited 1
+
+	edited 2
+	EOF
+	echo "reword new commit message" >actual &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="edited 1" \
+			git commit --fixup=reword:HEAD~ &&
+		FAKE_COMMIT_AMEND="edited 2" \
+			git commit --fixup=reword:HEAD
+	) &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'deny to create amend! commit if its commit msg body is empty' '
+	commit_for_rebase_autosquash_setup &&
+	echo "Aborting commit due to empty commit message body." >expected &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_COMMIT_MESSAGE="amend! target message subject line" \
+			git commit --fixup=amend:HEAD~ 2>actual
+	) &&
+	test_cmp expected actual
+'
+
+test_expect_success 'amend! commit allows empty commit msg body with --allow-empty-message' '
+	commit_for_rebase_autosquash_setup &&
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_MESSAGE="amend! target message subject line" \
+			git commit --fixup=amend:HEAD~ --allow-empty-message &&
+		get_commit_msg HEAD >actual
+	) &&
+	test_cmp expected actual
+'
+
+test_fixup_reword_opt () {
+	test_expect_success C_LOCALE_OUTPUT "--fixup=reword: incompatible with $1" "
+		echo 'fatal: reword option of --fixup is mutually exclusive with'\
+			'--patch/--interactive/--all/--include/--only' >expect &&
+		test_must_fail git commit --fixup=reword:HEAD~ $1 2>actual &&
+		test_cmp expect actual
+	"
+}
+
+for opt in --all --include --only --interactive --patch
+do
+	test_fixup_reword_opt $opt
+done
+
+test_expect_success '--fixup=reword: give error with pathsec' '
+	commit_for_rebase_autosquash_setup &&
+	echo "fatal: cannot combine reword option of --fixup with path '\''foo'\''" >expect &&
+	test_must_fail git commit --fixup=reword:HEAD~ -- foo 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--fixup=reword: -F give error message' '
+	echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
+	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'commit --squash works with -F' '
 	commit_for_rebase_autosquash_setup &&
-- 
2.29.0.rc1

