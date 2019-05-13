Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B581F461
	for <e@80x24.org>; Mon, 13 May 2019 23:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEMXRh (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 19:17:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34552 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEMXRg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 19:17:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id c13so7562674pgt.1
        for <git@vger.kernel.org>; Mon, 13 May 2019 16:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqsMqqElwe2xM0IWZVcICVsuQDuXVAJPknzhLFA7feU=;
        b=Qbo08iwheCZNUGxSlRKSsnTivytVclLV1wNK1JTt49KVkQRIhU+aoiE6Zx5mr7u7v3
         nO5A4QFKAJQJUTWoSARC63EN6X4VUlpn1i1azG30Il6TdDmEtia0qGYWa7HjOXgPydPE
         YlBruDCeT86rOGTOHHJFyNHzHNAgGMWNl/uWhvkj8UGMtRrRAhpubJfbPKKH6nFLSIqb
         6L6fpgeslzr0z3XTDevXMzFkz5SO6vpKOqU5daA8ZOd19+4SCsidlHHDqxABLvXEOYT0
         1NKYvfSsNp1+Lf7+pobK36JTz9m08GzU6Q4FDvZVsGH0jpgygCLMIBRbufGhgpkLZjwk
         nhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqsMqqElwe2xM0IWZVcICVsuQDuXVAJPknzhLFA7feU=;
        b=Mic7JHp95hqQHgTGbMBbIqpS6Kk2R1AkloFjAWQaW89IhVzl6q51gj4oMq285GfspR
         mZ0bDk52A0tn1mSpsenO5cBYy/EX9/F6iy6EuRmceDLy6ZlXd79a7OMcEj5hya+GLboP
         PQGX8zDOalDIPiTAY3O6Cn621h/VGmZdfPAIdSZeDmJ0bDL4lJzpp2wgBDZdHpjZv7hF
         puOo72JFu822zjqhaS7f+llqSuahOJ23bxN8Z+sJbIZOeuPnHchZsfsATDHCxNg3ivV3
         7CE2Cq24tyRLsG7pvaDcIlbFSHbuQTvBgTZd0EjYDCNJ/f3aUIMnslF0BRH/b3GprxuU
         bePw==
X-Gm-Message-State: APjAAAWFL7/O+tRSqdNaPYqLaY5hyM2l06PeLWwp98Ua5/zcrlHgsdH1
        4P/cKqSUp+elkMRo3fhngNk=
X-Google-Smtp-Source: APXvYqxwzYPrwh3phDW+TeoDypJYtS4C/YcPMCb1ZQHm2N+ZMYczs1m4qjLsDTlBphaEX7EMroP2VQ==
X-Received: by 2002:a63:1160:: with SMTP id 32mr34669815pgr.106.1557789455529;
        Mon, 13 May 2019 16:17:35 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id g10sm30664307pfg.153.2019.05.13.16.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 16:17:34 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 1/5] t9350: fix encoding test to actually test reencoding
Date:   Mon, 13 May 2019 16:17:22 -0700
Message-Id: <20190513231726.16218-2-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gd8be4ee826
In-Reply-To: <20190513231726.16218-1-newren@gmail.com>
References: <20190513164722.31534-1-newren@gmail.com>
 <20190513231726.16218-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test used an author with non-ascii characters in the name, but
no special commit message.  It then grep'ed for those non-ascii
characters, but those are guaranteed to exist regardless of the
reencoding process since the reencoding only affects the commit message,
not the author or committer names.  As such, the test would work even if
the re-encoding process simply stripped the commit message entirely.
Modify the test to actually check that the reencoding in utf-8 worked.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t9350-fast-export.sh                       | 27 ++++++++++++--------
 t/t9350/simple-iso-8859-7-commit-message.txt |  1 +
 2 files changed, 18 insertions(+), 10 deletions(-)
 create mode 100644 t/t9350/simple-iso-8859-7-commit-message.txt

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5690fe2810..c721026260 100755
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
+		 # to \xCF\x80 (\317\200) in utf-8 adds a byte.  Check for
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
2.21.0.782.gd8be4ee826

