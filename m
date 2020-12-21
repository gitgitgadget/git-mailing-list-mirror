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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82178C433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EAC622B43
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgLUV1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgLUV1l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 16:27:41 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C31C061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 13:27:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o19so27162484lfo.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TpIAXXiSM4wg/k3kURTL439k7yzpf3Z8Tb5lOk5tQ+8=;
        b=l5PjC8pa80USgwI80TUZdKrKef2Ux7X5lcWFZm5MA/pNfHCL+n3NX4+9wp85WaUVY3
         jyZNxx62avCWJMtXDL26JkN60RdK+ZLVWEghKTlUwQ9NR9IOv9ZCId6L1PJ9o65QxcAR
         rvTj2JZLrWjEk2JHebFaeoGqVeQLN+++A6rZ2IgFW6FQtibcjsKXf9gd/vlfdHnw84TQ
         bAldWc+Pi2T8x+7osVIWHYRBOlNGIbwhKO2bbU98JZtaPDdcP5jLf+OXfESvtbw9461L
         JeKkErHT0t7W1x8AM10E0HVJ4RcxN2MOWzrXZPK6PkQ46yYIsKxsh0J1T/Pe2VMg8H0o
         xfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TpIAXXiSM4wg/k3kURTL439k7yzpf3Z8Tb5lOk5tQ+8=;
        b=KJepMjSj98++64JXIl77Uv5vc7ja1QCuE8v9Y36fcHLD/rX1HjzI5Oz2HNijyvc1CJ
         UUOCj+m53WxPkE1OJKjAE2K9VM/HPyjgInd0OAgqR/+t0WGHC2LQsYx5nIbcWIzFseDR
         IoRHauVcpL65Bc2a8St3nvg3QcWQ2BKAXlVBH5YkqOu+d2aQBQpkEbzXKpgr02xe/HVs
         /UPkbcV7A1y1ZGxsjpBIbgsEGsXIVhIPCdAoRygPTr94pk0A4o5DuQJUUoYRSBhrc3BR
         txnewSBRR/FfN/YS0+yZwuNUN+Y2WXwFESB4H+01sRa83lhAYypQr8UNE02H2uhWQEXd
         3cIQ==
X-Gm-Message-State: AOAM533lgFEpC50vK7VUHgqZiXEtl5QiaHkDJJNPwhKENFoH9gdgwau5
        W1y1ZTfYtTs8ndPMwAZ37667cv0aFJA=
X-Google-Smtp-Source: ABdhPJyd+Hc4aLLe7w8MQ0f5yCo2zkp0KQLGC+BVQ9eA+nWUhb1LrxyaOKdyAuuweZu3dmSkBUFc6A==
X-Received: by 2002:a2e:b00c:: with SMTP id y12mr7976150ljk.85.1608586018933;
        Mon, 21 Dec 2020 13:26:58 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id t14sm2236100lfl.216.2020.12.21.13.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 13:26:58 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/3] gc: fix handling of crontab magic markers
Date:   Mon, 21 Dec 2020 22:26:32 +0100
Message-Id: <689d3150e9822eeccac0e1d07c2ba26dac47b4c9.1608585497.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <cover.1608585497.git.martin.agren@gmail.com>
References: <cover.1608585497.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On `git maintenance start`, we add a few entries to the user's cron
table. We wrap our entries using two magic markers, "# BEGIN GIT
MAINTENANCE SCHEDULE" and "# END GIT MAINTENANCE SCHEDULE". At a later
`git maintenance stop`, we will go through the table and remove these
lines. Or rather, we will remove the "BEGIN" marker, the "END" marker
and everything between them.

Alas, we have a bug in how we detect the "END" marker: we don't. As we
loop through all the lines of the crontab, if we are in the "old
region", i.e., the region we're aiming to remove, we make an early
`continue` and don't get as far as checking for the "END" marker. Thus,
once we've seen our "BEGIN", we remove everything until the end of the
file.

Rewrite the logic for identifying these markers. There are four cases
that are mutually exclusive: The current line starts a region or it ends
it, or it's firmly within the region, or it's outside of it (and should
be printed).

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t7900-maintenance.sh | 7 +++++++
 builtin/gc.c           | 7 +++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d1e0c8f830..4bbfce31e9 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -446,6 +446,13 @@ test_expect_success 'start preserves existing schedule' '
 	grep "Important information!" cron.txt
 '
 
+test_expect_success 'stop preserves surrounding schedule' '
+	echo "Crucial information!" >>cron.txt &&
+	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
+	grep "Important information!" cron.txt &&
+	grep "Crucial information!" cron.txt
+'
+
 test_expect_success 'register preserves existing strategy' '
 	git config maintenance.strategy none &&
 	git maintenance register &&
diff --git a/builtin/gc.c b/builtin/gc.c
index b57fda4924..4c24f41852 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1554,11 +1554,10 @@ static int update_background_schedule(int run_maintenance)
 	while (!strbuf_getline_lf(&line, cron_list)) {
 		if (!in_old_region && !strcmp(line.buf, BEGIN_LINE))
 			in_old_region = 1;
-		if (in_old_region)
-			continue;
-		fprintf(cron_in, "%s\n", line.buf);
-		if (in_old_region && !strcmp(line.buf, END_LINE))
+		else if (in_old_region && !strcmp(line.buf, END_LINE))
 			in_old_region = 0;
+		else if (!in_old_region)
+			fprintf(cron_in, "%s\n", line.buf);
 	}
 
 	if (run_maintenance) {
-- 
2.30.0.rc1

