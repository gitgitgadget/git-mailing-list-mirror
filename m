Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8042EC4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA2E20757
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9tIKjXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgCUQN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:13:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36421 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCUQN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 12:13:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so5201481wrs.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfIqeXydPmqmTJOYACyhK1s4kc+Xn+s619UoxOmuALI=;
        b=S9tIKjXy2JYNP6z9HFhhe8OfMQ/WOJLnIXLchBxmEpHNQI4Cm/9JFK4QtiMTuM48ri
         ca8KbvSW/S9CAkwrmlpg08MGQOd+0CZuB+VSMhkhpVUvOxhrlZ7T1gHkjpj3JX04HoXc
         hh9zMoO0tJpSCop0mGQO+LYUv67qAmoCjwuIqxLI/yKNaCtNmuD3zJLMpld9qsGr0K0V
         NbcjbmMBj9fije7smVOtq6KwH06U8TQmjTZbntPSexLHRjtvthnE+dasbiFq93BwoHUL
         +bKimLhMHbQHJTlmBW5DaReXhNOI6ezQYmNvgFJGfIM1s4RjvxUI7QxHrD1CNrNsiOVh
         GO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfIqeXydPmqmTJOYACyhK1s4kc+Xn+s619UoxOmuALI=;
        b=nFZwaZbszXbz6NOZ9hNpEDyn3C03le5Xe4J02Dr6j5gIyuLKZUtbWaD6tgBEweMM+e
         cjtIh8i/Sp2T8DkUI8Efb/XNg2X9ivJKFftAnmJta6sZD0Edf3B+7tfu0rtjvEV4bhvL
         pzCH5wmsub+hFe5NebsJjdUyaYLjcnZ0A6UwdZSZ40RYpbnvUo/W0PyS0dxveKt5Y3fE
         YMtAd55vWiAxrzFrbf9gDEaNX5YEoIuvOT/zBbCgs6IuKSfxO+r5kzBVZBCwOcyKhooL
         nad0BufjkxHB46qe34/uqdYrzcfGAcNW+mNuHWjZTKS3yc26LGk43RqPKkwthI4XovN7
         EK7w==
X-Gm-Message-State: ANhLgQ2xjI83mKxlCT21msM4H5RZA+9aTM3id3mAFLqxT2DghyaHOS/z
        VMf08CrN2muHlaRHqGKaEi1NLrtB
X-Google-Smtp-Source: ADFU+vsccbv+YwGH62fz71Q3WF5gvZpY0gNoPWJ6vhZDrFBNQKpj/dZ5HHrbAtuqoY5m5dlSDJfxpw==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr18949485wro.16.1584807236179;
        Sat, 21 Mar 2020 09:13:56 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id f22sm13992285wmf.2.2020.03.21.09.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 09:13:55 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 06/11] bisect--helper: retire `--next-all` subcommand
Date:   Sat, 21 Mar 2020 17:10:15 +0100
Message-Id: <20200321161020.22817-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200321161020.22817-1-mirucam@gmail.com>
References: <20200321161020.22817-1-mirucam@gmail.com>
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
index 0534adf216..086ab8e46b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
@@ -806,8 +805,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int no_checkou
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		NEXT_ALL = 1,
-		WRITE_TERMS,
+		WRITE_TERMS = 1,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -820,8 +818,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "next-all", &cmdmode,
-			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
@@ -858,9 +854,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case NEXT_ALL:
-		res = bisect_next_all(the_repository, prefix, no_checkout);
-		break;
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
-- 
2.25.0

