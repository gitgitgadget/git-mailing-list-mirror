Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1CDC388F7
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576712072E
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udDowu5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgJ1X7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgJ1X7C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:59:02 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475BC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:59:02 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id z23so1474943oic.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0+ROmKMSrlKNqnxSB8Zax10o0/ar5SuTTHYlNbgkJM=;
        b=udDowu5Fs9Elf04b/i0CVAeCA7+qsV2EAj2yVoiJTONG0e9g0wB66fGLl27YCcJyej
         bEexNPmjUSZhqxeWbQ/xQIPQ9yV/quI2UmHSY6eK41mSAL6zO6VMsDBEOitZFTjJlRXN
         9UmGtCHc4y51m/2qB1tLtGqdEfB/Cm1vdCMvpCrnvWalvsyroEWOkAVs2jfA5gU2mGMr
         H/4V/9HIaFujk265oUVF81VOG7JNm5T5gqtkqQ33zELYOEDSlCb/aLLj/nrL8ZESUdDx
         rVl9rIoJCy2KvlfWIL9iGwx/ZPIGbGJ/24oF/TNvfqTMwHt2RBpwgTH/MTo6//goI72q
         qTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0+ROmKMSrlKNqnxSB8Zax10o0/ar5SuTTHYlNbgkJM=;
        b=hZBv+JN84325LDEN06SAu2fdpXQLYlMW/eNW/QPc1CTey6TG5Tecc+XFCZKMTgzATA
         RUqQQv7HXD6vBfe5qvhxV67vmA7CYhceBPupvl17oqTU9eFSWW1U46o+2Rv2ZGapqkL8
         kdxIdL87Gb5dDLQb0ODaM2WI6hJrg2OGtBU/W2fIVCLmTXZhWattLm0y1kCMUOwctAaA
         keX9tKliOnSTI47xYeeZV/hdbejCwPfcH+YZ9XOjXId+SurWE0erbFD/tWrDxgB5BrHB
         a9Xq08ppQQonApLdb6cftfGA792x0sZO40I/luw7GU3GWSPKdODMdiDw8tjRqn9Zhbri
         65vg==
X-Gm-Message-State: AOAM5315ZEiMYo0VG0J7rT2XhnKTsKYoqwgv/iw2mH9wU0B7P8EHYsuj
        SaaJ4TWm/WvB8oIhfTv8kxyMTH+aa1eonqUq
X-Google-Smtp-Source: ABdhPJx1CRlkLiiXztAsgouyl/lKn3z7bOOMsxdG+GdZ+XhQ+opcqLnTuo5z5IBN2XzYjoFAJf2PRA==
X-Received: by 2002:aca:5f85:: with SMTP id t127mr3652854oib.18.1603850869096;
        Tue, 27 Oct 2020 19:07:49 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 105sm1734775otf.52.2020.10.27.19.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 21/29] completion: zsh: refactor command completion
Date:   Tue, 27 Oct 2020 20:07:04 -0600
Message-Id: <20201028020712.442623-22-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 60efddb4a9..858864f3fb 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -134,20 +134,32 @@ __gitcomp_file_direct ()
 	__gitcomp_file "$1" ""
 }
 
+__git_complete_command ()
+{
+	emulate -L zsh
+
+	local command="$1"
+	local completion_func="_git_${command//-/_}"
+	if (( $+functions[$completion_func] )); then
+		emulate ksh -c $completion_func
+		return 0
+	else
+		return 1
+	fi
+}
+
 __git_zsh_bash_func ()
 {
 	emulate -L ksh
 
 	local command=$1
 
-	local completion_func="_git_${command//-/_}"
-	declare -f $completion_func >/dev/null && $completion_func && return
+	__git_complete_command "$command" && return
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		words[1]=$expansion
-		completion_func="_git_${expansion//-/_}"
-		declare -f $completion_func >/dev/null && $completion_func
+		__git_complete_command "$expansion"
 	fi
 }
 
-- 
2.29.1

