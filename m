Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22CEB1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 17:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440540AbfJQRfQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 13:35:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40899 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436664AbfJQRfP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 13:35:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id o28so3304858wro.7
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAmHQa7BbpSDWk6c3is6+AZz0YpZ+C3LyS2a5t+dt24=;
        b=EMN8XnDR0hdESm8MweJxso1Faw/7+jDa0So/Di6tJ3j3H/PuI8C7YFFUCRrx+2PMsJ
         it8yuF67MENe9WevUY90Na4LJEewo9pR3ylUtmxKrEKYqDmeWDQupFfsVtea61I2aMWg
         QBEmdj7TVZP0FS6jUk6gid0l3zAXdOBUphY3Qm3733VazDXF8TmVGMNNXE/0rdknhrC6
         rNzL2XmaFZWXWWl+3IzWjLNKJGAZeV0Wums5TsdfU8e7et07Aof7XzjD/4DK4/us2VcI
         PzdXSrchZ535QRbiBDmhnbvL4CFRusxm5qVUW0AEBmvNbFJ2fSwIKvVu8JaWQW6yfTDx
         m3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAmHQa7BbpSDWk6c3is6+AZz0YpZ+C3LyS2a5t+dt24=;
        b=ShQh692ZW3Y0H2nbqHzzLcgz+t2U3VRj+ghd27KZbHCuIuYeGCUcZTZdhUkjROkpmb
         qXuvWMmKsQdamqNlEBeb4E5ZzRygfUXugCPMN501PM6KwTM/CgTtdECoQEsaqzNiMZnO
         LXIw6I1GcrR/YucZdPpFlVJDfU4p4q/7ibzg6to+jZOYsr1+rY7o7X0MnXGU8wSyZjpe
         4+PNpIlIXfHWDyM/tWlyrZ1zpSIG8RQb9ub6bkaY4XAE50IA7QBLrt8yBSuCOvGsLz0L
         duMZUxykxFN9kH+0V+qg05DROSNETdgA9arXDL7SBvCaqGc/CupCdQFky86miuaGFrol
         WINw==
X-Gm-Message-State: APjAAAVpgOIsUHYxjITmZqlx3jlpq3gfVAyHLZUVDBdlwYfYFsefVb0a
        R3VPv+3H5kc9aLoE94YsYvTTLFPB
X-Google-Smtp-Source: APXvYqzdCL77r5wvWZVLmQybBivWYfxuEfqucEuJd4jWM0O2hHKGOX1MmLQNO8mBiZkYPx0jWXvTjg==
X-Received: by 2002:adf:e292:: with SMTP id v18mr4030206wri.190.1571333713598;
        Thu, 17 Oct 2019 10:35:13 -0700 (PDT)
Received: from localhost.localdomain (x4db41bda.dyn.telefonica.de. [77.180.27.218])
        by smtp.gmail.com with ESMTPSA id f20sm2599876wmb.6.2019.10.17.10.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Oct 2019 10:35:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/6] completion: return the index of found word from __git_find_on_cmdline()
Date:   Thu, 17 Oct 2019 19:34:58 +0200
Message-Id: <20191017173501.3198-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.1084.gae250eaa40
In-Reply-To: <20191017173501.3198-1-szeder.dev@gmail.com>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
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
2.23.0.1084.gae250eaa40

