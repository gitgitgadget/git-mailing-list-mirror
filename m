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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961D1C55179
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E85207BC
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvvVMuns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390472AbgJ1X27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390455AbgJ1X1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:27:01 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52719C0613D1
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:27:00 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k27so1346991oij.11
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTB0EwlSLfn8A9nFm3XXpQgab7oYL7nI26zwYjOrHZM=;
        b=nvvVMunsdAlfmnDBDGVrpLNSy9CFW5JoUUVQZnAS+q086R71NIPQ4Mzdhjuqo+G/Ay
         ljtLszvP0vYD/QxpB3lCNlp95zk3litNEXb6RUUBl5aKRXHvtwIc4cBeikJaKTqJW9hk
         zEOc2N+fJRhgrJ1razG2Bt5i+fnuj4SSJzsYb9BgEdZrzDb4mbfdv6XxTMb1o60/RmF8
         9Ss8e9+FX9z7rcVn+o7RT6C/jF4lbMmBJ/bvZkv+t/t5A3GkTQ/NucTCK7X0vkofoKGi
         Wq97M012GJXBi48mmgigsNS8PG62zoStL9FnXK/3yIJzNwdvqqwEm693nsAs9OM4v0HJ
         lL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTB0EwlSLfn8A9nFm3XXpQgab7oYL7nI26zwYjOrHZM=;
        b=N1tN5y59o+iIBcNoo2K7YVImZEIZcJXJcc1FoiEIrrJd44zfVmnCArz4NYfMIX71xL
         hAngejLOZms17mRIeG70/BLwueXtK5PEk9qbzWTeANpM3tzjeA3ZEr/7rm9PqC4PLDUB
         lWI3NhKKaDqFu2idS3Lne78o5gbpeFXEBw6CupwX7XrwAJtCpYsAIfW81XxBRQXQCTyK
         wd4SfPW5EDhSkQa1WDsRyIcjQztZSO0i5xEkhWNVV7AEO2qtHIzeXNHYzNsPzkJ0EkGg
         3rtN4MJ0u5I+nftr1+TEVJK9uPZJYBTgYurmy+9gi0UnbOFy58BF2P586ZD0TP3W3Lho
         Ql8g==
X-Gm-Message-State: AOAM533BV+6Y1xdqirO84OzETVk4Vmop2x99Lt5BMtERUgM0XepDRU/Y
        7167WFiGjOsJUU/AltfU/6H5E1LEZ3YFPrYS
X-Google-Smtp-Source: ABdhPJwe1xx/4swczZucZrUDWp6IQDhKoD5luXbRfDI19wunVUw4/zpVKSjl3vP8SSvWRpxBaE6bgA==
X-Received: by 2002:aca:1a07:: with SMTP id a7mr3415164oia.169.1603850854102;
        Tue, 27 Oct 2020 19:07:34 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z126sm2347847oiz.41.2020.10.27.19.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Mark Lodato <lodato@google.com>
Subject: [PATCH v3 12/29] completion: fix conflict with bashcomp
Date:   Tue, 27 Oct 2020 20:06:55 -0600
Message-Id: <20201028020712.442623-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
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
 contrib/completion/git-completion.zsh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e567062505..b894cb52db 100644
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
 
@@ -48,7 +42,11 @@ if [ -z "$script" ]; then
 		test -f $e && script="$e" && break
 	done
 fi
+
+local old_complete="$functions[complete]"
+functions[complete]=:
 GIT_SOURCING_ZSH_COMPLETION=y . "$script"
+functions[complete]="$old_complete"
 
 __gitcomp ()
 {
-- 
2.29.1

