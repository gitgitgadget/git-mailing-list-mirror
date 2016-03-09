From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v7 2/2] pull --rebase: add --[no-]autostash flag
Date: Wed,  9 Mar 2016 09:48:20 +0530
Message-ID: <1457497100-13045-2-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
 <1457497100-13045-1-git-send-email-mehul.jain2029@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 05:18:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adVaM-0006TY-CR
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 05:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbcCIESy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 23:18:54 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35378 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcCIESx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 23:18:53 -0500
Received: by mail-pf0-f193.google.com with SMTP id x188so2585005pfb.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 20:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NUij2PUZ7VnNAjJiBF8qjNY7Weor7A/7+nQ3tys8nQ=;
        b=bHvBHrF8A5eWVhPL1CJoLr912WUrdwmEA8ZbjNe/TAVzuq/rwFij3uI1VcCmcHzYEL
         zY1IpiWzE9iMhxT6vx4PAj4138x6vRCwIa4gSWw2ou5/IlUa46ncdCSQ/InAYzYGyh3A
         KrO3VYs8k95CKy+9YI0XnPREHa7n/sxrInkMMek1dRFb0L+w0vZJj6Rm6L6Vj9ofTsXC
         grDjQxA5b2oHoGaey7Ized8Ai3p1degI8j9Nfm+EbzvNgB/6i23qpxEm4Xi4xKP+7fMY
         hiYBrVEwmNzOE70VOsPod8Z4KyI38+6Ga/YfzOE2wlMnjbWVqU89yrtFi9EBS52+Pgpd
         0amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NUij2PUZ7VnNAjJiBF8qjNY7Weor7A/7+nQ3tys8nQ=;
        b=P8Gzdg+2dtyU9Ms4Z3Q34qB08z0GiYBt1ACzrC5NIEq7Im1yPWBmtLsSUtcgjT/b+q
         wUbao+LJSJYpicoakv8yAQORHOaTWYRFxvs8pd4pnHaWmYyB+EFsEI9daAET+nank4uO
         PgEYdLMYtlw44fGUt3838Kw65JCzCuUm+yiiUBcKfF76fny9WwO5Mbq9bkkyln0k7m0f
         1ZjrDNoGlo9wtgmJRmm/JkzBWDG0dp6CyjK4A7qa9D92CliwMgUW3CSmPcOGNOSDKGMU
         VvzmyiZjDMWSHtWJ6s4IBhFzrSK8gx1qbKnZkhido9xNGDnc7krKvpeX2RJHQaVEJicH
         NOuw==
X-Gm-Message-State: AD7BkJKtVxDxZ2FmaF/tNZNBODM1O1/VkCv1Utol+hpSfXWlyF4CK5HKui4J1Tf/qv2Q6g==
X-Received: by 10.98.67.139 with SMTP id l11mr33855338pfi.112.1457497132339;
        Tue, 08 Mar 2016 20:18:52 -0800 (PST)
Received: from localhost.localdomain ([1.39.36.88])
        by smtp.gmail.com with ESMTPSA id s21sm8291548pfi.29.2016.03.08.20.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Mar 2016 20:18:51 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1457497100-13045-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288474>

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
Previous patches: $gname287709

Changes:
	- Slight change is documentation.

 Documentation/git-pull.txt |  9 +++++++++
 builtin/pull.c             | 16 ++++++++++++++--
 t/t5520-pull.sh            | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a62a2a6..da89be6 100644
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
index 8a318e9..a01058a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,6 +86,7 @@ static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static int opt_autostash = -1;
 static int config_autostash = -1;
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
@@ -801,6 +804,10 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	if (opt_autostash == 1)
+		argv_array_push(&args, "--autostash");
+	else if (opt_autostash == 0)
+		argv_array_push(&args, "--no-autostash");
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
@@ -851,12 +858,17 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		if (config_autostash != 1)
+		if (opt_autostash == -1)
+			opt_autostash = config_autostash;
+
+		if (opt_autostash != 1)
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
