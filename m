Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AABC433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 17:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245320AbiEURPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 13:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344056AbiEURPL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 13:15:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E50A66CB4
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:15:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso8449916wmh.2
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsTOyPms+0I1Xqcafs99ncW4nxy54zVM/Z/fBWT7/6w=;
        b=WyGdw41MrFJTD98pbxnm6u/itS6cW7bgwKc7eMtj0Uymgtt6HXx0VQ9R5DPW8P1p/3
         LCW0gnTa44NbpfqVYJ6C5qfSB16AB2NJBj5eWGRElbL9MALVlyOMsjW2kaYlD8XFWgPl
         6F/TtJsjmezusjYyQkJtFYBAb+4DecckWI2TMVrzkcVesC5ltnoy5HYd+51/0/m8XGNm
         1rQfyHuHI9gmYNvjDe45PDUU7cyf7qHqWAWjtddUedhUVoeLKzu3PnLVI9NbnI9GN1GI
         x3YmXtdWSvyhXEo+NNv1CxEE0Y2qVlXOLV+/tEcubARlAo+RQ8VeMCh6TW9u3mvflSSH
         LBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsTOyPms+0I1Xqcafs99ncW4nxy54zVM/Z/fBWT7/6w=;
        b=Qwj/SeDMhNOME2TCHRTTDjjEKPWBS9tKIwrIOiKhxFFMKlANVl4um20YFp3uIV9p2i
         Cs4FClO5ugq6SFtD/Xl21dKBAtb4496WirQTWKqFrWtW9c0mpDifHB/td/QR52J9zUwj
         KITuLkT9mvfUVKseaQsuF2t5PT+1wSlUyxeRFcEGSAf33jz9EZp9DawRBof7jMCBLAHb
         h8xD7RA+5z2D3RPr64BMnrCBWcgYcUVRC+Ca5qq02xoPi+9wYnIAtFxeqaHLblndxMtX
         UQUesPlRXBRr1mfFVwtMW3h7hIaRfSZr/Mb+76ON5/SAKPASJBihdLsMr3Xzowqdp28Y
         7gZQ==
X-Gm-Message-State: AOAM533ps9FR4/mPtLrY4shf+sLcRPBUnYD2F1m8zVm15iB4DAoOYD9T
        YxdrcBS7Y0AJKbfT6OzjmsRZntnKjHBk8w==
X-Google-Smtp-Source: ABdhPJzvsuY3YcNk+dE72eh26asdK1ZHfGUdeaoFqKF/PCxFqJgBsxV6BOlapTW0Trf+ANn3u9e80Q==
X-Received: by 2002:a05:600c:3b17:b0:394:88f0:a4b with SMTP id m23-20020a05600c3b1700b0039488f00a4bmr13117486wms.129.1653153305359;
        Sat, 21 May 2022 10:15:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b0039736892653sm4964685wmj.27.2022.05.21.10.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 10:15:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] parse-options.c: use optbug() instead of BUG() "opts" check
Date:   Sat, 21 May 2022 19:14:40 +0200
Message-Id: <patch-3.5-5a3e7609854-20220521T170939Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.960.g7a4e2fc85c9
In-Reply-To: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the assertions added in bf3ff338a25 (parse-options: stop
abusing 'callback' for lowlevel callbacks, 2019-01-27) to use optbug()
instead of BUG(). At this point we're looping over individual options,
so if we encounter any issues we'd like to report the offending option.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 7fff588a45f..5875936898f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -474,20 +474,20 @@ static void parse_options_check(const struct option *opts)
 			break;
 		case OPTION_CALLBACK:
 			if (!opts->callback && !opts->ll_callback)
-				BUG("OPTION_CALLBACK needs one callback");
+				optbug(opts, "OPTION_CALLBACK needs one callback");
 			if (opts->callback && opts->ll_callback)
-				BUG("OPTION_CALLBACK can't have two callbacks");
+				optbug(opts, "OPTION_CALLBACK can't have two callbacks");
 			break;
 		case OPTION_LOWLEVEL_CALLBACK:
 			if (!opts->ll_callback)
-				BUG("OPTION_LOWLEVEL_CALLBACK needs a callback");
+				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs a callback");
 			if (opts->callback)
-				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
+				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs no high level callback");
 			break;
 		case OPTION_ALIAS:
-			BUG("OPT_ALIAS() should not remain at this point. "
-			    "Are you using parse_options_step() directly?\n"
-			    "That case is not supported yet.");
+			optbug(opts, "OPT_ALIAS() should not remain at this point. "
+			       "Are you using parse_options_step() directly?\n"
+			       "That case is not supported yet.");
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
-- 
2.36.1.960.g7a4e2fc85c9

