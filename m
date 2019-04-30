Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07611F453
	for <e@80x24.org>; Tue, 30 Apr 2019 18:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfD3SZh (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 14:25:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37277 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfD3SZe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 14:25:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id z8so7126981pln.4
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VnwFBj5ZRBwbwUborlMJop//jbijPEB1BcYp0OsKUfw=;
        b=EqjTq1wmBFPUhkqN743MtMUDqM16J3m86QRv6ty1IvFbkUX7OElEg+7N7dH4jUFbjg
         SmDG7rwoIWjydLapoBAzxMVdSwp8dZLfEQVAj629StqAASyrmAljCM3BM19bkuWkYAlV
         tZaG1x3vc0RV5JmehQvfSUFHK0VI7mg6VA4kkHINKtlU0mGVbqQUzv6Zlvq3OcatG2cC
         DBIBbEQvyb73f+6g/Xpemwkq/8P1Kh5zTEQdp8IcYgMtHY1A9uEC80kjprMqlGaMxico
         rEwWu5GMMPClVuE+6NOivyowouv1iAhgWRK5uKWyKRzqHvsYwFFuFZtoYLDSLJRUD5fh
         vYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VnwFBj5ZRBwbwUborlMJop//jbijPEB1BcYp0OsKUfw=;
        b=nSuSy69jdWWxyvmgT6XHAA3Rtp4mlxYQZ3AbtfzgceeCfL6siwiRBTWV3y0lZ8nTQb
         CnJ4FV/cHIIHi0m3m2t+NPCaGDOS/zhaZa5ODRKdyJFlN65c1fNrsWt6ltyvHUpEiQwo
         sTk7qPE/Efi0+nHHv/g1lbhjm/bsvxoLZs12FQHBlIJSOWl0wrqb4UHElharDfGseyGK
         24vdb2dyTzdyfTx+PcWioN1saZmiEKjwLb4+duxbUAfjaNJ2vPy2HuPNmXBBkTHbGMFA
         kyVS3QNw8MRkZEBuZzvR6LjAybrpRA/2zGKTP20tk6+0ZXk0Vdcz/F1HyUBJryNcF39h
         CDAQ==
X-Gm-Message-State: APjAAAUYnsqrRHoD8o5kkR16PVh3By7C6Hd+5WHG6+dmkUs4v6wNdmj7
        KfAqLnYyCYl3zrWzwQrLWRE=
X-Google-Smtp-Source: APXvYqx1AqrTDxmVBvNPIaxX6BZ+WiTTKLzgIndApWlpSuFoCoDjtf32GQdLWOwuTk7IxSu3w7DwEw==
X-Received: by 2002:a17:902:5a42:: with SMTP id f2mr10693004plm.135.1556648733689;
        Tue, 30 Apr 2019 11:25:33 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id p2sm111217508pfi.73.2019.04.30.11.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Apr 2019 11:25:33 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/5] fast-export: avoid stripping encoding header if we cannot reencode
Date:   Tue, 30 Apr 2019 11:25:21 -0700
Message-Id: <20190430182523.3339-4-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g44aacb1a0b
In-Reply-To: <20190430182523.3339-1-newren@gmail.com>
References: <20190430182523.3339-1-newren@gmail.com>
MIME-Version: 1.0
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
 builtin/fast-export.c  |  7 +++++--
 t/t9350-fast-export.sh | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

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
index f55759651a..67dd7ac7f4 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -109,6 +109,20 @@ test_expect_success 'iso-8859-7' '
 		 grep $(printf "\317\200") actual)
 '
 
+test_expect_success 'encoding preserved if reencoding fails' '
+
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_config i18n.commitencoding iso-8859-7 &&
+	echo rosten >file &&
+	git commit -s -m "$(printf "Pi: \360; Invalid: \377")" file &&
+	git fast-export wer^..wer >iso-8859-7.fi &&
+	sed "s/wer/i18n-invalid/" iso-8859-7.fi |
+		(cd new &&
+		 git fast-import &&
+		 git cat-file commit i18n-invalid >actual &&
+		 grep ^encoding actual)
+'
+
 test_expect_success 'import/export-marks' '
 
 	git checkout -b marks master &&
-- 
2.21.0.782.g44aacb1a0b

