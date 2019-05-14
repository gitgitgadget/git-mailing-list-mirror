Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEBB91F461
	for <e@80x24.org>; Tue, 14 May 2019 04:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfENEbL (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 00:31:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44720 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENEbL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 00:31:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id g9so8374927pfo.11
        for <git@vger.kernel.org>; Mon, 13 May 2019 21:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q0DOeFHbhQx8Te52vA2Pf+kMCO5i1F/NiI5kqz/ZMdk=;
        b=K2ysvSPSIgwkVebZWR8WwETI7uPZgQA1H78gWpFGiV3WD9w4PgLQ0/tdd4Yqq1Gxqm
         gu0JOT/yw36wR1fhVvCiq/Gp8Z6FRWgF3dDX7zfGyEYwFED/huqzi+1zZuGTMMA5zB16
         jggYqzsX+d509up0n58EKwMW2oft4dsqvnXICUlBqryr6+41N/CCZtnSV0UE348OBYzn
         NnmZL9rF2Iw+dn76RdrFmDOZysB549bJcvjQVmEt5hj1ZX2BJu0eBE2aDku5JlZlHKn2
         0MNYy03Ys7NjkdZsKD05VSDiEvd0X2ooejY1KVUjW8K49tWH+Fqmvuv922Aa5M74gxRG
         f3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0DOeFHbhQx8Te52vA2Pf+kMCO5i1F/NiI5kqz/ZMdk=;
        b=mY1MWLeM3K2tUcEepvJR29WY8Iz4Tt0HX3nqI6HK1IOma6QxymvnGe+RN5neqxX/no
         Jy+khabuC61hxkFPpldKN6Cx//XUqfmAWNqcZhdAmF0jCIeMpi1fyy6JvnGNXLj+v7ya
         vQJOqPmuy8Eo0ClqkWZlEKJZs27k/Jyik8ZVwKurDQg153no1Apa9NfUn4uKqxbNTkzf
         hdRkdITXNCKofSvQE/GNuZxFVdBokqj5Rd+wSkt91B3XKWMQCB33XyRBGV3R9uNSKdlA
         aZdohPADaOjeVTiU8s0qYTS/41FnH5paiC8Oq0unsIF3dyQK59/LRJJCRepVWPio7XCR
         Ka8A==
X-Gm-Message-State: APjAAAU0H9kvubjDCVlJXmPOLzvjNZRhRUf0KysPTLwpj9B1C51DEyi7
        vt3gPDJjNdtjp3SH4gAEmoE=
X-Google-Smtp-Source: APXvYqyDiYV+IWEi6lLFwdwyojTxA3YzaggMvighimG6mLxawFQkoPjuvzMEcdcelWlAMu3U2FI5iw==
X-Received: by 2002:aa7:8212:: with SMTP id k18mr37944144pfi.50.1557808269829;
        Mon, 13 May 2019 21:31:09 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j12sm18331265pff.148.2019.05.13.21.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 21:31:08 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v6 0/5] Fix and extend encoding handling in fast export/import
Date:   Mon, 13 May 2019 21:30:57 -0700
Message-Id: <20190514043102.31979-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gd18f03d1bf
In-Reply-To: <20190513231726.16218-1-newren@gmail.com>
References: <20190513231726.16218-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While stress testing `git filter-repo`, I noticed an issue with
encoding; further digging led to the fixes and features in this series.
See the individual commit messages for details.

Changes since v5 (full range-diff below):
  * s/utf-8/UTF-8/, as pointed out by Torsten (in commit messages and comments)
  * small code cleanup pointed out by Eric
  * rewrap the first commit message

Elijah Newren (5):
  t9350: fix encoding test to actually test reencoding
  fast-import: support 'encoding' commit header
  fast-export: avoid stripping encoding header if we cannot reencode
  fast-export: differentiate between explicitly UTF-8 and implicitly
    UTF-8
  fast-export: do automatic reencoding of commit messages only if
    requested

 Documentation/git-fast-export.txt            |  7 ++
 Documentation/git-fast-import.txt            |  7 ++
 builtin/fast-export.c                        | 55 ++++++++++++--
 fast-import.c                                | 11 ++-
 t/t9300-fast-import.sh                       | 20 +++++
 t/t9350-fast-export.sh                       | 78 +++++++++++++++++---
 t/t9350/broken-iso-8859-7-commit-message.txt |  1 +
 t/t9350/simple-iso-8859-7-commit-message.txt |  1 +
 8 files changed, 163 insertions(+), 17 deletions(-)
 create mode 100644 t/t9350/broken-iso-8859-7-commit-message.txt
 create mode 100644 t/t9350/simple-iso-8859-7-commit-message.txt

