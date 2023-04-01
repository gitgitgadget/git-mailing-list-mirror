Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC6DC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDAItj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDAIs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:28 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7020C08
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:28 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-177b78067ffso25638795fac.7
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTDY6nWzZarXMnwKTTTfGUvU5eJA3nBZvLkl9EYJQ4s=;
        b=CsnJ9KJ0Pm0Jz6kaCsp3wRtRLTfYINkJWLRu5DRUOu4g8ZDOE9AXvM0/LWZ7dDNSzx
         /AaQdTbt3vEpKyiY/zPGo7XrMvhJF945eywW+OiBIqrr1MxCCkGHZW46/qXQ9YyZGu5W
         zHg5ABD6jUFOeTad27qf2YYe4e6FEhcUK19pHhVsoZSJ4k9Ae7D1nYNreDI57Trmc8ju
         R9itiCb2yewQnRG2M1hAAicuVdL6t0lFhEA+Lu9DYA50s+tBpNNXoiS0Hophp2hpLpV9
         1gtBibc5mUqTlUEwculk0a+enF4hPSqCociKs6HYKDC72en6XibUtN5Mu2jBgND7QsnQ
         5DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTDY6nWzZarXMnwKTTTfGUvU5eJA3nBZvLkl9EYJQ4s=;
        b=gX0sAuPT5eKqpMX/xeiWkLA0OKCSryNIF7BZlDt+WeEUjd5GczljiKHuxnBd4lDNqr
         zwxfZFVJIv+fHWHcUEPFppPzSqUbZJ4aL6Duw+qf50nw4RwHL5q61UgySHb1hkzpknMI
         sTC4Rj5oJj/OZnukLfNfzzLMJE6dLKRfZ4oqr74zX2JlRys3uJTwt1m3ucA29fHlm5FH
         fA588SZYb8IGdIgkF7BkXSvHFsth3/u5Ks5YM7eaf3k8iwEQMDHNwcIELb3vxbN4wBxy
         9KaGzvM0AYKYUrOo5Bw5ahOi597VBB/yAh6tE3VJQMHqxI+9ETqes5QWRwBc4Oyi5kIo
         L1vA==
X-Gm-Message-State: AO0yUKU4TW/cF/vUM7Nyz5VN3ZjaK0brN31xsKU18u972VUEmW4m9pP3
        taT47x7jR7bd5q3ClgRS9noBVvN5jaU=
X-Google-Smtp-Source: AKy350ZGu73u3z1s/CcTR2TdFQqNBaEKifm5/JzsacZKRYqXZ4dmwcuMeRWMCgtNrndo5Q/XyM7Bmg==
X-Received: by 2002:a05:6870:b512:b0:177:c4bc:c1c8 with SMTP id v18-20020a056870b51200b00177c4bcc1c8mr18938699oap.0.1680338848148;
        Sat, 01 Apr 2023 01:47:28 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id zh20-20020a0568716b9400b0017281100b75sm1710032oab.42.2023.04.01.01.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:27 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 44/49] completion: zsh: add correct removable suffix
Date:   Sat,  1 Apr 2023 02:46:21 -0600
Message-Id: <20230401084626.304356-45-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zsh has a nice feature that allows a suffix to be automatically removed
if followed by a space.

For example:

  git log --prety=

If a space is typed, the suffix '=' is removed.

But we have to set the correct prefix first.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 522b59cf5b..31bf88c1c5 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -52,7 +52,7 @@ functions[complete]="$old_complete"
 
 __gitcompadd ()
 {
-	compadd -p "${2-}" -S "${3- }" -- ${=1} && _ret=0
+	compadd -p "${2-}" -S "${3- }" -q -- ${=1} && _ret=0
 }
 
 __gitcomp ()
@@ -80,7 +80,8 @@ __gitcomp_opts ()
 
 		if [[ -z "${4+set}" ]]; then
 			case $c in
-			*=|*.) sfx="" ;;
+			*=) c="${c%=}"; sfx="=" ;;
+			*.) sfx="" ;;
 			*) sfx=" " ;;
 			esac
 		else
-- 
2.33.0

