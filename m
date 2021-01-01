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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A2CC433E6
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E1A207A5
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbhAACRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbhAACRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:05 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93339C0617A4
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:46 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x13so19288975oto.8
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6YXnKuwZpGK5A3JCGvLjz/NWAYoAVWrBdW06XEMFow=;
        b=hmF5OYNWp7ibKDiZ8X5nRIg76Lb7iqgVxeL148J2zv30fNXi3uNzy1S0xz3RDBEwRk
         GtEVFpxdTrE/rMQ5k1Q+mhUd/XZjsv2xxjA5KJ22+Yzs0TTtooMZwgNlW8dXatVGMVHS
         WmtsJG3r1Cvpi+JMZ0psadkmwA9cqtz1z7bLh3PAw0G16S5YKeIK4sS6xqpJYEiWz8xV
         953YG/nqozIdi7eTXr90mQiNrlLU5kOxnkVOBGWpcXxitN12AC3oYNog5hdvZD2Tfwyn
         o+jp2sZy5zTEjoHDluLywpKIY66SW4loIEavhQ5a5+D13iVTKqhxHBB/HFwQYXJjI8yb
         rWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6YXnKuwZpGK5A3JCGvLjz/NWAYoAVWrBdW06XEMFow=;
        b=eQG4ISIHYAQNSymDNCfOtGgePTKGzIZV/YJ2Xlf3TcDYIEy4VU9Qj2ey47WyBv/Evx
         B9XhQ1ggroHeVgQi6TiYFBUnruDk01zRitadjYmUbvV4MLQRJEChxhUpXg6b/fWJH5A7
         SwQWgvRkFth9X4owj2bH7T8m/2aAwXctF0ymmA8NmzBqwxwZJ87QuDsqcEIE0HcmshXs
         P4PRh8BLBMTiKhqkTW2q2+DF1xVra9MZg7QkPcaGALojamGlPezvtHgCizxXIG5F8k/v
         3A38cF/EJJiXgl8tEJ6v7K9RU5TMgC0xlLh+Zuf5im5BoR97ud+gmVPH4sWT8Gu/v7Na
         9Gug==
X-Gm-Message-State: AOAM5324E5363mdW+CP3EdcdguCSBXC2oS8UI11BdlBHf3Sl611VXlMG
        sMLKBmWDLfy28DMLS3vtWtRpopZUCtW8aQ==
X-Google-Smtp-Source: ABdhPJy4Aj0kS/Ee/3KJRU9W4CTZ8nMhD34QXSmShivBQ13TtMgy49VuvOtWFWF1XQI6EtGpIx7fFw==
X-Received: by 2002:a05:6830:15d6:: with SMTP id j22mr41078212otr.34.1609467405853;
        Thu, 31 Dec 2020 18:16:45 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r133sm11279796oia.17.2020.12.31.18.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:45 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/47] completion: zsh: expand --git-dir file argument
Date:   Thu, 31 Dec 2020 20:15:48 -0600
Message-Id: <20210101021622.798041-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 966b2d9277..755135a2a5 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -247,7 +247,7 @@ __git_zsh_main ()
 		if (( $+opt_args[--bare] )); then
 			__git_dir='.'
 		else
-			__git_dir=${opt_args[--git-dir]}
+			__git_dir=${~opt_args[--git-dir]}
 		fi
 
 		(( $+opt_args[--help] )) && command='help'
-- 
2.30.0

