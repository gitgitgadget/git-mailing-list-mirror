Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D714C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6D064DA1
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhBKTIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhBKTIp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:08:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6F5C061574
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:08:05 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u15so3837643plf.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AyYlCZYGVEWXsx11as8iSLbadERSHF3k41S7n126HSo=;
        b=MJAD3IPwANLIElMHGJIY16i4ixTKRh9hzvOZssqjV+Fj/z18u4lz4sOCFlK4EJT/Wv
         paTJQOo56N0FG7GY6VScM/SF4+f9kgwayBq61WghCPxJt7GGKoJl0bhvK8b9Ba4IjsG7
         yt7Fbjzh3hBNgiaYKDPU8F75A8nhiQtslJ66E6sYwyTenf+HqZxlQzosEGonjC7jSFjT
         hbWiZEGdZiIi3Cai4Gyk18X3DIzLYA/VCZjy+72Ew3fF/Ekh5LEmaFQKayaWVKkaIAHb
         gq9JA6dG6wScEZsiUJGsrszPIz2xp57O3PqtFZ5Rt6Bs67cnXqt4wto9mkakABy/1T3A
         TQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AyYlCZYGVEWXsx11as8iSLbadERSHF3k41S7n126HSo=;
        b=q8spiac7V05BAsqJnbCVCnA66pjxG+O/bNaXzDJSCsAjnPj3rZzfrGZhF5N8+U0SKl
         vE2h6PWlc2Zw90cH3deNL+3Nf/Y1bmxFOv4VBcwLmLVdzWTgIC1NnJSoh2VdydBX0FoB
         NtSN4Onq5Mfyb7Cx1Xmm0JwX4MXLxw00jvwAMRDpppx5Ynf5xurcBNAZukCn/eExv25a
         DKR6XR17VNEIaXc+VDwDEmp49CYoK7c1HxhFNABZF4sw3WUgPH1UsgpDXZX8MoOKDnDl
         aTKaZEI8jkxs9a4Pd6O5kcUOHNxCEP7gVKroR7CEdaam0QGQ2fmzUdk9zo/nXzSm6OcI
         JfLg==
X-Gm-Message-State: AOAM53069D+Z83cjIdat0C9XGaD5+yqDTLm5kolfc9C9y3MrLQUXoeRp
        3XvQxVw/iQIi6+UyKGwk7I23xCpgTYY=
X-Google-Smtp-Source: ABdhPJzKxV/TXehtvAU8o/O7DQQ2o0OAi8b8nWmR0jJs3VKZnDIoO1fkqnPW7oSPjXSbx7lpr0HDGg==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr5440467pjb.160.1613070484485;
        Thu, 11 Feb 2021 11:08:04 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id c188sm6231626pfa.98.2021.02.11.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:08:03 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] fixup! git-stash.txt: be explicit about subcommand options
Date:   Thu, 11 Feb 2021 11:07:53 -0800
Message-Id: <54f6fe119c61517d92a0aa43921ef9c1a52bb080.1613070418.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <xmqqv9b04cil.fsf@gitster.c.googlers.com>
References: <xmqqv9b04cil.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-stash.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 04e55eb826..f1197d641b 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -8,8 +8,8 @@ git-stash - Stash the changes in a dirty working directory away
 SYNOPSIS
 --------
 [verse]
-'git stash' list [<options>]
-'git stash' show [<options>] [<stash>]
+'git stash' list [<log-options>]
+'git stash' show [<diff-options>] [<stash>]
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-- 
2.30.0.478.g8a0d178c01

