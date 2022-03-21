Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85679C433FE
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiCUXH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiCUXHS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:07:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC713FBA
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h16so8854559wmd.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34mMrqgBbfnsuYKOqRocmbdX83HR9fyg+7WKRyJQFW0=;
        b=aXurSz6SlMik2hXi/FI6qz93QD2YFjjttuVM4nsav3RGYNawnxnYmAP8AZCD0HpiYC
         q0zVDGR2HgyUBqhI2vjPMyrN4crM4x/gmWPC7tTmH9lWqYYWy9rd140IUiCJ6M2lKqUp
         YFymdSAfHr4SptW7L9w4sCJlMs9PGp1akD52qK42aaX3I1ZillNGRRPm+QKon0CyjMOP
         P//F86vs4OFsmiGTjjE7xjII4yYxdcScCKQTQcUi04NLiNHZ9vN/Yi5l5De+489MgnWq
         s8E7JgWVTx1b7WKXai04HigU1XAOO4H6tZTs9SxakTZSoyx2Aiewm4FCp/r/OYsJY0Bl
         AQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34mMrqgBbfnsuYKOqRocmbdX83HR9fyg+7WKRyJQFW0=;
        b=ZePW8GhnO27Mc+PSGL6g/s9ge/XJB/sAW24OLeS/V31VQvGefVlpgLSXrNRPmoolW4
         X5Xb/fgpLePr/+DuVZLdtXR5RwESB+QR6HuBA5ptKwkmW12YXNn/+mIUYcu5fpT48UQN
         V4+XbkGbRGirlF52laInXbAspuyOBcv88RNHgxhE643lFKDQlMTqP5NHnJ5Jp8lZV5+5
         aP3L6gE8cqPqNscmanlIYbg+UTizZKm2JGOd9qMIMRDSlixCl1Hzn1R4WhukXyogj3mJ
         oYuajGZn0j7A42+jJmtquqNzVLwW7wpcxcPZTGlobJhwe40WcZqEPwidl0wY0MhMqUEq
         xcVQ==
X-Gm-Message-State: AOAM532KvZ4bQzEocLiqAXRZBhonXGWPX0Re3KKAHxaqhLnp3HF6r/5e
        VtEXS4/8pxK31Q2noizgD8IKzeRadBg=
X-Google-Smtp-Source: ABdhPJxElPQmuepytpj1OtrRKVKjHA11B7Iokvuk0Uy3Uy3wCLwmq3tcfIlX5lAGH1tcPS+GXAlFIQ==
X-Received: by 2002:a05:600c:3509:b0:38c:b03b:b3c2 with SMTP id h9-20020a05600c350900b0038cb03bb3c2mr1146503wmq.81.1647903373725;
        Mon, 21 Mar 2022 15:56:13 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:13 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 34/41] setup.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:16 +0000
Message-Id: <20220321225523.724509-35-gitter.spiros@gmail.com>
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
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 04ce33cdcd..f5cb3f30a4 100644
--- a/setup.c
+++ b/setup.c
@@ -1508,7 +1508,7 @@ int daemonize(void)
 		case -1:
 			die_errno(_("fork failed"));
 		default:
-			exit(0);
+			exit(EXIT_SUCCESS);
 	}
 	if (setsid() == -1)
 		die_errno(_("setsid failed"));
-- 
2.35.1

