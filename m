Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50BEC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhL1PgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhL1PgW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:36:22 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E80C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:21 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i22so39016132wrb.13
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sXTqPuEJH1xx6yOEBtjkGhTFVSSz4sf+5AfwK3HQrko=;
        b=OR8Ioi/1iiBxmQHP6C4sw66oWbbJ6WwcFvNKIZ+uBSO7fjVrDa0gJFp+86eaOqS1zw
         q+m/tYCLoNhceFk1ICJcLLfVOqiQcpKY4ddqw6m3K4aAMAUzLb8GyzUjgDE9EqDDVXO5
         AiixwnjnuSGtsWAnzsuz3WHvEsNAafQ926TN+35nbBWefQ22OmmSN6vUypJ3REmz/iDk
         p6w4xm2AftipNR3Pkbrft1TdacUX+YotTKYYUNQwzLoGawwqp3zdumVAwDbUHbUA7UUe
         b+AmR/A9uttIdl6vcqVq4lvzPl3OfFpwj74ekhvUcpJINHH4Y6+sAe4mUNwaIkDZ7B3O
         HuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sXTqPuEJH1xx6yOEBtjkGhTFVSSz4sf+5AfwK3HQrko=;
        b=0jDa4PKZ+Jwy2xphDjD+LKV/f3uSV94BFXyRfgpDvj0o1EjwnMBJUho+0fRNYgKsdX
         0XEYFh8tjkbLNT/BjoB4yU43vW/NAcer6z8iGm32WZwLgKo9cr19Bcx56xDs+jrLOgm2
         52iyiEZZhlaFZTIW7xv3Oxn02px/pIyMdwimrdxWcVDJeT30ywd5dSY7JR6CiNfTJZkJ
         D30CgPQFklWizii5SJcN7NjHauFrQLqI4QWY0ZjInvvf7jZwkGKLFc0v2imBc24fOAKz
         VNDJT3B2HGeYA5AD8AwlnFAcJHz28F0ht5B9/poNozHXPl4+wtFgQ/8LJktyr/pusUCi
         1trw==
X-Gm-Message-State: AOAM532tpwXIlqmZcMtMro2mT/41mFIEjuDkgHRcFxOgnjCmIDjxI0dg
        EmyUPOpAMeef7r0OSKKr1ThygY2YTJAGHwx/
X-Google-Smtp-Source: ABdhPJyeTSGlYXkzodnJM7yh5KkXeG1IakQyY4rit0RavWkh91n6vXXH0q/VkhR+w4wCfMfndcaIxg==
X-Received: by 2002:a5d:6dac:: with SMTP id u12mr16177205wrs.320.1640705780235;
        Tue, 28 Dec 2021 07:36:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p23sm18403137wms.3.2021.12.28.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:36:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/7] help doc: add missing "]" to "[-a|--all]"
Date:   Tue, 28 Dec 2021 16:35:06 +0100
Message-Id: <patch-1.7-652dae26bf4-20211228T153456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing "]" to documentation added in 63eae83f8f3 (help: add "-a
--verbose" to list all commands with synopsis, 2018-05-20). This made
it seem as though "--[no-]verbose" can only be provided with "--all",
not "-a". The corresponding usage information in the C
code ("builtin_help_usage") does not have the same problem.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 44ea63cc6d3..cf1d53e9499 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all [--[no-]verbose]]
+'git help' [-a|--all] [--[no-]verbose]
 	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
-- 
2.34.1.1257.g2af47340c7b

