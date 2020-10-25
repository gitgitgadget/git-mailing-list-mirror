Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AF1C56202
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7533920936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVciddwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766845AbgJYDOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766837AbgJYDOE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:04 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789F6C0613D2
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u127so6939219oib.6
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=izhR51gTfbtoViguCJVykzb7Oxsc3oGRsw7aRL5pm0s=;
        b=VVciddwCmumARk8/f6baAcy6jbkWCwyyjLDkCO8foziEIkdCDXcRdiFZ6Rb8OQhtPI
         4OSbMRHsgMZnjzyMnD0VCCLmaZkCVE2WIsOa/GW1muQjfxR780qp9UyDNWb3RBgxZqh1
         nY+FyX2WGf8ftkZ85OLgrl+pOaO2C+fd7YJEFtof4OerWbwJasUSLgChW94IY6YqwI/g
         cs/tWcHWK0qsFcu0Y1XeSGCNDSYKMYbsyVnuDsqiNZA+plZKWvjAESrP743cwQ17L02L
         ifd3XMcdwJr2iBMDhGgKVLGus+ssCNxUwdDzVPYmhz67dHPvGSb3Mk/n707oTkz1GqU8
         bumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izhR51gTfbtoViguCJVykzb7Oxsc3oGRsw7aRL5pm0s=;
        b=uFpAz0Mz/JnJmwOkx0twETrUl7ODJ/Akg5Bxu0k7fu0MGqA7W+xAAoO2CaHP7+g3zb
         zG71fJ/ovDHI5p+xoFpN1FHip++SmWqkRb40/VaoF/bObfYpUZLhLiOj9a0/8a1mKNNd
         2LGrznjCR3vYgr/IRa6oDEjFtmeRjoo+Gx8P9pE55RBCz1+lY3BjnamIuRCOnUW5GrwK
         rn2dulsNdSgQQF5XTYYrZDDvGF0gIIsjOcuZt7LiM9/5vNltAi9FBbhKp5SaaUbIqdG1
         h/Ia2DiD7+/gwiV/T++5n5w9rOuYA7GM0UQ/ZYrp8tXUKS4vu82/8KrWD9JhNZoEkgUq
         oFbw==
X-Gm-Message-State: AOAM533j4VwCTxckMYOX64Y35ASJg4bh16GsVlXWxGSWWhiiYr7NQaiI
        5RzNMzVnLu8AIPZQzkr+b6er6kq4kdILow==
X-Google-Smtp-Source: ABdhPJzFQq8ANRESicebXhI3TVxOu4aXxsq7mUxWX99pmQfTT9+ZWiBB4kg8A+LWtJt3XhOYqMw2sg==
X-Received: by 2002:aca:d7d6:: with SMTP id o205mr6468582oig.165.1603595643681;
        Sat, 24 Oct 2020 20:14:03 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k51sm1670959otc.46.2020.10.24.20.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Mark Lodato <lodato@google.com>
Subject: [PATCH v2 12/29] completion: fix conflict with bashcomp
Date:   Sat, 24 Oct 2020 22:13:26 -0500
Message-Id: <20201025031343.346913-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't want to override the 'complete()' function in zsh, which can be
used by bashcomp.

Reported-by: Mark Lodato <lodato@google.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 contrib/completion/git-completion.zsh  | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 26d6ee20b0..6de0e7b482 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3475,6 +3475,7 @@ __git_func_wrap ()
 # This is NOT a public function; use at your own risk.
 __git_complete ()
 {
+	test -n "$ZSH_VERSION" && return
 	local wrapper="__git_wrap${2}"
 	eval "$wrapper () { __git_func_wrap $2 ; }"
 	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index c2a90beb8b..1de9b9c80d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -21,12 +21,6 @@
 #  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
 #
 
-complete ()
-{
-	# do nothing
-	return 0
-}
-
 zstyle -T ':completion:*:*:git:*' tag-order && \
 	zstyle ':completion:*:*:git:*' tag-order 'common-commands'
 
-- 
2.29.0

