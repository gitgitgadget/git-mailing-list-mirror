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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C24EC433E9
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171C6207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbhAACRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbhAACRh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:37 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6EC06179C
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:20 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 9so23451005oiq.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVa2xBXsmRsHcHO+fZlPnEN5EtqBm6Pdub27IIeBiiU=;
        b=cbN0aiWc+NCf7jStrmeBetOSY0DhS4LZ4+7xtzd/FtDfQxrJZHFjhG6I3wyBmEoaVs
         uyA+V9BhDOpIIvY781vniMMdTi6rNVorG5H/nQQ9Ary6poax0zgMxxCGzqMYIZxRywSP
         bMKIt4UgdizbF6FHGmk+dHmOAlTaqgIQ4ZLYqsOvtsQwVKln3FpX9aIgnEDDX2pdTCsL
         s3umQ6W/ixXsyM9u+3cenUutqEZpiuXyUI8LmmMFinDazP1FfVl07U6R9hAsjhgWXR2D
         liehxuUXkuqe10Rv6FDK4Sba/uCZCs+AmxiPg04fY9L3sso0O05mx04KGqkPDg7VLDm6
         1IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVa2xBXsmRsHcHO+fZlPnEN5EtqBm6Pdub27IIeBiiU=;
        b=XuxjG2ejJ+dVUfM5t4s0gjTGVMIYOXw2wPpsqdVLRqGybZSW2WlrQf+HkcgUaL0V3y
         ts9g2YQ0nbUwefD0kPrfuXoRPfU3NSHhRAHySegXACrfuJfJ6/a9izU5Md3d4xckFMtm
         RhEr5Zbdjx1YzfF5arBp8mghyweDs6aFW6VVwkUTHe5slnaULAgoujNweWX14FiFQDPD
         xem5ylF7ivbkwAWw8tKATYFCpsRyXgypDo6dNMAoy7hAKAXBYZDLrum/vNON671NqyVp
         rNDlVXaWfy9Mj5A5ZVJx6KGn+MMhantP95uK9fjomeVWq1GnvO1ydxiMiFbFP2QDbjk/
         RWPA==
X-Gm-Message-State: AOAM532B8ZvWoGwv/4L3RLAK5OAjwncx0F7vu6FTEVhCMfBu8Qa9J4RQ
        zefmC+Reb/8fh4TralSs7o5HAlO65drDRA==
X-Google-Smtp-Source: ABdhPJxINE73uQj00UzbfcgLztRGFwuITId8+c1nHAgF6Y2JCUC4Nx7t5YSpgC7+WT+7ejZ6N83iXA==
X-Received: by 2002:aca:4b0d:: with SMTP id y13mr9325770oia.7.1609467440046;
        Thu, 31 Dec 2020 18:17:20 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m7sm11341537oou.11.2020.12.31.18.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:19 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 35/47] completion: zsh: add elements individually in __gitcomp_opts
Date:   Thu, 31 Dec 2020 20:16:10 -0600
Message-Id: <20210101021622.798041-36-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's useful to specify specific suffixes for specific words.

This will be useful later on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 2faf435087..82a4d6f470 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -66,11 +66,10 @@ __gitcomp_opts ()
 	[[ "$cur_" == *= ]] && return
 
 	local c IFS=$' \t\n' sfx
-	local -a array
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			array+=("--no-... ")
+			compadd -S " " -- "--no-..." && _ret=0
 			break
 		fi
 
@@ -82,9 +81,8 @@ __gitcomp_opts ()
 		else
 			sfx="$4"
 		fi
-		array+=("$c$sfx")
+		compadd -S "$sfx" -p "${2-}" -- "$c" && _ret=0
 	done
-	compadd -S '' -p "${2-}" -a -- array && _ret=0
 }
 
 __gitcomp_nl ()
-- 
2.30.0

