Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610FFC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiCUXLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiCUXIs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A188506FE
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so413117wmb.4
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kF+7rkf/S8GPsJaCqzMCFIaOe6etW4B3vxUir+eGeRw=;
        b=nhEcfyqjLOMq6/55xpHv1M9OxMbPPSHyZneEDxi0Hjc2j4AaF6Dzj+GeJSR88g5wyW
         Vm7/ev7K2zAkEgKXJ07/X6u0CLq+dWDJVr38ZYykjDgESmXayJmQ4ewjYyxDsM8AZA2b
         eu6YtrbfF7+rE/r6WWUWc0LAzZOb4sYnksSRnSoHeifkk7UwW8TH4FprP2mcn6X+ei+f
         f3WczhiGxwIWfy/6PzME94VR4aVm6SblBfNBhXS3px0tk376U5O+iXKX4Mc1Eb2KhW22
         R3qzlceL4Z7hhYvA/6t0WSX8+ZNDBiBIzt2LzUAePhhqvoKK9ibyR3fF8v06b1coYnEO
         ew7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kF+7rkf/S8GPsJaCqzMCFIaOe6etW4B3vxUir+eGeRw=;
        b=mnB/YpBbbP3qxc4zbPAVZIpMuNJPC94sc4KRy3vqetk87XpoNfCiy+17jlDbPp2Xi/
         yabduOeJa07+CfpqAsWVFNcvL88EcheLg/HgUWpzm4/aWQ8ozEcchF+96pTI2GzgB9A4
         af7w0r0ncWaHtP/MLgYwMJC2x2V7kkKLKU5rtAe6QaV2PGWNUSQsXvvoW0D39HJ3EbMr
         H/GDnbcPnYJVO71ppT3RP3tQ832AqABMhkc4sCunzCgfcqF3YARdxLycJjyn5OWM2M2V
         inEG9vpQBxp0HQi9vniC7JNxK4gTkLVSgVM7YybiC/BeB3S98OSa+y12QaAioDhkCw9K
         9IAw==
X-Gm-Message-State: AOAM531kFHDOneg1QtwhUzZ24xemIb2tDMIFqQVeT4ZTHdWDgcaEGm0O
        jxbceFnNQ2naHnNUUZlmumix1OF1rJQ=
X-Google-Smtp-Source: ABdhPJyb171/Og6zZXcDU9u8wcT60+wmVEhtOrnGSMGQDy1ye1OpTA5r3DRU8Yhdho2xA6cEKZ908A==
X-Received: by 2002:a1c:7312:0:b0:38c:6f75:ab28 with SMTP id d18-20020a1c7312000000b0038c6f75ab28mr1132469wmb.19.1647903354476;
        Mon, 21 Mar 2022 15:55:54 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:54 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 15/41] rev-parse.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:57 +0000
Message-Id: <20220321225523.724509-16-gitter.spiros@gmail.com>
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
 builtin/rev-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8480a59f57..e313b64fcd 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -543,7 +543,7 @@ static int cmd_sq_quote(int argc, const char **argv)
 static void die_no_single_rev(int quiet)
 {
 	if (quiet)
-		exit(1);
+		exit(EXIT_FAILURE);
 	else
 		die(_("Needed a single revision"));
 }
-- 
2.35.1

