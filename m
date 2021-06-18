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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECB2C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0AF611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhFRS2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbhFRS2H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:07 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF30C061767
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:57 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id h9so11529910oih.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jp7EkfeiOTWui82VagsHiOaToMZAPQZhYKxFbxXWEA4=;
        b=OrjFXdRxFGJtfYEqDZkOR+AiegWjZ3vRsMmZahhein4HS3kANrJt9UXQjrhVb/1omx
         6oq1HEfcXq+lW2tQJPhpOqwWckb2sJc4J3zkFUcoQgsO3Tk1F4pq8GbW8PVg6ZJssfoo
         pt7HCo1a/vbVxDX4Y2Bv/4lOhOMKFbzfGR10NBkXdlErlSVhzO7kSiKGHdancfjV7aeW
         d1VNlvo5gposYTDR8WSXtnNIrNeOJdAl54YitzNunkpEu5rOFUoBux4A+U93AQgwZFSd
         Q/qkKFPe588vGqHjJ4UtNHEKHG5Bk2+hA83+GkrdFbQvv1cKvZ8eawLqB5GuHR51Opwl
         oJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jp7EkfeiOTWui82VagsHiOaToMZAPQZhYKxFbxXWEA4=;
        b=AsiCZuvQmEwMDCbZyDwNmNqmhg6efaCCxIrQ8lKp88K3AKb+tbveFvx66L6lO+vvbV
         meym8BydmZXBB7mCH+vU9LZnmDv0RraZIqljte/qDXIM2jGIa+IcHQpeyB7unN6AeOec
         ZxStLHd+GyIOlRgYs6h3Jym8mjjL5rZzyaMex2KVJqpelwoIdSABaszoecVP5RitkNZn
         7qwgDYFdwJpj9k41y1iJbxzAYS5we7snmEhKdLrbxYK/C93lrUtZbsSFPzMUmMQC93wK
         bfRyiTgvRQfbaxiatg2QjCtx/jn7q/RmITBu/b9s24C5ESQz2IMx+rECMAJuk+cAQOVk
         pI9A==
X-Gm-Message-State: AOAM531jvjwRcrYaH6vy1wdbmdiDcEnq9mPe+kKpX99Q7OTj2DqABDIP
        IdOFH3o/RUdjtRgwy/qryGSpB55J647SzA==
X-Google-Smtp-Source: ABdhPJwpn86lTit97iLoCr96qxK5fSs/1ap4jDOn8SF2wEeQicWD4+XJrNv4yY6BATcyXKvxOu5HtQ==
X-Received: by 2002:aca:5dc6:: with SMTP id r189mr16004259oib.164.1624040756321;
        Fri, 18 Jun 2021 11:25:56 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id v10sm1901690ool.45.2021.06.18.11.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 17/45] completion: zsh: add support for general -C opts
Date:   Fri, 18 Jun 2021 13:24:50 -0500
Message-Id: <20210618182518.697912-18-felipe.contreras@gmail.com>
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
 contrib/completion/git-completion.zsh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 9768f76af3..f60801741a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -211,6 +211,7 @@ __git_zsh_main ()
 {
 	local curcontext="$curcontext" state state_descr line
 	typeset -A opt_args
+	local -a __git_C_args
 
 	_arguments -C \
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
@@ -226,6 +227,7 @@ __git_zsh_main ()
 		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
+		'*-C[run as if git was started in the given path]: :_directories' \
 		'(-): :->command' \
 		'(-)*:: :->arg' && return
 
@@ -248,6 +250,10 @@ __git_zsh_main ()
 			__git_dir=${~opt_args[--git-dir]}
 		fi
 
+		for x in ${(s.:.)opt_args[-C]}; do
+			__git_C_args+=('-C' ${~x})
+		done
+
 		(( $+opt_args[--help] )) && command='help'
 
 		words=( git ${words[@]} )
-- 
2.32.0

