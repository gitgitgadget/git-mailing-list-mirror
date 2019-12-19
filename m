Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0355C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B72206EC
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH4KYNfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLSPJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:09:41 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43477 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfLSPJl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 10:09:41 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so5176657edb.10
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+gm8hi+B2+57fpj63eg+nE8Lr5sFnGuz2vJzMEg9l8=;
        b=MH4KYNfuoZUlAslXQCsPRF+C3LwH3/CeN7Pm/9vjMLbTi5hg2YUNu+PXPFgN4V0eOn
         K+PeKiWTL2cu+WkNDN8jBkHEKRQ455TAARMgGSPVAmg43NiQr6fgul2tEGQSL3kB4jJd
         6fFozeeN3YpULrBUzkv4o+RAT1VIjo7eOqDa/657vGOSYP+F360mjUvQEkpD11B/91Le
         tfb4H1eqXikD/3kQbSJwyv8OMn+tUlFfLy5UockKVUlBHUAjiH/FB2Ayy65BIXDNosYr
         x467U00zUNZU+IFgYWagagjtiFSgFB/rliiLODiksqBvxlKloBFRknbkXCSmSWDIe/ZP
         eFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+gm8hi+B2+57fpj63eg+nE8Lr5sFnGuz2vJzMEg9l8=;
        b=rBnlS9RrbPYQa9wS9c0UDKkLX8nmB18XEiq2zjZ6HCDNYCclbUoqSyk+mv/zqInQRJ
         /r6Eecg87KzsLPm1wkYBDXHZ6mi1jHQ1jaZp8IBYkwkFtOFAGPWFFJHvFJyoOemhRXmv
         R47bwM7cSOlx3rDwEOOY94OGGcnRcMAJZIw93KGeHOvIBe7TD7oOJQxFjQJJPHFM3uG0
         mEKdV6oCSpjJbn9JmSecbhnu9S4gF9bUqJcgJjWFUjVjhpvsytqrzPxPzvHt0jTNW6Wi
         PMqINfjqaiqYb8pc0RwhbYmMY/YCnvHikB7D5LUyJ4vLY6mmuJ7saB9WUhDUCvA15OkZ
         IyMQ==
X-Gm-Message-State: APjAAAXGG+YCX8JqD++sB2ymliUmqegYiFJCy5go/6O1Upe0vUFaBPw5
        g8ltiX85CbF4nMcVj+e0xnI=
X-Google-Smtp-Source: APXvYqzgDvA6c9rN803qAFiFhtgq7ld0TGXZ+WzWnprMu4oaD6QIqDyGnVen0lHOQ4brIsbJ0EA1OA==
X-Received: by 2002:a17:906:3299:: with SMTP id 25mr10016454ejw.118.1576768179270;
        Thu, 19 Dec 2019 07:09:39 -0800 (PST)
Received: from localhost.localdomain (x4db583fb.dyn.telefonica.de. [77.181.131.251])
        by smtp.gmail.com with ESMTPSA id b27sm546584ejg.40.2019.12.19.07.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 07:09:38 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/6] completion: return the index of found word from __git_find_on_cmdline()
Date:   Thu, 19 Dec 2019 16:09:18 +0100
Message-Id: <20191219150921.5889-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.1.982.ga4d4aba446
In-Reply-To: <20191219150921.5889-1-szeder.dev@gmail.com>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
 <20191219150921.5889-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the __git_find_on_cmdline() helper function so far we've
only been interested in which one of a set of words appear on the
command line.  To complete options for some of 'git worktree's
subcommands in the following patches we'll need not only that, but the
index of that word on the command line as well.

Extend __git_find_on_cmdline() to optionally show the index of the
found word on the command line (IOW in the $words array) when the
'--show-idx' option is given.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 20 +++++++++++++++---
 t/t9902-completion.sh                  | 29 ++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2384f91e78..55a2d3e174 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1069,18 +1069,32 @@ __git_aliased_command ()
 	done
 }
 
-# __git_find_on_cmdline requires 1 argument
 # Check whether one of the given words is present on the command line,
 # and print the first word found.
+#
+# Usage: __git_find_on_cmdline [<option>]... "<wordlist>"
+# --show-idx: Optionally show the index of the found word in the $words array.
 __git_find_on_cmdline ()
 {
-	local word c=1
+	local word c=1 show_idx
+
+	while test $# -gt 1; do
+		case "$1" in
+		--show-idx)	show_idx=y ;;
+		*)		return 1 ;;
+		esac
+		shift
+	done
 	local wordlist="$1"
 
 	while [ $c -lt $cword ]; do
 		for word in $wordlist; do
 			if [ "$word" = "${words[c]}" ]; then
-				echo "$word"
+				if [ -n "$show_idx" ]; then
+					echo "$c $word"
+				else
+					echo "$word"
+				fi
 				return
 			fi
 		done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 847ce601d2..3e3299819a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1392,6 +1392,35 @@ test_expect_success '__git_find_on_cmdline - no match' '
 	test_must_be_empty actual
 '
 
+test_expect_success '__git_find_on_cmdline - single match with index' '
+	echo "3 list" >expect &&
+	(
+		words=(git command --opt list) &&
+		cword=${#words[@]} &&
+		__git_find_on_cmdline --show-idx "add list remove" >actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_find_on_cmdline - multiple matches with index' '
+	echo "4 remove" >expect &&
+	(
+		words=(git command -o --opt remove list add) &&
+		cword=${#words[@]} &&
+		__git_find_on_cmdline --show-idx "add list remove" >actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_find_on_cmdline - no match with index' '
+	(
+		words=(git command --opt branch) &&
+		cword=${#words[@]} &&
+		__git_find_on_cmdline --show-idx "add list remove" >actual
+	) &&
+	test_must_be_empty actual
+'
+
 test_expect_success '__git_get_config_variables' '
 	cat >expect <<-EOF &&
 	name-1
-- 
2.24.1.982.ga4d4aba446

