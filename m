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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ECAC433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7E3207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAACRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbhAACRr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:47 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C78EC0617B9
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:03 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id q205so23404097oig.13
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QCA0MjK5THAKmB95LbBpQTvBHaqa5P8ng9hNgIeFJY=;
        b=kaC2GiDJD5aRllvWbtlobPzAvHKH/IyqiLvo7NP52p7vSu11YcsVP+dQpAvXfSbHcp
         UGBbq6pI0dWK8fbBI9zzv08FFgPsTULiEm7Y2fKA30iDHWG8zXalUI88gdS2VnoKFcax
         wHMCn5kqU52qvaQitvVZWn+MUtp7TR1w3Ln/2K9O1xP8IfIOQ3gE7JxYPSVwzXvRW3OO
         XFnT9XbSAY6dfxSAl92qh0NZ8NElfQWH1Y0eu7xLSvXPS691GVPMUQu83iVmNOAvDm24
         LXODAI+rZecUkLDkGqBzI4FrFiiqBKYbLXIORrqvZaVcgvBu3sUOwMtYHi2UEOJTqxdc
         F7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QCA0MjK5THAKmB95LbBpQTvBHaqa5P8ng9hNgIeFJY=;
        b=l8F4Q0aKsk7knDEb6e8uQ2RzQPd/c6FHWMdkgYVT+jnX15BZ+soRlmavF+S59bx6UN
         pS3fIfyqdDVhGHckzWrkxz8VZvZvdzBQOMeR6N3C6cuDqBtv7jsVhoIKuJlGpweNvMNf
         UbxfrgJ8FzJKFeVzFzPdt9i2kYXvdB23ybpJ2pQ6sX2lEeyho1JrNOaM3I8Iolx3NU6d
         kp8Uj6ah4EdaInWXYXPRpRvilKJpEZeXM+EHX4FxHppex93nybZGDQPQQ8BoFgk5qVlU
         6wVYuYcmF5BR7cY3zuYN36eFlgAP6ah4SRWCUkKRJNmL7BVK0Kky3op10NwXkIT1nDuE
         +H9w==
X-Gm-Message-State: AOAM532kqYJPsyoMYnIIYlXn0KGmf9oQukQQQIEQDOje4OtrkQ1TBa1X
        9T60fNgQtxeN+zlfNGnPK/cMBaIYIahl+g==
X-Google-Smtp-Source: ABdhPJxyKusgVh8QdtTPxnOlIXyS2W4LElnzoIei3grM6TLBvYJtL7h/83OQUo2wyEIrLAEwHn0iig==
X-Received: by 2002:a05:6808:64d:: with SMTP id z13mr9705064oih.177.1609467422657;
        Thu, 31 Dec 2020 18:17:02 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s9sm11349583oie.53.2020.12.31.18.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:02 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 24/47] completion: bash: change suffix check in __gitcomp
Date:   Thu, 31 Dec 2020 20:15:59 -0600
Message-Id: <20210101021622.798041-25-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't match the prefix, we shouldn't match the suffix either.

There are no functional changes since all the callers that add a suffix
add an =, and if $cur_ ended with that suffix, we would return
immediately.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 00a78039b8..1f0728ae52 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -337,8 +337,8 @@ __gitcomp ()
 			fi
 			break
 		fi
-		c="$c${4-}"
 		if [[ $c == "$cur_"* ]]; then
+			c="$c${4-}"
 			case $c in
 			*=|*.) ;;
 			*) c="$c " ;;
-- 
2.30.0

