Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E031AECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiH3JeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiH3Jcu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:50 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA47DE0FD1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:33 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11dca1c9c01so15400871fac.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wi+XzLVgE6DRx/VrNp27C5yxPWOfQ4ztVhHFdeluvI0=;
        b=TuQ99KbfEK/+FsOD7SRUmnsWd7ZkL1aaHCQKHj0A/q98HeuEyxa3fmyaRBeSiBM8aC
         KjRjJYsAtL6+vKbGzFIqpnGf0MQP2jJQCzAPsIpK6a9cLU7ozyx20MvmDqhGMCXyEInJ
         uOoC8+oaEOiXmJf5XP4RDa5jrcET6h68RnU7uEsP6WP53GwvPUBOso41vjnQ6tGXJ5A5
         zgDTb/3EVUByd90U8XGjkGwnOaHmUKig+jAq7PtxI3WEf8G+4JqCkqhNv2vuC8RCiOmn
         XBLrM3fFtBaQeegZIkJo0+s0i74INXkg7CEc89hjcth7crEcv8QjWnGshOmfiehoS4eA
         tecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wi+XzLVgE6DRx/VrNp27C5yxPWOfQ4ztVhHFdeluvI0=;
        b=t8EwEt8wk8vIJDDjHmIVAztKD8TfMSyEunZ7hRBg2w5nInhnrc52eoPirzk53HwqBO
         vEXYP1vjv6muQ8lzMiOGD7YYRzTdbUfMdT5Ta58+7M/9xIwJqIh4kYSLcKqeGswfVWvM
         aXqlDxYHSoFGbXCjAC8bxUM9LeyJkn7F05pVhLAl6Zsx7Gywm+S30tNoET9OrFcbPfJa
         ZaTg6elp3Tzr4ZtOQLvQMIlz2b6n8WP08T5R5WBFvODl4FVpH6gZBF//0uLnnZ29UQkw
         dLF7yqOaa0e9H1+mi2RT9HAr6BXsEMw4UkQZQf0PnCthxAMuCYdMDN3wFotbeFPd1OJ0
         toQA==
X-Gm-Message-State: ACgBeo3zuFV6DJrOPYID07W81oIXB5rk15QtZa0VJ/xfiul6BiOeXFWd
        YoCKjagKJ3Bv9GDTxXIwdpjpfw7yiZA=
X-Google-Smtp-Source: AA6agR6MB32q7mIF3RrZiFdD3ZdbGeaBijDEr8DLXD91jYiur7mo6kgUMKAwL8TK3hU9qRar6XBqLA==
X-Received: by 2002:aca:b6c2:0:b0:343:5897:a366 with SMTP id g185-20020acab6c2000000b003435897a366mr9061858oif.184.1661851953042;
        Tue, 30 Aug 2022 02:32:33 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id c20-20020a4a8f94000000b0044528e04cdasm6531997ooj.23.2022.08.30.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:32 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 31/51] completion: bash: change suffix check in __gitcomp
Date:   Tue, 30 Aug 2022 04:31:18 -0500
Message-Id: <20220830093138.1581538-32-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
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
index c9315d4f9a..2ff7de1274 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -351,8 +351,8 @@ __gitcomp ()
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
2.37.2.351.g9bf691b78c.dirty

