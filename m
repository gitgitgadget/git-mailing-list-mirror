Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510B8C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbiKRLSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiKRLSi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:38 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61F5140A6
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:37 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m22so12172141eji.10
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbaVSWPxS4sAfZaeGc+YHhToAn6m864bioeAoh5xGAM=;
        b=CKlrwyjeuW24xrC7pxSZE09XHo3GaPYfF+WQpZy4J7HbHnS1VFzb8tLIEWxTe5d4+f
         8MNijgiVRGv6fovFBBIAGhfR7GPV/RjPpF1hO7M+VaIbsF88LI0RHrc7U9MWTbl13104
         Ru+Wq6fzOo5/jL1ljc4QT1U0UdMpdwUrDeMNyD/YGHGcox70orYCruhoc2gb+bq4TTzd
         zqyT+uF8Gzq/mAbHY2f3YIY8UHAVV/e0AkqjlvVlC/sm94W24wigAsPLV3N557kMltnz
         2hYgr+JtorDcvkfsf+JyUBZFclHuPuEuuEH4IFXwnc7SozmD6Hqc9xLsrcZqvxxkTgx7
         TEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbaVSWPxS4sAfZaeGc+YHhToAn6m864bioeAoh5xGAM=;
        b=oFwJZT5+KZc9bDTOl4w1SrOqg+1GsCam3dEqTQZOFMcd5+pzkD70G0k81QyWGPN6C7
         Wi9jb029R/H3EC8VyoDvDGE33sfvGKM8wYhaghS0VAAeqoH1WzhTF07jTE/ln/XCi7TK
         N3Q7iNgv+54TWnkdaRY5eub7uoFJYqAoX09EsY7CTOXdBsK36E0gspRc32e4YZktSSqF
         jNJ4IqSUVmcRm3E5DAIrbqUn2DLO9cXq9dXnafPLSqHkbO1S0bol75rpRj7nfhC323so
         bdsc+DtdHpzMIGRWea4F1HrVSk+lwR4TXH7LdvZKv8073We2HznwKEQvoti3Xy11nL8R
         VhCw==
X-Gm-Message-State: ANoB5pkMkUvuxl4WPwfpj7HRjvXi71d7vn8nZcon6MpvLzLap5/+++vT
        EpM5NVqHJv8n8VUuB8wY62gqAfWN911/Lg==
X-Google-Smtp-Source: AA0mqf55MkJPqYRRhp9Hef3+BFJSTQg3RCW4kqkdJb2QaXQPkdK3xpG8dphKcoo9E6fNMakRP83QBQ==
X-Received: by 2002:a17:906:c011:b0:778:f9b6:6fc with SMTP id e17-20020a170906c01100b00778f9b606fcmr5615957ejz.580.1668770315822;
        Fri, 18 Nov 2022 03:18:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 03/12] t6060: add tests for removed files
Date:   Fri, 18 Nov 2022 12:18:20 +0100
Message-Id: <patch-v9-03.12-af3a235a224-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alban Gruin <alban.gruin@gmail.com>

Until now, t6060 did not not check git-merge-one-file's behaviour when a
file is deleted in a branch.  To avoid regressions on this during the
conversion from shell to C, this adds a new file, `file3', in the commit
tagged as `base', and deletes it in the commit tagged as `two'.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6060-merge-index.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 30513351c23..079151ee06d 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -8,12 +8,14 @@ TEST_PASSES_SANITIZE_LEAK=true
 test_expect_success 'setup diverging branches' '
 	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
 	cp file file2 &&
-	git add file file2 &&
+	cp file file3 &&
+	git add file file2 file3 &&
 	git commit -m base &&
 	git tag base &&
 	sed s/2/two/ <file >tmp &&
 	mv tmp file &&
 	cp file file2 &&
+	git rm file3 &&
 	git commit -a -m two &&
 	git tag two &&
 	git checkout -b other HEAD^ &&
@@ -41,6 +43,7 @@ test_expect_success 'read-tree does not resolve content merge' '
 	cat >expect <<-\EOF &&
 	file
 	file2
+	file3
 	EOF
 	git read-tree -i -m base ten two &&
 	git diff-files --name-only --diff-filter=U >unmerged &&
-- 
2.38.0.1511.gcdcff1f1dc2

