Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EBF31F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbdBCCuF (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:50:05 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33936 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752198AbdBCCt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so1187988wmi.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kci/geIHhfsXRZQffPhkm9bLEdr9KN1llIqj4Lh1V18=;
        b=S1aeJOjmPOjyScT0PYY54A/EtJsq3KcFAfStLlMJ4yOnsBpn3rUkMvWz3yckrtsPwj
         AOEsV1O2O8rnp/L6/9Rsodrnb5o8ZaQ/5CfuXD78KdzzyqAomlcteEJAdKRW804/ntHs
         WtaJmQZnIpLmU9gUgj0o1OK2WYI+ItYKwx7s1M38k0xWkgx/8FrNNagZnLA/CIZLPF+2
         ZNKHn+pT9qY1zD6BzuJh0R9vQCfb5p06FSBZ6JzMc6JYB3lvjQaUvL8xOCP/Fi/S3k0a
         y7QrkfzVP3AaXmqe0JlBLrCDvu5noNncm2f8qBv/H8/k+SDQhxC06Eq/pCAk/tR4Jf9r
         vOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kci/geIHhfsXRZQffPhkm9bLEdr9KN1llIqj4Lh1V18=;
        b=Zg9N5/XKQYwPpwb1QV5a/zoQCfyDh6sutusYGuZU9G/tgkZeiskRttIaHfvDrR+gOL
         qAsfM6yhYIIDqPjt2/ovV+0MSf3OYQn79Cjo4Xk5vmZp3XH+DaL0T8bNApHYtPUwqlsb
         T15J2SZQjYgMTeFUEiOfwerzMa0SGYYpRjjCGG933b54050D4CS4qFgG1KCtOtMPobQF
         hqd89sGRp54lzAJb6HtTu3Neh1xMSIoP7fsA0rexypi0f1FnnQ3w7Hnp4YIbqrUnr+Z5
         XIilij2kO2I9RUBaVIlEVzuGBq/XGcz90K7hBslNVzU16evkbBa4w22DQUB0cXhooYwa
         n/2w==
X-Gm-Message-State: AIkVDXKx9lf05pD2Z/hF2Gd3mz6J2T2t3P3If1gYlrmHF0sfxLDlW403wuxInD+xE3nVNQ==
X-Received: by 10.223.163.201 with SMTP id m9mr11147292wrb.66.1486090166174;
        Thu, 02 Feb 2017 18:49:26 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:25 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 14/21] completion: fix completion after 'git -C <path>'
Date:   Fri,  3 Feb 2017 03:48:22 +0100
Message-Id: <20170203024829.8071-15-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main completion function finds the name of the git command by
iterating through all the words on the command line in search for the
first non-option-looking word.  As it is not aware of 'git -C's
mandatory path argument, if the '-C <path>' option is present, 'path'
will be the first such word and it will be mistaken for a git command.
This breaks completion in various ways:

 - If 'path' happens to match one of the commands supported by the
   completion script, then options of that command will be offered.

 - If 'path' doesn't match a supported command and doesn't contain any
   characters not allowed in Bash identifier names, then the
   completion script does basically nothing and Bash in turn falls
   back to filename completion for all subsequent words.

 - Otherwise, if 'path' does contain such an unallowed character, then
   it leads to a more or less ugly error message in the middle of the
   command line.  The standard '/' directory separator is such a
   character, and it happens to trigger one of the uglier errors:

     $ git -C some/path <TAB>sh.exe": declare: `_git_some/path': not a valid identifier
     error: invalid key: alias.some/path

Fix this by skipping 'git -C's mandatory path argument while iterating
over the words on the command line.  Extend the relevant test with
this case and, while at it, with cases that needed similar treatment
in the past ('--git-dir', '-c', '--work-tree' and '--namespace').

Additionally, silence the standard error of the 'declare' builtins
looking for the completion function associated with the git command
and of the 'git config' query for the aliased command.  So if git ever
learns a new option with a mandatory argument in the future, then,
though the completion script will again misbehave, at least the
command line will not be utterly disrupted by those error messages.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 8 ++++----
 t/t9902-completion.sh                  | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7d25b33b8..ac5eb9ced 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -816,7 +816,7 @@ __git_aliases ()
 __git_aliased_command ()
 {
 	local word cmdline=$(git --git-dir="$(__gitdir)" \
-		config --get "alias.$1")
+		config --get "alias.$1" 2>/dev/null)
 	for word in $cmdline; do
 		case "$word" in
 		\!gitk|gitk)
@@ -2800,7 +2800,7 @@ __git_main ()
 		--git-dir)   ((c++)) ; __git_dir="${words[c]}" ;;
 		--bare)      __git_dir="." ;;
 		--help) command="help"; break ;;
-		-c|--work-tree|--namespace) ((c++)) ;;
+		-c|-C|--work-tree|--namespace) ((c++)) ;;
 		-*) ;;
 		*) command="$i"; break ;;
 		esac
@@ -2844,13 +2844,13 @@ __git_main ()
 	fi
 
 	local completion_func="_git_${command//-/_}"
-	declare -f $completion_func >/dev/null && $completion_func && return
+	declare -f $completion_func >/dev/null 2>/dev/null && $completion_func && return
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		words[1]=$expansion
 		completion_func="_git_${expansion//-/_}"
-		declare -f $completion_func >/dev/null && $completion_func
+		declare -f $completion_func >/dev/null 2>/dev/null && $completion_func
 	fi
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 500505dca..be2ed8704 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -755,7 +755,12 @@ test_expect_success 'general options plus command' '
 	test_completion "git --namespace=foo check" "checkout " &&
 	test_completion "git --paginate check" "checkout " &&
 	test_completion "git --info-path check" "checkout " &&
-	test_completion "git --no-replace-objects check" "checkout "
+	test_completion "git --no-replace-objects check" "checkout " &&
+	test_completion "git --git-dir some/path check" "checkout " &&
+	test_completion "git -c conf.var=value check" "checkout " &&
+	test_completion "git -C some/path check" "checkout " &&
+	test_completion "git --work-tree some/path check" "checkout " &&
+	test_completion "git --namespace name/space check" "checkout "
 '
 
 test_expect_success 'git --help completion' '
-- 
2.11.0.555.g967c1bcb3

