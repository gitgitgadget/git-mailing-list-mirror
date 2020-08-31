Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E04DC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AD82068F
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg12/VnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgHaKwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgHaKvV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B16BC06123A
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e11so2027454wme.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjlcmqDkoBU4zYuVyCyhpOVtSC+VbYEAFixsbaU2PfY=;
        b=Eg12/VnBaIfd47QhdmPqm46t9lzrT3ePolXlue1a8zEosNPog/MGOcPZjpP30D/UYS
         EThYeW4wYS/98TkS8zAWpy4rI+OblxsTx5vzMMsXdnVUJTDpISR38gUE2Kpm+olqdv99
         KtLadryHtutfU7oqmy7KG63YYNeJr3xmoab30WSpYKCASF0OaCnK5kzG8D6EsyAOBsec
         JXbIsey2nDpcc357mbX+4cLFqAs4Dv8yuIUjexwI2KlLHKlcIf7SpzD+JxGN0s9iIoD+
         XxxcUXQSkTu6mHsEd+2oxu6xmP3AzbqA63sVUtxJ8ZEVMRxG+8FdMQYV8+RvPlPZK4Z5
         rLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjlcmqDkoBU4zYuVyCyhpOVtSC+VbYEAFixsbaU2PfY=;
        b=s1WLcNkGKpMuIna845F/8Fmn6ixUMWYw0e4rvvwhgb5++F/ayU5z1XevFUIapn1aNl
         e8xFevKvNYEDkt8WkW2sdGXArKQyBy4wzqeUIOtkQ2UWw0yty/gekrAkn7+c4XjxWhQW
         5fOecfHFz8AiPRVzLte29PlN8/cFhNKP28dy88kSVRb/Su2APWs0leD+KTcAiXRYoq3W
         HKy9bitF0x8AIP3vAeV/pB83Qm3fFsrAmD5fMuPAhxLrEq0vDIchvhr0bQuxrxI5QGEv
         UMGCxC88s+Oo6KXrua1WTNG3u/PG5ljV+hKF7P7AvmGiACBDZ6Xo7kLyweUTZQjH2Nss
         VxEA==
X-Gm-Message-State: AOAM533i3E7uc/3GWHi0A+iI9IYsElaMsMRuqw29vDCj1PdzarGDv0uz
        fJrPjvJB9lSxbAQlVJbqsCQIFYfl6Vk=
X-Google-Smtp-Source: ABdhPJwr4I/NSnmr/S/udodXNmxzCqGR6+hn3wlwpD8M/Z9d1oADDpkrKzqeMsSh/cNYSEdU10feZg==
X-Received: by 2002:a05:600c:2cc1:: with SMTP id l1mr826534wmc.78.1598871079626;
        Mon, 31 Aug 2020 03:51:19 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:18 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 09/13] bisect--helper: retire `--next-all` subcommand
Date:   Mon, 31 Aug 2020 12:50:39 +0200
Message-Id: <20200831105043.97665-10-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200831105043.97665-1-mirucam@gmail.com>
References: <20200831105043.97665-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--next-all` subcommand is no longer used from the git-bisect.sh
shell script. Instead the function `bisect_next_all()` is called from
the C implementation of `bisect_next()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index b8b8a7473c..0796e51672 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --next-all"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
@@ -866,8 +865,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		NEXT_ALL = 1,
-		WRITE_TERMS,
+		WRITE_TERMS = 1,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -881,8 +879,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "next-all", &cmdmode,
-			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
@@ -919,9 +915,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case NEXT_ALL:
-		res = bisect_next_all(the_repository, prefix);
-		break;
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
-- 
2.25.0

