Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4FD61F45F
	for <e@80x24.org>; Fri, 10 May 2019 20:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfEJUxs (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 16:53:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40332 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfEJUxs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 16:53:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so3554421pgl.7
        for <git@vger.kernel.org>; Fri, 10 May 2019 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thzPcNZYyZtDqqXJF1sl2c0x8kPsCKdG9c/FNxkgTHI=;
        b=b/2FhsSUNxQyl3QhGnqNMgPoTZyYNS/Xky6obOEvhXXNqRhIwdNwAjT4/6SXQfj/6s
         UxmAXSpKEB/MDoqs/TxGLoMUTW5D7kP12rzQoAa9dpqUYkDm5ctPN/X3/+mzikjdkbTX
         Ntx8CW5q7zLqMCG5NRvhcPTDQBvwPfKONeDEiRCETYcOhwbtx6IH8nO77ob8ciYaGlus
         qpKOCDI1xxZzj308VCzIZm7o6OLSoJgO0PCbXD1xFYYMXg47hrafmHlVgJM63uHSjxS8
         4VwwzR68I/tTlutkb5HI3og0zoqlBBRCB+RqVM+r00Q3llg44Pb1ndyxMob6CkaQSAGu
         d9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thzPcNZYyZtDqqXJF1sl2c0x8kPsCKdG9c/FNxkgTHI=;
        b=WxCisJwxFNRvCdXaOnnvdAVbN5Yrl/o1SKjmRuM3uk54o+fi+10UyPM7NMDdV7poON
         03wXl3v1GBVkDHHijS/zdR1OdpEOENMbhaodmSny4GTwvY8dTgS3gRLEA10CmFKbDS+s
         Ko41nKy9DBNzozzIbLKo3D9E4FChqHBHtcLA0jADEI6x6nAogNNPxOQB3sP/YfSWyuEv
         FY403MXxZ3Bnx7CMU3SGlBZGxpK7FCJO0zwf13rxM7VZDEQrS39uJcwbVUsfg5fbWT0t
         hhwBm3Jkzy/mcIHs5BXZJjgERR1j2Vv7GYd2e2XnDLH4BbklVHCQdY0UuvBlvzrJVioo
         z4OA==
X-Gm-Message-State: APjAAAUB+3wMhXeiUc/uaCGstfvJOw4h1q3PP7IiwhFutLfntd7J8Bu5
        Ucew6oT7pPFRtE3eJ4PLyuk=
X-Google-Smtp-Source: APXvYqwjy96W4GqssDnhnyLlDlvhDujDczR3yIsvZnJsCOGtKnLUiwHFC39L0S6bNIc9JGYhwqS+LA==
X-Received: by 2002:a65:5244:: with SMTP id q4mr15763341pgp.79.1557521627112;
        Fri, 10 May 2019 13:53:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id n127sm7305142pga.57.2019.05.10.13.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 May 2019 13:53:46 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 0/5] Fix and extend encoding handling in fast export/import
Date:   Fri, 10 May 2019 13:53:30 -0700
Message-Id: <20190510205335.19968-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g2063122293
In-Reply-To: <20190430182523.3339-1-newren@gmail.com>
References: <20190430182523.3339-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While stress testing `git filter-repo`, I noticed an issue with
encoding; further digging led to the fixes and features in this series.
See the individual commit messages for details.

Changes since v2 (full range-diff below):
  * Modified the testcases to pass on Windows[1], as verified via
    gitgitgadget pull request[2].  Required adding a couple new files
    (which store the desired bytes) and checking the size of the output
    instead of checking for particular bytes (but the lengths of the
    expected byte sequences differ so this works fine...).

[1] Failures of previous patchset on Windows noticed and reported by Dscho;
    explanation from Hannes is that Windows munges users' command lines to
    force them to be characters instead of bytes.
[2] https://github.com/gitgitgadget/git/pull/187

Elijah Newren (5):
t9350: fix encoding test to actually test reencoding
fast-import: support 'encoding' commit header
fast-export: avoid stripping encoding header if we cannot reencode
fast-export: differentiate between explicitly utf-8 and implicitly
utf-8
fast-export: do automatic reencoding of commit messages only if
requested

