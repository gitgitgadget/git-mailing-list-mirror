Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644E0C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDAIqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDAIqj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:46:39 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF424F74E
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:37 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r14so12747584oiw.12
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux3n5HafMSlbprFuxRK6bFQoW7jxZooRkaDvi9NccYI=;
        b=EDPE/TcPzJrDsLvWGYI9VkN2vNyPzYt8xNr3Mo5jjGGSjzJKa5OtumNYQcf1fGa5+C
         3KtpN6yP+Fnz7QbFcXMm30J4MFBPFlz36FC5imcxCRK4Ej7nM5Pa6DcbCJ+P7Ci5BY0y
         8c00YM/UwJM4zSoF6fIYt2Y0dzmxTs583jrLY5FcBPqTJGkjry74qde/8jbDDSiIWsrn
         omojMb6oPCWo2SMnFkLCVCM5JYYSjaPRPCBtnDrkUcT/XXtwH/MBxJ03q4J+trb95d5I
         N7DcmHC4MkdhBhImtEN3O3DSPMlQDL3WNS7fKMvIs7NN75Fk6CaKqi9cHuzkHnVpJoL9
         0Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux3n5HafMSlbprFuxRK6bFQoW7jxZooRkaDvi9NccYI=;
        b=FWxNg7Lm1ElhFwLY5yMyykKTalimY+1jIYphmPvL2IhQh9Q9iCRlHAG7APdE4P3RM1
         UMrm1yszd37FQYZh80u9LKxBDsPVnvM0TMVtFYsAWV1D+YSfp5w+1JgHbAsz6MjSVhih
         Aa6VhgonaYCXtuRXO9MEkYAiSAuhxnNDWrdhChwiuDUD7BJrX/80hEZN/fqmki4u1aww
         x2R9AivAUIPtjW0TCScpq3tXGAGKahquEGL4v+4YUSA8KNzWgqsjqWbyFzAI7ajqT+80
         LMNkFdebCK/+gRF64ssPI02vTSEkjmE+G1IU/YGUhqR3vczA/i0sKZC0bRMaQuVhKDn9
         W26w==
X-Gm-Message-State: AO0yUKXmQUcXidj9xRdrLri66LC8sd56ZhC6IqMwUaqYCHPNJROR5eK6
        hCxoUQD7rLZnpS9ixB5KKBmKN4jzzEM=
X-Google-Smtp-Source: AK7set/lu82gFpRVovStix3hVFStslLJ+k9fyeMiMJkX4QMz5HQA5zf0YJs/uW2XYjFjASmL/plxjQ==
X-Received: by 2002:a05:6808:18a0:b0:387:205b:70c7 with SMTP id bi32-20020a05680818a000b00387205b70c7mr17864278oib.13.1680338796643;
        Sat, 01 Apr 2023 01:46:36 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id y35-20020a4a9826000000b00524fe20aee5sm1743917ooi.34.2023.04.01.01.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Bianco <iloveitaly@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 06/49] zsh: resolve symlink of script
Date:   Sat,  1 Apr 2023 02:45:43 -0600
Message-Id: <20230401084626.304356-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Bianco <iloveitaly@gmail.com>

When using zinit the completions are symlinked to ~/.zinit/completions,
this causes the zsh script to not be able to find the bash script.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 5f2c63236d..75bb44d41a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -33,7 +33,7 @@ if [ -z "$script" ]; then
 		bash_completion='/usr/share/bash-completion/completions/'
 
 	locations=(
-		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
+		"$(dirname $(realpath ${funcsourcetrace[1]%:*}))"/git-completion.bash
 		"$HOME/.local/share/bash-completion/completions/git"
 		'/usr/local/share/bash-completion/completions/git'
 		"$bash_completion/git"
-- 
2.33.0

