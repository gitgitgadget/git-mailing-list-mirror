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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C204C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052F06105A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbhHEHUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbhHEHUB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:20:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EDFC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:19:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so12797160pjs.0
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2A4eYVaTTM9VZxd7hC9YXxEmUa+bNfFFszvXpQKiZlA=;
        b=bmBUKmCfXiv1SFldvDOjgSh2B/hdvWGWmPhi9CRoxW4cgFHIfSaO1RZkahDJ0d0LhM
         WkjdHmnZqT0C2rMMchJWQhdyrMNRAt/5K3/ggoA3S9NKJ7AlKxjSjYQLHvL9f3wVrY5N
         aBFH3fxeYVu0sdAF0qipLV8VHu0ffOUUdDQL0cTnEBoPSsS6VA97KIg1RB1QywAkKJsf
         H47KGFz4AwZhfPWdUWnwDeWAnzijiZafEAiUubxRsplARqsVFKP9VDVBb4ASg7BOPnDT
         7iSp0GhBjz3QQwWEM2+mfs3qtGCsaISiDYgoA39FRwThfNyR8zU50BmPd64UXRZoJFCP
         0THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2A4eYVaTTM9VZxd7hC9YXxEmUa+bNfFFszvXpQKiZlA=;
        b=VskU58NqWaEoJvHw3UCbHFD19PfkqVzX8hwAIzh+CqZkAaNxy2fyG4GNLKR80INxeo
         wtWU4BpkfPMpZJuCEXc/qDfYVy/wwkrAQiM9ih9F6CXFq9UjKJKinpHbJeWSQCStmBPQ
         GFyXYVhqdOCFeIobXRy6l4reiV1Q8zi0oKfxXwVaeGpCOi2MPRmu5lY3N/CXmQ/PSEXh
         5Rs2a/I9AyUf5QTEHvTyDSpd8+lj4517ri1FJnK7KH2FpERuEIHy6x85ZYrnYv84xtP+
         Vm1qouWtEFOmjZIyow9wIGwhVTB/QqSrhiCI0/czd21GjztYkTTa+N59puW4uDH0+3Va
         PpAw==
X-Gm-Message-State: AOAM530Wk5ZEUEEpjrJrgMMmMihAMVKDHTXrXUsQdYWBTRmogvDyyF58
        U2WgFHqk0A/Qk01gqYN/QD0mnYJcniK9itIs
X-Google-Smtp-Source: ABdhPJzd07xDFIgGjSHDei3j45QMpEZwpnjSyX8GLDeoWW6dAWi2arO6af5Jl6Gt6+GJDCL8AJ7JRg==
X-Received: by 2002:a62:7f0e:0:b029:3af:e2a6:f838 with SMTP id a14-20020a627f0e0000b02903afe2a6f838mr3692631pfd.7.1628147985985;
        Thu, 05 Aug 2021 00:19:45 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id p17sm8569603pjg.54.2021.08.05.00.19.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:19:45 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Emily Shaffer" <emilyshaffer@google.com>,
        "Jonathan Nieder" <jrnieder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Shourya Shukla" <periperidip@gmail.com>,
        "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Prathamesh Chavan" <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Rafael Silva" <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH 2/8] submodule--helper: remove repeated code in sync_submodule()
Date:   Thu,  5 Aug 2021 12:49:11 +0530
Message-Id: <20210805071917.29500-3-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805071917.29500-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This part of `sync_submodule()` is doing the same thing that
`compute_submodule_clone_url()` is doing. Let's reuse that helper here.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4b496bac6..9b676c12f8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1373,20 +1373,10 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (sub && sub->url) {
 		if (starts_with_dot_dot_slash(sub->url) ||
 		    starts_with_dot_slash(sub->url)) {
-			char *remote_url, *up_path;
-			char *remote = get_default_remote();
-			strbuf_addf(&sb, "remote.%s.url", remote);
-
-			if (git_config_get_string(sb.buf, &remote_url))
-				remote_url = xgetcwd();
-
-			up_path = get_up_path(path);
-			sub_origin_url = relative_url(remote_url, sub->url, up_path);
-			super_config_url = relative_url(remote_url, sub->url, NULL);
-
-			free(remote);
+			char *up_path = get_up_path(path);
+			sub_origin_url = compute_submodule_clone_url(sub->url, up_path, 1);
+			super_config_url = compute_submodule_clone_url(sub->url, NULL, 1);
 			free(up_path);
-			free(remote_url);
 		} else {
 			sub_origin_url = xstrdup(sub->url);
 			super_config_url = xstrdup(sub->url);
-- 
2.32.0

