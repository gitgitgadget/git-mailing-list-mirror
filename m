Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD239C2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9474D2082E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcSAbXP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfLTSOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33158 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfLTSOr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so5333425pgk.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RD1xYedwlsBj9gbr+CqlHSkDxXhwhE2Z6Ug+R2zhg4g=;
        b=TcSAbXP63/U5deGq6CeKKU7OQKB94pAykMSfLUr04AIiMEEixsEQy/i5NvRBMdEk+3
         xZf2MLLPXofrwZyMXDgs4yjr6wT3h6M/GDy+ZvZQOSqEH9tbmU1ngLPSHVc52Mivu0Co
         XyYdZDsbGNF3GAcq+Y6C2s/FOiEEFrJ8uyntYJ624jVKCvdEWqlyc6cm2kN88NnYlO2d
         bap6FdVifouC8/LI1xXi8m429BHEIoTIZgZ/k+ZyRFRSxQBf/y8FxeIeIfRdsH6xbdc+
         uneIueqpIoXBGimHr8cY3XgMqZ55HxLG0XTlhG3xa1vsxltOYnAvQwYkAgIm2osWPDU/
         z/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RD1xYedwlsBj9gbr+CqlHSkDxXhwhE2Z6Ug+R2zhg4g=;
        b=jdVnVIflsqqCbhf17jHSIp4PGuxHl4x/55aGuRYlvVHptrfw2guLVCRfsHYi2jH3yI
         Ker5TzEy6hH1c4Z9y3CNOfDKiLgjjLv7LnV3T7UwioOMbFLlhjv4xAbsjRfgIphuDB32
         Lo1oikl33ECiBm1BNyu6CLNksAOYeg0guLe0yUJGukQinGFC67gwDuB5f1c4zZtxHV8X
         ekdcjCbjvq+8loaXAoNpf6/+OKXsqYKV0XFn5UEhv9ZcpmoFnurdDyigHSe/ss4uzEP+
         ZYN2FMPAJYuCQebinHG6qVmK6Bl8z7MZJm0extlGY5SLcfFATmTW760M0cW1N4Fwbfep
         tmXw==
X-Gm-Message-State: APjAAAXtRhnqnQh7U/uGEfZOlVp47jKU7+wMxGOiCiq5qpGJTfTKMFgy
        4+id4EQ7UT7twCCoM66Q+rMYLcKl
X-Google-Smtp-Source: APXvYqwNbyuHLp1GtoXufH9efz2dImbFY6jMxR5TALwwEbKJDexY5LYnDBbDPby/SkzeO53YR+AK0g==
X-Received: by 2002:a62:be0a:: with SMTP id l10mr10633507pff.187.1576865686211;
        Fri, 20 Dec 2019 10:14:46 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:45 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/15] t1507: run commands within test_expect_success
Date:   Fri, 20 Dec 2019 10:16:01 -0800
Message-Id: <44a410d57a3e9c25c609a23619d48b471e5057b5.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The expected test style is to have all commands tested within a
test_expect_success block. Move the generation of the 'expect' text into
their corresponding blocks. While we're at it, insert a second
`commit=$(git rev-parse HEAD)` into the next test case so that it's
clear where $commit is coming from.

The biggest advantage of doing this is that we now check the return code
of `git rev-parse HEAD` so we can catch it in case it fails.

This patch is best viewed with `--color-moved --ignore-all-space`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1507-rev-parse-upstream.sh | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index d81f289ace..f68b77e7ba 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -225,32 +225,32 @@ test_expect_success '@{u} works when tracking a local branch' '
 	test_cmp expect actual
 '
 
-commit=$(git rev-parse HEAD)
-cat >expect <<EOF
-commit $commit
-Reflog: master@{0} (C O Mitter <committer@example.com>)
-Reflog message: branch: Created from HEAD
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:15:13 2005 -0700
-
-    3
-EOF
 test_expect_success 'log -g other@{u}' '
+	commit=$(git rev-parse HEAD) &&
+	cat >expect <<-EOF &&
+	commit $commit
+	Reflog: master@{0} (C O Mitter <committer@example.com>)
+	Reflog message: branch: Created from HEAD
+	Author: A U Thor <author@example.com>
+	Date:   Thu Apr 7 15:15:13 2005 -0700
+
+	    3
+	EOF
 	git log -1 -g other@{u} >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-commit $commit
-Reflog: master@{Thu Apr 7 15:17:13 2005 -0700} (C O Mitter <committer@example.com>)
-Reflog message: branch: Created from HEAD
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:15:13 2005 -0700
-
-    3
-EOF
-
 test_expect_success 'log -g other@{u}@{now}' '
+	commit=$(git rev-parse HEAD) &&
+	cat >expect <<-EOF &&
+	commit $commit
+	Reflog: master@{Thu Apr 7 15:17:13 2005 -0700} (C O Mitter <committer@example.com>)
+	Reflog message: branch: Created from HEAD
+	Author: A U Thor <author@example.com>
+	Date:   Thu Apr 7 15:15:13 2005 -0700
+
+	    3
+	EOF
 	git log -1 -g other@{u}@{now} >actual &&
 	test_cmp expect actual
 '
-- 
2.24.1.703.g2f499f1283

