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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53F1C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839E960C3D
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhDZQSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbhDZQSv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:18:51 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D682C061760
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:10 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u16so39645430oiu.7
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9b+ft01Mh+8KepunERauSp/wqCcfeGnl/4X7z843wfw=;
        b=I+zMDsC30NSEKPWUAEdjI1KOFNvRKmcMkj1ojmY4wyabAQCe70qPboDZiBmKLPUyyH
         rMRJdzkwET6oEDwW99LgUjfzYJjZbdqLBLPl+dnqx+AQXYxI1WEK6YttZa9UzV/usCIz
         /CgiiMAnA8AVXhN4EoYLnmHWv0r26rH5sUF82nuDaEQIabKHt1PP1XsWPJ4pCnsfDdyl
         akcGLLfcn40KEusFW9bs762Nziew5KgyAH01EqQsjCcfeL8tGG6Ook8HXfzsPy7zYKjA
         Xf/maveY8osduzexD+RrJgdZ+3WE2G2zv0ckCHpw7WtgIpq2q0TV+uKlVaBtKV/7wq3g
         d5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9b+ft01Mh+8KepunERauSp/wqCcfeGnl/4X7z843wfw=;
        b=GsEu+W7FsU/BHTDCpVMr8DG91QrLUIjdoZaZHVFBoX02Fr7b6wqQHrhwQ8Cf2Hve4a
         TGHT76Kr0iNZfET10IFeyyv/jl5PLu/JqDOGbFPvcOCHm38Zpm++2rxA4DbfHdA210fz
         AsOj8tJEVFgeV6wXe6EQXO50riQ+FQloYgwXGn0dIgG1+izfjbvWXVDMMZp30UcvsPlA
         QSD+XmzvP+HXrh/VqrU7rSvOQ0AkoSAzPi/cbK63BniFBoP41hDDheiiDkaKhxI8aW/t
         4iT4qYpm4unwmErs7cOiOcTeeVaUwxAXvHWKzjvDBeNapmY/ccmm5A3W20kqAZ3H6QSb
         5oVg==
X-Gm-Message-State: AOAM533w+iqfUWcAXFKdDsYMTchudR4pmy4PR9QRjZxmCBkZnm4//5wR
        yLP+BSmYr73/CF8JzsgF0f7m8wUbSCFn+A==
X-Google-Smtp-Source: ABdhPJxq+xxU1UpfvQ89bejxYGmM8p3UD+Y3vQWgq52tbxwD7RkF2T6dUkIGlV8ixCc1vKht4TaN0g==
X-Received: by 2002:aca:33d5:: with SMTP id z204mr14218582oiz.32.1619453889132;
        Mon, 26 Apr 2021 09:18:09 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z23sm152011otm.51.2021.04.26.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:18:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 21/43] completion: simplify equal suffix check
Date:   Mon, 26 Apr 2021 11:14:36 -0500
Message-Id: <20210426161458.49860-22-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We know the prefix is already '--no-', there's no need to check for the
first '--'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0d00bfe83b..cd1e0ba704 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -344,7 +344,7 @@ __gitcomp ()
 			c="$c${4-}"
 			if [[ $c == "$cur_"* ]]; then
 				case $c in
-				--*=|*.) ;;
+				*=|*.) ;;
 				*) c="$c " ;;
 				esac
 				COMPREPLY[i++]="${2-}$c"
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 090c644b71..8db7d0693d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -67,7 +67,7 @@ __gitcomp ()
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

