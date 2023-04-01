Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F46C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDAIqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjDAIqp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:46:45 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF9910A82
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:38 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l18so18397105oic.13
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWLZZzZSM4/MpiTNasv+Z75s8Mh1UYH3jnDgIhWXEV0=;
        b=YTmG6liWL6flTLa+CUD7/tvs+Qtuzp2+B9ItndET0m4f+AldnSxdnkG7L9840kFTKx
         vJGLRGcn2Fo/r5EahYC2oRPlYTeBY2iftO/GqxNz2LTM5ymwyZMNYloCgajlN6ZpyTdu
         DHfUtSwkVslDGJWbA82ek/VNXX4gofuAJL62KP68/Um34bSwioQ/u73HUR4DeZT20GzY
         o2MdimZMfxRD12Yvg+7JlNFSYgfdirquBued/GT3b+6fJG3VoX6TF+IczcG5KoNtLXa7
         7lysbUtRmNC8z+DN5a6hiScfxWR5p8ILbGno+4CMo8Iy3N3xAng41Dn1N5MxxouqJGaV
         Fz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWLZZzZSM4/MpiTNasv+Z75s8Mh1UYH3jnDgIhWXEV0=;
        b=m9pVjoy331WY979PO9evV5URRDvvtb0hXpaES+UI9m/7HV7PPQdW1rcbPe9Nd4TKWa
         80uTeJNDellEKrssWnFaMBf94IIgJUPLQUMh1XigCPoX16IpUgXdSFPYuANKYGZBoAfw
         FJqKSFnL7QlKdr7IpTnoA86b23RMhAam1eCbMnDsb+Okyy/SuDzkK9MCqUMII9oYTlfv
         iyYwA6UWfyVpIx8BKq2OY6kLYQr/oqpOeMbs2Vy+KvNpgmISAonqle+uhuGmfDqrpM7J
         df94dU81++urbojbMHxGIfn0Djmh0sFYw8tfaidtAIUXonPB9PGdMLldNy9ldZS7GiYg
         m7fA==
X-Gm-Message-State: AO0yUKW27As0cKWctip03UjOhQvBY00id3X748zB7CNYY5RszvBfevbQ
        qMv4o8Uw9duGZqzeshhIyPrkdOdoA3o=
X-Google-Smtp-Source: AK7set9RqkkhrPUR+guohiATUhHvBYlExA/JJKsppE3xTm+O/tYjNQC/Vc77Rr2KsayxIjkDX3jlAA==
X-Received: by 2002:aca:1718:0:b0:383:fb11:6513 with SMTP id j24-20020aca1718000000b00383fb116513mr11781056oii.46.1680338797913;
        Sat, 01 Apr 2023 01:46:37 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id l2-20020acabb02000000b003896df086b0sm1864399oif.15.2023.04.01.01.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 07/49] zsh: simplify realpath dirname idiom
Date:   Sat,  1 Apr 2023 02:45:44 -0600
Message-Id: <20230401084626.304356-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a much simpler way in zsh.

It's a shame that ${0:A:h} doesn't work probably due to a bug in zsh.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 75bb44d41a..4f22e8f85b 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -33,7 +33,7 @@ if [ -z "$script" ]; then
 		bash_completion='/usr/share/bash-completion/completions/'
 
 	locations=(
-		"$(dirname $(realpath ${funcsourcetrace[1]%:*}))"/git-completion.bash
+		"${${funcsourcetrace[1]%:*}:A:h}"/git-completion.bash
 		"$HOME/.local/share/bash-completion/completions/git"
 		'/usr/local/share/bash-completion/completions/git'
 		"$bash_completion/git"
-- 
2.33.0

