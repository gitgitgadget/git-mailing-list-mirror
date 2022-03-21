Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31662C433FE
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiCUXKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiCUXJI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2265837DE5F
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v22so8742441wra.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GcAAMnxSYGQuJRI4FtntEMkQxb+m46GxWQIsUu2gRL0=;
        b=ZkYfcjfbklkd59c4oskqUsyePn9YdlF1y47Osz3etjK90TCQAStkyc5LyxVX25wDWT
         2f98yl9Ajjz0WV8mwB60wsYqYKy22mHA/4HSHIdYrVDhiq7S8PYDpYzRXWkhz/ci5COF
         z0WY+bjLAigRljr9YTBr+qGozLFJXm/j3UYX4CpSO/XN8jjp23vyfnjQR8yOmp6cT/AJ
         eehBA6zudXGOX6gM/yJjS5vBeFJE2V6iWSgFPIJwtTfMibWdBvHGImoUcGJC4sYXmV+8
         ZARxhF8+lvjuvoAMdEC/nqKVfPSSriu0w0SqvP/A2Rx8+twOdN3fFVv88+s5MZfOCDzj
         loiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GcAAMnxSYGQuJRI4FtntEMkQxb+m46GxWQIsUu2gRL0=;
        b=l0TmaG3XvodjhlrKDNCg2ArEf1EYuV6k1ibAcq1WnZy+1N1CAI7XkPAxaXz/ql7gRl
         QlQLxDrKFUaKFUs06pHwNU0g7lzr2zqCyDiN6HrcRyH7nysFql6aQ28unusFKhX724i/
         O2pBBDBQQCItYoDeLPT42qR07fXdrHkrccO+FeWtaoO7QA5uraw66jxu+yuFH0ACl4DJ
         xu3LFytNBeYwANW6wH1/mgD7ShR/JqGeroxkgp5I4iWM4syhv83/4q4QOC2AK9CCmkXz
         Tf4z/CqCF/Os4nmYC7n2Xzk0vEAnzmXKqbvi/iLIDoVebY40TopYmOYOpmdEmHzLiKGW
         iSAw==
X-Gm-Message-State: AOAM530Hjlt4EYlHAz1EZcseCKNEju4lg+ZNUcB9HPZTv0/LlKulm95Z
        gzR+0RSv55V873BzuiaeoXuti3geznY=
X-Google-Smtp-Source: ABdhPJyUQ54w/8HzuRZK5ZBuUvUdhv8QClRRfWwnMNsnNMh1cp7/ggM0a0k3NKYCsWYll9nH1R7blw==
X-Received: by 2002:adf:cc88:0:b0:203:f088:c9f5 with SMTP id p8-20020adfcc88000000b00203f088c9f5mr17096459wrj.312.1647903343210;
        Mon, 21 Mar 2022 15:55:43 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:42 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 02/41] branch.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:44 +0000
Message-Id: <20220321225523.724509-3-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 branch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 6b31df539a..7a28ccdbd2 100644
--- a/branch.c
+++ b/branch.c
@@ -260,7 +260,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		string_list_append(tracking.srcs, orig_ref);
 	if (install_branch_config_multiple_remotes(config_flags, new_ref,
 				tracking.remote, tracking.srcs) < 0)
-		exit(-1);
+		exit(EXIT_FAILURE);
 
 cleanup:
 	string_list_clear(&tracking_srcs, 0);
@@ -388,7 +388,7 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
 			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
 				error(_(upstream_missing), start_name);
 				advise(_(upstream_advice));
-				exit(1);
+				exit(EXIT_FAILURE);
 			}
 			die(_(upstream_missing), start_name);
 		}
-- 
2.35.1

