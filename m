Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495EBC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173EC61090
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhEFQxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbhEFQxp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:53:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296AEC061761
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:52:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso5660250wmh.4
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Zi+hq8aiYbnsFSQijylzQu3r5I5OBBYzjBOxosnP4s=;
        b=qknpvUV02w3jat7KPJxAdu2TmTxho011hGVLJ3tBbCE8TB4wFPz3pXDFeyL719m4rp
         pDCdnGFRWWSBLC0z1ihWcbA/Q6yB13OgmVYjnYBOhtO/keF9WlPe5qNqDZOUVtVF/oOm
         rJDiLbFgCRGnYSFKd4Fqo7qAxVlX4h0IbzjWl8roPPTFGGjmhQSZs1t2drXd6xMWPeoz
         0Pbl+0dETzQ+uNwlg/UjCrLvETwoo9IcZJEKea5Ncpn0sdJZKUZaRy7t9KYmeg7Ewwt9
         b0omtCibAEpi/zLNr4KOvpqSZ0wFDmqWyRXJybEcH/MVFFeZG+xyGqqSKAlvt3QUCEFB
         2+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Zi+hq8aiYbnsFSQijylzQu3r5I5OBBYzjBOxosnP4s=;
        b=O3GUT+CVc2bNSTzokkAMqSgtgWngi+xDVcbGm2PfBA9KpK2Uub1dvo+tOn5Ze5uXP0
         z0JJm1/NXBR3BeiC88Gjej8KLm3RdJajNFX3KlWhKq70hFK7+tCU4Wfd6kEUpea1L2sB
         XddLFctXKdaifX/oVaCB8Lfbdu71Uv0uOVVYoe+TBf1AJ+KqvcEGjYGD0J1xWAwFFkLa
         unAmVMMv3tZMHl8jaMDwzjxk+WznftHMq8GlPc3sk5mQk8+ozdotUaOv5nuLXV59bw4q
         Tu5fOrWFhR/boMBB08blJlcvBV+py42QPYBddEL0J2ZN6p2uev05ITOyrhaSavLKM7Qx
         AmvQ==
X-Gm-Message-State: AOAM531f4bN8TpNmDK9+PEpO24O/46xkxDhe0cG8wVcILVdZ/1q3NA8K
        PAao0UzD5BRHdaOkuOy71KA=
X-Google-Smtp-Source: ABdhPJwNXBkFeZCCgTQif0PnUb9XsnL7vV6EM06d/Nm51R6H+ERQ2zmtfSMeJ3KAiMA3LgPccb45yg==
X-Received: by 2002:a05:600c:4998:: with SMTP id h24mr16218682wmp.10.1620319965831;
        Thu, 06 May 2021 09:52:45 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42006d71140a7638f172.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:6d71:140a:7638:f172])
        by smtp.gmail.com with ESMTPSA id y14sm5354482wrr.82.2021.05.06.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:52:45 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 7/8] doc/format-patch: describe --confirm-overwrite
Date:   Thu,  6 May 2021 18:51:01 +0200
Message-Id: <20210506165102.123739-8-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.450.g14fbf8793d
In-Reply-To: <20210506165102.123739-1-firminmartin24@gmail.com>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/git-format-patch.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 911da181a1..49f08b5e51 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,6 +20,7 @@ SYNOPSIS
 		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
 		   [--cover-from-description=<mode>]
+		   [--confirm-overwrite=<when>]
 		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
@@ -195,6 +196,7 @@ will want to ensure that threading is disabled for `git send-email`.
 --cover-from-description=<mode>::
 	Controls which parts of the cover letter will be automatically
 	populated using the branch's description.
+
 +
 If `<mode>` is `message` or `default`, the cover letter subject will be
 populated with placeholder text. The body of the cover letter will be
@@ -212,6 +214,23 @@ is greater than 100 bytes, then the mode will be `message`, otherwise
 If `<mode>` is `none`, both the cover letter subject and body will be
 populated with placeholder text.
 
+`--confirm-overwrite`=<when>::
+	Specifies when Git must ask the user to confirm whether existing
+	patches or cover letter of the same name should be overwritten.
+	<when> possible values are:
++
+--
+always;;
+never;;
+	Always/never prompt for confirmation whenever patches or a cover letter
+	are subject to be overwritten.
+cover;;
+	Ask confirmation whenever a cover letter is subject to be overwritten.
+--
++
+Defaults to the value of the `format.confirmOverwrite` variable, or
+"cover" if unconfigured.
+
 --subject-prefix=<subject prefix>::
 	Instead of the standard '[PATCH]' prefix in the subject
 	line, instead use '[<subject prefix>]'. This
@@ -409,6 +428,7 @@ with configuration variables.
 	outputDirectory = <directory>
 	coverLetter = auto
 	coverFromDescription = auto
+	confirmOverwrite = onlyCover
 ------------
 
 
-- 
2.31.1.449.g4a44fa8106