Documentation/git-fast-import.txt            |  7 ++
builtin/fast-export.c                        | 44 ++++++++++--
fast-import.c                                | 11 ++-
t/t9300-fast-import.sh                       | 20 ++++++
t/t9350-fast-export.sh                       | 75 +++++++++++++++++---
t/t9350/broken-iso-8859-7-commit-message.txt |  1 +
t/t9350/simple-iso-8859-7-commit-message.txt |  1 +
7 files changed, 142 insertions(+), 17 deletions(-)
create mode 100644 t/t9350/broken-iso-8859-7-commit-message.txt
create mode 100644 t/t9350/simple-iso-8859-7-commit-message.txt

Range-diff:
1:  9cc04242bd ! 1:  2d7bb64acf t9350: fix encoding test to actually test reencoding
    @@ -32,15 +32,26 @@
     -	git commit -s -m den file &&
     -	git fast-export wer^..wer >iso8859-1.fi &&
     -	sed "s/wer/i18n/" iso8859-1.fi |
    -+	git commit -s -m "$(printf "Pi: \360")" file &&
    ++	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-message.txt" file &&
     +	git fast-export wer^..wer >iso-8859-7.fi &&
     +	sed "s/wer/i18n/" iso-8859-7.fi |
      		(cd new &&
      		 git fast-import &&
    ++		 # The commit object, if not re-encoded, would be 240 bytes.
    ++		 # Removing the "encoding iso-8859-7\n" header drops 20 bytes.
    ++		 # Re-encoding the Pi character from \xF0 in iso-8859-7 to
    ++		 # \xCF\x80 in utf-8 adds a byte.  Grepping for specific bytes
    ++		 # would be nice, but Windows apparently munges user data
    ++		 # in the form of bytes on the command line to force them to
    ++		 # be characters instead, so we are limited for portability
    ++		 # reasons in subsequent similar tests in this file to check
    ++		 # for size rather than what bytes are present.
    ++		 test 221 -eq "$(git cat-file -s i18n)" &&
    ++		 # Also make sure the commit does not have the "encoding" header
      		 git cat-file commit i18n >actual &&
     -		 grep "ÃÃ©Ã­ Ã³Ãº" actual)
     -
    -+		 grep $(printf "\317\200") actual)
    ++		 ! grep ^encoding actual)
      '
     +
      test_expect_success 'import/export-marks' '
    @@ -54,3 +65,11 @@
      	git checkout -b copy rein &&
      	git mv file file3 &&
      	git commit -m move1 &&
    +
    + diff --git a/t/t9350/simple-iso-8859-7-commit-message.txt b/t/t9350/simple-iso-8859-7-commit-message.txt
    + new file mode 100644
    + --- /dev/null
    + +++ b/t/t9350/simple-iso-8859-7-commit-message.txt
    +@@
    ++Pi: ð
    + \ No newline at end of file
2:  0cd023ac7a = 2:  9fa5695017 fast-import: support 'encoding' commit header
3:  1fddf51402 ! 3:  dfc76573e9 fast-export: avoid stripping encoding header if we cannot reencode
    @@ -35,7 +35,7 @@
      --- a/t/t9350-fast-export.sh
      +++ b/t/t9350-fast-export.sh
     @@
    - 		 grep $(printf "\317\200") actual)
    + 		 ! grep ^encoding actual)
      '
      
     +test_expect_success 'encoding preserved if reencoding fails' '
    @@ -43,15 +43,26 @@
     +	test_when_finished "git reset --hard HEAD~1" &&
     +	test_config i18n.commitencoding iso-8859-7 &&
     +	echo rosten >file &&
    -+	git commit -s -m "$(printf "Pi: \360; Invalid: \377")" file &&
    ++	git commit -s -F "$TEST_DIRECTORY/t9350/broken-iso-8859-7-commit-message.txt" file &&
     +	git fast-export wer^..wer >iso-8859-7.fi &&
     +	sed "s/wer/i18n-invalid/" iso-8859-7.fi |
     +		(cd new &&
     +		 git fast-import &&
     +		 git cat-file commit i18n-invalid >actual &&
    -+		 grep ^encoding actual)
    ++		 grep ^encoding actual &&
    ++		 # Also verify that the commit has the expected size; i.e.
    ++		 # that no bytes were re-encoded to a different encoding.
    ++		 test 252 -eq "$(git cat-file -s i18n-invalid)")
     +'
     +
      test_expect_success 'import/export-marks' '
      
      	git checkout -b marks master &&
    +
    + diff --git a/t/t9350/broken-iso-8859-7-commit-message.txt b/t/t9350/broken-iso-8859-7-commit-message.txt
    + new file mode 100644
    + --- /dev/null
    + +++ b/t/t9350/broken-iso-8859-7-commit-message.txt
    +@@
    ++Pi: ð; Invalid: ÿ
    + \ No newline at end of file
