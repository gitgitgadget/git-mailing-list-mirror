Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852AD1F45F
	for <e@80x24.org>; Fri, 10 May 2019 20:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfEJUxt (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 16:53:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44124 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfEJUxs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 16:53:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so3542121pgv.11
        for <git@vger.kernel.org>; Fri, 10 May 2019 13:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJjGD2+V9M0rU0nMPJ2HorVdg24TDeZr+I8byAqrzFY=;
        b=BwFcgATSvoZ6yv3rjiIlQ/VDEQxBD5eaqCZKBIgjEPkxGTmiwhWoBGHi1fbLEbKEqa
         u1mHDZiJ/TqNbrkZmYsBEE/T1ZG+dBeUxUFvhqmeXZMqwzQRpdTzvgH4FtblKBQTiMPz
         pCdmDUuFOscRnGiSJ1dYQnKQdKeuBWHBWYtZwLgh+1XiYj0rxyZJ82Hn/yTTAo6nluHS
         KlLOsNe2NC1mc2LRXJZbUFBlz7+Oih5K+Xr9pgSc3dr9ntPsYfGP3gJys83f4ItEVHGb
         FCe2UfibjP6q3OogA4bzH0qB7+6O0kM5Shh9Js21EcG/vk2FBtj8JwjB7elsUPMCB/Hg
         dilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJjGD2+V9M0rU0nMPJ2HorVdg24TDeZr+I8byAqrzFY=;
        b=th3BrJDTy6P46zUc/4H1d2f3gT1V0MtkB7+dc5IOvv3fv+fWMTsJTfJuSwYwMO8PmK
         q1xHSomJq/tPvT/atotulAVbrnbiW+wG1njaHJjv8NYbmT9ZrgeJ77QTwek5iwfMkn+O
         hExPoG4qVcIWEh6kYVuzGMQB0Jzm1pVDiNwm4pTSLK1/uJcdCC8SjgdGLPSCTzv4uSL+
         lncYbK06Af+VPs/rcKnpl8ItY1cmTbpf4XWGHzW3N2dErL9sIWzf5I31v1qZHFq4hdOu
         NNdKCzp3TffNX3PuAJYJWcX42FanC+D6sH2qTTje4rwsTCX2ZSm+M5WROBk+L4YypCJt
         zwWg==
X-Gm-Message-State: APjAAAVnZ8ITM9J1MtysTmNGeo/589+6TWD3uHT+UaZYunkdjde2/8Aa
        m36ngHNFB86lyZ0VKbWMJqY=
X-Google-Smtp-Source: APXvYqzh0RTnn0o73ySJUf/CivUdADFGuVDP06Mxy54BIsv/5ZufYWlFxy2mXMYsmnt3aLit3/Z3ig==
X-Received: by 2002:a62:4d03:: with SMTP id a3mr17553047pfb.2.1557521628130;
        Fri, 10 May 2019 13:53:48 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id n127sm7305142pga.57.2019.05.10.13.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 May 2019 13:53:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 1/5] t9350: fix encoding test to actually test reencoding
Date:   Fri, 10 May 2019 13:53:31 -0700
Message-Id: <20190510205335.19968-2-newren@gmail.com>
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

This test used an author with non-ascii characters in the name, but
no special commit message.  It then grep'ed for those non-ascii
characters, but those are guaranteed to exist regardless of the
reencoding process since the reencoding only affects the commit message,
not the author or committer names.  As such, the test would work even if
the re-encoding process simply stripped the commit message entirely.
Modify the test to actually check that the reencoding in utf-8 worked.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t9350-fast-export.sh                       | 29 +++++++++++++-------
 t/t9350/simple-iso-8859-7-commit-message.txt |  1 +
 2 files changed, 20 insertions(+), 10 deletions(-)
 create mode 100644 t/t9350/simple-iso-8859-7-commit-message.txt

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5690fe2810..ef9b1aa20b 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -94,22 +94,32 @@ test_expect_success 'fast-export --show-original-ids | git fast-import' '
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
+		 # Re-encoding the Pi character from \xF0 in iso-8859-7 to
+		 # \xCF\x80 in utf-8 adds a byte.  Grepping for specific bytes
+		 # would be nice, but Windows apparently munges user data
+		 # in the form of bytes on the command line to force them to
+		 # be characters instead, so we are limited for portability
+		 # reasons in subsequent similar tests in this file to check
+		 # for size rather than what bytes are present.
+		 test 221 -eq "$(git cat-file -s i18n)" &&
+		 # Also make sure the commit does not have the "encoding" header
 		 git cat-file commit i18n >actual &&
-		 grep "Áéí óú" actual)
-
+		 ! grep ^encoding actual)
 '
+
 test_expect_success 'import/export-marks' '
 
 	git checkout -b marks master &&
@@ -224,7 +234,6 @@ GIT_COMMITTER_NAME='C O Mitter'; export GIT_COMMITTER_NAME
 
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
2.21.0.782.g2063122293

