Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978141F461
	for <e@80x24.org>; Mon, 13 May 2019 23:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEMXRf (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 19:17:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40525 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEMXRf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 19:17:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so7220357plr.7
        for <git@vger.kernel.org>; Mon, 13 May 2019 16:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENQym6SZUXSoUK+EF+ZwoUUP9JgvRLCp/ygSlStBV40=;
        b=AN2/qXqd5jce2ZaXRLnmNaclS1ZVh6PuGESh4nXDCV75/v3eaVHFlB9YpoxJ3AOOFc
         UHHK0tUvYIHTY1KiRhDiqSW5uEMF2UDS798Ei5R904j5EO4PyQdXmgQRGnw2IFwVWUmt
         hu+eouPfu/H5T245gtGgt4w/Pdovc0FalYwjxTpSTQEMnGXexyyxI0czKvi/bEZyaRqU
         5ckYT0V6bahVgPOOwLHEsJ8z1bwhxhz4RjjlepO9/W07A3PuslqACE0+AyM5hcOC5ULw
         HHowYS2Tkuk14jwb3IxbTPncevLay5zu5yLDVHcHDu2+4wdFgrhbvTSQ+wKKS+pZUKP7
         X3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENQym6SZUXSoUK+EF+ZwoUUP9JgvRLCp/ygSlStBV40=;
        b=tEBO6ztYIb3sXr6kVfhL4/9D4BhR6DVnLiWOMC9Cv4gt2yKxeHTfpndrabnwfEAqV6
         m95xmyOwJBwmwRgxdVut54yxukrVTBh156F3Xecbr3IhprRZwFb19sVRG4TutV23vIbA
         bQAHScvGAmmHdVdTuqwI7NQXiNJiGZTO4NQcT+R1/jsRPV4H+OuNpxc+cznMl4FuSRO6
         Bvl8hevkIJocErK5XDeMFj6wHCiFv2hJDKVD2WEiTEH+kLmGpQc5uKAU9RRWw3a2vZVO
         MirWhJ2IW67xwzQA+2hPKIEPugAtHjV+gSgYpd5w1saGSzzvyKuFrirpZV2X2MOubvwc
         Ylaw==
X-Gm-Message-State: APjAAAUJKqHxekepEnLq36+1r08EUv6dVzgJxV56Zju3YHFDdSrVCBj5
        hVzd2G1sShMGg8dMs5fHtwQ=
X-Google-Smtp-Source: APXvYqyt4c7T5tXnNyatNv0MaJw6WqALd1lxcl0QarngFDoaqmtQaHllhByYm7L34ougGlFSPs24KQ==
X-Received: by 2002:a17:902:a510:: with SMTP id s16mr34168339plq.334.1557789454149;
        Mon, 13 May 2019 16:17:34 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id g10sm30664307pfg.153.2019.05.13.16.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 16:17:33 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 0/5] Fix and extend encoding handling in fast export/import
Date:   Mon, 13 May 2019 16:17:21 -0700
Message-Id: <20190513231726.16218-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gd8be4ee826
In-Reply-To: <20190513164722.31534-1-newren@gmail.com>
References: <20190513164722.31534-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While stress testing `git filter-repo`, I noticed an issue with
encoding; further digging led to the fixes and features in this series.
See the individual commit messages for details.

Changes since v4 (full range-diff below):
  * Used git_parse_maybe_bool()
  * Updated Documentation/git-fast-export.txt to document the new option

Elijah Newren (5):
  t9350: fix encoding test to actually test reencoding
  fast-import: support 'encoding' commit header
  fast-export: avoid stripping encoding header if we cannot reencode
  fast-export: differentiate between explicitly utf-8 and implicitly
    utf-8
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
1:  37a68a0ffd = 1:  37a68a0ffd t9350: fix encoding test to actually test reencoding
2:  3d84f4613d = 2:  3d84f4613d fast-import: support 'encoding' commit header
3:  baa8394a3a = 3:  baa8394a3a fast-export: avoid stripping encoding header if we cannot reencode
4:  49960164c6 = 4:  49960164c6 fast-export: differentiate between explicitly utf-8 and implicitly utf-8
5:  571613a09e ! 5:  d8be4ee826 fast-export: do automatic reencoding of commit messages only if requested
    @@ -13,6 +13,24 @@
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
    + diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
    + --- a/Documentation/git-fast-export.txt
    + +++ b/Documentation/git-fast-export.txt
    +@@
    + 	for intermediary filters (e.g. for rewriting commit messages
    + 	which refer to older commits, or for stripping blobs by id).
    + 
    ++--reencode=(yes|no|abort)::
    ++	Specify how to handle `encoding` header in commit objects.  When
    ++	asking to 'abort' (which is the default), this program will die
    ++	when encountering such a commit object.  With 'yes', the commit
    ++	message will be reencoded into UTF-8.  With 'no', the original
    ++	encoding will be preserved.
    ++
    + --refspec::
    + 	Apply the specified refspec to each ref exported. Multiple of them can
    + 	be specified.
    +
      diff --git a/builtin/fast-export.c b/builtin/fast-export.c
      --- a/builtin/fast-export.c
      +++ b/builtin/fast-export.c
    @@ -31,14 +49,25 @@
     +static int parse_opt_reencode_mode(const struct option *opt,
     +				   const char *arg, int unset)
     +{
    -+	if (unset || !strcmp(arg, "abort"))
    ++	if (unset) {
     +		reencode_mode = REENCODE_ABORT;
    -+	else if (!strcmp(arg, "yes") || !strcmp(arg, "true") || !strcmp(arg, "on"))
    -+		reencode_mode = REENCODE_YES;
    -+	else if (!strcmp(arg, "no") || !strcmp(arg, "false") || !strcmp(arg, "off"))
    ++		return 0;
    ++	}
    ++
    ++	switch (git_parse_maybe_bool(arg)) {
    ++	case 0:
     +		reencode_mode = REENCODE_NO;
    -+	else
    -+		return error("Unknown reencoding mode: %s", arg);
    ++		break;
    ++	case 1:
    ++		reencode_mode = REENCODE_YES;
    ++		break;
    ++	default:
    ++		if (arg && !strcasecmp(arg, "abort"))
    ++			reencode_mode = REENCODE_ABORT;
    ++		else
    ++			return error("Unknown reencoding mode: %s", arg);
    ++	}
    ++
     +	return 0;
     +}
     +
-- 
2.21.0.782.gd8be4ee826

