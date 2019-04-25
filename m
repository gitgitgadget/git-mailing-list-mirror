Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5AF1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 15:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfDYPvc (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 11:51:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44922 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfDYPva (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 11:51:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so39700pgv.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0pan+jubN3FbM6wnXkNvfYqTU0f3coUCryga+dFXdw=;
        b=jSH/z1SYo7vvRGoM3p/e04Z+BLjb3WUlDPA6LFrJGWnqZhdZ1akvQ7K3v/uy36PFkX
         RV0HD+nMidsP71rM01zPmYBWKckGOOQWBaBIuQPhFGkHtX+FxZbJh1+LOQaEhWNg/kvn
         PVeILyTpWnLVxFHrMk154JcJxButmuZYEuPVG6Sc1pW9q52488VOox/jhtFtwr0iPza5
         TKKD0nHxpfN5anKe+vIWu5qRV1+AdcyyDfslNvZtFNKcKKP9M9IZmWXgKSOGCogqYE67
         rbhw2U4z5KS/al4n8w09GJg7lWUBheHFQortwrgk0ztDIw1YT+ai0YFtzpK7IfHKH0di
         bnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0pan+jubN3FbM6wnXkNvfYqTU0f3coUCryga+dFXdw=;
        b=oVFZCiCWNg8GdegI5L01oKKPsOGRMv6g7Ugyp3rPDi87qh3B/fAPHDpodQaYWLXfhc
         XrlFav06ORyYz4kJT3N4q8nn4JIEHWXWqXSdAk1p/LRJUNDWfhMVUAi8Nr/455jdrZh6
         ks5qEoM39ebEdbn9fw3mGrohaQ5qL0zaWZEbtrmG8A7Yq2RUraCqqeJHXbHB0SV9Cno6
         BoWsE08JRlSSC7f8qK3mwG5tJgo/Hag5KicUJofMLSNRonrciMUrrG+ACvviQcuNUnG0
         mnm3CYRbhcYqWore+wMuqARqg0tBYZ3ftCGJJ1E9/uVPTHcPrJYZ7leXve/HrkNzuwc8
         0ZCA==
X-Gm-Message-State: APjAAAV2r6TfBX6QvpIaCthWYl7/377yzwP5WPXvOvr9vfjHhhY9XlWL
        BF7vqxCCvugteEMHozJB8uZf5wkG
X-Google-Smtp-Source: APXvYqzV4/2v0/tKb2WEkzkBqje1z1Bo0trAFYK05E1oVHJLjhaTlQgoYlk12By+xdA9L5lnlD6yJg==
X-Received: by 2002:a63:d34b:: with SMTP id u11mr6085886pgi.385.1556207489510;
        Thu, 25 Apr 2019 08:51:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id e6sm15244914pfe.158.2019.04.25.08.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2019 08:51:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/5] fast-export: avoid stripping encoding header if we cannot reencode
Date:   Thu, 25 Apr 2019 08:51:16 -0700
Message-Id: <20190425155118.7918-4-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gb6cebc4909
In-Reply-To: <20190425155118.7918-1-newren@gmail.com>
References: <20190425155118.7918-1-newren@gmail.com>
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
 t/t9350-fast-export.sh | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

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
index 6c07f910eb..975c8c4014 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -110,6 +110,21 @@ test_expect_success 'iso-8859-7' '
 		 grep $(printf "\317\200") actual)
 '
 
+test_expect_success 'encoding preserved if reencoding fails' '
+
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "git config --unset i18n.commitencoding" &&
+	git config i18n.commitencoding iso-8859-7 &&
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
2.21.0.779.g2f4b9c5032

