Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204CFC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEB22177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9rEPrR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH0RpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgH0RpS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 13:45:18 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9942C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:45:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so4067871pfp.7
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFl0zxz/R/Z1d53jhb7yMVOit1YZcax8f1UC7bCCpmo=;
        b=m9rEPrR6P2guEbJcEXKGyrsk6vtD1AJghemDtDO/188gT9vJETMVDsfcyBYNPAjtPJ
         g6R6FMsuIqiwgfHjqGPqFC4a+5ZYUvBjIn28bfWVxUUCrbkR7MoaLVwkdt5ugeMTq0IC
         waDcoANqdfCxHdgHdflP1HgJeEvwqJy5pV6z5B5di/sF73oA/jKeSzOvh2NGnllLIQFQ
         qy/cbumLbV8T2QShbfzx63TZTTCKfiWEQcCWUna95NmuSeryjViBFUtxue245XzzsoNH
         TxlpFWsSxNdHLRWdFOgO33IUSspgaKj5O6akYEn52qHNU7FN5zpeAU/ezCfYT1gSwz3f
         VfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFl0zxz/R/Z1d53jhb7yMVOit1YZcax8f1UC7bCCpmo=;
        b=bhQEAehMvaDchqSzFR1dnfwHS4fC4svpELP7Eh0+IPGeZbVeFxytaNGkpCEC7ftIM1
         lFP3WU21zZsxBMDtc/gfhkjfhqJBt5CHdY8Ad8JRYn76mFetma8BXRtTkddi/fWo8/l2
         TvoW5gjCyRNCrSC/5i0g6TX7s4P0uRm34iF71oWv2AEfTwpGbtXCOj0HaBg7Wp5V0Iz5
         Wd14Rbp6UO7QFSk58WTEwUBz6+OQmoTqE5y72bTAnWLvdN6BCqB7nOXL9acI9aLrbEzh
         wkcfBvq77I7eho8u0F7uyWqZldL/df7+AoxtUQKE5/wLdncByvn6c+nyqW/fDzvofJE6
         HGlw==
X-Gm-Message-State: AOAM531Dh5iQep8g2AJZwzBoi3Q6QZcSAMrcNMSvJsvgzFReATPuhFv5
        LCjYI0DSQ2Pm1DE8qmjj7F7T5jWCAo5RtA==
X-Google-Smtp-Source: ABdhPJz5KdMcKs86M6xy23JbTCrM2qfe50BzFnIBI6Q9AebktvyRpS3GZXPTYrE2q3dBzHz2vVw07w==
X-Received: by 2002:aa7:8699:: with SMTP id d25mr9123588pfo.191.1598550317764;
        Thu, 27 Aug 2020 10:45:17 -0700 (PDT)
Received: from konoha.iballbatonwifi.com ([103.84.62.195])
        by smtp.gmail.com with ESMTPSA id i20sm940847pfq.204.2020.08.27.10.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:45:17 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     kaartic.sivaraam@gmail.com, christian.couder@gmail.com,
        gitster@pobox.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, peff@peff.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/3] submodule: fix style in function definition
Date:   Thu, 27 Aug 2020 23:15:00 +0530
Message-Id: <20200827174501.7103-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827174501.7103-1-shouryashukla.oo@gmail.com>
References: <20200827174501.7103-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The definitions of 'verify_submodule_committish()' and
'print_submodule_summary()' had wrong styling in terms of the asterisk
placement. Amend them.

Also, the warning printed in case of an unexpected file mode printed the
mode in decimal. Print it in octal for enhanced readability.

Reported-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b83f840251..93d0700891 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -959,7 +959,7 @@ enum diff_cmd {
 	DIFF_FILES
 };
 
-static char* verify_submodule_committish(const char *sm_path,
+static char *verify_submodule_committish(const char *sm_path,
 					 const char *committish)
 {
 	struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
@@ -979,7 +979,7 @@ static char* verify_submodule_committish(const char *sm_path,
 	return strbuf_detach(&result, NULL);
 }
 
-static void print_submodule_summary(struct summary_cb *info, char* errmsg,
+static void print_submodule_summary(struct summary_cb *info, char *errmsg,
 				    int total_commits, const char *displaypath,
 				    const char *src_abbrev, const char *dst_abbrev,
 				    struct module_cb *p)
@@ -1056,7 +1056,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 		} else {
 			/* for a submodule removal (mode:0000000), don't warn */
 			if (p->mod_dst)
-				warning(_("unexpected mode %d\n"), p->mod_dst);
+				warning(_("unexpected mode %o\n"), p->mod_dst);
 		}
 	}
 
-- 
2.28.0