Range-diff:
1:  37a68a0ffd ! 1:  b5dcdab662 t9350: fix encoding test to actually test reencoding
    @@ -2,13 +2,13 @@
     
         t9350: fix encoding test to actually test reencoding
     
    -    This test used an author with non-ascii characters in the name, but
    -    no special commit message.  It then grep'ed for those non-ascii
    -    characters, but those are guaranteed to exist regardless of the
    -    reencoding process since the reencoding only affects the commit message,
    -    not the author or committer names.  As such, the test would work even if
    -    the re-encoding process simply stripped the commit message entirely.
    -    Modify the test to actually check that the reencoding in utf-8 worked.
    +    This test used an author with non-ascii characters in the name, but no
    +    special commit message.  It then grep'ed for those non-ascii characters,
    +    but those are guaranteed to exist regardless of the reencoding process
    +    since the reencoding only affects the commit message, not the author or
    +    committer names.  As such, the test would work even if the re-encoding
    +    process simply stripped the commit message entirely.  Modify the test to
    +    actually check that the reencoding into UTF-8 worked.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
    @@ -40,7 +40,7 @@
     +		 # The commit object, if not re-encoded, would be 240 bytes.
     +		 # Removing the "encoding iso-8859-7\n" header drops 20 bytes.
     +		 # Re-encoding the Pi character from \xF0 (\360) in iso-8859-7
    -+		 # to \xCF\x80 (\317\200) in utf-8 adds a byte.  Check for
    ++		 # to \xCF\x80 (\317\200) in UTF-8 adds a byte.  Check for
     +		 # the expected size.
     +		 test 221 -eq "$(git cat-file -s i18n)" &&
     +		 # ...and for the expected translation of bytes.
2:  3d84f4613d ! 2:  af7d4e18fa fast-import: support 'encoding' commit header
    @@ -2,7 +2,7 @@
     
         fast-import: support 'encoding' commit header
     
    -    Since git supports commit messages with an encoding other than utf-8,
    +    Since git supports commit messages with an encoding other than UTF-8,
         allow fast-import to import such commits.  This may be useful for folks
         who do not want to reencode commit messages from an external system, and
         may also be useful to achieve reversible history rewrites (e.g. sha1sum
3:  baa8394a3a ! 3:  d5b300692a fast-export: avoid stripping encoding header if we cannot reencode
    @@ -3,8 +3,8 @@
         fast-export: avoid stripping encoding header if we cannot reencode
     
         When fast-export encounters a commit with an 'encoding' header, it tries
    -    to reencode in utf-8 and then drops the encoding header.  However, if it
    -    fails to reencode in utf-8 because e.g. one of the characters in the
    +    to reencode in UTF-8 and then drops the encoding header.  However, if it
    +    fails to reencode in UTF-8 because e.g. one of the characters in the
         commit message was invalid in the old encoding, then we need to retain
         the original encoding or otherwise we lose information needed to
         understand all the other (valid) characters in the original commit
4:  49960164c6 ! 4:  2cef40c613 fast-export: differentiate between explicitly utf-8 and implicitly utf-8
    @@ -1,11 +1,11 @@
     Author: Elijah Newren <newren@gmail.com>
     
    -    fast-export: differentiate between explicitly utf-8 and implicitly utf-8
    +    fast-export: differentiate between explicitly UTF-8 and implicitly UTF-8
     
         The find_encoding() function returned the encoding used by a commit
    -    message, returning a default of git_commit_encoding (usually utf-8).
    +    message, returning a default of git_commit_encoding (usually UTF-8).
         Although the current code does not differentiate between a commit which
    -    explicitly requested utf-8 and one where we just assume utf-8 because no
    +    explicitly requested UTF-8 and one where we just assume UTF-8 because no
         encoding is set, it will become important when we try to preserve the
         encoding header.  Since is_encoding_utf8() returns true when passed
         NULL, we can just return NULL from find_encoding() instead of returning
5:  d8be4ee826 ! 5:  d18f03d1bf fast-export: do automatic reencoding of commit messages only if requested
    @@ -62,7 +62,7 @@
     +		reencode_mode = REENCODE_YES;
     +		break;
     +	default:
    -+		if (arg && !strcasecmp(arg, "abort"))
    ++		if (!strcasecmp(arg, "abort"))
     +			reencode_mode = REENCODE_ABORT;
     +		else
     +			return error("Unknown reencoding mode: %s", arg);
    @@ -156,7 +156,7 @@
     +		 # The commit object, if not re-encoded, is 240 bytes.
     +		 # Removing the "encoding iso-8859-7\n" header would drops 20
     +		 # bytes.  Re-encoding the Pi character from \xF0 (\360) in
    -+		 # iso-8859-7 to \xCF\x80 (\317\200) in utf-8 adds a byte.
    ++		 # iso-8859-7 to \xCF\x80 (\317\200) in UTF-8 adds a byte.
     +		 # Check for the expected size...
     +		 test 240 -eq "$(git cat-file -s i18n-no-recoding)" &&
     +		 # ...as well as the expected byte.
-- 
2.21.0.782.gd18f03d1bf

