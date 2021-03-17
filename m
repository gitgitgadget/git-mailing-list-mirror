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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2023C4321A
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A700664F7E
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhCQSVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbhCQSVV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E9C06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so1874900wmi.3
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SAHTG+EgpxZAlDX3vxSLrH9AscZjXYwixsTgbzS0E/M=;
        b=E1I43TJ4SE0vNkXLlu+eUhxLjp/oVBHdt53DabtdbPdaZ+hSEhoiqWnp78KEC50PWc
         TSQEWm+pV3SP6nIsYcShGkzAKyzi1MyM5TBRgXycXLKHX5BI2kLd5KqzfnllhTOU0zhY
         dl61lzdSScR0ZBMn/VbGAH913xfclCNOWV5JVbWM8HhjOb6252Mu4CUVVN68Bq8czuJK
         8EoUA1alfH08sN8EuCqaYuWxoL3YK4sSOVRCRDLUABDvVewX0o9nrmoHCO73m4+ic8NM
         xdhtc1ydTVOhguK1j3M5e8s7ngXgBbAUVQ6fr7z/MYg3LeIdZ/2poxuJeq/YWTgDaSQe
         wnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAHTG+EgpxZAlDX3vxSLrH9AscZjXYwixsTgbzS0E/M=;
        b=U3yRyhFAI/3tfFZOJSVwF9mUntIlhHY015oa83xHdytU8ksBLi+HVsa3+VV9v5b1cx
         IVlC6J5VwRj+k8AFI1nxaamN3qcyTcYHx3Z0YoKTnMK2imHYDRocy7h2pyZuEszityuH
         lcUBp60a6yWLixB/422hkJNtGnCIRckxBW7b2TN4eN1v5UHaWxd6LypYEV8pOoGd0M4s
         3+oIJFElqWl+CRFnNWMYGBDkMuxGhaG73zEinA9lvBhXusf/o9xi4mxmkIuVPni81XQO
         D3uZ40oZ0mFn62y9Fh2tjAfzCPgGIa7WNx1AHhO8EDT7V3NdTjckY8U+Jy9EIeXcZ8ho
         iTjQ==
X-Gm-Message-State: AOAM530hb/K0+RapJszwmvu9rnQ/GA7BUDfyeXp6P0mijYgck9CXHqow
        JuLqVltBmCpGL+FD20lGZpHY5l64TzBwMw==
X-Google-Smtp-Source: ABdhPJwc4t1khj1e2spk7mfnq/sfm4xVzHEL0FH0SD1Kcs4AxX0byfUrJAa4B9Rzcp9dlJ/kSJzuUg==
X-Received: by 2002:a1c:b006:: with SMTP id z6mr110297wme.19.1616005279360;
        Wed, 17 Mar 2021 11:21:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 11/19] fsck.c: undefine temporary STR macro after use
Date:   Wed, 17 Mar 2021 19:20:46 +0100
Message-Id: <20210317182054.5986-12-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f417eed8cde (fsck: provide a function to parse fsck message IDs,
2015-06-22) the "STR" macro was introduced, but that short macro name
was not undefined after use as was done earlier in the same series for
the MSG_ID macro in c99ba492f1c (fsck: introduce identifiers for fsck
messages, 2015-06-22).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck.c b/fsck.c
index 341c482fed..e657636a6f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -100,6 +100,7 @@ static struct {
 	{ NULL, NULL, NULL, -1 }
 };
 #undef MSG_ID
+#undef STR
 
 static void prepare_msg_ids(void)
 {
-- 
2.31.0.260.g719c683c1d

