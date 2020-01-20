Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26990C35240
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD6C22314
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KInWb7g+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgATOit (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36315 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgATOir (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so29847948wru.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qo+K54LDNNvRakb2fu62WPC6I5xEcHpgOLSRcyDPBO0=;
        b=KInWb7g+TLl22mN+uLyTbK2wYroC8Hav+Ay5GdBPF9sPaTRTyKpu78zNbLW/TPoyH0
         +Y72WcIxh7MmvgzUTyZS7rp69tIz5es74rx9p7ieswpu5MyKhG0DZew7l+t9C5moUya9
         6YTjCnv5yCuoqP65OQoXxVneclZze6wdocO5B8e5mpmvYkGGEDHu38az2fhSjjXGKdHT
         z3vi9+lqDWjX7Ycay0/6RLE2VDuHDrDqs5OVlP6NRWEfGmbfjkjWwsPd34YFNyRmbAas
         oB6Cv2GivQlOfnSY2XHrxBKrJPzf0HscXQkIUAuU8LMZfy79IzByVYnFvCYcxp1fkk9H
         /sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qo+K54LDNNvRakb2fu62WPC6I5xEcHpgOLSRcyDPBO0=;
        b=O93ogqYz81bftieUoCiH+eRyr353ko/MsuAgy9eGY1e8rEh6d3ynS3Zhlkj9xL0hLw
         rIq0q2b29gINozNcM37fXEkI5fXmqF8H1xZcJ4fl25hbz1v9p86GcnYg+aUuTvewHmb1
         NWal+VwTABJPgM4MeqqPVcJ7zN1HtEE+R7eeRY31DArZ30Wc38NtsvijJJTQ9gQcE5tN
         fZSI/dWonQ3eucrzHuA53GgbhNUd+G/PqEbW6wY6KTgk0RsutIjYAU7kdrBuKP95zIip
         uUWSYx602RNW9uAqkQbiwh8DukEe5yUFw1Th4Oh284UMfu7fiU3nE0arZWalHAQ5V3Cv
         2dgA==
X-Gm-Message-State: APjAAAVg8VUeXh9zLuKOYau97a4NYx/nCf5w4V82KthplRc03wO1wvr4
        mmjKllxaBTN1vHmGSTYHqIvatTZuD9Q=
X-Google-Smtp-Source: APXvYqw3ZjZQVOxLHFZzEahQ8zSahs7OFIvF1Yp6sb7MGDw68rYUUAXou/WTRWQqOLEQ4pDpROXGEw==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr18944474wru.399.1579531125437;
        Mon, 20 Jan 2020 06:38:45 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:45 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 14/29] bisect--helper: retire `--bisect-clean-state` subcommand
Date:   Mon, 20 Jan 2020 15:37:45 +0100
Message-Id: <20200120143800.900-15-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-clean-state` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`bisect_clean_state()` is directly called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e604334c91..7190304a98 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
-	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -800,7 +799,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -817,8 +815,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
-			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -860,10 +856,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
-	case BISECT_CLEAN_STATE:
-		if (argc != 0)
-			return error(_("--bisect-clean-state requires no arguments"));
-		return bisect_clean_state();
 	case CHECK_EXPECTED_REVS:
 		check_expected_revs(argv, argc);
 		return 0;
-- 
2.21.1 (Apple Git-122.3)

