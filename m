Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC98D1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfHMM1Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:16 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:56146 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHMM1P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:15 -0400
Received: by mail-wm1-f43.google.com with SMTP id f72so1320643wmf.5
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67cFOYIO8oZab8Us9FEfxOgog/JH9eJeEIdnk/hLLH4=;
        b=Vqw7DQFUKIBSopN6xjJ/FGtEkdMP09T4e8esoH1x50qLX7UsmlxfKXgmkIQ8GmNdm7
         z5nGpFKCEpMEYW4IslOGgYBmnt5M1SQVgUxAS31kp76/LCVpamteoJltD5MZwMiEzlmO
         EJkCqOflUhsR32D/6la+CeiizelTs/lP30wEaHmjRD6brAYqFEMhwf1s2y2PtKCNA6mc
         fmK3nnHyf7SVo4H9ySzNmvg3+o5m+s2g9ucpu5b15VS6R+xs4yPvxqBpBKDXVUf7Xf3/
         dPjdHX7HulhQhWzKeox9hCk3h8mpFsdaMmL9gr//MUMslr+900f2rQi+LnLdy7dZLR0D
         Vs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67cFOYIO8oZab8Us9FEfxOgog/JH9eJeEIdnk/hLLH4=;
        b=qsRQ9A+1MWCsrwAk8GIOzyYP2p/ce8B9FGcUawv0cjlt1itmdIrQ1+E7I7oipbGyMA
         T0fU2MhjhpNjdHwNZT3acICoYj74krI00hIGs68zjCiTEA/6ml+M2k7QcUqqglVUbHMf
         jV8+dZtLU+vrOvlZl2c3cS8ysPSlmUWUJscB9A7BZFjcb9R6uSKEBPywqQ8skeQS2BU7
         3At102UGfNEOdywIn/6Udbh0IsydyVEmcEp3Yaf8I/22dcnSEDpYdeGbyGPa6p9Z4F05
         cO3D2HbudoUcx1p8nTu8B+O1fSMgR0rt9YlGaKqtlBAPF0PsLWWZzb1ScJ8aXz3pasak
         pqvA==
X-Gm-Message-State: APjAAAU2HJzEmShXZn7xutg79OiWurl2VJHGBErE7g/PlPMaggggJezu
        mhBrL7VZ18M4DkuOIYEfHBxViVs2
X-Google-Smtp-Source: APXvYqyqjOz3ZaZ6pHbWxf8mqxIvlfPn7GDid5rA2hkRnLibuBZIKXuGVp+1/+jlAY/0TBE8Hqy2jw==
X-Received: by 2002:a1c:e703:: with SMTP id e3mr2515448wmh.91.1565699234027;
        Tue, 13 Aug 2019 05:27:14 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 09/11] completion: complete values of configuration variables after 'git -c var='
Date:   Tue, 13 Aug 2019 14:26:50 +0200
Message-Id: <20190813122652.16468-10-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.350.gf4fdc32db7
In-Reply-To: <20190813122652.16468-1-szeder.dev@gmail.com>
References: <20190813122652.16468-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git config' expects a configuration variable's name and value in
separate options, so we complete values as they stand on their own on
the command line.  'git -c', however, expects them in a single option
joined by a '=' character, so we should be able to complete values
when they are following 'section.name=' in the same word.

Add new options to the __git_complete_config_variable_value() function
to allow callers to specify the current word to be completed and the
configuration variable whose value is to be completed, and use these
to complete possible values after 'git -c 'section.name=<TAB>'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 65 ++++++++++++++++----------
 t/t9902-completion.sh                  |  7 +++
 2 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 367b1c50f4..6f2bc60707 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2229,96 +2229,112 @@ __git_compute_config_vars ()
 }
 
 # Completes possible values of various configuration variables.
+#
+# Usage: __git_complete_config_variable_value [<option>]...
+# --varname=<word>: The name of the configuration variable whose value is
+#                   to be completed.  Defaults to the previous word on the
+#                   command line.
+# --cur=<word>: The current value to be completed.  Defaults to the current
+#               word to be completed.
 __git_complete_config_variable_value ()
 {
-	local varname
+	local varname="$prev" cur_="$cur"
+
+	while test $# != 0; do
+		case "$1" in
+		--varname=*)	varname="${1##--varname=}" ;;
+		--cur=*)	cur_="${1##--cur=}" ;;
+		*)		return 1 ;;
+		esac
+		shift
+	done
 
 	if [ "${BASH_VERSINFO[0]:-0}" -ge 4 ]; then
-		varname="${prev,,}"
+		varname="${varname,,}"
 	else
