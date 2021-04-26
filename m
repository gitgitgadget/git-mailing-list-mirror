Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7481C43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906A461164
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhDZQRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbhDZQRD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:17:03 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1899C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:21 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i81so56951079oif.6
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMJvwmyU+l8oG8yGKAfmlKQa4GNrJ3s75/vQURhiX7A=;
        b=lm663jJc1x75xMliNqw+KqEJLeHB7wgXJGQpWKlLLxUL9LJhPUyFTfNu1YWD+d8zcb
         NunUHZZnVYd4LNKcPtlGVLmGcKpXo+aWPFs0aHhzHX1/8hVKNYotRMh0BZ9fujqburtC
         Ih1TMZJJTaM6Mt55G8Z8UQR8gX3O8LP13irk+gPUE6nCcM9syDBp9UOPjkwGefAWQ7Vq
         EZHJL4nGWNsNqSaTsnrig+nxaAAQ7IAdSIepB5v9gyRMslLNQxAkneNPLGw704zLHOip
         E9Us761fXST14S8ueS9qGEiHm/syoyHDf7Z09Tg63PNEKDI7VBmeuUEqn/Au84t8YnFj
         uzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMJvwmyU+l8oG8yGKAfmlKQa4GNrJ3s75/vQURhiX7A=;
        b=lMqZfsiTZbE4hzbVN1urMpvk/ZKTWTIWFJC6VlEeaBQpzECaN2fpFln0S4R1pjHTKe
         G8wVXnX/ScpatPk48XxAeZVUNiQpBLo8S4Kzkso3OQgLHmcqK/Usc7M+Lt+TfprZS6tB
         Hy0fe68G4F8uFY8fquL0xvmfVBrmhXbB4vsl0iU69JlDgoUGaaG1TnM802SSxTLmki1b
         gk5NSYhLvBcMvJzHFKmalOlxr1qFpD/ekNAFig9YGUkBe7jqfH6lnsdWjY04LFDJ9Fqo
         EZ9L/h+A3t9FEuYMzVlfEVlUg76Urn5mFYD+oxSNorJzDoK2IH26T72t9PkbVra/APGl
         iYYA==
X-Gm-Message-State: AOAM530E9EanUSqkPlVxZrA9KziJswexGahe9q8vGgLhTzu92PKagJ7j
        q2d8QbUmHDJredLkKF6WLGxsTttS9gGx9w==
X-Google-Smtp-Source: ABdhPJxD/glY2sfh0Ug81Ar6m0opMxb4G5s/3cfWlYahbXRLsHpi0s9a49PPL3K2j2jAldIhJgBphQ==
X-Received: by 2002:aca:5307:: with SMTP id h7mr13721432oib.140.1619453781218;
        Mon, 26 Apr 2021 09:16:21 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r19sm3098320oie.58.2021.04.26.09.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:16:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 17/43] completion: zsh: fix extra space on foo=
Date:   Mon, 26 Apr 2021 11:14:32 -0500
Message-Id: <20210426161458.49860-18-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index 6232d0a823..073f7d91d8 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -86,7 +86,7 @@ __gitcomp ()
 			fi
 			c="$c${4-}"
 			case $c in
-			--*=|*.) ;;
+			*=|*.) ;;
 			*) c="$c " ;;
 			esac
 			array+=("$c")
-- 
2.31.0

