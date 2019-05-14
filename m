Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6020E1F461
	for <e@80x24.org>; Tue, 14 May 2019 04:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfENEbN (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 00:31:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42725 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENEbM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 00:31:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id 13so8390192pfw.9
        for <git@vger.kernel.org>; Mon, 13 May 2019 21:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTBer9XzOK6RK21ySMmstXamu4XMjYB4E3GEoabZJNU=;
        b=Ef2cGe0mdH98x3VXID106k+mnNGzW0kW1Yw4AKQxX6gyZDbDhV420dX+2qCGLOEacl
         ckg2hwsRehqar+FTdZhQteQqa8dXl65vxfkuoG5i/lsFghK6PoxsSXUOhuZvsjq80sdy
         pu2h3ApHPAKQq802ictr80HIkY6H825zTxFj811+qBFzEKAiSoMZLbrOCko3UI7ZkAxI
         bxFrO3V7D6+MhCHQ01r1WaukxeLOB33HrVMxGlucIeLKlQkyPIcKD0+zXFoSKItGpCFI
         ygjhh0RySj7oqLRtecPeVJEJw27xw60vFr49yE9gKyBIl6bMThk/wTVOoFoxINkhTG/t
         QIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTBer9XzOK6RK21ySMmstXamu4XMjYB4E3GEoabZJNU=;
        b=iUOo1R9QOaN3lREpZsC+pPDH35gKfI7QD0s8z6UuKih6fSuucEdHfYUwt4gDRQFRYC
         QUvKFB19/O1GXVnCRHS3+AwD/wi5n57JMneBU3dj8jABLbtUqHl09kc8EOUZi7oFoH+x
         A3rxymnluXRQa2iSEnFW3s72h4sTP6WZqYlTx/OOzDoP++9xJM11+/bSVF/pmceMUoP9
         +RJzZIACkED91O8PFab/TeTiNsO34iBsGuYYji6uDSP6/CBbDeuTbAfJX5OgI8NP8ccO
         gZF39N7zVHpar/IBI/LU99yZ4yqzyIawRcPCd9b+qfidz1P+V3yx9txFsRiDYBPIWDLy
         XVig==
X-Gm-Message-State: APjAAAXMxvcHoGhkA4GpSDK+uUvQUdL8mpTK+VV2zyF1R94lyjMb44QN
        oq/On4u0CrJTtuvwsOfHBQY=
X-Google-Smtp-Source: APXvYqyA6qJJoOQb4E86FHBdwrJlFoFZN3qAHVGaY8vHgOldufhdt8p9+yA5Gw7CyR9vTCGGUkjbwQ==
X-Received: by 2002:a62:2fc6:: with SMTP id v189mr568117pfv.136.1557808271884;
        Mon, 13 May 2019 21:31:11 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j12sm18331265pff.148.2019.05.13.21.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 21:31:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v6 1/5] t9350: fix encoding test to actually test reencoding
Date:   Mon, 13 May 2019 21:30:58 -0700
Message-Id: <20190514043102.31979-2-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gd18f03d1bf
In-Reply-To: <20190514043102.31979-1-newren@gmail.com>
References: <20190513231726.16218-1-newren@gmail.com>
 <20190514043102.31979-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test used an author with non-ascii characters in the name, but no
special commit message.  It then grep'ed for those non-ascii characters,
but those are guaranteed to exist regardless of the reencoding process
since the reencoding only affects the commit message, not the author or
committer names.  As such, the test would work even if the re-encoding
process simply stripped the commit message entirely.  Modify the test to
actually check that the reencoding into UTF-8 worked.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t9350-fast-export.sh                       | 27 ++++++++++++--------
 t/t9350/simple-iso-8859-7-commit-message.txt |  1 +
 2 files changed, 18 insertions(+), 10 deletions(-)
 create mode 100644 t/t9350/simple-iso-8859-7-commit-message.txt

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5690fe2810..756d6a9905 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -94,22 +94,30 @@ test_expect_success 'fast-export --show-original-ids | git fast-import' '
 	test $MUSS = $(git rev-parse --verify refs/tags/muss)
 '
 
-test_expect_success 'iso-8859-1' '
+test_expect_success 'iso-8859-7' '
 
-	git config i18n.commitencoding ISO8859-1 &&
-	# use author and committer name in ISO-8859-1 to match it.
-	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_config i18n.commitencoding iso-8859-7 &&
 	test_tick &&
 	echo rosten >file &&
-	git commit -s -m den file &&
-	git fast-export wer^..wer >iso8859-1.fi &&
-	sed "s/wer/i18n/" iso8859-1.fi |
+	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-message.txt" file &&
+	git fast-export wer^..wer >iso-8859-7.fi &&
+	sed "s/wer/i18n/" iso-8859-7.fi |
 		(cd new &&
 		 git fast-import &&
+		 # The commit object, if not re-encoded, would be 240 bytes.
+		 # Removing the "encoding iso-8859-7\n" header drops 20 bytes.
+		 # Re-encoding the Pi character from \xF0 (\360) in iso-8859-7
+		 # to \xCF\x80 (\317\200) in UTF-8 adds a byte.  Check for
+		 # the expected size.
+		 test 221 -eq "$(git cat-file -s i18n)" &&
+		 # ...and for the expected translation of bytes.
 		 git cat-file commit i18n >actual &&
-		 grep "Áéí óú" actual)
-
+		 grep $(printf "\317\200") actual &&
+		 # Also make sure the commit does not have the "encoding" header
+		 ! grep ^encoding actual)
 '
+
 test_expect_success 'import/export-marks' '
 
 	git checkout -b marks master &&
@@ -224,7 +232,6 @@ GIT_COMMITTER_NAME='C O Mitter'; export GIT_COMMITTER_NAME
 
 test_expect_success 'setup copies' '
 
-	git config --unset i18n.commitencoding &&
 	git checkout -b copy rein &&
 	git mv file file3 &&
 	git commit -m move1 &&
diff --git a/t/t9350/simple-iso-8859-7-commit-message.txt b/t/t9350/simple-iso-8859-7-commit-message.txt
new file mode 100644
index 0000000000..8b3f0c3dba
--- /dev/null
+++ b/t/t9350/simple-iso-8859-7-commit-message.txt
@@ -0,0 +1 @@
+Pi: �
\ No newline at end of file
-- 
2.21.0.782.gd18f03d1bf

