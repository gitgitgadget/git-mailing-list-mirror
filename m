Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A8C433E0
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 16:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547E223F28
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 16:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6PkjgH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgFTQjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgFTQjK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jun 2020 12:39:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E5C06174E
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 09:39:10 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so1332579plq.6
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AdxhF4Al6SoInDQuPmBvASgtBfxX8FMKiOGqQE4m/I4=;
        b=V6PkjgH35lV2JXIVZx2jeeI/yWLk6b1RvnOUjVrzr+LVx/kPuxmODzKWTLhNmI6jE6
         xiNBc+HDZlMMs80mS40IiyMtlBfr5B/ib99FDXQIaDW4PRzRxNPa1H05nsSnjaNh354t
         VSPGenOOqMGYlt5+74XOkEIJrlY/85u5KU79jK8BBR/Nh23bY1xuB7NSSYtxA7Pa9AKM
         RQgcggFNPcFj8PVdmp7h0uP7ARdMpe1MTYZgGL4EHfvPRFs5zwuNymyutmQ+hm4Q83tr
         FRuKYsRWndRRfN2obeY3MK99CzRi3Pf5fDmEgkogGEG943H32LEvxqVuqcPRav6uwpM8
         UZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AdxhF4Al6SoInDQuPmBvASgtBfxX8FMKiOGqQE4m/I4=;
        b=NCbxzQMEzg/lfd6OA3jRFHaUAZkGpxoX2QLGtzmM9Qti5ptKYF1HbIXrpRpGaCnIkn
         6hxDzjjvs3jymUaBF7SX81e6lFLbWbgRba6lmPOAhDOcIpaDQDY3aKsBK3/6F9HKLDTh
         Tl/SrIyGWztd4bFywD0Up1d71PV5CzOm7LR6zKbIuKJjt8FkSJyLbnGD74+pkMlG82Wv
         gQxQuaL2L/u4Lwzq3Bhlffp/n0nfUrkAlh2/wM7n7ue4H9AeGwf8/z5hzdhCPvg17PuW
         EYxfKfkvssvwu5RavfPOS068owlE8PbV+7mVbTdzJ1oZXpli0wmom7/yNMQapltyUPLc
         zXTg==
X-Gm-Message-State: AOAM531eMY9TtcPwF9emxHKo5475n/JucZYONt5OEnlmGqZC4Sgqe7LZ
        /i5rpcE1wZAsge5PRrhHFmESgL2X
X-Google-Smtp-Source: ABdhPJx39BUlJRL2PuomJEGbleQYr38bL17vECFuDONx0zuaV4U24wfMzf4A0VYPsP6pMLjR7B3YsA==
X-Received: by 2002:a17:90a:d305:: with SMTP id p5mr8894373pju.44.1592671149569;
        Sat, 20 Jun 2020 09:39:09 -0700 (PDT)
Received: from localhost.localdomain ([49.206.10.141])
        by smtp.gmail.com with ESMTPSA id s63sm7986030pfc.133.2020.06.20.09.39.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jun 2020 09:39:09 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] diff-files: treat "i-t-a" files as "not-in-index"
Date:   Sat, 20 Jun 2020 22:08:45 +0530
Message-Id: <20200620163845.871-1-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
References: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `diff-files' command and related commands which call the function
`cmd_diff_files()', consider the "intent-to-add" files as a part of the
index when comparing the work-tree against it. This was previously
addressed in commits [1] and [2] by turning the option
`--ita-invisible-in-index' (introduced in [3]) on by default.

For `diff-files' (and `add -p' as a consequence) to show the i-t-a
files as as new, `ita_invisible_in_index' will be enabled by default
here as well.

[1] 0231ae71d3 (diff: turn --ita-invisible-in-index on by default,
                2018-05-26)
[2] 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist
                in index", 2016-10-24)
[3] b42b451919 (diff: add --ita-[in]visible-in-index, 2016-10-24)

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---

Summary of changes since v1:
  - Combine the existing "diff", "diff --cached" test with the new one.
  - Fix quoting, empty file creation in tests.
  - Add an additional test for "diff-files --abbrev".

 builtin/diff-files.c  |  7 ++++++
 t/t2203-add-intent.sh | 53 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 86ae474fbf..1e352dd8f7 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -28,6 +28,13 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
+
+	/*
+	 * Consider "intent-to-add" files as new by default, unless
+	 * explicitly specified in the command line or anywhere else.
+	 */
+	rev.diffopt.ita_invisible_in_index = 1;
+
 	precompose_argv(argc, argv);

 	argc = setup_revisions(argc, argv, &rev, NULL);
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 5bbe8dcce4..8a5d55054f 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -232,17 +232,54 @@ test_expect_success 'double rename detection in status' '
 	)
 '

-test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
+test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new for "diff --cached"' '
 	git reset --hard &&
-	echo new >new-ita &&
-	git add -N new-ita &&
+	: >empty &&
+	content="foo" &&
+	echo "$content" >not-empty &&
+
+	hash_e=$(git hash-object empty) &&
+	hash_n=$(git hash-object not-empty) &&
+	hash_t=$(git hash-object -t tree /dev/null) &&
+
+	cat >expect.diff_p <<-EOF &&
+	diff --git a/empty b/empty
+	new file mode 100644
+	index 0000000..$(git rev-parse --short $hash_e)
+	diff --git a/not-empty b/not-empty
+	new file mode 100644
+	index 0000000..$(git rev-parse --short $hash_n)
+	--- /dev/null
+	+++ b/not-empty
+	@@ -0,0 +1 @@
+	+$content
+	EOF
+	cat >expect.diff_s <<-EOF &&
+	 create mode 100644 empty
+	 create mode 100644 not-empty
+	EOF
+	cat >expect.diff_a <<-EOF &&
+	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")empty
+	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")not-empty
+	EOF
+
+	git add -N empty not-empty &&
+
+	git diff >actual &&
+	test_cmp expect.diff_p actual &&
+
 	git diff --summary >actual &&
-	echo " create mode 100644 new-ita" >expected &&
-	test_cmp expected actual &&
-	git diff --cached --summary >actual2 &&
-	test_must_be_empty actual2
-'
+	test_cmp expect.diff_s actual &&
+
+	git diff-files -p >actual &&
+	test_cmp expect.diff_p actual &&

+	git diff-files --abbrev >actual &&
+	test_cmp expect.diff_a actual &&
+
+	git diff --cached >actual &&
+	test_must_be_empty actual
+'

 test_expect_success '"diff HEAD" includes ita as new files' '
 	git reset --hard &&
--
2.27.0
