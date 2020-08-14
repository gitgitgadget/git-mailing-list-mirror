Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21847C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8CD214F1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPWSbJIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHNMWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgHNMWK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:22:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4583DC061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so9692135ljj.5
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bCmRfWf3V5Z8kL7hlwU6HQ2D31NYOkEfTR37ogrKfxE=;
        b=QPWSbJIB+jI03tmP/Jdb0uPslF4C43GGUYydV8HPUsU+qqzBOaeQkXnvMErUgqxfCF
         DHCbU1I+CmCicsQoUs5kAq22+/1TJktSm2d6v4gDji2GEqcJFfgh7KMSBsUO98SBm1/A
         6hrA5Ne6Yc7ix350LVYBH5DDEDNfgJm3EvuJWXPMUg51RdHMqVwCHM/KIMc6V/ZNlJmt
         OefkN6n73uiHrOMlnhyYnhV9eH+nmD1ePHMPqPiM/uZZLvLFTCJsZCyv6WvyhWP3i7I+
         iwqSAmeGdGr306IgHdDsijHh4kbyjto2TJphKN25FfFrqf8XxquccKEayuldh6duUrk9
         T9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bCmRfWf3V5Z8kL7hlwU6HQ2D31NYOkEfTR37ogrKfxE=;
        b=gd1cKeBoP9iyG0SIfPXaP2xB5Lh22MXtbDUebd3Djm59aSMAtsBzn+9eA3Ke0VUxnX
         RZosQc+PMfEHmkCZCHj/oMRyU/OfwHUckDXARE92geOqyOd4+jrP1XlwCqgJznTp1nbp
         xjTGVlN5mQM2CIbh/NKn1uYb434HPymKTTOmSiUt/7pclgZZV3IAq6kuYTcRppjiWeEy
         Kud83YSeLklS/u105ZRCozOpFRSn79qYpp3Qzql+FRiNmkKA4ihu3f1U6N4m2i2xGL1x
         pAyC1GBcbm79rGNKjGms96Uv4fNCEpuzOJsWsKJVUzI4TAjg+N0/eNVAWVL8QEwt7/XD
         zwLQ==
X-Gm-Message-State: AOAM530HMMX5DaTaCyosi+tofAnaLaVwlHeCc9qWRJwd2AOele3Lebq9
        2k5nT7HcFI1g9Hz5L5pmR+3dxtzMk+s=
X-Google-Smtp-Source: ABdhPJz1jmZIOWJAVmhRPFZIc2KIJ5BH1+BHcw5ExlQLkGPXOXVKiaJPluun9dgAmCg4zLq98XWiIA==
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr1122441ljp.247.1597407726748;
        Fri, 14 Aug 2020 05:22:06 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o2sm1847407lfi.50.2020.08.14.05.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 05:22:06 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] protocol-capabilities.txt: clarify "allow-x-sha1-in-want" re SHA-256
Date:   Fri, 14 Aug 2020 14:21:44 +0200
Message-Id: <13798dfb121c9631e9d811f5f74f9a78c1fcfdf9.1597406877.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1597406877.git.martin.agren@gmail.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net> <cover.1597406877.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two of our extensions contain "sha1" in their names, but that's
historical. The "want"s will take object names that are not necessarily
SHA-1s. Make this clear, but also make it clear how there's still just
one correct hash algo: These extensions don't somehow make the "want"s
take object names derived using *any* hash algorithm.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/protocol-capabilities.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 36ccd14f97..47f1b30090 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -324,15 +324,18 @@ allow-tip-sha1-in-want
 ----------------------
 
 If the upload-pack server advertises this capability, fetch-pack may
-send "want" lines with SHA-1s that exist at the server but are not
-advertised by upload-pack.
+send "want" lines with object names that exist at the server but are not
+advertised by upload-pack. (Note that the name of the capability
+contains "sha1", but that it's more general than that: in SHA-1
+repositories, the "want" lines provide SHA-1 values, but in SHA-256
+repositories, they provide SHA-256 values.)
 
 allow-reachable-sha1-in-want
 ----------------------------
 
 If the upload-pack server advertises this capability, fetch-pack may
-send "want" lines with SHA-1s that exist at the server but are not
-advertised by upload-pack.
+send "want" lines with object names that exist at the server but are not
+advertised by upload-pack. (Same remark about "sha1" as above.)
 
 push-cert=<nonce>
 -----------------
-- 
2.28.0.277.g9b3c35fffd

