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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD92C433E9
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B1D207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbhAACRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbhAACRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:45 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C85C0617A7
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:54 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j12so19272007ota.7
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KyxN+RW1RnJVcXTmv5htWUBU+dr5L46ejIUUoMzdMTw=;
        b=GmtwyN6afYh7t839dWdVEm9SOuGrfIgVT4dKQoBa1nuCvw9F6MjhxdJ3CwujKPResu
         HTyMtA0aRX1VAqWE7LqbgdxtaUk8hHLAzBgCTJUr32RDYB9JODDkvN2gi6eWXATT8JCF
         NXbyXnDK0tiy0YW3h8OIcFoSQbW12x3ZBCKCDOnD40RrOxkBwjOLkxlpm1M75ojuHW3P
         BLeT4cHDh6k+yy3bDbfklkfGMwQhgJc9HicW5hmJu8ZSCWtPbdq4AH2i8BAImuv565+N
         LA1pKFsY5YqdkOSkbDFcu5Pezd66G8Ve8DtC3uqBY8Vv9Bq/71qK0Eka+qepoMk1rMlj
         uOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyxN+RW1RnJVcXTmv5htWUBU+dr5L46ejIUUoMzdMTw=;
        b=jN4uNJFNg5/I81bUwCXngT1zndTtS6wcM3XwcbOoes2uFKsxLFzVC8T0coSjQoQLen
         TM5X+DjytqaY9MkZqU9wnWCbdlasCX1/T3zXyGP0moCdXrX5TM/Ku6DLam2UtuU8GF5g
         e3G7W7D6prl2QECoqT5jQGv4bmnkSN5Lvc/hkAgBR2+9jtsVib4d+lDnXikEXh3ahC85
         DT9gfove6acicJTdET85kRF5TuGG58s46ibQUGmTRoucJ0m706SIv+ubsHhe8T33GsaA
         hnI6bUcK8sPZYuWoDjOiIoFfJj2ipB037gEjXH+rBHFH8L2TfzjRXmAp77Fh0gAKLRji
         TeXg==
X-Gm-Message-State: AOAM531DhIOtqdXoPu3+oQJ3Ec9WvXlFJuQgbmrhdgkhWWWiZw2Lbqj7
        9iMPsf5Esh3C7e2XpjxI72xrMXe5BdH2mg==
X-Google-Smtp-Source: ABdhPJyz1rZ1Zkdv4sdmiNWTv21FCaNwRNwUy9Rgh2g1MjnrICSGpQp2HzjJJ9zousVbwUUrmhXXTA==
X-Received: by 2002:a9d:1d05:: with SMTP id m5mr44022594otm.324.1609467413623;
        Thu, 31 Dec 2020 18:16:53 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a15sm11443054oii.50.2020.12.31.18.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:53 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 18/47] completion: zsh: add excluded options
Date:   Thu, 31 Dec 2020 20:15:53 -0600
Message-Id: <20210101021622.798041-19-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
2.30.0

