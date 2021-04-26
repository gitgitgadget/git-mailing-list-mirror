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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD346C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDA76115C
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhDZQUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhDZQUe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:20:34 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6035DC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:52 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x54-20020a05683040b6b02902a527443e2fso1519561ott.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1Carr5nFWwqLMAQMrCfsgkPiY7L1Ez7UH1WoS5YxbM=;
        b=g6hAzbg1lTfW19W8dKvzG4g6+f6njsUFf9Bsmd2yD1r3EsI1v75lhaXUltIZMwpW0R
         3/WtSdHi/j1oZg8kf6vLdt+wzhdETkNeFnAZPWaPY73/KzvylCg7HfwWT9X6EPG67Z+/
         1WAVmpMugEjeeUZf9VfyRxtcy7gIFgHaWhO6rqNRYtoG25AIcQapIo7phpGTBLx0YGON
         Im0kXai6CSulz1r8vIfgRqYEpgbF5Iuns9fh6jE2EIyI+Qwux23XVWxiMUhgvOMmmaTM
         DFpW8hl+/3vV8yVE/kH0+4zqbzh2mwV/gEI/DsVq0BQSQlxd05EMiBmYLm+Cngc0oKv9
         FRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1Carr5nFWwqLMAQMrCfsgkPiY7L1Ez7UH1WoS5YxbM=;
        b=t5jjLTV6TMEfAPwRYfkJR0/6CgSSu/HQ+wsn6VCTPbBxckdydw2zdi3FeN79MP4qdu
         a+iNQB3K0/QBo/vu9JfpMAYPq5EX/RwQLsrZbiH6JOZj1F7TczbumrXS7lnMR6AZPv5x
         t1deSB+puaeCK117aPvMf/biEXS45W05YLlx/3YJBQnQ5xfuaV0FxkkJCzncj5m2UMAY
         LKj2a0WoyqsIbnkSrow68Wj/7e7wU2pMRIK3RXnMSJ9H+h+4JDLtlc8cT6GWrmuNeeQ6
         1uzxsEsb3xDIwZJ+3F8LAk6/cfGRV3vSvz4E24Fg3Rr+Es94hBZA6llDBLo8vDPEgOCj
         sbzw==
X-Gm-Message-State: AOAM530GzHPJNuXiR6e3SaoxGn14lmlKO+wzVMmixGiOfuX8nElndHuh
        bfQS0p4WixrpNsw6glYqcy8Al2Un0QYpSQ==
X-Google-Smtp-Source: ABdhPJw5hgJEzvUWr49d7PAveMAjkUnF78EdrUAuVcxjzgukJ1YxlZKJxkm47y6QBpvO0/mcRRJPGQ==
X-Received: by 2002:a05:6830:1543:: with SMTP id l3mr4115754otp.31.1619453991617;
        Mon, 26 Apr 2021 09:19:51 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x129sm927934oix.9.2021.04.26.09.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:19:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 34/43] completion: zsh: fix direct quoting
Date:   Mon, 26 Apr 2021 11:14:49 -0500
Message-Id: <20210426161458.49860-35-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
2.31.0

