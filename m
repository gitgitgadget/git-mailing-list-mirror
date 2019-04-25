Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E2051F453
	for <e@80x24.org>; Thu, 25 Apr 2019 15:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfDYPv3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 11:51:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36621 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfDYPv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 11:51:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so61266pgc.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xXKRepJQ3cq0XLqXzeTfQ4xDiSV03kB7Y95atqgvqg=;
        b=P6v1CyAg929rAjoq9Fw/BQtal1CiI8wDHEgwAjKBHKAexvKYMx/Ajrrp2kGv4hvBMb
         sM6+akqtUKQBr4qNvIeKE4ihCoRWyig8HBy8hk8JGQu5eOUYfJPcy1mMHHDWcmA0ovgs
         0u7mMi8URZEOKYG4tNyqnw586FeY9Od64TpL592NXb0dHwF/VdFSXKj/dM1BYvaknkLA
         Rd3o6qFqUqQL0U5nl9LUKTiBB6phO8jHsyPqlBIlLj9NyQvuFKOdmTa0Z7BZuMa+fmp7
         OYyimjiX+WJYNPvwYYq2M8aldLZE0BlU7a6kcgv5gH4LggN0BlUH3dCWoG/c3lolJ4OC
         sJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xXKRepJQ3cq0XLqXzeTfQ4xDiSV03kB7Y95atqgvqg=;
        b=OSQcMywF+GVAOUGVe8IMAEF/dSu4LmS/ygMXWXf6kBrNJH6+a7GqSsngj3DAPrexm3
         s/8trdLFW4XYv9N9cnpgqNECvDyoD3CbN0A/w1HUit0pd+V5HN/KliBLnX3TIhcLiAjT
         WYg1sZxo/lOtQUdQnjLs0kzyNrtKBLAV408M0TE+05RE9T/8xmOmcPtnTDW39qigEQBS
         LUZ8nYd4vF8BC63OZSFE1H7OuVv76HaL+mmx5vA8b0DNnVa2fYx02EboLHUbAInl48k/
         7BPPhH4Ph3nfKe20hMGKkm6U9bszpjF1fgWCX5kmjirF61Vy62HxIUvpLmKy35y6kfD3
         iBuA==
X-Gm-Message-State: APjAAAUAayyxOr60ILvUksGGcNAJRjpr7HX9nwHt+R0TFbgY1U767Afv
        GzaSkAjGzQdSqw08asUJteguXNu1
X-Google-Smtp-Source: APXvYqz40b8kVkMzNGTsP5prynPiCpiT55L63UrRm4cp53zvf1H53TDjDfcyfWZTCOpvXBZ+1MirKQ==
X-Received: by 2002:aa7:8b4c:: with SMTP id i12mr22701467pfd.189.1556207486890;
        Thu, 25 Apr 2019 08:51:26 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id e6sm15244914pfe.158.2019.04.25.08.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2019 08:51:26 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/5] t9350: fix encoding test to actually test reencoding
Date:   Thu, 25 Apr 2019 08:51:14 -0700
Message-Id: <20190425155118.7918-2-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gb6cebc4909
In-Reply-To: <20190425155118.7918-1-newren@gmail.com>
References: <20190425155118.7918-1-newren@gmail.com>
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
 t/t9350-fast-export.sh | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5690fe2810..6c07f910eb 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -94,22 +94,22 @@ test_expect_success 'fast-export --show-original-ids | git fast-import' '
 	test $MUSS = $(git rev-parse --verify refs/tags/muss)
 '
 
-test_expect_success 'iso-8859-1' '
+test_expect_success 'iso-8859-7' '
 
-	git config i18n.commitencoding ISO8859-1 &&
-	# use author and committer name in ISO-8859-1 to match it.
-	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "git config --unset i18n.commitencoding" &&
+	git config i18n.commitencoding iso-8859-7 &&
 	test_tick &&
 	echo rosten >file &&
-	git commit -s -m den file &&
-	git fast-export wer^..wer >iso8859-1.fi &&
-	sed "s/wer/i18n/" iso8859-1.fi |
+	git commit -s -m "$(printf "Pi: \360")" file &&
+	git fast-export wer^..wer >iso-8859-7.fi &&
+	sed "s/wer/i18n/" iso-8859-7.fi |
 		(cd new &&
 		 git fast-import &&
 		 git cat-file commit i18n >actual &&
-		 grep "Áéí óú" actual)
-
+		 grep $(printf "\317\200") actual)
 '
+
 test_expect_success 'import/export-marks' '
 
 	git checkout -b marks master &&
@@ -224,7 +224,6 @@ GIT_COMMITTER_NAME='C O Mitter'; export GIT_COMMITTER_NAME
 
 test_expect_success 'setup copies' '
 
-	git config --unset i18n.commitencoding &&
 	git checkout -b copy rein &&
 	git mv file file3 &&
 	git commit -m move1 &&
-- 
2.21.0.779.g2f4b9c5032

