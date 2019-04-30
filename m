Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704FF1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 18:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfD3SZd (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 14:25:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34987 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfD3SZc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 14:25:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so7234256pgs.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOg7K3U0YRtXmjZF9lIBSBumTpKCe56z9DZr7rHuGvM=;
        b=XKwRM6rDCw7nF7o2nj+6gT0/Z6kmqvR56uPL0zDyJE4rRLtsc/3duhu+TL77HvrnLQ
         p76qAIEkrRSSNqlSHHmBz9CKeY5YTt0JpEHcKC7e9aSTTY0cjdyZjoKa8+jOZm5kO26C
         nwkC3mFgGrGlHUIOXgfRBwo508Wb/Lxvd55zxQhMiwkvOSDB8CiCzQbz/ksTvD6hzhDK
         xhBDRXacKy/wZQrF41NTdd4wez6JP3P/UrXHbFgjd3ZWT+Uo/UDLI/4zHSneyzcSTEM7
         MzjQD0I4+0o44rnVXVlQsQFGIYJ5vv3coT4iN0PZACE9irkh0OWS7mAskUFCc2na9fY3
         Tbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOg7K3U0YRtXmjZF9lIBSBumTpKCe56z9DZr7rHuGvM=;
        b=WFTGm+RPvYVRMuh7k4AnpcN18jSNlkokGaFpg6SIMgzBxpRuG/KJaZWdL5eOqEzvgV
         UXGmyDe9fNrX36KuYLIgkb1HdcU7Xw/m83kRUUVco2jIrul2c7AkVjJz77Xw1H7z6EIS
         5dTGociVdgsKmrGlTe1a2Ufud1qjZmATlZt/FZjtzxKePebhG1d3PpdmKTMaZMdFa0cY
         Nq/LxNr+n9xYG2xp7vPMtEBFbsI3V0bVf7D9lh80MUoinedGeUcznm57XJV03TC/oCwk
         zdFQ7/ukK4VkkzPypCQlDjzNtw2dhChy72TgpvTP4gQFnP+Wov9lVcveouM76lcySS28
         KSSw==
X-Gm-Message-State: APjAAAX73lMLGDt4Cu8tdG8V9SYmD8MlvNNM+g274ZJDKJ7qMJlSi4Kj
        7NXWAsU9KaMoaLZ+nIZTXxc=
X-Google-Smtp-Source: APXvYqzXhOCkS7naQUPOCGqPaSjeagElo9NuB5jN7kVF+xIPIvO81lsVERhSmqbC8f6sq9g5rJAOtQ==
X-Received: by 2002:a63:fd06:: with SMTP id d6mr68740201pgh.183.1556648731433;
        Tue, 30 Apr 2019 11:25:31 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id p2sm111217508pfi.73.2019.04.30.11.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Apr 2019 11:25:30 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/5] t9350: fix encoding test to actually test reencoding
Date:   Tue, 30 Apr 2019 11:25:19 -0700
Message-Id: <20190430182523.3339-2-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g44aacb1a0b
In-Reply-To: <20190430182523.3339-1-newren@gmail.com>
References: <20190430182523.3339-1-newren@gmail.com>
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
 t/t9350-fast-export.sh | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 5690fe2810..f55759651a 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -94,22 +94,21 @@ test_expect_success 'fast-export --show-original-ids | git fast-import' '
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
@@ -224,7 +223,6 @@ GIT_COMMITTER_NAME='C O Mitter'; export GIT_COMMITTER_NAME
 
 test_expect_success 'setup copies' '
 
-	git config --unset i18n.commitencoding &&
 	git checkout -b copy rein &&
 	git mv file file3 &&
 	git commit -m move1 &&
-- 
2.21.0.782.g44aacb1a0b

