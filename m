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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9CBC2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A8620866
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebl2tiRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfLTSOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:43 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:32925 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfLTSOm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id u63so4156586pjb.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2mUy2uXMcc2KMq6HG3rtk0SZXxq/MwIutBy33gHbX0=;
        b=Ebl2tiRmjGEjs4YoPdjAIsnPY6VLCTWS+h0OHMueBBtGN7mIBW9BeHWM1v1KxVPdt7
         RaYUYAvuhrs7EFuO1Z6R4wxFQV7HKmHPmRzYPJOGg4aGwcZ4BtBDUXY2LI1KjW6PG8W7
         b2VOK2behto0BfG+7Z2SKIYjmPF6KaaXOzB8f1a69ewultBTBXIHO5F9qsX0CyVM0YuA
         QaC8wt2XWO2VDy20lrS86FvIHEm3d7mZnkc+vOseaWqVr5hLtsnvdT9f3LnhWafYTdGc
         nc0NL2tmNlj9cDwRzrDB/2sE52tNZ+zHjcBs2tftzF34H3IGUer0ktPe24ziAOY4vAkL
         aZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2mUy2uXMcc2KMq6HG3rtk0SZXxq/MwIutBy33gHbX0=;
        b=dxWE0aF9GZL3ubPJyP8jTQvlVomWaEBrroG5QI+nDiuuLsxTeh/loCbZGq/k+D7xUB
         keIyIK3HCLR6jVIomYKBxOdEST3NnFkpeqqmX47WPHHooaGJDlElUQcvFz+ctuZHrvNB
         PDfqDIkBIxBGrBgRFoBTxIMvUffVRR66aXGq/EoYaqwryLVhaBWGqZtQ+6d0Ch+i2++B
         e9W1XWNxucdbq08pzWiUVmdpuAwDOVxKKpFgxcqLvNi09njt/ong5zgPFiVmp+R5zTGn
         Lpnp8dkfjvvyxmzDokmu8+kK01rRVIxvfDI7h/xE0+D/aR96ornRksO0sPet4+pmb4nf
         ZEeA==
X-Gm-Message-State: APjAAAWJcK1aUC3sn+tJ8EVtPWCTtUD8mCSZaiQ8xOXqgrvFzNi5mL79
        Q4J+KChix/TfIGGTRh69xMmhtDHg
X-Google-Smtp-Source: APXvYqwoI89BBZpX8AWKA1ZXIwP9wG+D3XJ7WCXY5ImW1LZXNYDY8lxIu6wkGbkXGdQ/3O6JRIisLQ==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr16589824plp.300.1576865680936;
        Fri, 20 Dec 2019 10:14:40 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:40 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/15] t1306: convert `test_might_fail rm` to `rm -f`
Date:   Fri, 20 Dec 2019 10:15:55 -0800
Message-Id: <7e29b0154ef71a0a5743f9a2b281b40ba3337a07.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() family of functions (including test_might_fail())
should only be used on git commands. Replace `test_might_fail rm` with
`rm -f` so that we don't use `test_might_fail` on a non-git command.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1306-xdg-files.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 21e139a313..dd87b43be1 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -153,7 +153,7 @@ test_expect_success 'Checking attributes in both XDG and local attributes files'
 
 
 test_expect_success 'Checking attributes in a non-XDG global attributes file' '
-	test_might_fail rm .gitattributes &&
+	rm -f .gitattributes &&
 	echo "f attr_f=test" >"$HOME"/my_gitattributes &&
 	git config core.attributesfile "$HOME"/my_gitattributes &&
 	echo "f: attr_f: test" >expected &&
@@ -165,7 +165,7 @@ test_expect_success 'Checking attributes in a non-XDG global attributes file' '
 test_expect_success 'write: xdg file exists and ~/.gitconfig doesn'\''t' '
 	mkdir -p "$HOME"/.config/git &&
 	>"$HOME"/.config/git/config &&
-	test_might_fail rm "$HOME"/.gitconfig &&
+	rm -f "$HOME"/.gitconfig &&
 	git config --global user.name "write_config" &&
 	echo "[user]" >expected &&
 	echo "	name = write_config" >>expected &&
@@ -183,8 +183,8 @@ test_expect_success 'write: xdg file exists and ~/.gitconfig exists' '
 
 
 test_expect_success 'write: ~/.config/git/ exists and config file doesn'\''t' '
-	test_might_fail rm "$HOME"/.gitconfig &&
-	test_might_fail rm "$HOME"/.config/git/config &&
+	rm -f "$HOME"/.gitconfig &&
+	rm -f "$HOME"/.config/git/config &&
 	git config --global user.name "write_gitconfig" &&
 	echo "[user]" >expected &&
 	echo "	name = write_gitconfig" >>expected &&
-- 
2.24.1.703.g2f499f1283

