From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH 2/2] pull --rebase: add --[no-]autostash flag
Date: Tue, 15 Mar 2016 22:41:44 +0530
Message-ID: <1458061904-26516-2-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
 <1458061904-26516-1-git-send-email-mehul.jain2029@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 18:13:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afsX2-0003dN-Mg
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 18:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965296AbcCORNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 13:13:17 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36030 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965132AbcCORNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 13:13:16 -0400
Received: by mail-pf0-f176.google.com with SMTP id u190so36586958pfb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3k0MQTwPEXRuaWy5KNCK6i4lDNHfsL/CcVeTSFD5tg=;
        b=tXYYTeOVh1Mbe6WblT4DleeZM0Sw0CWCOa5lE3SXAqxzgRjmCrxqss3yfcIFlgyNDz
         FwdHnC0ZucbSBK9rrznMjqLoDrSJBau0K+aNKm/iK95jStp9k8Pf9vz0GPTn4iHDYAyz
         D14zIbAjCO8iiUHyOyxBtSI9FGQP8YOJZxQEvR8UC2x63jwxydD/hgKcoxM2giokfUYZ
         Tew0+Jyr1sBmi9HTFHRuOT7ipRgXMLvEAxausIA7wGrPJdusYEEb+/EXWA/rRcL3JErN
         6PxVJ/gNFUzaQHRpSg2J/6frktiUzfmxWgTCZ3xZxWLnphh892I+cpf8D0Th57jahpeO
         ZJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3k0MQTwPEXRuaWy5KNCK6i4lDNHfsL/CcVeTSFD5tg=;
        b=DwQZ64KilDIVmQaT/tggc9Yx6Kz8qK5uqi+Vb86v8PBAmCnENjQ2drzyxsDbUCY7dG
         319NrAjZr7333tPy363TltL1nEQasyokwTJUIwy3GyW4AhVLdzXBCrG8qUYiSr1xN4As
         lqgWk3RizXWa1kYV/j3dH9agFrJk6lV3grh43MAWQVlmnEzU/bEYXdPBIrdrM8pgwCdt
         btzuMl2Dk1H0CgFWLdYwpwDamB1+X8RLevVFckgzbwYPOnIWI0Gp6dtndh3gxVkUzB5X
         mQK7e1+lAzF/MUaVeBbRinP+BWzInKUThhMl4YaxWOC36kXD8rX2iUI4DhZdmNBAmZNl
         JKcQ==
X-Gm-Message-State: AD7BkJJb01lgkwspACeYG3iv3GSFH59C6wrV8JE8mMU7l+iMOAQMveXEqyRNT7rcd9lQNA==
X-Received: by 10.98.87.216 with SMTP id i85mr39695129pfj.72.1458061995544;
        Tue, 15 Mar 2016 10:13:15 -0700 (PDT)
Received: from localhost.localdomain ([1.39.36.65])
        by smtp.gmail.com with ESMTPSA id 9sm40988137pfm.10.2016.03.15.10.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 10:13:14 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1458061904-26516-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288885>

If rebase.autoStash configuration variable is set, there is no way to
override it for "git pull --rebase" from the command line.

Teach "git pull --rebase" the --[no-]autostash command line flag which
overrides the current value of rebase.autoStash, if set. As "git rebase"
understands the --[no-]autostash option, it's just a matter of passing
the option to underlying "git rebase" when "git pull --rebase" is called.

Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Paul Tan <pyokagan@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
previous patches: http://thread.gmane.org/gmane.comp.version-control.git/287709

 Documentation/git-pull.txt |  9 +++++++++
 builtin/pull.c             | 13 +++++++++++--
 t/t5520-pull.sh            | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a62a2a6..a070ec9 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -128,6 +128,15 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+--autostash::
+--no-autostash::
+	Before starting rebase, stash local modifications away (see
+	linkgit:git-stash.txt[1]) if needed, and apply the stash when
+	done (this option is only valid when "--rebase" is used).
++
+`--no-autostash` is useful to override the `rebase.autoStash`
+configuration variable (see linkgit:git-config[1]).
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 43353f9..c48e28a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,6 +86,7 @@ static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static int opt_autostash = -1;
 static int config_autostash;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
@@ -150,6 +151,8 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
+	OPT_BOOL(0, "autostash", &opt_autostash,
+		N_("automatically stash/stash pop before and after rebase")),
 	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
 		N_("merge strategy to use"),
 		0),
@@ -801,6 +804,7 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	argv_array_push(&args, opt_autostash ? "--autostash" : "--no-autostash");
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
@@ -851,12 +855,17 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		if (config_autostash)
+		if (opt_autostash == -1)
+			opt_autostash = config_autostash;
+
+		if (!opt_autostash)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
-	}
+	} else
+		if (opt_autostash != -1)
+			 die(_("--[no-]autostash option is only valid with --rebase."));
 
 	if (run_fetch(repo, refspecs))
 		return 1;
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c952d5e..85d9bea 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -255,6 +255,45 @@ test_expect_success 'pull --rebase succeeds with dirty working directory and reb
 	test "$(cat new_file)" = dirty &&
 	test "$(cat file)" = "modified again"
 '
+test_expect_success 'pull --rebase: --autostash overrides rebase.autostash' '
+	test_config rebase.autostash false &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase --autostash . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
+test_expect_success 'pull --rebase --autostash works with rebase.autostash set true' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase --autostash . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
+test_expect_success 'pull --rebase: --no-autostash overrides rebase.autostash' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
+
+test_expect_success 'pull --rebase --no-autostash works with rebase.autostash set false' '
+	test_config rebase.autostash false &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
 
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
-- 
2.7.1.340.g69eb491.dirty
