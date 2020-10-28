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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299FCC56202
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6DBB246CD
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNxESoSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgJ1VyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgJ1VyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:54:16 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADACBC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:54:16 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id f7so1161884oib.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VQTNXYVrUBWkpiOZS+bhpmquE7TdMjk1fmvFFUySG+0=;
        b=jNxESoSB5U9dFncOlJeJP8hfA6xaJRb8rKs9MZDHbNrfTqmYNddlZ0idG6EsGw3aFr
         dZhxGuBzhY0mvoGTcDwgI03JVdak2/cqw8Sn0AtyKuc+XrE6BNIRmWM7xZav81/b7Yt0
         nedVFCHjBkUl+j2oq8/ldCfCgOu7CUmF1KwkelhjYckckzsEGixJAXTOBjHzGx3p4uwZ
         mBApgjR5Pd3IdzIKh091X+U/qJsqBFOXT/do3WeC7DPgMP1b9syDlre3TksVLuKxxR+j
         PbdL8O7GlFYw4b7AM3oIOTtPRpJNAl3kNdjBg+UF/nYTW7TsFZUnG5gn3Av0X7J8tOqR
         eisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VQTNXYVrUBWkpiOZS+bhpmquE7TdMjk1fmvFFUySG+0=;
        b=ZApXx3DsNOsrk/pQ8yaynXJXZfMs0OhIh970/O9ZuQlkB6KRCbCJiJUp9TEJYMmukU
         HI+2JDlgMthnZyz4MPBw+3GcYa09f3u53TRX1J0gPRDutsFJqmlrH6R2fT+mwnMkGruc
         WAki2mEYcv8fWqrvNSKCnKQGIlgK186hghbLAZK6GOhTKvVQz6QMFS68SkCjLID9Kdvl
         6qMTS9JMAfDyWRGCFWMcfHPC5Eagl5Gvl+i2jZqqUxUCLUAcTo4o/WqF0gZFJu8KoyOW
         hWHyh/5cpWE6f82FtTHxy9NF7eVzDcaAWF4D/ngi0xXvVZApDXgUvTOy1miPQRc1pD8g
         x+7w==
X-Gm-Message-State: AOAM531+YQBVu6WcH24BZmXgi9fHER/CEdD+/wwZVc7jAHNwLwBViujP
        qEW2C7saGkLxVnp/EaS9r13R3e2K0o8E6A==
X-Google-Smtp-Source: ABdhPJxt054RU9A7qDP3yYuWRK2jMYf+E3Hknqgj5E9ab/yhwFsjVp7AjFujiKWXHYtvKeztimeeDA==
X-Received: by 2002:a05:6808:b35:: with SMTP id t21mr3498076oij.102.1603850872288;
        Tue, 27 Oct 2020 19:07:52 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g25sm1746623otr.35.2020.10.27.19.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 23/29] completion: zsh: add alias descriptions
Date:   Tue, 27 Oct 2020 20:07:06 -0600
Message-Id: <20201028020712.442623-24-felipe.contreras@gmail.com>
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
 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 22d8e58fcc..1204a55890 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -196,8 +196,9 @@ __git_zsh_cmd_common ()
 __git_zsh_cmd_alias ()
 {
 	local -a list
-	list=(${${${(0)"$(git config -z --get-regexp '^alias\.')"}#alias.}%$'\n'*})
-	_describe -t alias-commands 'aliases' list $* && _ret=0
+	list=(${${(0)"$(git config -z --get-regexp '^alias\.*')"}#alias.})
+	list=(${(f)"$(printf "%s:alias for '%s'\n" ${(f@)list})"})
+	_describe -t alias-commands 'aliases' list && _ret=0
 }
 
 __git_zsh_cmd_all ()
-- 
2.29.1

