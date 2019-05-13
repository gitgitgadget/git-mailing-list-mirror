Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A34B1F461
	for <e@80x24.org>; Mon, 13 May 2019 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfEMQrd (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 12:47:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41878 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfEMQrd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 12:47:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so7053824pgp.8
        for <git@vger.kernel.org>; Mon, 13 May 2019 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nvhDdzu3LphRbtp/OSTXIvEIE6QAdQfjBNd1JV7NHCA=;
        b=UBhwLVgR4d0BNeCGl0SbjGETrVQXa0aYjcyIzYq/lYtrjwM1pTol193fLM+5JZmFEP
         DSeFEeNOA3NliWrLCtfAWZ/ZIJ3bF3QEzn1ZKSYibnjZ5OpVEtwMdPem8YsfbNs4/3mS
         DX5uJFqWycCxEd4wai3ovImgmRIupVmXCmwaLa3XkjVjVLSvG8wXhqI4tgg+XrG6lVQM
         /uvx2Z+SkW7pbBPpaBl3JaPJjyk4l5ZAITOQ15xzVurJdXBI9irnrtayP4UVuIHbTiLE
         8qoaAfKLuIRxVbJGJDd0izYXDUpLB98QZQdjPlRdt5PIBu+kdfJz+qoVu/r+GVpuXaxZ
         j7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nvhDdzu3LphRbtp/OSTXIvEIE6QAdQfjBNd1JV7NHCA=;
        b=VdAMT2Fbt+MyfBnCSIVo4RpsFmubhQJHs4GM9jqgZBvZ9E4h/6A9DIH2Xo8T9oz94v
         Po8eZyrFc3Pbhtm+3iHNpLJoKXj9z0w0NfRjJVQBaaJw+28ObxJBeubaWM9i0KVZ+IaZ
         sC1bT7EZBMIcbaT7mmFAtKLpKzXSc8/SlcbdeIdonEHT3YNrdBbfL0Amhg9WVl/fY8Ba
         usJ7Pi0WmIbXF6cWR5+zbC5Qy3VXPIoGkiBWztQ0vrq+0dDXVXS6wewtaoh5gc6L0h+z
         g7/vXYOrxYmdl0D9sSo7IhFxyw76bodBnzcsJtsK65suHUT1tAR/ybvKL69AJj9+HO/D
         H4Ow==
X-Gm-Message-State: APjAAAXfQHie+Oh4depPW/8sqUBUo1kdK0RdlyZeY5M+K2oH+B951IE6
        21P7ATzdSu0XLOGrlJUt68w=
X-Google-Smtp-Source: APXvYqwaZckdj5NZvNcsHSjcGHQfL7NiTPQqaUSKTnAtPDdwNvNMNUa/PNVIQvbhhQDZFwUPG7+gOg==
X-Received: by 2002:a63:3:: with SMTP id 3mr31751706pga.360.1557766051732;
        Mon, 13 May 2019 09:47:31 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id n35sm2851206pgl.44.2019.05.13.09.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 09:47:30 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 0/5] Fix and extend encoding handling in fast export/import
Date:   Mon, 13 May 2019 09:47:17 -0700
Message-Id: <20190513164722.31534-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g571613a09e
In-Reply-To: <20190510205335.19968-1-newren@gmail.com>
References: <20190510205335.19968-1-newren@gmail.com>
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

Changes since v3 (full range-diff below):
  * YES/NO changes suggested by Torsten
  * more boolean synonyms as suggested by Junio
  * check for the exact expected special bytes, in addition to the size
    (Dscho pointed out that it was GitForWindows that munged bytes, not
     Windows, so while I need to be careful in what I pass to git, printf
     and grep can work directly with the special bytes)
  * also checked on gitgitgadget that it passes on the major platforms

[1] https://github.com/gitgitgadget/git/pull/191

Elijah Newren (5):
  t9350: fix encoding test to actually test reencoding
  fast-import: support 'encoding' commit header
  fast-export: avoid stripping encoding header if we cannot reencode
  fast-export: differentiate between explicitly utf-8 and implicitly
    utf-8
  fast-export: do automatic reencoding of commit messages only if
    requested

 Documentation/git-fast-import.txt            |  7 ++
 builtin/fast-export.c                        | 44 +++++++++--
 fast-import.c                                | 11 ++-
 t/t9300-fast-import.sh                       | 20 +++++
 t/t9350-fast-export.sh                       | 78 +++++++++++++++++---
 t/t9350/broken-iso-8859-7-commit-message.txt |  1 +
 t/t9350/simple-iso-8859-7-commit-message.txt |  1 +
 7 files changed, 145 insertions(+), 17 deletions(-)
 create mode 100644 t/t9350/broken-iso-8859-7-commit-message.txt
 create mode 100644 t/t9350/simple-iso-8859-7-commit-message.txt

