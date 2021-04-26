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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E653C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F373B61158
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhDZQPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhDZQPv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:15:51 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B75C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:08 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id x54-20020a05683040b6b02902a527443e2fso1504416ott.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gB7XKDX+4BdwbEDALUu1tA4TooNcKHP+uZUeZ6j7NK0=;
        b=VKjpcuehEuANsehdriwdndRB9T/Y4gAqbyO4YOIv+Pi3aEvBK6CJJ7puugK9UKweZ0
         yO771rR8V4ekJ27ILU4PS9OPYqx4eBOyVPzr7mCA3CukTRtM97RJ/wBZyo9XJ6/qXt5y
         /CrqCAA55A6+OlY8muZyGplGPAxmCW/6uanoVikD61nCHTSt9V48Wqnugmp/ArRezdp+
         XF2lYGZB6vr+EUeP6yVVIBNyEHv2hCm+r18glZ78u1EqQ5VkhepwphMTEY6UjwI3H6oa
         CygykXJZZREZds1uycJ+DGMc74A0mYVaejPuOwDZPKYizxXChI6VvDp1ZPIiRGbfW91h
         TVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gB7XKDX+4BdwbEDALUu1tA4TooNcKHP+uZUeZ6j7NK0=;
        b=J/Oo/Mz6oV+FHqEZQg9kuv6gN1jbdHfURroPd+PqUDErGrnn3ywTB2qC8oP/l26V2S
         GJ0X7AfCJBicfYARZS1L2v5mIHPkCssF8xEEa/K06wJQq0VSTWEv3aY74zNF59HE3c7p
         v225nzeTeA8g1kmgt7l+DgEgz3P+zzcPZzHRom6tl+efk3WrWt8H2EOg/iLY9HHlKqoX
         eGgNs35so+TsyaIdGFcBWK0oxwVvj/wHdQCt0ftfncpmZ3KdVT5kFLWuE4IRIyCA0sV4
         iafaQyTikwPzIvvAf/nKEm5FubrLPmCsUKuAbZMRco1UfMVRWzNlWq3yHym5JyEGYUcL
         zjGQ==
X-Gm-Message-State: AOAM530xN+i7fh2deVssdFTqc1iFLU2jyoFNy5Y34EGoeE3fP1H4B0/i
        L6YoTlt1caXbTbQK8VvsAWH7J4PJcfEBYA==
X-Google-Smtp-Source: ABdhPJwjwkSvzKZ4k/WuUf6NP3cEiHiOAhLPXLyYi9bcIbH2mH1wUfY5whgZiqZcVKv+nJH8c3EsiQ==
X-Received: by 2002:a05:6830:16c8:: with SMTP id l8mr15358976otr.56.1619453707906;
        Mon, 26 Apr 2021 09:15:07 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id q189sm3061648oih.25.2021.04.26.09.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 01/43] completion: bash: fix prefix detection in branch.*
Date:   Mon, 26 Apr 2021 11:14:16 -0500
Message-Id: <20210426161458.49860-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise we are completely ignoring the --cur argument.

The issue can be tested with:

  git clone --config=branch.<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7dc6cd8eb8..3323b770e1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2644,8 +2644,8 @@ __git_complete_config_variable_name ()
 		return
 		;;
 	branch.*)
-		local pfx="${cur%.*}."
-		cur_="${cur#*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
-- 
2.31.0

