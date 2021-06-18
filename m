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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64F8C49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32F7611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhFRS2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhFRS2F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:05 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757A0C061760
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:55 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so3964636ote.11
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BA+On2NfP5uKdi37PiVeRqvTi1iwdUaAFDENGVTDPgo=;
        b=jCU7j/Qj9Y4cGO1YEOgy6mVtmd79QAaZxuUJgmB8sHwWNXCTZS+IbR4tczRn71yNzh
         OZB7p3RwAdGYkOjM3wXKvIa1lfumC5272e2U7STBF7qJXjn/eWYdRL1DHWN0IOfLumPz
         9RJgfjFCDEzkvERnK240fqw4gPjd0LK9RAaL+nYi8Xyin11ZHdt40HNPxsCe/R38ZzI1
         5DeauBGZg31u6oa3CKEHVcM4/nPEn0Vm8fvfurhCP1WhzDbyAXut9b7lpxkYj0lmE+NR
         IBqBO+kq9utKg/fu9AgHZpZe+XXiL69hkVlVbaIDbTXoNgHM+2+GO9YSVgmeUNWut4Jb
         oyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BA+On2NfP5uKdi37PiVeRqvTi1iwdUaAFDENGVTDPgo=;
        b=OvkOa2HzFRt5jyycbkrZWKpocuXV+5/1psyB2hJXirrXIXZ4qFyFwKTd7LCR/ghuoq
         u2wAskmUBOzZLcjQQcBOxDW8m4BUk1C8eMgqr4LjGmDaBWa1OvB9T47Joy2sbvKjTSsg
         32uI+GwTr/3k8a8JSIaDmHIzooUMt/Ykrk/ngNNIUVQhcJE3WP61Gt8rlCgW2anmumb1
         LyTVA3wLoDvWthSxAen4MyM3xJS193ozkMzQgrVMLDxUhGr7PoJGSG4SulxCm1kU4YLz
         felO96DTQS4cerQMoRX696gzkUR09sJKIGeAw1BpWmf76vJJv8e9y86H2tJvpJgPx353
         oRjQ==
X-Gm-Message-State: AOAM5321K8v9Mj9dvEwASbrqIYca+Z/LjHlBh/4zg0QOU6s9aWB2SA2t
        hBha2ssUnbyqW03V3BDt9IULufm1PGN1/A==
X-Google-Smtp-Source: ABdhPJy478IpfX3dEsHMJLh3+XzjDc8Ag5RnJCz1nG0Z5sgQhdmsn3uFFJwOp2rtx3BoGk7KVWXM4A==
X-Received: by 2002:a05:6830:1e95:: with SMTP id n21mr10742156otr.350.1624040754669;
        Fri, 18 Jun 2021 11:25:54 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u10sm2280345otj.75.2021.06.18.11.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 16/45] completion: zsh: expand --git-dir file argument
Date:   Fri, 18 Jun 2021 13:24:49 -0500
Message-Id: <20210618182518.697912-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 33bbf3d993..9768f76af3 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -245,7 +245,7 @@ __git_zsh_main ()
 		if (( $+opt_args[--bare] )); then
 			__git_dir='.'
 		else
-			__git_dir=${opt_args[--git-dir]}
+			__git_dir=${~opt_args[--git-dir]}
 		fi
 
 		(( $+opt_args[--help] )) && command='help'
-- 
2.32.0

