Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98992C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbiBWSca (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243915AbiBWScK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:10 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE8B4BFD6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:27 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so4914468wmp.5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0virNklmWNiDFPjHgrPqI8m+ooiigmpC/NpkboLQmU4=;
        b=C0x97i+wR9hdRVNm4dYTyMmt0txIaoXL3hW+W4CmSnlIOZFDebBh+MdZ2U3nDqcaGZ
         RFmEFTPz2w66tfHjXBpcpDg5LR3n32Wu2UDqP4cdJkymsGnUBzen4AyqFuPQ4CxcPCTm
         O64gKpcWQYtvG3EpwskiBNxe+tWi0EqoIEHF8PnQ/rjI5Avsy0oGoI0pFWGdgf9kqVBf
         qknzatUeSBIT68BTwmNNyoiv0KcETTf4i3rKk/WIpZyjnTDeQFMV/6/swcms5VkBs/4K
         9QLPuQhBo39hvc6u9TEXt88HEP+GNe5cOnbOTP5TQ9lccwuGakFS44n+jXOKLMOFSxOV
         GiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0virNklmWNiDFPjHgrPqI8m+ooiigmpC/NpkboLQmU4=;
        b=RaCF5vSGXSQ+T5kPsWCuLaxpxCTccFWVPrnDJ90umCwhCZ+p+JOTl3JwDusW79qIE0
         mp0moxZUA+4bWOSjMMV2iRxFWtjYuOH7OjceJcPGEPiT2Pg0qXP+WwpHMPmtg5ULxfZv
         QiSj088YJoqeju+uXebZ6zVIEB8kq8NGWqfqIDGML79T9b0fG2cUDfkLHOD/oI7RxPrb
         xP7BDqcKojbkBkZsXoy5dW2AG2WRRSWH4PbKMzmR3P3padJWQo+haEIb2I9f7CJ6DdZp
         PSvPIMktwrtCWh1tgO3bpcOM/9N5LcKgPDcII9iWVggd4vTvLriQiyeJ4GWdrgOWQBEp
         oMbA==
X-Gm-Message-State: AOAM530Lmz6R9qqeF3oBY/PlTAMUgeNlNjsrfq0El7nrNU9wQ4k4bXFb
        Ufp0tRhud7viSvj6L/+qOAh79QE1ZG0=
X-Google-Smtp-Source: ABdhPJwibmooduDpAX49qxGS9cKEAFgLWaE3cqFGWbZuqxPZsVJxqTMqVMuuB2pUnxXDmqYPm25lYg==
X-Received: by 2002:a1c:540b:0:b0:380:edd5:9f2a with SMTP id i11-20020a1c540b000000b00380edd59f2amr3820720wmb.122.1645641085659;
        Wed, 23 Feb 2022 10:31:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12sm319349wrs.1.2022.02.23.10.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:25 -0800 (PST)
Message-Id: <5b983cc3c104fe6ed64608320387bf82fefcdbb4.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:58 +0000
Subject: [PATCH 20/25] serve: understand but do not advertise 'features'
 capability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change implemented cap_features() to return a set of
'key=value' pairs when this capability is run. Add the capability to our
list of understood capabilities.

This change does not advertise the capability. When deploying a new
capability to a distributed fleet of Git servers, it is important to
delay advertising the capability until all nodes understand it. A later
change will advertise it when appropriate, but as a separate change to
simplify this transition.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 serve.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/serve.c b/serve.c
index b3fe9b5126a..a1c853dda1f 100644
--- a/serve.c
+++ b/serve.c
@@ -18,6 +18,12 @@ static int always_advertise(struct repository *r,
 	return 1;
 }
 
+static int never_advertise(struct repository *r,
+			   struct strbuf *value)
+{
+	return 0;
+}
+
 static int agent_advertise(struct repository *r,
 			   struct strbuf *value)
 {
@@ -136,6 +142,11 @@ static struct protocol_capability capabilities[] = {
 		.advertise = always_advertise,
 		.command = cap_object_info,
 	},
+	{
+		.name = "features",
+		.advertise = never_advertise,
+		.command = cap_features,
+	},
 };
 
 void protocol_v2_advertise_capabilities(void)
-- 
gitgitgadget

