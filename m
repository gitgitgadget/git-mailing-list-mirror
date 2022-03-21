Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9499DC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiCUXL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiCUXJI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228C837DE73
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v22so8742487wra.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ag0H3TBwts0PKbp1hELy5woRZ8DbBzPLtBivF32I2JM=;
        b=FSAqnA8gaGKW4dSZz3Ddpx7lEjPb9GNxpZedcWWlGwAwGaia67sfY3iq56ouGx+mS6
         91v7gRXCV4DKWlV20IYil/Fzy7M5pVPysQQBS0gU3Ir0oK+Tp3EA602ZJ2hyM31bwRd0
         x5IO7+jgk8R/SKha8Ayegc14e3PCssLJGgcYDM3VddBGY6S+8ZgapaDPq4KzChcOLTIy
         C4dNlmbyqqkDq+e1ZE6iWMOXQ3Yv5dW1ymUjZTrb+lTyHVfRmJmgDUT6D7tFK/IweujN
         w9tJIx0k37ZVN8MRbmkQ2T/kd5Ha272X7urjqh23NhlXZBIgLddvCU1rUTQm6xTib8v2
         2VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ag0H3TBwts0PKbp1hELy5woRZ8DbBzPLtBivF32I2JM=;
        b=CH5cMK3YbjifY0cRk3kF8Sx/cLuIzupmuRTz+p50WYOjLfltGSc0yYkn82rvzFgoNb
         gprikf0HuocTJnPap9VugSrPdxieyYJrURrT7sKHqHwaQQ0k0iwaSPLBMpzdrtJ88uCY
         oBtC7Dssq5sEp88VMvY08kAr3jcAT6wcFrce9qcL8GzJBE5n9eVYPd6Gr0Rstyf1wy/w
         HNxxUL0XKrFlDplqqVjEb/3XiwAafsC2i4gH0Y3DBqcaphINSt7V0TkdtRKOXPwkWuJC
         kGwV0KWMx8oL6GO6lfJrLCGH9pqjZBcPWbwiVkQYddgpL/8iV8HsQNddtzM0t5Ftm1AU
         rCSg==
X-Gm-Message-State: AOAM530d0x75DSJiZp+9LpLlSCu89GxVrS+yKXTANXG8ksjBH0atLN9p
        P2rZ50LfrtLKJA9uak8kFCl7kuYRZkY=
X-Google-Smtp-Source: ABdhPJxaujTqv9kHBcspri7EOalTCB2wagkvDr7y8aTjLqY+LfIB7V16aNzZDfpN9Tg8OlLrz6OAAw==
X-Received: by 2002:a5d:6d83:0:b0:204:107d:ffe2 with SMTP id l3-20020a5d6d83000000b00204107dffe2mr5995282wrs.413.1647903343975;
        Mon, 21 Mar 2022 15:55:43 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:43 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 03/41] am.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:45 +0000
Message-Id: <20220321225523.724509-4-gitter.spiros@gmail.com>
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
 builtin/am.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0f4111bafa..ac74bce555 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1638,7 +1638,7 @@ static void do_commit(const struct am_state *state)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (run_hooks("pre-applypatch"))
-		exit(1);
+		exit(EXIT_FAILURE);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
@@ -1841,7 +1841,7 @@ static void am_run(struct am_state *state, int resume)
 		}
 
 		if (run_applypatch_msg_hook(state))
-			exit(1);
+			exit(EXIT_FAILURE);
 		if (to_keep)
 			goto commit;
 
-- 
2.35.1

