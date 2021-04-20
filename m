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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C735FC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953CF61057
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDTJUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhDTJUd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 05:20:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C61C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:20:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so22021732pjh.1
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4QUn1MJIiiv9bTaQ/vinfQ4bodzXgbz7zi1f29rVwY=;
        b=QKLHPgNH7kLva+IbHpN4J67AnIa6fbIiw4zdrNgxfCiSKCJKfhYHNQrjQZEUy3WYQG
         0rLklpNzym5PGyWtFUvV/p7r+wGbkBfssvZ5d5ssl7aMKlbwKquyR634e3RgDCBovfSL
         2yokR3+6qiaF2NoR+9Sa1yyrgq2Wgyh7qGa7E6iNxlJJf+jku8Moh4E3fWhU/TWXc5+Q
         xtt6aucg3qZK4HXWNc6rm6Q1XpV8grBBK7DQDZPLYwj749uKc2pJg+H2zrvAiOMjVIwK
         xp+NouQeZB1bMaKTM+vuZMBWiVoLieNd6WND5sW10ct4tSPMWB9x1wMgm63WH8Bx8Vle
         7rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4QUn1MJIiiv9bTaQ/vinfQ4bodzXgbz7zi1f29rVwY=;
        b=DQzCQWQfXrMH/VyObJibNFfFjgL7pvuNkos/7+EA+qcvBkDZYvxuvJq1S+9Hb3juPY
         p2hkY1vRUXZX5DMf8CjsE1x/Ewqwb/1gUjQtlQAUtPWncAstCnwuqKsQTGBxRAwSF3m2
         PHbw0XvZt9cfnBl29TRnnFwcbNRwtveN9ApJuggYDoDrJjimRlrAgbKxuzh8/bGcFA5U
         nF4nq7sB2q4s7ijKIRYvKfutFoHdVdqletfd2J6z4ex0Y6f+i9ZcNQknZz7fpJO1lKhA
         6NdhV2kPq4/rE4LYeQDDJX3HpuMYlEKp5+vzgzPgj++bCpeUSw3fykWmRQLPv0bJYJs+
         6WCw==
X-Gm-Message-State: AOAM5324wy4Twehw3WaewiD0+9zBQ99X993LCbC9DulIJm7MizJpmDr9
        G4VwbRzB1QZ0n66UOV4aIOxtMnGhlEM=
X-Google-Smtp-Source: ABdhPJw9+rQ072m4P/FyBhSZyguKMXKdAuqeVSaF4cMQeqv/OjPIBkgv2G5hNxq6JfSmJ1UF1I2U1w==
X-Received: by 2002:a17:902:d2ce:b029:eb:364:a2a0 with SMTP id n14-20020a170902d2ceb02900eb0364a2a0mr28080950plc.0.1618910400679;
        Tue, 20 Apr 2021 02:20:00 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id k15sm15247630pfi.0.2021.04.20.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 02:20:00 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] git-completion.bash: separate some commands onto their own line
Date:   Tue, 20 Apr 2021 02:19:47 -0700
Message-Id: <65c485ea0c1726c96d292d7d7385def8d2f19f25.1618910364.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.424.g95a8dafae5
In-Reply-To: <cover.1618910364.git.liu.denton@gmail.com>
References: <cover.1618910364.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e94fb44042 (git-completion.bash: pass $__git_subcommand_idx from
__git_main(), 2021-03-24), a line was introduced which contained
multiple statements. This is difficult to read so break it into multiple
lines.

While we're at it, follow this convention for the rest of the
__git_main() and break up lines that contain multiple statements.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 37 +++++++++++++++++++-------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c926ca26c6..1dedb14b47 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3400,17 +3400,35 @@ __git_main ()
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
-		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
-		--git-dir)   ((c++)) ; __git_dir="${words[c]}" ;;
-		--bare)      __git_dir="." ;;
-		--help) command="help"; break ;;
-		-c|--work-tree|--namespace) ((c++)) ;;
-		-C)	__git_C_args[C_args_count++]=-C
+		--git-dir=*)
+			__git_dir="${i#--git-dir=}"
+			;;
+		--git-dir)
+			((c++))
+			__git_dir="${words[c]}"
+			;;
+		--bare)
+			__git_dir="."
+			;;
+		--help)
+			command="help"
+			break
+			;;
+		-c|--work-tree|--namespace)
+			((c++))
+			;;
+		-C)
+			__git_C_args[C_args_count++]=-C
 			((c++))
 			__git_C_args[C_args_count++]="${words[c]}"
 			;;
-		-*) ;;
-		*) command="$i"; __git_subcommand_idx="$c"; break ;;
+		-*)
+			;;
+		*)
+			command="$i"
+			__git_subcommand_idx="$c"
+			break
+			;;
 		esac
 		((c++))
 	done
@@ -3432,7 +3450,8 @@ __git_main ()
 			;;
 		esac
 		case "$cur" in
-		--*)   __gitcomp "
+		--*)
+			__gitcomp "
 			--paginate
 			--no-pager
 			--git-dir=
-- 
2.31.1.424.g95a8dafae5

