Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4EB1F4B6
	for <e@80x24.org>; Tue, 14 May 2019 04:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfENEbQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 00:31:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36004 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENEbP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 00:31:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so7579480plr.3
        for <git@vger.kernel.org>; Mon, 13 May 2019 21:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5AXA9AK0aUpKs6VmBNgXhqskGlcBafwGsYoWWGZJlUE=;
        b=mdAvxQkSctVrQX8CBmR7rhN+AYhriQgr00RpEufw3gFYdpoNPeHiD2xFKRcj8Yck9Q
         f6ohvgbjhcgYk5cn3fvdKPEfdrs/TdyyjXyeohvC9qAx9PZijNSSvzCx+TRk70VkGXN2
         ee7vq/cI4Sx1UgoWKb8igSc7RD1rF7WoiVIe0eGB2RDAxQGF2cb6gGevJVMjYCgOpbcz
         2dcCdrRqUb5GiI9Vt7/4vXz6q32hpDsI8ghMnsD6SiHOakqQjAz+xPTOL3EpUlxCimiv
         ljZvSbZwj9m7VLa6KQTIZH3BGZX7pRlPQXwlSeKAE/YpOlwb+z3IdhPGmwKTMIgXu+XV
         G8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5AXA9AK0aUpKs6VmBNgXhqskGlcBafwGsYoWWGZJlUE=;
        b=G/Pzs38OG/vdB1EVUzsPiTQR8lKoybVZ5l/V+c4Ex2XkPA4ArlF1erQn3JduEuAbOd
         26/JJcluOeOOUTcPWtN/L0yrONR1X2zl4WDe8wuFGlWsjxSFxVI52tmH3QXFF0939yhN
         M/rSWF7D38p8qnny3AwOZe+NMadgScG+RsAXe3Xvm+yhW369+wSn8lzALaaeKRls2Xy/
         RT6siotytQYnBY7tastsabpyx/9J4AaLP3YEmHgCOjkDmkltlAkjinFxgFFJUmLZk5Yj
         QL9DmHTC2mLX9cRVPq19U0X0igAqh4+Udghp2qch9bo7SBr9x2Z/Epasa9FSx6KKXsJJ
         5PnA==
X-Gm-Message-State: APjAAAUEoclTUMtL7ZzyrMU6VrTVeAxmH+M736qIBgB+NA6w7U8eXzYr
        +BkhRDcofkozLajzCRdVPmo=
X-Google-Smtp-Source: APXvYqxBIjb8dKv198nPiDuufb+T6eufJZckyyZZEfUA5p/v/6GrveiN3KyR9yC9yagOaf3pAj/NtA==
X-Received: by 2002:a17:902:d892:: with SMTP id b18mr36024288plz.209.1557808275006;
        Mon, 13 May 2019 21:31:15 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j12sm18331265pff.148.2019.05.13.21.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 21:31:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v6 3/5] fast-export: avoid stripping encoding header if we cannot reencode
Date:   Mon, 13 May 2019 21:31:00 -0700
Message-Id: <20190514043102.31979-4-newren@gmail.com>
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

When fast-export encounters a commit with an 'encoding' header, it tries
to reencode in UTF-8 and then drops the encoding header.  However, if it
fails to reencode in UTF-8 because e.g. one of the characters in the
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
index 756d6a9905..e2ab8eddc0 100755
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
2.21.0.782.gd18f03d1bf

