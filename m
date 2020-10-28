Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595F6C388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2AE624743
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6ZgJ90k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgJ1V6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgJ1V6c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:58:32 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6DAC0613D1
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:58:32 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k65so1148261oih.8
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uu94bCnEjKN/EoPVWZtRahi/YSyBfCxIantkDCjPil0=;
        b=j6ZgJ90kwR+r/teP41UV5t2f55Rw6dnVJFdaV0RKRh/MVR/jg06PMhqTE2XKWxyFs4
         1/Cej06RDAlr1hAnFzsVpdL8xs6ZQStX0Q/myQU0/nHsu4M1k305QMgYQqIpStHP4Esv
         r9B5g8obfZSbFB4+9uT7OVsQrNj3siXsaV/UjPz5zSDrYrRzhhLU8M3zecEsiaCAEpn/
         rk1KuGW7+tCR1jONZxdK4MLc3415w53iSIk03RBGOyn6711QbDDqAuL3PK6kstYJYvkv
         UTT+aiXoUMt1C6+oNYDPMpg8TcXleiwqSNM4S58Qv0WyccyonvUzgYMDHqM3+swUmn1R
         Eorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uu94bCnEjKN/EoPVWZtRahi/YSyBfCxIantkDCjPil0=;
        b=TN6WkQ/ZNevszVb3trUUlv6Pp8s/Rmqp/yLWN5Zhbf3s2fm3RoJXvUPkfS0MkF+y/H
         CkJP5PBfFxsSF15LwJs0ZEvFWZ6tKyMngQhm2DfkwYV3an1NdUpzKoX+TdQKio35DENN
         IXpnlXaqdnTdirDaIZOyjKJwB9WghMFjDLQzuDBosy8R6/VLFTotlUFQakQJxEo6BKL1
         T+I3LV/IjqIEIURFNn9U3oIuw995cZe7tIymmiL/LmG2aizj2BK7xpmlUkvC4VHeeO0t
         JgDgf1tK9nkH6vQVawUQqf9TjqR1jgiXv+gdjLzaw5l2qUcw+dnnNAeaqc9B3kVhEN/R
         oeYQ==
X-Gm-Message-State: AOAM532AmTMAjdYijwdQ/cB2WqOD5G6SK+8lw9O4wwRRUBX9BPxsIdKb
        7aMnm75wWXP65r8lcVg4iQmWNdFGoErY7g==
X-Google-Smtp-Source: ABdhPJx65rpiuX8qhS/Oxq+ep4wh/rA1OUYKqu6zlndWUWomn9Y7IYgWX0wYzWxWR8SBmPw0O2CA1Q==
X-Received: by 2002:aca:aacf:: with SMTP id t198mr3741234oie.132.1603850875531;
        Tue, 27 Oct 2020 19:07:55 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z12sm2487956oos.12.2020.10.27.19.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 25/29] completion: zsh: add simple version check
Date:   Tue, 27 Oct 2020 20:07:08 -0600
Message-Id: <20201028020712.442623-26-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A lot of people are confused about which completion script they are
using; Zsh's Git script, or Git's Zsh script.

Add a simple helper so they can type 'git zsh<tab>' and find out if they
are running the correct one: this.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 2956b9d0d8..811d77cb95 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -134,6 +134,11 @@ __gitcomp_file_direct ()
 	__gitcomp_file "$1" ""
 }
 
+_git_zsh ()
+{
+	__gitcomp "v1.1"
+}
+
 __git_complete_command ()
 {
 	emulate -L zsh
-- 
2.29.1

