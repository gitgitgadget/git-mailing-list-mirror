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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC25C433E6
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61CA20798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbhAACR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbhAACRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:25 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A514C0617A3
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:45 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q25so23434514oij.10
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tkd/Mq3vKfj+u6T1eMAOcDgqPvxRS/boq2LE6Q3Y5lA=;
        b=TEJNzH4HwSXrKFhGjMoqUU+esKvPRb63h49lcANQHj7ico7UDX0RkLAWWyQ6c4wBmx
         V0A+1J+WqWCrGCISn/w7nXz2hCPuOioYYQv8Qgvl3PBawH2FYPXNpYLr527WwspNuTF6
         5DS499fRKzzfwq6XH84ynUipj0Ji5ANmY5qmP1mVqsaU6LTfwAvmJ+lNeOFZ7Db1qVW8
         R5n64G/E022eSzqlxRUQDslv2aB2Yjig5qlzHMFFM8hSj1xf6ReS6dVMry77Ks/q0vDV
         Var8t29THL1QN00jrYGCIv3rG9JLGYDK+DacK2XeQtBKn0d5GneyKKlxORh1Y2LqwJuh
         F2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tkd/Mq3vKfj+u6T1eMAOcDgqPvxRS/boq2LE6Q3Y5lA=;
        b=VS2p2rYmEIRjPw3hG/UA7EHnB0PVwaBxaPdhxqWspltCukICiAzrlUSh8R/l7yJGJK
         Ak414KIqxq43D3ibbD24C225dUq3YeTOOTnEKhhV4Mj2ofEOEFck5vrnjvP3uVQGTPHN
         hrcfc69sBHDgfa077KnIc6cv8Fx489qKJJfD7/1HE2D6YexTQocEg0BpIc957uT3bqye
         ezBqirZhgMDQ1mq23c2PTedQfP6Y13BMz7oynAL3mBf2v1T52joqcIZeUn8sIgx2AmI2
         nBMP1/ITK0ZZqDG0Bfqd3TC2uud05KVPbQ2fDzth7qzcGLK+PuFxqCiwAW8ByUbf5mxM
         PIpQ==
X-Gm-Message-State: AOAM533fA2Pocsa+pYk+zoe/p6//Aayolx66RPFmpMk0/U9SI0KDu0Ta
        iazNk9Gca+wpUpYoS1G59HRzsrYXRHuqMw==
X-Google-Smtp-Source: ABdhPJyGLaUy38hPhsXBF6mQLEe40o13RBhrNE+RNuR71kIzSY4AQkXK6kzO/Rw1aRMesF7PQcfCzw==
X-Received: by 2002:aca:1109:: with SMTP id 9mr9745193oir.131.1609467404409;
        Thu, 31 Dec 2020 18:16:44 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p28sm11570341ota.14.2020.12.31.18.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:43 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/47] completion: zsh: fix options with arguments
Date:   Thu, 31 Dec 2020 20:15:47 -0600
Message-Id: <20210101021622.798041-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They support both '--git-dir=value' and '--git-dir value'. Fix the
arguments to support both.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 97d2bcadd6..966b2d9277 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -217,15 +217,15 @@ __git_zsh_main ()
 	_arguments -C \
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
 		'(-p --paginate)--no-pager[do not pipe git output into a pager]' \
-		'--git-dir=-[set the path to the repository]: :_directories' \
+		'--git-dir=[set the path to the repository]: :_directories' \
 		'--bare[treat the repository as a bare repository]' \
 		'(- :)--version[prints the git suite version]' \
-		'--exec-path=-[path to where your core git programs are installed]:: :_directories' \
+		'--exec-path=[path to where your core git programs are installed]:: :_directories' \
 		'--html-path[print the path where git''s HTML documentation is installed]' \
 		'--info-path[print the path where the Info files are installed]' \
 		'--man-path[print the manpath (see `man(1)`) for the man pages]' \
-		'--work-tree=-[set the path to the working tree]: :_directories' \
-		'--namespace=-[set the git namespace]' \
+		'--work-tree=[set the path to the working tree]: :_directories' \
+		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
 		'(-): :->command' \
-- 
2.30.0

