Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024D8C433FE
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDBB206BE
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+ub72ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGQKy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGQKyt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DACC08C5DB
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so10506297wrv.9
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+Un0S0WKVlK4zYjloNvUAcbWjdMeO2ifKR96edwGHo=;
        b=q+ub72ahxHuQrQttHjxyMVGwtgHwX/DKiFA1+jZEJhTabbrGp6I84/WhFi+F/ZdP4/
         K6LT1gqs/avJi9/NLNrEKogpBwB4sW2erjsTTC0iSOAHe07zkLnX5azN0lRvQW7qHvAO
         ZhLkxYsxfj+NUSqlUjsL5aOwVRSS+NjrN6G4prThxzpsjRxiR/4jq03ftY/EFMPsWELI
         pJ67ElpWUzTe/PVtBBzPksw2LmT8yP19y8lOWrG8iB34EpSYTQ4002nIWNQFU8516/jA
         aTfPVDD5L613LRecRZr7Ep1n2taSpvsXyOvjz9u6w5U6UG31NznrO9Z0JY2+a18NPFnl
         hFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+Un0S0WKVlK4zYjloNvUAcbWjdMeO2ifKR96edwGHo=;
        b=c4uW7/urwoSbGdxG4Fzja6SoDBNvXUe1X8fUArcZ4lcfzR63s+xix21l4ffTF4++wc
         tr5JSDpc0/Ey0b+nIj8Edh0aNpIcwWfffPVcn1SLQYkpL7Axb6FAX6iZq8eeYOLA9gF8
         Xd/RCDwEOme7n8PGUtWaMyoXfaiY0qagiQ/pQsivC4heUiDi8q+tKJVnhiSGDr+puEeg
         yWSCRtSLEETmp6JjgIJBB6R1gPwqwVpTvvVhSpUIADm6a8/vuSNRpvFsL/bpKS3JBqD4
         7aDD8Iul8P+psBPAdEAwpIcO+NmLtveYesSelgecxASNGznXeKPdzm2pS/RbQ0ZJ+S2Q
         Jv3w==
X-Gm-Message-State: AOAM530DXC/ohrOS9q+2Z7NfQSUuEmadaniR6bfpRqwAkmrWQt7y03Kr
        h6eFFcfMh9hGNxS/ZQzuun1lI5FV
X-Google-Smtp-Source: ABdhPJwfSHZL/Tp01dyq3f+inoWTrTmXxq4bG9xugp6AIHbuCl8i3PZSzgD8UVyO5iGVWH5Zg9oxQw==
X-Received: by 2002:a5d:4c91:: with SMTP id z17mr9412127wrs.267.1594983287654;
        Fri, 17 Jul 2020 03:54:47 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:47 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 13/13] bisect--helper: retire `--bisect-autostart` subcommand
Date:   Fri, 17 Jul 2020 12:54:06 +0200
Message-Id: <20200717105406.82226-14-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-autostart` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`bisect_autostart()` is directly called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 6f42e968ad..20d359b2ca 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -29,7 +29,6 @@ static const char * const git_bisect_helper_usage[] = {
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
-	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	NULL
@@ -911,7 +910,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART,
 		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
@@ -932,8 +930,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
@@ -995,12 +991,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
-	case BISECT_AUTOSTART:
-		if (argc)
-			return error(_("--bisect-autostart does not accept arguments"));
-		set_terms(&terms, "bad", "good");
-		res = bisect_autostart(&terms);
-		break;
 	case BISECT_STATE:
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-- 
2.25.0

