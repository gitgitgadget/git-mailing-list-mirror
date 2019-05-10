Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9B31F488
	for <e@80x24.org>; Fri, 10 May 2019 20:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfEJUxw (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 16:53:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41421 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfEJUxv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 16:53:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so3552269pgp.8
        for <git@vger.kernel.org>; Fri, 10 May 2019 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WNzs0yu8KKJfzui1gJDXSmXZbzQulSUDKj/7fDPN2w=;
        b=RYZt+buf8eZL6ap2Jhf/F3LnZoBEBwLoRrfDPXlibLZ7vfHqvxjhl0JrKkciQiL7Mj
         uMe0z7znCA+/dndy254kgiqp9ENcuYou3KPXLK7s1/fIeQr2Tyy22tIDdnVYK2f42cXZ
         WkEw66rPuuTq9NmI5wDtlz65qy0NMWkBHE2Tpa7V6pQLldzvajS9BetXBSmTWEi+FYST
         i/0wdmmgOupIgT3Xbsvrtt+DdLwtCnNiIsRn3HiWcVjp98fBgZdXjRX2X/Tup04lFVXP
         UCEyl+93e+AuXFNkR3dIhE7mD7rXTEbzWXmwB01hsZluaLqRTTB6A4YK/297zxCfoW/d
         VKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WNzs0yu8KKJfzui1gJDXSmXZbzQulSUDKj/7fDPN2w=;
        b=FvFIuo4UdpALRLuDo5aNJxCPovCcawqbL3cnXlhl6izE4OdHcAU1osRyLKvcFTmDlO
         woXHiM6hS4ZldcP68wjzCIBFIjgy/eOznxkaYPCtBretOgeA+eUa3JeDZpp3HRSkn+uQ
         yioTc9m2NFmg/5K/qYwpEdhQ8k6sx1P2HvODW9KEqNU2erV9mSZhTe6yqs8BI8nRxhJJ
         H6jOe7qvhBVZp5HzwzFQHsemTFaJk7wEkZcB1JOAMyhMFJ7ewyuphN4q8pd5JZOmlRv7
         44Fqf2z75I3aLeFjXzBZmtcB+LQ553g8tDTxVGSiKOc9hrHU9PtMZmSnzserKLENwyex
         eaFA==
X-Gm-Message-State: APjAAAXF3CELp0EzqCSqxsiwfPck/GfA9x/yazQjDiWSxE2RNJ3y0oTa
        p/nAAp+r78tK4dUa1O+RwkNDcU0c
X-Google-Smtp-Source: APXvYqwjZBvLMavKxdYUAYtOkFba4nhH9N9IhGEUmBt3qvVZrrndNNUNqqryuinzYJldngz/0Q5stA==
X-Received: by 2002:a65:6658:: with SMTP id z24mr16471643pgv.323.1557521630437;
        Fri, 10 May 2019 13:53:50 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id n127sm7305142pga.57.2019.05.10.13.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 May 2019 13:53:49 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 3/5] fast-export: avoid stripping encoding header if we cannot reencode
Date:   Fri, 10 May 2019 13:53:33 -0700
Message-Id: <20190510205335.19968-4-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g2063122293
In-Reply-To: <20190510205335.19968-1-newren@gmail.com>
References: <20190430182523.3339-1-newren@gmail.com>
 <20190510205335.19968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fast-export encounters a commit with an 'encoding' header, it tries
to reencode in utf-8 and then drops the encoding header.  However, if it
fails to reencode in utf-8 because e.g. one of the characters in the
commit message was invalid in the old encoding, then we need to retain
the original encoding or otherwise we lose information needed to
understand all the other (valid) characters in the original commit
message.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c                        |  7 +++++--
 t/t9350-fast-export.sh                       | 17 +++++++++++++++++
 t/t9350/broken-iso-8859-7-commit-message.txt |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 t/t9350/broken-iso-8859-7-commit-message.txt

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9e283482ef..7734a9f5a5 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -642,9 +642,12 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	printf("commit %s\nmark :%"PRIu32"\n", refname, last_idnum);
 	if (show_original_ids)
 		printf("original-oid %s\n", oid_to_hex(&commit->object.oid));
-	printf("%.*s\n%.*s\ndata %u\n%s",
+	printf("%.*s\n%.*s\n",
 	       (int)(author_end - author), author,
-	       (int)(committer_end - committer), committer,
+	       (int)(committer_end - committer), committer);
+	if (!reencoded && encoding)
+		printf("encoding %s\n", encoding);
+	printf("data %u\n%s",
 	       (unsigned)(reencoded
 			  ? strlen(reencoded) : message
 			  ? strlen(message) : 0),
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index ef9b1aa20b..fa124f4842 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -120,6 +120,23 @@ test_expect_success 'iso-8859-7' '
 		 ! grep ^encoding actual)
 '
 
+test_expect_success 'encoding preserved if reencoding fails' '
+
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_config i18n.commitencoding iso-8859-7 &&
+	echo rosten >file &&
+	git commit -s -F "$TEST_DIRECTORY/t9350/broken-iso-8859-7-commit-message.txt" file &&
+	git fast-export wer^..wer >iso-8859-7.fi &&
+	sed "s/wer/i18n-invalid/" iso-8859-7.fi |
+		(cd new &&
+		 git fast-import &&
+		 git cat-file commit i18n-invalid >actual &&
+		 grep ^encoding actual &&
+		 # Also verify that the commit has the expected size; i.e.
+		 # that no bytes were re-encoded to a different encoding.
+		 test 252 -eq "$(git cat-file -s i18n-invalid)")
+'
+
 test_expect_success 'import/export-marks' '
 
 	git checkout -b marks master &&
diff --git a/t/t9350/broken-iso-8859-7-commit-message.txt b/t/t9350/broken-iso-8859-7-commit-message.txt
new file mode 100644
index 0000000000..d06ad75b44
--- /dev/null
+++ b/t/t9350/broken-iso-8859-7-commit-message.txt
@@ -0,0 +1 @@
+Pi: ð; Invalid: ÿ
\ No newline at end of file
-- 
2.21.0.782.g2063122293

