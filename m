Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BEEC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5256135B
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhDZQRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbhDZQRL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:17:11 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD408C061756
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:29 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i81so56951520oif.6
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIOEL5n9E0ms8ekZ+SF2/qGNCqq9wqO7huF95oRI1xU=;
        b=uWemPqufzVOkh+SYZkUn+yt+Wgw0aFWuEq1bLqN4GzLthLQH2Lkt4JqcO2yRcapX+d
         ALLm51EU3TN+naevWW4veyYPTe3LI3ry0pNMD1uaIxCp4P96odPiUBqidFJC8ihp5nqy
         3fd/15eje8ifHB2wcvWNc4P2TgsZ7Ukivso9YmDxxeHKaXIKgm87qJb+4tcV7NBtmd9s
         nSVgTZh9yUTwkleZylBFVdeAXI/d9u+Evj+6IhIbRbeGzUksY79x5zzaKzgnlYZaMz5n
         RQfHVR1xIWQ6byQgzACVMYf733sqfeC9d0aAJX1VbPN17xVKTsAt3P25+QCOC1eKENy8
         0/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIOEL5n9E0ms8ekZ+SF2/qGNCqq9wqO7huF95oRI1xU=;
        b=terQ44jwI0pyPK90eFM1W1dBFRRPppYkDDt2fwB/NbEi9pg5Y9siw0GnsQRjDvaQ0x
         A93u0sxwCFmwyngjEvGxrLZ5Swca+Dn9nH1re2DZoXR7pxVem9q2U1Yq3VDr2N7W/xak
         1xPD3ZvP97xx6zjOoRgR5Pz6Me8dND3N47/0Us6okipUshc/4b8AHC5wAbzOULhkindf
         B9+Y1jogIsgTvXetIuhuat0ANyQAXHhFY1Nmh1kWA9nWXsTm+PxKoyJ2kBqyCkprATPW
         DWjJnlj4GXtsIggYLva0rmst9Nq9JzIzQ/nU3Ml1e+nWm+HcjZsNYpAU06O+TxaQ7gWi
         VwKA==
X-Gm-Message-State: AOAM533BFizbzELiaLMMDwijNwWVtnKyB92Z1YVuyM/T6SvWaeAf6PY4
        BGcmZlJ9eaNcZefx0EY4w6pUfu6RRQW9CA==
X-Google-Smtp-Source: ABdhPJwRM9psdNVtRwC++QY+2XYpsxrxW/9OTxwwzaWmK/w3TWTp2kCEt4rR9/ddDTalWvxvuxIPTw==
X-Received: by 2002:aca:c350:: with SMTP id t77mr12310269oif.42.1619453788937;
        Mon, 26 Apr 2021 09:16:28 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id d6sm70186oom.33.2021.04.26.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:16:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 18/43] completion: zsh: add excluded options
Date:   Mon, 26 Apr 2021 11:14:33 -0500
Message-Id: <20210426161458.49860-19-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more excluded options, for example: --bare excludes --git-dir.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 073f7d91d8..7cb0f33209 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -218,15 +218,16 @@ __git_zsh_main ()
 	orig_words=( ${words[@]} )
 
 	_arguments -C \
-		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
-		'(-p --paginate)--no-pager[do not pipe git output into a pager]' \
-		'--git-dir=[set the path to the repository]: :_directories' \
-		'--bare[treat the repository as a bare repository]' \
+		'(-p --paginate -P --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
+		'(-p --paginate -P --no-pager)'{-P,--no-pager}'[do not pipe git output into a pager]' \
+		'(--bare)--git-dir=[set the path to the repository]: :_directories' \
+		'(--git-dir)--bare[treat the repository as a bare repository]' \
 		'(- :)--version[prints the git suite version]' \
-		'--exec-path=[path to where your core git programs are installed]:: :_directories' \
-		'--html-path[print the path where git''s HTML documentation is installed]' \
-		'--info-path[print the path where the Info files are installed]' \
-		'--man-path[print the manpath (see `man(1)`) for the man pages]' \
+		'--exec-path=[path to where your core git programs are installed]: :_directories' \
+		'(- :)--exec-path[print the path where your core git programs are installed]' \
+		'(- :)--html-path[print the path where git''s HTML documentation is installed]' \
+		'(- :)--info-path[print the path where the Info files are installed]' \
+		'(- :)--man-path[print the manpath (see `man(1)`) for the man pages]' \
 		'--work-tree=[set the path to the working tree]: :_directories' \
 		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
-- 
2.31.0

