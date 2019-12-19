Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B4EC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2690724672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKAuI1Ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfLSWV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38061 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfLSWVt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so3878346pgm.5
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RD1xYedwlsBj9gbr+CqlHSkDxXhwhE2Z6Ug+R2zhg4g=;
        b=FKAuI1LlnVzqbkxlCCQ0Ein6qfmh441aw385ETuNIvMGpjquEIzIEiTuvkpvAi9UCt
         XOweYAsvP1WPh/gfqGeKfBblyxXlBnX7O5rkkyCNQrgxJRmuTsUHZ0DxhKg307Vetp8T
         YH0le+a6Or2XZ42Co7+eQdmcWJ54VA5ozaGDer0vdBrE4V94NbWT5ISZG7QHlmGuY9m5
         ZedvnKwPrT70ccOdlskWlYj39rcwo0DKOhhMxLhZIPFsoGlAopBlCHKXpKDDVTzbvUuY
         +7xqENsCIhbRfvBdxPpskEUO5cCaXW0puLQCNJHihZuYhGkCGkg/xgWVlRZaXL+fhc27
         zcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RD1xYedwlsBj9gbr+CqlHSkDxXhwhE2Z6Ug+R2zhg4g=;
        b=er9fGYvDRfVYvasLu+Hx/w3OIpwGu9zjyEiLEvpg5qZN3DdHZv+NYsLRSipcMs3XI2
         UetqxYdUiWdvUOdVDssvE1A5qsta7jy42xS+lLhiUHru4vNE9g+pFT3W3KWZW2xOhJKJ
         0/D+uK36e4GNmrobqKsOR2D/uJwGFKyyg0gZFFudvPIg2KXaAZCK5OnNI1VSA2NruNX0
         n9O+Sn4jXWL09pRuu9ttHKh/hb3MmlMJ3+8k+c/808jfvJi3m83Lm17c6yDek0ShHNaU
         bIaYAWh07YDaaNP6ZMsCXR6Rj19xrLpNMvC0Q5KbqQyX6bLmLvlGS7SIg+QAunn4czQR
         JQxw==
X-Gm-Message-State: APjAAAXQ+aYzP2ALPzF+NpF1p+FLTyQbbXxd418me/vpKTokvXEzcfoD
        l6tedQznXgpTYaFbF8PWh2UVVKbP
X-Google-Smtp-Source: APXvYqwxjqvOmMN9JpIANfGDpWQ3DxrXkm04Yw7kXeD+VIqIvrJx38SZ4qbxRaJw76y0u68xmUrkeg==
X-Received: by 2002:a63:770c:: with SMTP id s12mr11811063pgc.25.1576794108126;
        Thu, 19 Dec 2019 14:21:48 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:47 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/16] t1507: run commands within test_expect_success
Date:   Thu, 19 Dec 2019 14:22:50 -0800
Message-Id: <7c61ac6b67a32da86fcdafaf4a69f2662efb4bd0.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
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

