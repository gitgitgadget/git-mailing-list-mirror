Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AB2C77B60
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjDAIr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjDAIrT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:19 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D939191EE
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:55 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x8-20020a9d3788000000b0069f922cd5ceso13144138otb.12
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpignU75XOPRKpUUxUZsEhg8hoR4DwwwSQC2GnPLcmI=;
        b=fRaBzJaxvMyYj9YKR61BiWYtVdcavfK68xXiJFv1y2tX68DKY8YP4p3fCkO9nEFiRD
         1RhvGBokUZRDNWnhEvI15Hm76QNmM4T++PhG5+PPHmlTggruDNhvQqZGW5SXYusSbk/N
         i0pr65ov9fsbb2LzW9pM47EtQ67T5K/OXnKlMmyJUALsOcbH5L5dcWVqSe514gjHsOZ+
         fa2rD30YV7NwDrisMAKQcIe9QuvOd+f9VUQuZo3JA3Pt2ouNd8004B8LMtkkrcvDRrjR
         1WHtWjEM9qvtdTcitISNQKdM0AzNS9xcSkukeufHiDp5u3NN7/Jq4Hev6XXJPNoG+Qoq
         okSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpignU75XOPRKpUUxUZsEhg8hoR4DwwwSQC2GnPLcmI=;
        b=K5Qc22nDWHmQ59Q08EFU9/5XpE2419qGQwFJXGY+6uQ6eaAXnxTcKEzq9ePaCz3Wyk
         2hNh+oapZ7JzzWWJ7UwrYAAeU1dlSqihe69ww0f8Ie+zgNhGF4AxVxtPoENHE1AzU+5J
         8YVsnsWGz9Gu71Wjk+k6Ye2DIgPYUp7HXqfd+76Wwx8SwK0h6ajdjVfdyvmNBunN+7+v
         Lsr561JqsuAthS25UfZfmuvzmLnBONqkc4ljCNmSsp++hqfnoLlsw/MR1OhSmn9tQMU2
         332oQbePV9evfnih004Rfwuehak8WydIxm4ZkzLISBebXXX84XlQSd6cUX+x97Ubl2v8
         h2mw==
X-Gm-Message-State: AAQBX9cw4mqOyyO4Mki5x8omHDzNJfc2pWqMb2x7pNM8hyh8gCxye0s9
        4dfWXdLnXeovIwzyr1n6Rp9Ybqv9xQY=
X-Google-Smtp-Source: AKy350YCip4VdEahNrQ8KFpdB0twagLBuvUNmOc/u/iqk/sH/eEzIRvVh1UMxfMv/yPzSSUEPnw3Xg==
X-Received: by 2002:a9d:4f18:0:b0:6a1:20b9:34b6 with SMTP id d24-20020a9d4f18000000b006a120b934b6mr12872225otl.0.1680338814356;
        Sat, 01 Apr 2023 01:46:54 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id d11-20020a9d5e0b000000b006a3170fe3efsm322275oti.27.2023.04.01.01.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 19/49] completion: zsh: fix options with arguments
Date:   Sat,  1 Apr 2023 02:45:56 -0600
Message-Id: <20230401084626.304356-20-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
index b31c9894e4..0619d05d34 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -210,15 +210,15 @@ __git_zsh_main ()
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
2.33.0

