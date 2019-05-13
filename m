Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32FEF1F461
	for <e@80x24.org>; Mon, 13 May 2019 23:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEMXRj (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 19:17:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40952 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfEMXRi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 19:17:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so8003428pfn.7
        for <git@vger.kernel.org>; Mon, 13 May 2019 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yt+wTGv/xE0igXogS+6fzV8Emv9In2cdvRwxnsAd848=;
        b=LZPjLG8eNSTykDU8OlMbmOqBZrlzv5hOOVHhgHLBtmuM9dNNvfpCeS0AjLK/DLVIQu
         ys1rLZMTa0/b4cN1b1sTuWln5GWA7zDxYMgGKiIRxRTv9H79WVs7cASUd2d3DwcRgIU+
         QlVbpyNuJWuCDCwxlMcP/iraBIgXxi7U/Oe+1WFMV9DbNgC4vZzwpP/ne3dhOstfgiL/
         D8JT03eWr6SodV/K70k4I85aV9ZSGFZyUwcpRTcd3AdHbtPqM0TVd7iNDm9L9OBmF2ol
         qH8sAmHzJ/Vb9mfcdWHJd0mFt6NTb8YnT2Z1qUZNDd6I1hn6Ym3CqOMlrzPmgypIBVl1
         dlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yt+wTGv/xE0igXogS+6fzV8Emv9In2cdvRwxnsAd848=;
        b=sEuMrgC1qtL/e43WArzuWtaC4ArDncQxpoSoMe525lxt9oKnhRTTJUcyKgZlmsXpwi
         SvwwmgkclLISt/2SC5VLr5/v1I5fxaurmjjrVsDVg53eO7ps7DH4jve94tVA/X8inUuI
         pKkAiNjfB2Q5X7dad0tL+IUhJNLsUz2CYM15UBLyIGqs4rwOYzZ2a8KLHO8vdGC7ZWo3
         akH4n6XJ91G7Ji9VxHGUU/mrU3CbE2Djlo/fFn3M0oplbeS+LVRDIJLKna2IfYu5CBdi
         lHu970wBrCcHBLyollW/MVYcB1o229H1hDtK1wRXSnwOk+XtdlSsGua05mw/xY1t4IwQ
         85IA==
X-Gm-Message-State: APjAAAXe/svrQIHl8qNQyvOfw+yBMI1jOV/WKV5SSe/FwvMK1T+tnbcN
        xcru6NYiMv1/P6ZQHUk6xYk=
X-Google-Smtp-Source: APXvYqzgj1zy7LqFhgfeT2ZfsA245DmxV+O6vDO/8/HiO6hVY1Ch413eyCIKiHf/tU9f3Q8jxjqmMQ==
X-Received: by 2002:aa7:8a81:: with SMTP id a1mr36449589pfc.121.1557789457774;
        Mon, 13 May 2019 16:17:37 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id g10sm30664307pfg.153.2019.05.13.16.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 16:17:37 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 3/5] fast-export: avoid stripping encoding header if we cannot reencode
Date:   Mon, 13 May 2019 16:17:24 -0700
Message-Id: <20190513231726.16218-4-newren@gmail.com>
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
 t/t9350-fast-export.sh                       | 21 ++++++++++++++++++++
 t/t9350/broken-iso-8859-7-commit-message.txt |  1 +
 3 files changed, 27 insertions(+), 2 deletions(-)
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
index c721026260..4fd637312a 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -118,6 +118,27 @@ test_expect_success 'iso-8859-7' '
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
+		 # Make sure the commit still has the encoding header
+		 grep ^encoding actual &&
+		 # Verify that the commit has the expected size; i.e.
+		 # that no bytes were re-encoded to a different encoding.
+		 test 252 -eq "$(git cat-file -s i18n-invalid)" &&
+		 # ...and check for the original special bytes
+		 grep $(printf "\360") actual &&
+		 grep $(printf "\377") actual)
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
2.21.0.782.gd8be4ee826

