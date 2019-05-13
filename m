Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81B61F461
	for <e@80x24.org>; Mon, 13 May 2019 16:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfEMQrh (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 12:47:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43148 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfEMQrg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 12:47:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id c6so7492789pfa.10
        for <git@vger.kernel.org>; Mon, 13 May 2019 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iu0/cZfhDGxWaaJN6txnAFROn63Kq2g/U/Ny2x7aVbI=;
        b=Wr3orspsKaiGws41qkZ9InmbRzAv0MDE4j5c3CwdLDSZqn1RciQUaUqRLO4X53iggp
         YCQ3/iJZmvyVxCl4/soSKm2tzfEvTZrEFCsCYe24OYRz5f61IHqlEhR3qT4Hl+pY+h9X
         07qXUSSZ7ODpo6tMU48wJdiYFpy0iQX7QWgVeNFdAx1nOeNIAzHGxImmaW6MJveHOk1d
         HyhbctEk3vH9yYqdi3tI+venyeMr9+G/8y9DR98TQlITOQTIavjLVAeH7mqMmrV1Z4tP
         zbO0xIW3sX4HYpIhZS5NAxKqzKFFnvk8fA6HWo+L5fqF3z31xqPVntAnWVQtYvlmN4eX
         WfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iu0/cZfhDGxWaaJN6txnAFROn63Kq2g/U/Ny2x7aVbI=;
        b=S/8mpsrAIdSOjPA3/kK2ScauH41Bk3cVUjIV1IwtQj/gJ4hpGF4iw8//s0R9nbKTFY
         Ls89SaUp6SPBQsdSUY94kqsHMgKYCK3CjvJCzeGrbvX69cD1p0h/ZKXTtNr5ChQ7XS2Z
         xTTKr7YFQyGcvRvDRXetIhPdLbYce2OZPqUp2Z7j2BeN42c7JTkF07lDn/EgUp8JXnYv
         yok8oWEn79BSnBvfTv8Dp4PToX0aBrpZzjkCL7N9DL0T4/X6X2wR1AkA4/ZtCktHVSL7
         StMFv+bg6kuRlRNABpE6XtpnrJkNAYXI+uW/oHoZEeKWDGGnfIuFocXDymbsMi6mx11v
         oG1g==
X-Gm-Message-State: APjAAAWdfDLA1kuXWw2PkQA8Jh07hYYFbv3h0ISp5Cee0DdboEzz6X3y
        SDALH+XluL48zvC30UrjcAw=
X-Google-Smtp-Source: APXvYqyC45AprSKcBxxpvF79Q3BvYVjiBfdVq7XJXkp2JPP1C8SODLd9lEqwQzlXTU6q6nzDdBAPbw==
X-Received: by 2002:a63:5012:: with SMTP id e18mr31802668pgb.383.1557766055661;
        Mon, 13 May 2019 09:47:35 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id n35sm2851206pgl.44.2019.05.13.09.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 09:47:35 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 3/5] fast-export: avoid stripping encoding header if we cannot reencode
Date:   Mon, 13 May 2019 09:47:20 -0700
Message-Id: <20190513164722.31534-4-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g571613a09e
In-Reply-To: <20190513164722.31534-1-newren@gmail.com>
References: <20190510205335.19968-1-newren@gmail.com>
 <20190513164722.31534-1-newren@gmail.com>
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
2.21.0.782.g571613a09e

