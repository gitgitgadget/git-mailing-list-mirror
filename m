Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8DEC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E3461139
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhDZQQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhDZQQh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:37 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAACBC061756
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:54 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso50706281otb.13
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d3ll2VtSLN3A8nhX9iE55BTSNDeOOmX0g404u4X3k4E=;
        b=Q2UT81bBiixWBpGjP8qKTMyQMLeTP8SUP9afhyn5wm479Qy7W6RJldn7t0Ot//VFh6
         8C/iIGuqQ4LsucQYbje4kCjMPvuGWYD+wlT21SBSihogDdXqwcG31TPCVNmX9a6HwfXE
         NNac+lBmwXgF0SpLtNHgIorUErrXee2faH6X8PubP4RYfwf3GdacoINTR5zOzP7kwGhj
         NC0A7HQXaBK5hNhgaJU0CuFkWxXop818hNgadd+npZS+Z566ZjTb/J8oKEICgSwU5U5S
         F4yi5/qTdsnf/X4bbsfoLtbj5qEFuOnKFD0ubNHqEZdQm2lB31xfTu1yFB4UkYH8lYAi
         kSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d3ll2VtSLN3A8nhX9iE55BTSNDeOOmX0g404u4X3k4E=;
        b=Mlf74jSvp863qMSn5t8fPedCnQDm9a90qazlOQLyEtiwnpCV46XqK0iGbmSK2YSd4a
         YjFWcRV3kMmAyO3PnT076pzYUHhUj4Nb0UUPr8dY0mE8K0XlRrDtZyWn6JK3dDJ87Obu
         xi+ETPR4cJVzakVzVGIhuOGhltsDaiO8vapGEDRjgZVq7rLxOR93cbMXu01QkE2WSTB4
         jhQyrcP4R//uwdxPLeJnRryNDYxxhT4yDy3bQFZGmto5Sp6QwINZtK+XANnFpP2N+UR8
         UfXzcP13tGWeERaD/KbR+4XK5U1xdQ1MLZfwFk4Lc4TCZh3IRNHy0e485WpsxpkvkHOG
         fDtA==
X-Gm-Message-State: AOAM533NhrwJjaCTtRrsurPsWgxdDlAeLvmYTUYUjxX0UY23QsXsdzHN
        UnMlKTf+i17R16bAO5SpYylATSKj1B3iGQ==
X-Google-Smtp-Source: ABdhPJw1j2pT4GB4solIrBVNLbi/FxGYTlQZnOaXMysgSuYqdh7zzzbgKqD19p8jSzjcCRLxmgh63w==
X-Received: by 2002:a9d:3424:: with SMTP id v33mr15063037otb.137.1619453753978;
        Mon, 26 Apr 2021 09:15:53 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 88sm3503139otx.2.2021.04.26.09.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 11/43] completion: bash: get rid of any non-append code
Date:   Mon, 26 Apr 2021 11:14:26 -0500
Message-Id: <20210426161458.49860-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index d87d1ad12a..e05588e109 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -309,7 +309,7 @@ __gitcomp_direct ()
 	COMPREPLY+=($1)
 }
 
-__gitcompappend ()
+__gitcompadd ()
 {
 	local x i=${#COMPREPLY[@]}
 	for x in $1; do
@@ -319,12 +319,6 @@ __gitcompappend ()
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
@@ -438,7 +432,7 @@ __gitcomp_builtin ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Fills the COMPREPLY array with prefiltered paths without any additional
@@ -451,7 +445,7 @@ __gitcomp_file_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 
 	# use a hack to enable file mode in bash < 4
 	compopt -o filenames +o nospace 2>/dev/null ||
-- 
2.31.0

