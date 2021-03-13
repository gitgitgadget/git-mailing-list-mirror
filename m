Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB10C433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C075E64EF6
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhCMNn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 08:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhCMNmy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 08:42:54 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43E9C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:42:53 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id l2so17676805pgb.1
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edTsZ60Zi8Uq977DHpqX32yiQmjeakSoKWVWgEQLZWg=;
        b=Qxzq6ns1gWrjIcr9Y7Gb1M2+N4fr6QxkbIb24Ray2CV2ut/IyCLzqFmobQuZo0E0fE
         4hT29KKmFUX+CrlkUB7CWTMfL0VVHWg6Q6Fc70paAbIlqEmT6GM/vjWDBpbv3XNJUVVb
         4bb31w/sJgAisR7NcFNM3d3LhcLuj0vy9nU4gMRtfPz2QrZxcQjmuUA7a4hoQBHO+q+x
         zcNaCOcQ5UmGNJUvrkABi6C3KHL27WQvUTLWd01Y0LyuZapIb7sU5JG48liz9TT5zp0s
         tB9RztnurgBAPJ0etDhxyi0mpsYNcqjoSB3yGIgpVv5QVWi+hoa+G93h7ngLmgSzAiq9
         qE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edTsZ60Zi8Uq977DHpqX32yiQmjeakSoKWVWgEQLZWg=;
        b=H1KUKSi9jBKx5PmFhi3dulJzgrYjUGUAvOrpCIY4cv9DtF2CCKDN5RVf1l0SOrTYOK
         aFPguflr8J1GqT3ttMO/BblfUZnsuGyPGzEtU2v0Jr3WJ2Qa2hW3wp308l/6se6xNi5d
         GWIIFL8D8ML3U6GW77KZr8oelCv9ZBx1P98RBbwHzBaCYYriTeZWp3/gkEOcyZFKAKUj
         wtVAJaW+JM/BYLcWs35c60Qx5E+lxOZJ+CAcZG2qlIzxqVs2Q25PzACy5yzUjt9EbIGI
         dEdKhA6c1aM9AbtJy+VKbov0njOkaglQLBTDb+uLRuOh2Zk8QLTt1tpKwUlOB/qQGFTh
         J/lQ==
X-Gm-Message-State: AOAM533HmeIbfYC0CoVl61g935yrSBBjFQF9TIDuXZLamiFgiUVgldbd
        8Vpo9aMhv7FMVe27uleB2Tq8qS+1E/toKQ==
X-Google-Smtp-Source: ABdhPJxUeJI1BpC3Z1ijnFzPk5AjJMjhG1H40TOBy+tmP66cY7vgKE2qQp25Cph+d9TNCOvpeqXTDA==
X-Received: by 2002:a63:81:: with SMTP id 123mr15663306pga.307.1615642972893;
        Sat, 13 Mar 2021 05:42:52 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d98:f55e:3466:3377:eaba:8d02])
        by smtp.googlemail.com with ESMTPSA id y20sm8657809pfo.210.2021.03.13.05.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 05:42:52 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, sunshine@sunshineco.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 4/6] t7500: add tests for --fixup=[amend|reword] options
Date:   Sat, 13 Mar 2021 19:10:11 +0530
Message-Id: <20210313134012.20658-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
References: <20210310194306.32565-1-charvi077@gmail.com>
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

