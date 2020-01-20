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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDE3C33CA1
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AC922464
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRtw7qza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgATOjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:39:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40750 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgATOjE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:39:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so14928095wmi.5
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5QqPW++gfEQ6MjOHpQ88/wrQYYFq5e1qOb6oI1cos+o=;
        b=jRtw7qzaUtJr6/Uqq77I6iPJeVWKgcFk+Xvqw5IQPHs8sXpvchB1CJsAe5SBSeTFJD
         umd5eurzvICvvJYWZ6tZOjFi0Usf0XrGmd7bFn5zllM8wExe9k4H94cc2gNe0+9EtXRw
         OBJihvDauSC1VtGy1KoZzV0AbyVtRniYllHnJk0QXeIerFQGXyZTHrV3W12kMcvLvCAa
         /9YW7zsS9z2CDT2taN3lUCq09Nz/Bi554p4Fxh9vvpawEv7EbSVv9zNQaYePIE6CPJuW
         4/z3B4ypCDUyNR5mMkdoS6NUYlk1KyrlQ9I+YjDagadqY945GAMGTZ4Z6GmH/V6JVK/Y
         VYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5QqPW++gfEQ6MjOHpQ88/wrQYYFq5e1qOb6oI1cos+o=;
        b=FiXZc1SX526Pzgf0mFbAmpulVmonVXo4LHLsgjxwhZcMOo3VHLMVEGZpEWYn7gXM7x
         e42dGcrDHuQRv4rEKd/SNBf8DL9MRDqjwcfvAKY2TPu0hmPN6hR9VJncwK0OzWEbyZvZ
         Oy9Ziy3RKR2ZoOZZMwmw8DiybPVDZIizc7Ip91SP9xYYcTqNu4jLgKQCAeTAJ9aDq9o7
         WuL056ivFU5T0v5Q1kHN7xwEhFjL1YZhycG0cclWlSuq0K263uAiHQ4Rx39QHtx8qe7K
         GM3XcedntXg4741grxXXnLJ2tku7dvRegbzq9bjKzkNLdU/pCHEKjr75EpSeWdOQm7jp
         U+Uw==
X-Gm-Message-State: APjAAAXjBG1r5P42Pifc1Ip3x8AhPlhN1CIw7VcgR+WGqZYpgaZDDmNX
        diIjpfmUtmBenqwf26xDs4kpKAxkN6E=
X-Google-Smtp-Source: APXvYqwEqXa4VzgOAbToUBj9IjqwwVbY3iB4DbvzbJPDJwdWwlzJFeYozzhWL9io/6Dj53OFcYqwmQ==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr19642154wma.139.1579531141808;
        Mon, 20 Jan 2020 06:39:01 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:39:01 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamil.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 27/29] bisect--helper: retire `--check-and-set-terms` subcommand
Date:   Mon, 20 Jan 2020 15:37:58 +0100
Message-Id: <20200120143800.900-28-mirucam@gmail.com>
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

The `--check-and-set-terms` subcommand is no longer from the
git-bisect.sh shell script. Instead the function
`check_and_set_terms()` is called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamil.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 841a76fc7c..7bc28d728e 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
@@ -1058,7 +1057,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
@@ -1072,8 +1070,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
-			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
@@ -1111,12 +1107,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case CHECK_AND_SET_TERMS:
-		if (argc != 3)
-			return error(_("--check-and-set-terms requires 3 arguments"));
-		set_terms(&terms, argv[2], argv[1]);
-		res = check_and_set_terms(&terms, argv[0]);
-		break;
 	case BISECT_NEXT_CHECK:
 		if (argc != 2 && argc != 3)
 			return error(_("--bisect-next-check requires 2 or 3 arguments"));
-- 
2.21.1 (Apple Git-122.3)

