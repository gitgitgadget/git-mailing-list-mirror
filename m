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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DFFC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 10:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C080E6144D
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 10:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbhDVKBm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 06:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhDVKBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 06:01:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE22C06138B
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 03:01:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gq23-20020a17090b1057b0290151869af68bso678012pjb.4
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 03:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6l9/19H8W1JSYN3ievg870oMVAzs3a48rcQq0CQclTk=;
        b=VVx22evVHX6EzjMSHcyQCYcGRrLksrgqPPCk+3qehH8Q0RUvoj9GnWUc6tKQUfWyHz
         dn8ETYmaTpnvbwT3Q8Et+Yba+XH+niqJPYX1hwH/avAgQEnS+U/ngxjBA0fUl35UYy0B
         lt2Lf9AD/16kxN/iUW/k0X3VEhfJ1i8KHYFDNp5GOi+gnuFE71lO0/15XXxZs44dTluR
         RIHle335t/oiVYr2ogImr2HDDflm5m7xMo7xkJhf/6WGl2+GsDCgeez7Lu1ufczff7yf
         Bp6ZHMNj4FC6DhWNLfuwDD+zPAPC008RUfmm44TXkXHKR2lqTyjkqpmQY2arXNbYESwm
         KmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6l9/19H8W1JSYN3ievg870oMVAzs3a48rcQq0CQclTk=;
        b=Pm/LTGy+Nnbb336vJbRCKKkwp0lmGAoyCzCmKnWVxqhrMUPA4Il8sXOdISdEOQIbaH
         hUAAAO/v78Bc7iMGQWqWxxdwZ1vCn/DSh8usuKNKNq5Lp+eqMoxs1sBLgy7lp7b7vute
         tSiKpjMe8dZ0NE7IBZikjjmrJaSW9Ak0DC0BVVZrYOkfZw8NlwUjqgRA7l9snCOYu8K6
         9bRok2Ebo4SpTEo9ta0zaZTvo/EXbdmQnJwRNsBv+3jif+0nOdRJXBhW9JQ9oBhXiny8
         sENsN2SHRcKMKRcZAIk9bFI/FlzdkLRk2bNcUguXvyNhmKG8g1xpiZjPVtK12kBVAg50
         bf7A==
X-Gm-Message-State: AOAM530ZzVet6jeuvdO+cAWrUxHFj9eZvwh5vSD9nP0vcQe7X1XMCt/K
        uL6RB39KB0elhc2VSr3YG80t181kZXg=
X-Google-Smtp-Source: ABdhPJxQ3seQmv/ofvdK5k0GankPwW+ySYZffmSCp9pLkgqurfGgGTq4k9rKOo+IC+/svzN2ylBJRw==
X-Received: by 2002:a17:90a:6282:: with SMTP id d2mr15738219pjj.168.1619085664731;
        Thu, 22 Apr 2021 03:01:04 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id r3sm1741314pfl.159.2021.04.22.03.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 03:01:04 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] git-completion.bash: separate some commands onto their own line
Date:   Thu, 22 Apr 2021 03:00:49 -0700
Message-Id: <65c485ea0c1726c96d292d7d7385def8d2f19f25.1619085387.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.499.g90b4fd31cd
In-Reply-To: <cover.1619085387.git.liu.denton@gmail.com>
References: <cover.1618910364.git.liu.denton@gmail.com> <cover.1619085387.git.liu.denton@gmail.com>
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
2.31.1.499.g90b4fd31cd

