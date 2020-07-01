Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673D2C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42709206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9/4h/Es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgGANfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731161AbgGANfn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294CC08C5DC
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so22462392wmj.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbdsvKjzU0UnoYa8KZsCBXF+EruRq+Y58XPmYZGj/os=;
        b=R9/4h/Ess1fhF9JQ/ss+DVVNzdulSiiDbOgY2DF1O/JuKFxTH9PuSnQ5unSLXmnm6J
         Ebjt5acKX0O5c4MFtb6A4jE6GWXkQCBsI9B4X80ZXcYpMORF1eiyXEKlvAY+MZWDIsg/
         xpkh8zBPiJ4N61Q0qKdSrQI5js/DVUbcvZ0qi5Pm7EKQQktV4pbq7MMs7DkIbrZSi4QD
         Tn7N7wKuxoN/JPPeclUELGiLy2x/DE0+K/x8UyX9SgTyEXXOBv+WXGFloC/nj1ruNO6u
         JVMIIEPlnSGj/eQ9T2oDRqVzbU7SEU3eomNEZNqG1jS2fr/hJU6jff5PN+gj0ILE1zRF
         NwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbdsvKjzU0UnoYa8KZsCBXF+EruRq+Y58XPmYZGj/os=;
        b=Sd1XHKyFFfemab0JbvUJ13Lu24n6RzXqEh+dk0qigDN+47Plak9aei8lcwlfF0Vr8Q
         CSR8FCkgFfytGveR+ilcqWZLza358i9+ctrFXlkpBk334rfvrb7vJ6ZhAeOWMvsrYdSu
         TS7wlrtwek552y/lmXoJiXNY7yu5idrlu7mgDyBVTaVNvXU1diiIeiTpf/GkfgNwtj/+
         rDNIyBroRAlDlCXCGRyEuZp+XF6IVf5GJcU/PS3i5ZXAG+hxAgp5kM9Qo5UA3t63QcYY
         sU3lO/f01FrHGK1WdXNVPefp7rqLvcUhKaG+GALPKl4Tz4Vq447sOsQz3Lf5XQEUxbNB
         nnUg==
X-Gm-Message-State: AOAM532Cbou4cVobQIc0YvbEe8BC2XiAnUEST+62qeDntRAitYMvCyZh
        vwp5W0gTnnSg19pNY9GXZgrx796LlsY=
X-Google-Smtp-Source: ABdhPJz9/GxxSbz/MDJk6evEeOhSfiPXJ99vchnTzGTZOyGoA2tiJrxLTyM25fb7MmidiRALIq4Zhw==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr27340080wmm.48.1593610541384;
        Wed, 01 Jul 2020 06:35:41 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:40 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 09/13] bisect--helper: retire `--next-all` subcommand
Date:   Wed,  1 Jul 2020 15:35:00 +0200
Message-Id: <20200701133504.18360-10-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200701133504.18360-1-mirucam@gmail.com>
References: <20200701133504.18360-1-mirucam@gmail.com>
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
index 59385e2b9d..3ded6a0ea2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
@@ -861,8 +860,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		NEXT_ALL = 1,
-		WRITE_TERMS,
+		WRITE_TERMS = 1,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -876,8 +874,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "next-all", &cmdmode,
-			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
@@ -916,9 +912,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

