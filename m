Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44112C43457
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009142087D
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdMiYu8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404123AbgJLSJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404029AbgJLSJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 14:09:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B2AC0613D5
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:09:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e18so20236170wrw.9
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tFL4r2UdZXenUC1jsuAHj0eOXdER7ohplVdJo78DJ0Y=;
        b=IdMiYu8dv9F+DjyMVYd55fVvnwNVZiEUqqxlzBBLMwKdRZFk+uLAY2J6heViu1RCo6
         ZiMywWC4fFwMuXtGXSmKVaOWa0Kt1V6MB4DGtw9t/naFq+Ji0njlBm+6FhA/mjxKePLU
         QLdW7ru/Sg04SXvVx+pDe9eXc9mST2f4Z/QQDr6jkP29ZF6Il6FgMpFVGlAKPL55ttRD
         011qL0TU8u/YveAHKGWtThcNJ7o5bX6UpTmcgsZtrgOsmNuEIUuD/hQrFCgXnvHVbmGx
         v2P+9x0Cmt49jsb9+R3dDtpzxsK6bbPUDsfwtfuiwiXBwKYvSAnOZwROzn/37udcMe/g
         4qQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tFL4r2UdZXenUC1jsuAHj0eOXdER7ohplVdJo78DJ0Y=;
        b=rLd/ueQgwido3/YIsO8BB7YNO+c8xe3+r2vhOO8AEeS8nIgpWCcicDs1Rp/9kZHR00
         nzul0QbtdYxmtUPPSnpIrUm8E+NoUevp9cZxdQ6rjAJVeI+Dn06JvFw3G0jKBdWntJc1
         JGZBtEPFdHEplPzu35d3hJ2xTdhCY8Ebrs5kyoO2U2p/fou6pUHRwsWP4+w35ro+/hYk
         iXbFQ5R1aDWITUa35Hkphy8WOYEj1u8RCjmBt3eqYT+QqBYfp+nroQn/mc/zsVE0OG9y
         RY4y6/1EtjftGbOdPSehlviIXRx3myTm/UtVXf0E13hPHPEihRufLgjll5Jz1bsHqUts
         NsAg==
X-Gm-Message-State: AOAM531aXsoEsSZ1pPbPlhkSb/wK3p91oXDbUopXtlsH8BzL34Ea+hbM
        yR9UbueY8Z2tFrq6t2v7YESDwDdlJCg=
X-Google-Smtp-Source: ABdhPJz4sVeP4Y04hw4nZye+FI2l+PY957ZC2KtmwVP7Rr06VuqtLlsUgklzIAaZFcTCarGKfpH5Hg==
X-Received: by 2002:adf:ea0a:: with SMTP id q10mr19438324wrm.242.1602526173174;
        Mon, 12 Oct 2020 11:09:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a82sm25792521wmc.44.2020.10.12.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 11:09:32 -0700 (PDT)
Message-Id: <59957d139135bc33dd1de97a60d02890dbfce7d5.1602526169.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
        <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 18:09:29 +0000
Subject: [PATCH v3 3/3] log, show: add tests for messages containing CRLF
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

A previous commit fixed a bug in ref-filter.c causing messages
containing CRLF to be incorrectly parsed and displayed.

Add tests to also check that `git log` and `git show` correctly handle
such messages, to prevent futur regressions if these commands are
refactored to use the ref-filter API.

To prevent having to modify expected output in further tests, use
'test_cleanup_crlf_refs' in t4202 to clean-up after the added tests.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t4202-log.sh  | 18 ++++++++++++++++++
 t/t7007-show.sh |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 56d34ed465..d4942a6f92 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -6,6 +6,7 @@ test_description='git log'
 . "$TEST_DIRECTORY/lib-gpg.sh"
 . "$TEST_DIRECTORY/lib-terminal.sh"
 . "$TEST_DIRECTORY/lib-log-graph.sh"
+. "$TEST_DIRECTORY/lib-crlf-messages.sh"
 
 test_cmp_graph () {
 	lib_test_cmp_graph --format=%s "$@"
@@ -105,6 +106,23 @@ test_expect_success 'oneline' '
 	test_cmp expect actual
 '
 
+test_create_crlf_refs
+
+test_expect_success 'oneline with CRLF messages' '
+	for branch in $LIB_CLRF_BRANCHES; do
+		cat .crlf-subject-${branch}.txt >expect &&
+		git log --oneline -1 ${branch} >tmp-branch &&
+		git log --oneline -1 tag-${branch} >tmp-tag &&
+		awk "{print \$NF}" <tmp-branch >actual-branch &&
+		awk "{print \$NF}" <tmp-tag >actual-tag &&
+		test_cmp expect actual-branch &&
+		test_cmp expect actual-tag
+	done
+'
+test_crlf_subject_body_and_contents log --all --reverse --grep Subject
+
+test_cleanup_crlf_refs
+
 test_expect_success 'diff-filter=A' '
 
 	git log --no-renames --pretty="format:%s" --diff-filter=A HEAD > actual &&
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index 42d3db6246..5ffe852829 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -3,6 +3,7 @@
 test_description='git show'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-crlf-messages.sh"
 
 test_expect_success setup '
 	echo hello world >foo &&
@@ -128,4 +129,8 @@ test_expect_success 'show --graph is forbidden' '
   test_must_fail git show --graph HEAD
 '
 
+test_create_crlf_refs
+
+test_crlf_subject_body_and_contents show $LIB_CRLF_BRANCHES
+
 test_done
-- 
gitgitgadget
