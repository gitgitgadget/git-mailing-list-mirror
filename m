Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D00F71F404
	for <e@80x24.org>; Sun, 25 Mar 2018 13:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeCYNqk (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 09:46:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33042 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753330AbeCYNqe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 09:46:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id o23so1470397wmf.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1smYdiE2BpNhSNUu67Z6hjZ/4dd1NHz2Ws7LfjlkNnk=;
        b=nRUjw1YjIR+RNDMD+0D4EBns571kOP0V826I70G5uQzfedWoNX2P5QKbPet6lzq5xt
         9drbEORh+Gs5Yh5ZqwD0KlLClxpdMUXK6Wo/UoInfSHg/dz6Afyq2qm3jUa1hOf0Bn7h
         WXp7//heNMIqxSfHyLjcNt13s8Sx3VG0CTTxkFEGBcOOD+2deFUM3VLKl0XYOjnSn9sE
         WdxSFccNLgy10wafcqC5xGWVYpGXVJVHNdm92CkhpeJ/g4AAYdN5Wu/N/TUtNpqpW7ed
         IYIwKmwgB6iR/RhyqHfnVceDrWrgnMNUb/uyIBCpFNhKELR1gyK5m3BJnbWpjeNr2YWM
         XH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1smYdiE2BpNhSNUu67Z6hjZ/4dd1NHz2Ws7LfjlkNnk=;
        b=HynteqQXvXrO2j4sH813xcDWajqvbnesq6DiBJ2XdP+grkbFysUQ6AMvUR26yHwVSB
         zQuMfua1Td/p9Gm71cPiMWjWT9mMlu0u2jVfUjktO3VenJcnnpvAaHNk9MzB2LtVgskm
         elQo4WLtqhYRqO5uEyzFud4Iw5BWuj4zlg0huwfOmx+No/k+6qo8vuooXVNfEy3oWXt5
         5+i2tOthCPbVQhB0uLOuaTPg61xeRoLed/r+pnIWjBYFb4zy9qSpRf4j7XSAyNyjy1da
         UjY7uwiw8MRPOwNDduQv5YLApBYHz1kU5OOKVELl+t/1eawOljGgRuxYqShr0+j5wzxQ
         copQ==
X-Gm-Message-State: AElRT7GyErHB9ur2N9i1f5W7d+jMp9XYuYyHsAa62s/z2zuAelg3swxS
        j81wwybIbR8FjYVmOQOfkuLAwsPX
X-Google-Smtp-Source: AG47ELs5FFzuWvYvRuMopLw4MD3n+L6XP3KLP38AJQB0w/LMpPdP4Hf7ZnB7rphCiAtL/XesHR8lXw==
X-Received: by 10.28.149.71 with SMTP id x68mr14080403wmd.78.1521985593233;
        Sun, 25 Mar 2018 06:46:33 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id u3sm18095603wrf.3.2018.03.25.06.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 06:46:32 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 3/6] worktree: remove force_new_branch from struct add_opts
Date:   Sun, 25 Mar 2018 14:49:44 +0100
Message-Id: <20180325134947.25828-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.77.g8685934aa2
In-Reply-To: <20180325134947.25828-1-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180325134947.25828-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'force_new_branch' flag in 'struct add_opts' is only used inside the
add function, where we already have the same information stored in the
'new_branch_force' variable.  Avoid that unnecessary duplication.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index a082230b6c..1e4a919a00 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -28,7 +28,6 @@ struct add_opts {
 	int checkout;
 	int keep_locked;
 	const char *new_branch;
-	int force_new_branch;
 };
 
 static int show_only;
@@ -405,8 +404,7 @@ static int add(int ac, const char **av, const char *prefix)
 	if (!strcmp(branch, "-"))
 		branch = "@{-1}";
 
-	opts.force_new_branch = !!new_branch_force;
-	if (opts.force_new_branch) {
+	if (new_branch_force) {
 		struct strbuf symref = STRBUF_INIT;
 
 		opts.new_branch = new_branch_force;
@@ -450,7 +448,7 @@ static int add(int ac, const char **av, const char *prefix)
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
 		argv_array_push(&cp.args, "branch");
-		if (opts.force_new_branch)
+		if (new_branch_force)
 			argv_array_push(&cp.args, "--force");
 		argv_array_push(&cp.args, opts.new_branch);
 		argv_array_push(&cp.args, branch);
-- 
2.16.1.77.g8685934aa2

