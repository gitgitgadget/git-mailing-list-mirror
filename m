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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA1CC43217
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4E2207A5
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbhAACRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbhAACRU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:20 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F97C06179C
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:52 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id w124so23456608oia.6
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tm6KPstUW72+JXxK5veP45TSUkg6Rkb9WnRf0UgCg2U=;
        b=MIYo8adhCC8Y0/keyV9zriL9fR2nkGW4ILh8ZDvN54su784OjkZ6n4nY0oU6jJvJml
         KVwMX6ab3MU24YfBZLvjZMtJv2KDn9bbCZAhe3SfDTFCYIvN4Q+LWsThMPl0aavqxgce
         sSEBu8fIMaL6r9Iz1KNkdnCnzBvMce4YZe00bXOj8WdWzLGYSGQpyml4sNNU9OCphXT9
         GoItQUWDu4O/97vsHGF/is0ZZLBHwYDwyp0KqNitjsOa7AmbFR6xiuUGa8fwRP+37Pfd
         /nXBjVMFuy2ksBLAoUeiONZ/eVQQtim08DKdU/DmzF6S4NUdevUbE/DOCYRpR+vm85ne
         Ef9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tm6KPstUW72+JXxK5veP45TSUkg6Rkb9WnRf0UgCg2U=;
        b=Uf/8acUh38BpwsGYLKczyg6fZPTFikALDt65/5aAtOVTu41bNFAxXWB9oFnyVBiJid
         tt8Z2bX284xPqWpGdQ7kMU2ivqGDpaysmQAis2vQYslLwSeQjVXKttcWDxEmL/Vf3GoA
         mPMjDgCEktoufr4w02+dxb2IlJ/5iaG59Wc8+TR9xrKDj2uC9TJZZBWOaB8/jFw2PXb8
         2oEPU6GlSxwZ9dSzSBK6d3n+T6Gf1N8adWWDvc1lLzehSEjiWr7MSEKnQRlYFy+g3fS9
         9/n0H4xsi8dSLi4YQbDgzP9qb7OppScMbuRu/zNJYP3yOgrd3BT4UkRGHGy7lAWG+jEG
         voNA==
X-Gm-Message-State: AOAM532uZWYAh072/IjQcsbOKL9zr7zle15/d/6ZHtRy+1uXI3zOcPB4
        FUju9PJRC1ZLB7vfQoEsrRFbx/9xN7Lwjw==
X-Google-Smtp-Source: ABdhPJy6ZOLPuaSpTLgv1p3rfkAaenl7RMZndzB4qIEkST2dHEkCk/KW/cw53rOtZhzao7cgI2BItg==
X-Received: by 2002:aca:5d42:: with SMTP id r63mr9646748oib.94.1609467412087;
        Thu, 31 Dec 2020 18:16:52 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l134sm11171236oig.25.2020.12.31.18.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:51 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 17/47] completion: zsh: fix extra space on foo=
Date:   Thu, 31 Dec 2020 20:15:52 -0600
Message-Id: <20210101021622.798041-18-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
2.30.0

