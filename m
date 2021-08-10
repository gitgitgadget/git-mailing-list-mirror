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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B080CC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A266023E
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhHJLsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 07:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbhHJLrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 07:47:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA5FC061387
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l11so9000683plk.6
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1gRep377kazGCVux9LgpDgLFk9zmRefTC/yi5pLJEc=;
        b=ABj5SqRTUePCR44CR6oBbHloQNfzzeDj68NOD0QpSdZ8x7mrDDpS8dJuJBu8CdTns/
         t1SIptJBRwlegxIaKtHbkOtuES7458oUfM2dLNit4MMPtiH+83sXXzoEgE0FkJdMyWwg
         9iJlAkwAMxgZOpHGeeAJbIPkh0D5Fd//DztK5mkF2g92tSW2ao802q9MAyP2Psxn0MME
         6t6lnoL1df00S6k8SWZW0h9mbdsfsR+LNUiStwGURq2V9qrlJGsLdV0lDLX3rzL+MPNc
         Nu/VtTeY0RMG+Vh9xEhixT7tbXPjLOfQXtiZMurTOR6nv7kGWd7JDsrdViljHYssKyGZ
         i/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1gRep377kazGCVux9LgpDgLFk9zmRefTC/yi5pLJEc=;
        b=cS3cPpZZKFjquy2wQrOEFWJ5MwKx62S5uygVRP0hpZZULpR9gLEJtwNpyyS/1HiBLG
         CMoRPTeoal6RiDhMLR/8geyXFBzUMPeGxsro9JJ6H2nAmNyfKZvTxMmVvy+D3Q1tny4o
         LiayRrdvv6GPyOKCmJr6a+KldUoYXkz2ovjHSfM4t7FkMBe8vclR/NkNXm8P7fMQtezp
         AaTrPFICTujfEd/fYpvdvyhNMCOJ13oermw1VIn73rgIGQduOLxRIgYu/2dAphhw7vRC
         vG3/EKX8KMBKmfgFYN7B0g/Tp+gV+8gfPsarwpGErYi9UqnBKdG/ALqN5zHRJr3QCVLl
         a2cw==
X-Gm-Message-State: AOAM531KuvJP3D37Wpxh8/AIkOT73EI/1mgLHzGZCPT6xfYJGrMTeZ9C
        Z2EoPh/Pv7zzPbEHoTmBwAg=
X-Google-Smtp-Source: ABdhPJxMmCNSdo0X6qbdMU3Nop1ZGU/6YtQP4/48md3jR76ri+t040RaFz7rua/qNgcCfa16fkKfvw==
X-Received: by 2002:a17:902:e88f:b029:12c:c949:36dd with SMTP id w15-20020a170902e88fb029012cc94936ddmr14747252plg.84.1628596034891;
        Tue, 10 Aug 2021 04:47:14 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id g19sm12410232pfc.168.2021.08.10.04.47.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 04:47:14 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v5 3/9] submodule--helper: remove repeated code in sync_submodule()
Date:   Tue, 10 Aug 2021 17:16:35 +0530
Message-Id: <20210810114641.27188-4-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810114641.27188-1-raykar.ath@gmail.com>
References: <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210810114641.27188-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This part of `sync_submodule()` is doing the same thing that
`compute_submodule_clone_url()` is doing. Let's reuse that helper here.

Note that this change adds a small overhead where we allocate and free
the 'remote' twice, but that is a small price to pay for the higher
level of abstraction we get.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fe126cdee9..da77248948 100644
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

