Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDA8C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F50F215A4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKERQOXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgDWHJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgDWHJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1E5C03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x17so4765244wrt.5
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URG5S9Gb+4uj3txSvkoDvh025lJpgIkTibCjFFMw/Pc=;
        b=DKERQOXUF+lNQJ4pPjg4uNC0aJAO4EGWyVpgFq2ENbq3UFrGhtVOI8/+4BQ7fO5pmn
         Jc/WjTz5x8vR9r/36CFgh7sClyY+aFYosGLQZx2hmazfBRpUlUobugwxF+O0z6YtiIZ5
         HvMlJR6HEzIQehhcnzZUtGae0k/kXoFe2Y9k8iJuRFqzLJeozHY1tKc1Jyi1WZoCTpam
         yOCdyDqXPN8GTjFbFRTn+89qDvsmz1fhFUfMsQ+C2JKNbSKxJ04RS/G+k4SET41EBYKn
         U1KrnJ0R7MkgT0/jkv+Dgq1mjkAfNRDB3TMuMY1+aNpLRCUJC+DeNglQ4pvwMuBKq4+5
         pjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URG5S9Gb+4uj3txSvkoDvh025lJpgIkTibCjFFMw/Pc=;
        b=YIsg2r+/grQTQ2fv6TUoKw9JE5BJsY4i8l5jPXozP/bEXItIN2Qikxm9c09sketo/l
         shxtwQfz4Q6RckfPR916UqpPBTPGqtWqMHYinK4yxIdOQVnW7+ohRD4kd/i0zEDPEmBW
         H4yZ3+i2xq7Z/Y7XXJNIV0fJdcF0/n9o7lx/vdp1Spe/tIcnXO1vzN8QdEJ2uWU8Fskp
         ygzhTCrXdpUB9tHy22WMS/Gn771oS3r7uw32Z/2dLhHotNl0N7agbahdAfuL+X6x2lxX
         LGyOsPD92+hZ5yXXG1gVZx42vYd77v7DwgfuYRaBi+yXtW3WinWiRQKdfXTYG/qKx58a
         GXjw==
X-Gm-Message-State: AGi0PuaBawZAa/f6nh7IMXVKj28u9SmMiity1DIJ4P7mdgTg/Kq86wr1
        4cvyl4FiaGzu7X2JAZkuv++V4WMQPVg=
X-Google-Smtp-Source: APiQypL14VT1RoRakmN58ZA0RbKd0S1Jo/TvDtjRf6M0baLDbb9iHltdYLzmx3qEejvkNXwZy93LPg==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr3432350wrs.12.1587625775433;
        Thu, 23 Apr 2020 00:09:35 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:35 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 01/12] bisect--helper: fix `cmd_*()` function switch default return
Date:   Thu, 23 Apr 2020 09:06:53 +0200
Message-Id: <20200423070704.39872-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
References: <20200423070704.39872-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a `cmd_*()` function, return `error()` cannot be used
because that translates to `-1` and `cmd_*()` functions need
to return exit codes.

Let's fix switch default return.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c1c40b516d..a81a2c76ff 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -711,7 +711,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_start(&terms, no_checkout, argv, argc);
 		break;
 	default:
-		return error("BUG: unknown subcommand '%d'", cmdmode);
+		BUG("unknown subcommand %d", (int)cmdmode);
 	}
 	free_terms(&terms);
 
-- 
2.25.0

