Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD53C7619A
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 01:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCaByC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 21:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCaByB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 21:54:01 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D925B83C8
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 18:54:00 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id r17-20020a05683002f100b006a131458abfso8529281ote.2
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 18:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680227640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUBYnP5/eW8gBH+iwg0RRmETdJD0UK6bV75u+ysRiSU=;
        b=lXPxTLv8XdlM1/r4jtRyp30I6/kxIi9SC24wyM9wb9Ws9z0JDkD9HstUiqTYJpQeTe
         NGWNnE7qqY9KaeGd3y2guoG61AQfhM4zb7Y2WTB+q6O7RIW4VfirhzYQFDlCuNJddeYQ
         ThfuplEBEkHPukSnKFTK78Ot3Tx/VpsSzscrmY9ttIHjQmWlRgtqQ5Jt28I22IWsrVny
         P7i56LlQICG/VAYb5mZT2PXCWIQoNgb7pAhJgGcuqBNB1PZ29udNWf6dim6JjbrR/xzy
         ZnvMSY5BQYcMziIjuWfO0urMcNPI0W5KO19X1oaqICsFGuooKaH5Y7wVLf77s83Dbgko
         21Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680227640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUBYnP5/eW8gBH+iwg0RRmETdJD0UK6bV75u+ysRiSU=;
        b=2YP6qsJJN6pU2/iA07QERJdpyv8V9r046mmSUMmZn42s96VwLq3bHr3UnVPh1t5xZV
         31YtZVAovNJY92gOHxtIgYN8p8ssB8mtiCkPvJXPH97rtaZYJkVwpJAYyVd04CVi2lMM
         v7yDzcWQ+zzqPkhG3p6m7T+ZTKVXTZ/7/yXw6X4t2zgX/rB74k+UETDzRV/4ML7BmRUg
         FqOLEtHrR0FyLUQ2ghYcojzlxV6zpcAF5PEMk/AxSlX6GZqemOsBzh2PijCPCT8vt68R
         dPnLVCUPCgLP/qlXkfz37gW74Td8cFO9U3yeI0QedgpJJ74YxVBDhRUlcUIi2JCc7xOT
         GRXQ==
X-Gm-Message-State: AO0yUKUv+Cmlyw82vJgVsuxd7oELM9lAGVZhcIwTXdSXX2IOn4tSbEb3
        EtLYJIyOLul/UolO/Z51oWWHVQjS0Ao=
X-Google-Smtp-Source: AK7set+PRiOZgzm3Hj6fR15hQkc5B6C20gjWdqx9UiHdQT7PrnY2k6aH+r4mwyGuxfG4cXd4I+UVjQ==
X-Received: by 2002:a9d:7b55:0:b0:694:346c:10da with SMTP id f21-20020a9d7b55000000b00694346c10damr11093155oto.35.1680227639968;
        Thu, 30 Mar 2023 18:53:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7693000000b0069abd1e5573sm614312otl.17.2023.03.30.18.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 18:53:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Thiago Perrotta <tbperrotta@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: show --no options correctly
Date:   Thu, 30 Mar 2023 19:53:57 -0600
Message-Id: <20230331015357.154459-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0.133.g8a4477c8d7.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the --no options need to be after the `--`, otherwise the
completion will show them initially.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-send-email.perl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 07f2a0cbea..f0d80baa01 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -142,9 +142,10 @@ sub completion_helper {
 
 	my @format_patch_opts = split(/ /, Git::command('format-patch', '--git-completion-helper'));
 	my @opts = (@send_email_opts, @format_patch_opts);
-	@opts = uniq (grep !/^$/, @opts);
-	# There's an implicit '\n' here already, no need to add an explicit one.
-	print "@opts";
+	@opts = uniq (grep !/^(--|)$/, @opts);
+	my @pos_opts = grep(!/^--no/, @opts);
+	my @neg_opts = grep(/^--no/, @opts);
+	print "@pos_opts -- @neg_opts";
 	exit(0);
 }
 
-- 
2.40.0.133.g8a4477c8d7.dirty

