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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B5AC433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC5C20729
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbhAACSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbhAACRg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:36 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A787C06179E
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:19 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id d203so23464680oia.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ds3FVR3Eyu+inUKpchuszJWOeWm2MDrOLxPtdK7+jSU=;
        b=ihXHOVyymsuevEZsiw0s5F3wcgj3uwAiAPb4mpWDWUUgHYM1iChkg0FSCJNZLOKTdZ
         ATlvjiqwdVpXZzxBORfqKbNvsvbNKJSAbNV32hFlqW6+fmk/pLtPDQNQwqIZGCeQBeX2
         EhFTc1qGH7xELry2wfRUGAHnl4Vve3y2ckY+2g9FTNPLO2VUA+6yIPqUqmvtoQ5LCLBh
         Kdjsu4ElemzbzDAwxY/bgk+F+6txBpBLhUlCAND2vpzsIU8IDKVeuVVqY4X9oyxo84Ed
         wGm27lTFN/5hIR+ZQHlUa/lNnf55LEZOLhKxLrQ5vOWrxrcBWTsWDiGi7DB26/DEY7Cf
         Cqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ds3FVR3Eyu+inUKpchuszJWOeWm2MDrOLxPtdK7+jSU=;
        b=IgBv9bJvY4NuQW+uuTHsaMRjF7KatjU1aarMtfDV/kCURnfLDSVIcIOIFeeMWTcG0h
         NQER/Nzr6W4BjVh8WPTPVRn/lUMKLQRTnPo1NkWipus7qYC+3k2EZoNKWJCCzQHWtBZs
         oealh4fu5ItaehsvDpgBOhky3EFStCi0Nsux9RO9KmGG7pogf0inyqyfmIP4Fb9oOZw4
         raknHDf2PVzaSLqRO7y6sO3luXS8IB++XhWRRoIDpduFyTdcuXbpVKdk4ICtB6VmGpRj
         r5BZyteWjk0SKyZhxhp8P7c92xHJS2QzPXkHhCktAK6HciKuqzitJJUK9QQ8YEUL1sTr
         WEbg==
X-Gm-Message-State: AOAM530giXvJjgOQTyaAbeluOP3wpPJlPzYyTuckJl7PrHhEgU8DLvgf
        TgXoPcxR9rpIffjbPvea5QS5Ix5UmFSS+w==
X-Google-Smtp-Source: ABdhPJwjCttQmQ7tk+8UZKMkfHx4aQ16I3FFOJZHvj+J3sFOycnUuWq+OzTsGGDRvwOlHAH9c2Aw5A==
X-Received: by 2002:aca:3083:: with SMTP id w125mr9653784oiw.130.1609467438421;
        Thu, 31 Dec 2020 18:17:18 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s66sm10098017ooa.37.2020.12.31.18.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:17 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 34/47] completion: zsh: fix direct quoting
Date:   Thu, 31 Dec 2020 20:16:09 -0600
Message-Id: <20210101021622.798041-35-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apparently using "compadd -Q" is almost always wrong, we want zsh to add
quoting when necessary. However, if we remove the -Q option, that would
make zsh add an extra "\ " at the end of some completions.

We can manually remove the spaces from the completions that have them,
and then add the suffix with the -S option, thus there's no more need
for the -Q option.

This makes completions like "stash@{0}" complete correctly:

  git stash show <tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 3665167b3f..2faf435087 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -54,7 +54,7 @@ __gitcomp ()
 	emulate -L zsh
 
 	local IFS=$' \t\n'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compadd -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
 __gitcomp_opts ()
@@ -84,14 +84,17 @@ __gitcomp_opts ()
 		fi
 		array+=("$c$sfx")
 	done
-	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
+	compadd -S '' -p "${2-}" -a -- array && _ret=0
 }
 
 __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
+	# words that don't end up in space
+	compadd -p "${2-}" -S "${4- }" -q -- ${${(f)1}:#*\ } && _ret=0
+	# words that end in space
+	compadd -p "${2-}" -S " ${4- }" -q -- ${${(M)${(f)1}:#*\ }% } && _ret=0
 }
 
 __gitcomp_file ()
-- 
2.30.0