-		varname="$(echo "$prev" |tr A-Z a-z)"
+		varname="$(echo "$varname" |tr A-Z a-z)"
 	fi
 
 	case "$varname" in
 	branch.*.remote|branch.*.pushremote)
-		__gitcomp_nl "$(__git_remotes)"
+		__gitcomp_nl "$(__git_remotes)" "" "$cur_"
 		return
 		;;
 	branch.*.merge)
-		__git_complete_refs
+		__git_complete_refs --cur="$cur_"
 		return
 		;;
 	branch.*.rebase)
-		__gitcomp "false true merges preserve interactive"
+		__gitcomp "false true merges preserve interactive" "" "$cur_"
 		return
 		;;
 	remote.pushdefault)
-		__gitcomp_nl "$(__git_remotes)"
+		__gitcomp_nl "$(__git_remotes)" "" "$cur_"
 		return
 		;;
 	remote.*.fetch)
-		local remote="${prev#remote.}"
+		local remote="${varname#remote.}"
 		remote="${remote%.fetch}"
-		if [ -z "$cur" ]; then
+		if [ -z "$cur_" ]; then
 			__gitcomp_nl "refs/heads/" "" "" ""
 			return
 		fi
-		__gitcomp_nl "$(__git_refs_remotes "$remote")"
+		__gitcomp_nl "$(__git_refs_remotes "$remote")" "" "$cur_"
 		return
 		;;
 	remote.*.push)
-		local remote="${prev#remote.}"
+		local remote="${varname#remote.}"
 		remote="${remote%.push}"
 		__gitcomp_nl "$(__git for-each-ref \
-			--format='%(refname):%(refname)' refs/heads)"
+			--format='%(refname):%(refname)' refs/heads)" "" "$cur_"
 		return
 		;;
 	pull.twohead|pull.octopus)
 		__git_compute_merge_strategies
-		__gitcomp "$__git_merge_strategies"
+		__gitcomp "$__git_merge_strategies" "" "$cur_"
 		return
 		;;
 	color.pager)
-		__gitcomp "false true"
+		__gitcomp "false true" "" "$cur_"
 		return
 		;;
 	color.*.*)
 		__gitcomp "
 			normal black red green yellow blue magenta cyan white
 			bold dim ul blink reverse
-			"
+			" "" "$cur_"
 		return
 		;;
 	color.*)
-		__gitcomp "false true always never auto"
+		__gitcomp "false true always never auto" "" "$cur_"
 		return
 		;;
 	diff.submodule)
-		__gitcomp "$__git_diff_submodule_formats"
+		__gitcomp "$__git_diff_submodule_formats" "" "$cur_"
 		return
 		;;
 	help.format)
-		__gitcomp "man info web html"
+		__gitcomp "man info web html" "" "$cur_"
 		return
 		;;
 	log.date)
-		__gitcomp "$__git_log_date_formats"
+		__gitcomp "$__git_log_date_formats" "" "$cur_"
 		return
 		;;
 	sendemail.aliasfiletype)
-		__gitcomp "mutt mailrc pine elm gnus"
+		__gitcomp "mutt mailrc pine elm gnus" "" "$cur_"
 		return
 		;;
 	sendemail.confirm)
-		__gitcomp "$__git_send_email_confirm_options"
+		__gitcomp "$__git_send_email_confirm_options" "" "$cur_"
 		return
 		;;
 	sendemail.suppresscc)
-		__gitcomp "$__git_send_email_suppresscc_options"
+		__gitcomp "$__git_send_email_suppresscc_options" "" "$cur_"
 		return
 		;;
 	sendemail.transferencoding)
-		__gitcomp "7bit 8bit quoted-printable base64"
+		__gitcomp "7bit 8bit quoted-printable base64" "" "$cur_"
 		return
 		;;
 	*.*)
@@ -2430,7 +2446,8 @@ __git_complete_config_variable_name_and_value ()
 {
 	case "$cur" in
 	*=*)
-		# in the next patch...
+		__git_complete_config_variable_value \
+			--varname="${cur%%=*}" --cur="${cur#*=}"
 		;;
 	*)
 		__git_complete_config_variable_name --sfx='='
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index bf60a11fa8..9e90a64830 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1733,6 +1733,13 @@ test_expect_success 'git -c - variable name' '
 	EOF
 '
 
+test_expect_success 'git -c - value' '
+	test_completion "git -c color.pager=" <<-\EOF
+	false Z
+	true Z
+	EOF
+'
+
 test_expect_success 'sourcing the completion script clears cached commands' '
 	__git_compute_all_commands &&
 	verbose test -n "$__git_all_commands" &&
-- 
2.23.0.rc2.350.gf4fdc32db7

