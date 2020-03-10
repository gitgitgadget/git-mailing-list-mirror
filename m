Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38235C10F29
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 02:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120E720637
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 02:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JileBRml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgCJCY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:24:59 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46349 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgCJCY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 22:24:58 -0400
Received: by mail-wr1-f53.google.com with SMTP id n15so13808329wrw.13
        for <git@vger.kernel.org>; Mon, 09 Mar 2020 19:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9GxdOtN0bmM+XVUuzeI/34i+MSmFF2Wr/jG/pEgwPqQ=;
        b=JileBRml084ABEML2FsluSyTo5VEcdOzH0eUSBQr2A6zIUWNWgG8RoF2N45eCXWea4
         IpYrdiS25CAXHsMlWTce6WdoB3eWzl+GaDh0GBgb1Lry0h9/vd6mzPKWPyV7wOR+ERXX
         ZUtf+thekLQr4Rh3zCWSQnz09t0w6ZNZon4yfEmvnjQ1YnKOsOn0M2w90WJ5XBtUJLtw
         JlljasJrymXEV3RIBMOlv8X2ziJOGwA6Sme079Pk2sUXFPHwXLj3oUQkKn2ihirmKTkC
         +Ke7PxCajchg+LTAiuwIXvaPPV/i5i4ZGP6mgML3iHBG4K8d90I6KVNHw99If6ig+ShD
         wYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9GxdOtN0bmM+XVUuzeI/34i+MSmFF2Wr/jG/pEgwPqQ=;
        b=RNtKqO/kjnplA+GFIahM7qf8uxwk7lS5f8dkukZWh7rbbEPcMCIZzo7eji052JDTEE
         bX+by2lSWd3v6jTjEid9sFdXInKP/7e9Dqu4xhWAoFsvhZeAGx6FvwNirrmFWMbING8D
         yDulS5NX+t22uDDXUJUfZmiBOFMFGF79slcVPBzWbh8IPwvKPUuSKj05jhL6dis26Ljv
         rLbNSG6JlAe6AIIjybpviih6W9iRUotn3oiDdeSBHsSPjWB+NeXJgIqTJX7SyK1/e4wu
         T2lFfh6kiFNuILnrWk3pYsGHcHJiuSePYrFvqv6waic0ayqdB2FGYhP+TN2oGaTgC0yg
         aR2w==
X-Gm-Message-State: ANhLgQ3xnKvIHpaa5Yk80k1n9Fy29m3iTseD9IqDQE8+0EO8v9bkDAhH
        0FXBCRzuWXeYJMIjqSWV1Z8eQwRq
X-Google-Smtp-Source: ADFU+vtPC05fA+X4b3IShwZXsoe6Airt8Exd0GoPIxvxoDUEhuqVHwiWfL8D0NQGB3b+7A7opdNZHg==
X-Received: by 2002:a5d:55c7:: with SMTP id i7mr9305503wrw.252.1583807097106;
        Mon, 09 Mar 2020 19:24:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l83sm1999347wmf.43.2020.03.09.19.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 19:24:56 -0700 (PDT)
Message-Id: <c84092e457c873e18548b647e2c672b737abcb24.1583807093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
References: <pull.576.git.1583692184.gitgitgadget@gmail.com>
        <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Mar 2020 02:24:53 +0000
Subject: [PATCH v2 3/3] log: add tests for messages containing CRLF to t4202
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
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

A previous commit fixed a bug in the ref-filter API causing messages
containing CRLF to be incorrectly parsed and displayed.

Add a test to also check that `git log` correctly handles such messages,
to prevent futur regressions.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t4202-log.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 4694b6d0ce7..1e6149372c5 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -6,6 +6,7 @@ test_description='git log'
 . "$TEST_DIRECTORY/lib-gpg.sh"
 . "$TEST_DIRECTORY/lib-terminal.sh"
 . "$TEST_DIRECTORY/lib-log-graph.sh"
+. "$TEST_DIRECTORY/lib-crlf-messages.sh"
 
 test_cmp_graph () {
 	lib_test_cmp_graph --format=%s "$@"
@@ -105,6 +106,29 @@ test_expect_success 'oneline' '
 	test_cmp expect actual
 '
 
+test_create_crlf_refs
+
+test_expect_success 'oneline with CRLF messages' '
+	echo "002093e Subject first line" >expect &&
+	git log --oneline -1 crlf >actual-branch &&
+	git log --oneline -1 tag-crlf >actual-tag &&
+	test_cmp expect actual-branch &&
+	test_cmp expect actual-tag &&
+	echo "6f814b0 Subject first line" >expect &&
+	git log --oneline -1 crlf-empty-lines-after-subject >actual-branch &&
+	git log --oneline -1 tag-crlf-empty-lines-after-subject >actual-tag &&
+	test_cmp expect actual-branch &&
+	test_cmp expect actual-tag &&
+	echo "8c58a85 Subject first line Subject second line" >expect &&
+	git log --oneline -1 crlf-two-line-subject >actual-branch &&
+	git log --oneline -1 tag-crlf-two-line-subject >actual-tag &&
+	test_cmp expect actual-branch &&
+	test_cmp expect actual-tag
+'
+test_crlf_subject_body_and_contents log --all --reverse --grep Subject
+
+test_cleanup_crlf_refs
+
 test_expect_success 'diff-filter=A' '
 
 	git log --no-renames --pretty="format:%s" --diff-filter=A HEAD > actual &&
-- 
gitgitgadget