4:  4a2e04b3ae = 4:  83b3656b76 fast-export: differentiate between explicitly utf-8 and implicitly utf-8
5:  44aacb1a0b ! 5:  2063122293 fast-export: do automatic reencoding of commit messages only if requested
    @@ -95,14 +95,14 @@
      	test_config i18n.commitencoding iso-8859-7 &&
      	test_tick &&
      	echo rosten >file &&
    - 	git commit -s -m "$(printf "Pi: \360")" file &&
    + 	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-message.txt" file &&
     -	git fast-export wer^..wer >iso-8859-7.fi &&
     +	git fast-export --reencode=yes wer^..wer >iso-8859-7.fi &&
      	sed "s/wer/i18n/" iso-8859-7.fi |
      		(cd new &&
      		 git fast-import &&
     @@
    - 		 grep $(printf "\317\200") actual)
    + 		 ! grep ^encoding actual)
      '
      
     +test_expect_success 'aborting on iso-8859-7' '
    @@ -110,7 +110,7 @@
     +	test_when_finished "git reset --hard HEAD~1" &&
     +	test_config i18n.commitencoding iso-8859-7 &&
     +	echo rosten >file &&
    -+	git commit -s -m "$(printf "Pi: \360")" file &&
    ++	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-message.txt" file &&
     +	test_must_fail git fast-export --reencode=abort wer^..wer >iso-8859-7.fi
     +'
     +
    @@ -119,13 +119,21 @@
     +	test_when_finished "git reset --hard HEAD~1" &&
     +	test_config i18n.commitencoding iso-8859-7 &&
     +	echo rosten >file &&
    -+	git commit -s -m "$(printf "Pi: \360")" file &&
    ++	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-message.txt" file &&
     +	git fast-export --reencode=no wer^..wer >iso-8859-7.fi &&
     +	sed "s/wer/i18n-no-recoding/" iso-8859-7.fi |
     +		(cd new &&
     +		 git fast-import &&
    ++		 # The commit object, if not re-encoded, is 240 bytes.
    ++		 # Removing the "encoding iso-8859-7\n" header would drops 20
    ++		 # bytes.  Re-encoding the Pi character from \xF0 in
    ++		 # iso-8859-7 to \xCF\x80 in utf-8 would add a byte.  I would
    ++		 # grep for the # specific bytes, but Windows lamely does not
    ++		 # allow that, so just search for the expected size.
    ++		 test 240 -eq "$(git cat-file -s i18n-no-recoding)" &&
    ++		 # Also make sure the commit has the "encoding" header
     +		 git cat-file commit i18n-no-recoding >actual &&
    -+		 grep $(printf "\360") actual)
    ++		 grep ^encoding actual)
     +'
     +
      test_expect_success 'encoding preserved if reencoding fails' '
    @@ -133,7 +141,7 @@
      	test_when_finished "git reset --hard HEAD~1" &&
      	test_config i18n.commitencoding iso-8859-7 &&
      	echo rosten >file &&
    - 	git commit -s -m "$(printf "Pi: \360; Invalid: \377")" file &&
    + 	git commit -s -F "$TEST_DIRECTORY/t9350/broken-iso-8859-7-commit-message.txt" file &&
     -	git fast-export wer^..wer >iso-8859-7.fi &&
     +	git fast-export --reencode=yes wer^..wer >iso-8859-7.fi &&
      	sed "s/wer/i18n-invalid/" iso-8859-7.fi |

-- 
2.21.0.782.g2063122293

