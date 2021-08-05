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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0548EC4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D3161008
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbhHEHlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhHEHly (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:41:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9A7C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:41:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so9596425pji.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2A4eYVaTTM9VZxd7hC9YXxEmUa+bNfFFszvXpQKiZlA=;
        b=FLMHg7/tZFQ3Ou1CvVLbqtC5tRpOz7xPIY/Nwrj3ANf4MJQ0kjXquE3duiJZxaogHl
         PVkBxSxdX3Z61M0+AT/IVJMLGKOK/GGzzptQGiUR9Hjb1Ntu0e73+uOrA+oVVnumMfcr
         vKAhXbEYIVAx288gq/osrTGMks4e+a1fHktAjEyr1d4ZnvdP2r0mDsGd6TVl4+s00kU8
         3hjnmmfJIp7UD8x57Oorhrgy5t/L87BA5rT2fkrtQ/MsdhoIZjnIDNheS8Mcpl9w7xRZ
         9fUOEXrM2I1GE3CXo7B2rPhhypXsZUuZ8Qkf6g4Lm/mYRduDDjiKwsl6PvdXSZQ9eDl3
         2T+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2A4eYVaTTM9VZxd7hC9YXxEmUa+bNfFFszvXpQKiZlA=;
        b=o8ymELKriaNL+skONmvw5jfVr/+W5VPjMj+108L80sAntyD926J6Gq55nPFQBkRJq1
         xNeIfW9bual8wo4HcGvZ6dNmsi9RHwl9OJ/lTOZVdqwXRnmjUgIg3Tp2qCQ41Vj+ro2d
         Rpx0IoWFEG53Q2zYi5lpnKsNDJIJ/EDDBHgunJym/26j1sIJzuQ2iwlUrISWhxDz81t8
         EXNeGbnHl14F7lFQkkyuhMXhmfA0c8wsle/jshkhAoPjhgAVTpeWckU+bY1qNoZSCIoO
         BAHVI70iivdjkYRKOXPxTpsyX/KnGFnrzB+jTfKwL58I4CiJLxD3F4BqMq6bHBvq11dg
         lGQg==
X-Gm-Message-State: AOAM530PaTSx+yX5IC+NQo4YXBWLIWCl9VVNsK9e3HuCy6jKvtooKoXl
        RhY+k3dKffkTk0P5Pb9F6iI=
X-Google-Smtp-Source: ABdhPJz1uZDrxBBk94RyZjI6H8StuqogJkHdKFxRdsUiq+Qtch2T9uTinBWpYTojz+sj3Wu/8KsMdg==
X-Received: by 2002:a63:9c5:: with SMTP id 188mr1632328pgj.187.1628149300214;
        Thu, 05 Aug 2021 00:41:40 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b2sm4885153pjh.18.2021.08.05.00.41.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:41:39 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v2 3/9] submodule--helper: remove repeated code in sync_submodule()
Date:   Thu,  5 Aug 2021 13:10:48 +0530
Message-Id: <20210805074054.29916-4-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805074054.29916-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
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