Range-diff:
1:  2d7bb64acf ! 1:  37a68a0ffd t9350: fix encoding test to actually test reencoding
    @@ -39,18 +39,16 @@
      		 git fast-import &&
     +		 # The commit object, if not re-encoded, would be 240 bytes.
     +		 # Removing the "encoding iso-8859-7\n" header drops 20 bytes.
    -+		 # Re-encoding the Pi character from \xF0 in iso-8859-7 to
    -+		 # \xCF\x80 in utf-8 adds a byte.  Grepping for specific bytes
    -+		 # would be nice, but Windows apparently munges user data
    -+		 # in the form of bytes on the command line to force them to
    -+		 # be characters instead, so we are limited for portability
    -+		 # reasons in subsequent similar tests in this file to check
    -+		 # for size rather than what bytes are present.
    ++		 # Re-encoding the Pi character from \xF0 (\360) in iso-8859-7
    ++		 # to \xCF\x80 (\317\200) in utf-8 adds a byte.  Check for
    ++		 # the expected size.
     +		 test 221 -eq "$(git cat-file -s i18n)" &&
    -+		 # Also make sure the commit does not have the "encoding" header
    ++		 # ...and for the expected translation of bytes.
      		 git cat-file commit i18n >actual &&
     -		 grep "Áéí óú" actual)
     -
    ++		 grep $(printf "\317\200") actual &&
    ++		 # Also make sure the commit does not have the "encoding" header
     +		 ! grep ^encoding actual)
      '
     +
2:  9fa5695017 = 2:  3d84f4613d fast-import: support 'encoding' commit header
3:  dfc76573e9 ! 3:  baa8394a3a fast-export: avoid stripping encoding header if we cannot reencode
    @@ -49,10 +49,14 @@
     +		(cd new &&
     +		 git fast-import &&
     +		 git cat-file commit i18n-invalid >actual &&
    ++		 # Make sure the commit still has the encoding header
     +		 grep ^encoding actual &&
    -+		 # Also verify that the commit has the expected size; i.e.
    ++		 # Verify that the commit has the expected size; i.e.
     +		 # that no bytes were re-encoded to a different encoding.
    -+		 test 252 -eq "$(git cat-file -s i18n-invalid)")
    ++		 test 252 -eq "$(git cat-file -s i18n-invalid)" &&
    ++		 # ...and check for the original special bytes
    ++		 grep $(printf "\360") actual &&
    ++		 grep $(printf "\377") actual)
     +'
     +
      test_expect_success 'import/export-marks' '
4:  83b3656b76 = 4:  49960164c6 fast-export: differentiate between explicitly utf-8 and implicitly utf-8
5:  2063122293 ! 5:  571613a09e fast-export: do automatic reencoding of commit messages only if requested
    @@ -20,7 +20,7 @@
      static int progress;
      static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
      static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
    -+static enum { REENCODE_ABORT, REENCODE_PLEASE, REENCODE_NEVER } reencode_mode = REENCODE_ABORT;
    ++static enum { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
      static int fake_missing_tagger;
      static int use_done_feature;
      static int no_data;
    @@ -33,10 +33,10 @@
     +{
     +	if (unset || !strcmp(arg, "abort"))
     +		reencode_mode = REENCODE_ABORT;
    -+	else if (!strcmp(arg, "yes"))
    -+		reencode_mode = REENCODE_PLEASE;
    -+	else if (!strcmp(arg, "no"))
    -+		reencode_mode = REENCODE_NEVER;
    ++	else if (!strcmp(arg, "yes") || !strcmp(arg, "true") || !strcmp(arg, "on"))
    ++		reencode_mode = REENCODE_YES;
    ++	else if (!strcmp(arg, "no") || !strcmp(arg, "false") || !strcmp(arg, "off"))
    ++		reencode_mode = REENCODE_NO;
     +	else
     +		return error("Unknown reencoding mode: %s", arg);
     +	return 0;
    @@ -56,14 +56,14 @@
     -		reencoded = reencode_string(message, "UTF-8", encoding);
     +	} else if (encoding) {
     +		switch(reencode_mode) {
    -+		case REENCODE_PLEASE:
    ++		case REENCODE_YES:
     +			reencoded = reencode_string(message, "UTF-8", encoding);
     +			break;
    -+		case REENCODE_NEVER:
    ++		case REENCODE_NO:
     +			break;
     +		case REENCODE_ABORT:
     +			die("Encountered commit-specific encoding %s in commit "
    -+			    "%s; use --reencode=<mode> to handle it",
    ++			    "%s; use --reencode=[yes|no] to handle it",
     +			    encoding, oid_to_hex(&commit->object.oid));
     +		}
     +	}
    @@ -126,13 +126,14 @@
     +		 git fast-import &&
     +		 # The commit object, if not re-encoded, is 240 bytes.
     +		 # Removing the "encoding iso-8859-7\n" header would drops 20
    -+		 # bytes.  Re-encoding the Pi character from \xF0 in
    -+		 # iso-8859-7 to \xCF\x80 in utf-8 would add a byte.  I would
    -+		 # grep for the # specific bytes, but Windows lamely does not
    -+		 # allow that, so just search for the expected size.
    ++		 # bytes.  Re-encoding the Pi character from \xF0 (\360) in
    ++		 # iso-8859-7 to \xCF\x80 (\317\200) in utf-8 adds a byte.
    ++		 # Check for the expected size...
     +		 test 240 -eq "$(git cat-file -s i18n-no-recoding)" &&
    -+		 # Also make sure the commit has the "encoding" header
    ++		 # ...as well as the expected byte.
     +		 git cat-file commit i18n-no-recoding >actual &&
    ++		 grep $(printf "\360") actual &&
    ++		 # Also make sure the commit has the "encoding" header
     +		 grep ^encoding actual)
     +'
     +

-- 
2.21.0.782.g571613a09e
