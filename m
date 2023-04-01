Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1492C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjDAIr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDAIrS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:18 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5C721A81
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:53 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id j12-20020a4ab1cc000000b0053e6062a9eeso2335382ooo.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lSQdi/dPLdQF8j9Encu99pooeEVxX8fmEDc/gqBk6c=;
        b=f0mIrbI0b8IXn9YKGxZTC0jXH1ZoVu2K6Mq3Y0mwd/EWHxejOc2oeMCwUhTNXCixIx
         t+PJVp3gwMnSISJLg5bdY9lXgXORZ/Stw6p92n5uW7V/DY0cbULHTqQhh9yK5flkV4kZ
         nIJq6f1fgXeg9Gmni7xb74w4v695qPI68tzGDweoZa+I/LlQt4LkN/XTdQ3NAkUR16vK
         QJsg4dm4Oly6MXkqUm+s3Y8Dit+iowF4975p+37oBoXr45k19VjTuU62NNR4bDzN2N0d
         NSxHk7McWJbf7Gp/dotKM3/XNn0lEytUW21NlAeKeYijgMnJ3XA+NDoqcYh1QXndAOK7
         TFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lSQdi/dPLdQF8j9Encu99pooeEVxX8fmEDc/gqBk6c=;
        b=GVK5/FW69evpsZUHO/byx248YqrlDaZ72wiDRgZDaRCSQRt7XB5eUfGu712AxR2scd
         lYjDAT0AFNBEIO5jPi+CxuQUCGl4GzhAM/KMyWxyqIOXJD0OXHm0EauySzRg9FLda3QP
         90P4FWrAVPqbCiYeNeNUU/6HxoQGWFSHcQ52HA5fyVqDouOVuOZtI4kFoJC12cqpd9tw
         /uxxsrNj0Ey7r+e5RcEkpXKvTPaa9tQiXgLw2dG1yKllcuSjVHba58n0LVrsWiwStrg1
         3J6wD4lcPD9mpzUDB9MNpPlgccFPPndUXC5dKxST/2qrlBfkwHKgMvH/sI/5GyEt4+9Q
         umgA==
X-Gm-Message-State: AO0yUKXGmsG023ZJzR+p7QzA+prlSuoOZgAYuNgq+hYCD3cf/JaRTN6A
        tXQwqXJDMt1UiFsTyRqa1bdH3l9HQZo=
X-Google-Smtp-Source: AK7set8Vy0cowDWxqFm7woAzS8+cyos6Zv5K212JgBwN90Nd6IJJV+zck4gVssVF4u+CwOQhqbYzJQ==
X-Received: by 2002:a4a:d64a:0:b0:53b:4d59:4058 with SMTP id y10-20020a4ad64a000000b0053b4d594058mr14920773oos.4.1680338812827;
        Sat, 01 Apr 2023 01:46:52 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v184-20020acadec1000000b003871471f894sm1844538oig.27.2023.04.01.01.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 18/49] completion: bash: get rid of any non-append code
Date:   Sat,  1 Apr 2023 02:45:55 -0600
Message-Id: <20230401084626.304356-19-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3c8f907d45..98eb7c9604 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -320,7 +320,7 @@ __gitcomp_direct ()
 	COMPREPLY+=($1)
 }
 
-__gitcompappend ()
+__gitcompadd ()
 {
 	local x i=${#COMPREPLY[@]}
 	for x in $1; do
@@ -330,12 +330,6 @@ __gitcompappend ()
 	done
 }
 
-__gitcompadd ()
-{
-	COMPREPLY=()
-	__gitcompappend "$@"
-}
-
 # Generates completion reply, appending a space to possible completion words,
 # if necessary.
 # It accepts 1 to 4 arguments:
@@ -449,7 +443,7 @@ __gitcomp_builtin ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Fills the COMPREPLY array with prefiltered paths without any additional
@@ -462,7 +456,7 @@ __gitcomp_file_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 
 	# use a hack to enable file mode in bash < 4
 	compopt -o filenames +o nospace 2>/dev/null ||
-- 
2.33.0

