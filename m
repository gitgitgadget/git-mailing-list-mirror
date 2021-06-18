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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7493C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7E4611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhFRS2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhFRS2M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:12 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11CC061767
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:01 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso2670032ooc.13
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dXlYzPbBXdJzNOPEVUVvitzi1CW1bMP9B30F8iOMDHE=;
        b=vYBk3136IAgVedbCHZlIuQdowg59tKW1WnZoTMyswCF+5QfUyMvd6sCsj4lWBmm6A7
         b2+CyRChGNJ2ZRcQC7xERy3vTts/CYZHXX0PY79jV+sPvwJGQd5w80hFACB75mtj3RwE
         rvAEPLOf1hwdnL9wHBXApqw7bYmb7UgShxMrysn+apsINavRjl1BGke9Zz2t7NBDPXP1
         nxcXDdQ5KgeTG5uNb6uqqszg+rbqPaPEYWZxN+sLOMd15OorfyKkqGBpSo74JFneKeS8
         JAqfCqVIUyApA8z1MG73FuVo/vJcRGG/e6uATiPUMhl7GABgQVCTz8CulTuoAOJVr3Er
         mswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dXlYzPbBXdJzNOPEVUVvitzi1CW1bMP9B30F8iOMDHE=;
        b=tjXKIhJhUHayxgi13EmnQXlCWfoK3bo9BUpMm8MbHFmqo54aKyjZgwNZxepTdvj3XX
         g3JMSv9WjcJKAB1qibwbWw3cD38MK2sBv6xLsS+axgBJVmIochgseA5If8n399WXyHzC
         PRLiOnS+xBc2qylNzv++dj5MejuEpHt6A3aj0U7KCnpuGAt6NOoz9jdMz6Eq4Oj3hHyl
         MHm0L7G9v77KmVz+MdgzwE15uC1CecUmBPxdC0WsjOB8hKNxL/VzcyNwxnfXlP6sgyJb
         q1g0KtiBYqQuZq3tP/8gRMqLV4k6VrPjDym5AdnGjPyl0ALaLZkIrls8hQJk6bafglls
         LO0g==
X-Gm-Message-State: AOAM530ktDyMhocy04iVAdxtGD32wA9Zr0pfIflKJxbRqO5u2b7kIvT9
        tWaY/iM3k9f/J4H/4oILYTr+8ZFSKgU7Uw==
X-Google-Smtp-Source: ABdhPJwrpWpVN7JkFAw2QYDjz1my5ZM0ntsqwX1gYTZP++kAubikex9mvjQSXhbDemDtDDzixisKFg==
X-Received: by 2002:a4a:df11:: with SMTP id i17mr10007683oou.93.1624040761025;
        Fri, 18 Jun 2021 11:26:01 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id j7sm1951564oij.25.2021.06.18.11.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 20/45] completion: zsh: fix extra space on foo=
Date:   Fri, 18 Jun 2021 13:24:53 -0500
Message-Id: <20210618182518.697912-21-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Upstream commit e1e00089da fixed the issue for Bash, but not for Zsh.

When we are typing configurations an = at the end signifies we still
want to type the value.

Can be tested with:

  git -c log.d<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index f3e8cb7535..56a1bb16b0 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -87,7 +87,7 @@ __gitcomp ()
 			fi
 			c="$c${4-}"
 			case $c in
-			--*=|*.) ;;
+			*=|*.) ;;
 			*) c="$c " ;;
 			esac
 			array+=("$c")
-- 
2.32.0

