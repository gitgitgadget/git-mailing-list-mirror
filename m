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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B75C47082
	for <git@archiver.kernel.org>; Sun, 30 May 2021 03:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE92B61104
	for <git@archiver.kernel.org>; Sun, 30 May 2021 03:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhE3CvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 22:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhE3CvI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 22:51:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FB3C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 19:49:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g24so4685719pji.4
        for <git@vger.kernel.org>; Sat, 29 May 2021 19:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tsizkrt55nvLWrRZyAjefTxS5z4bocKMCIfxBgpm6aA=;
        b=Sz6kWxV3GazrgW6PtcaDWpEjz6XUH4sok5+nx1BJ/dg4vNGupdCbEs2M4qpBKZOXH5
         VP0DAHKzciIYfugzFZJuVyKImXQ1nxh/w1nzNIw4ylzKvwL6hEcR88P8SO6dVEY6gHxd
         1IQnQf0mmI7N9TplwLYgkAVyFiGKb6XpLh+6zGpfPX4ICnxzJ1M1Sf/GVR7/XZGkEIEE
         tiFD25d0pIRLco+JTx4JlFyqwc+CV8CHc+7e8vSJgAP6piSVvMrVeidD13Y5DCoYACjU
         7vNxb1V+yJXhvX00ynalHbmc7+hV6MDJz4dor3/tEfpWvb5egne5Qz1U+UEyXXUNZK/+
         WyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tsizkrt55nvLWrRZyAjefTxS5z4bocKMCIfxBgpm6aA=;
        b=AzjprHhR/upFKaLkLMZFRre2mGKLD2UWDYM+LfhePrGoWNtvsC1umN41ER10AeS0D4
         NhYVQ3Fx7JkhbCkOOpRocnnVuM7iaVD9/c32uwPb0/O84rz3d8Oo/+YYvai1U4iieFaa
         ar1ntwA/Srq7123mXFQLvwIeUHRWdcef5Fu9BRyd/mKZnbDzez8ggcukOQkVGt8gnaYT
         eCdsyLQR8kGawTrcDjmvFAKpPieHzP8fFhuw/6sbLVLtcRS6n51nXEsrNq4lik/qe6LQ
         K+XIGerAPTT7uWAwVG5+nufNCMtIh3il5Tj7FPC82L1AyQZQuUknU6NeQ/9tntymmiNw
         iCtg==
X-Gm-Message-State: AOAM532E4u6oFdQhjevbPmJ/WvTt43V9oPXfXKtiTJpU/i/j016LAYrf
        5XUpDra9qGYAfpBdw4S3BBA=
X-Google-Smtp-Source: ABdhPJzU6LcCtNE44dWQYyGnZweSrNSjRKluTPz/sfAwwHWx28dobrgdss/vcunS2Ncx4pSsZUtn4A==
X-Received: by 2002:a17:90a:9103:: with SMTP id k3mr12103978pjo.117.1622342970984;
        Sat, 29 May 2021 19:49:30 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id k90sm2577677pjh.13.2021.05.29.19.49.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 May 2021 19:49:30 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] contrib/completion: fix remote completion for "git push/remote"
Date:   Sat, 29 May 2021 19:49:28 -0700
Message-Id: <20210530024928.24158-1-davvid@gmail.com>
X-Mailer: git-send-email 2.32.0.rc2.2.ga063d53b1a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If __git_cmd_idx is empty then zsh will silelntly fail to
complete remotes when doing "git push <tab>".

Ensure that __git_cmd_idx is non-empty before using it in
__git_complete_remote_or_refspec.

This was tested on zsh 5.7.1 (x86_64-apple-darwin19.0).
Other versions of zsh, eg. zsh 5.0.2 (x86_64-redhat-linux-gnu),
do not exhibit this behavior.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Further testing of the completion behavior spotted this regression.

This should be applied on top of,
"contrib/completion: avoid empty arithemetic expressions".
and could arguably be squashed into that commit.

I have my zshrc setup to point directly to a git.git worktree and a recent
update seems to have caused these regressions.

 contrib/completion/git-completion.bash | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d51ff5302d..bc1aea82bf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1006,6 +1006,9 @@ __git_complete_revlist ()
 
 __git_complete_remote_or_refspec ()
 {
+	if [ -z "$__git_cmd_idx" ]; then
+		__git_cmd_idx=1
+	fi
 	local cur_="$cur" cmd="${words[__git_cmd_idx]}"
 	local i c=$((__git_cmd_idx+1)) remote="" pfx="" lhs=1 no_complete_refspec=0
 	if [ "$cmd" = "remote" ]; then
-- 
2.32.0.rc2.2.ga063d53b1a

