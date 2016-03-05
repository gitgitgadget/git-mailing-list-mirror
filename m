From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v4] pull --rebase: add --[no-]autostash flag
Date: Sat,  5 Mar 2016 15:22:25 +0530
Message-ID: <1457171545-14496-1-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Cc: Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 10:53:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac8te-00017x-MI
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 10:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759389AbcCEJxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 04:53:03 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35731 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbcCEJw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 04:52:58 -0500
Received: by mail-pa0-f65.google.com with SMTP id fl4so4466210pad.2
        for <git@vger.kernel.org>; Sat, 05 Mar 2016 01:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kMXVrHpxO2D7GVDmTU4pfVKtFBLDhU1ZZEgIN8N/1Tc=;
        b=mgpOsdf8GyTJSy06I7P5R5Vewk2WsThIpsiGmpzBLSO35H02ArkqcM1fZLjoGfeguZ
         8d2DB2agN89+O4nbeL0z3adyJ05UL0a3bt38OopCFh40TSeomsScBG6IKngvRSkuuDAI
         egEXrBaz3N9Sj4EcufOoQ9W0rsxBv63aCW4ORDldlmk9j4UZ6rxW7A4lZcPTlOOuyvxO
         FDlqMiY+8qg1NhiWw10ctCc2pg6hXy8A9DdqQvnvmpNkcZusx/tvNcm3FyGhv3j2HzOG
         f9k4+uToOUujtAmOqpWyLgK5bkZVAcYXlemHlHZlooZh67BGTIIETAnWw6ZBaw+lBsvb
         6arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kMXVrHpxO2D7GVDmTU4pfVKtFBLDhU1ZZEgIN8N/1Tc=;
        b=ZPXn+1q89MWOiYrfZdbXEArG315ieVuDCTGdJ1ZL+4Hphu2W2IuVnlOoMDn34i9FuA
         qIJOjLPbex6GkXd3iUDdY9wfdcy8sdRVbNN8eEtwIRo49UOlpgYwYB3cQhStYoTtwOO/
         BpgJkFhHS6DqC4q/VCgsdT5QAmww0Kks36x3b6Gi3b+LlzzJh28IzJo9KPY3ogZT7yx0
         zyzrdmb3M65J10CbUHYqu2YxY22Isnb3OgKWcxHtOnLZIBtAkQyp99UVvWKxnNbYWQpd
         4ycJzhmOtdLmaxENxsMcYaZWSAXaP52ua/OxB/CMHe0AsvBi6HFZGTQDolg00oQzLP0k
         Ui+w==
X-Gm-Message-State: AD7BkJIfeaPWVS2icFejqxAdKROmk31foO2N7dRP6PUIPliDLJfwNvSgcSEoeHCuLHpc5g==
X-Received: by 10.66.144.134 with SMTP id sm6mr18896829pab.158.1457171578002;
        Sat, 05 Mar 2016 01:52:58 -0800 (PST)
Received: from localhost.localdomain ([1.39.39.70])
        by smtp.gmail.com with ESMTPSA id x1sm11194050pfi.42.2016.03.05.01.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Mar 2016 01:52:56 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288308>

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
	* --no-autostash is passed to git-rebase (suggested by Paul)
	
	* Error message changed when "git pull --[no-]autostash" is called.

	* If rebase.autoStash is unset and user don't pass --[no-]autostash
	  flag then nothing is passed to git-rebase (i.e. if rebase.autoStash = -1),
	  as it should be left to git-rebase to decide what to do.

 Documentation/git-pull.txt | 15 +++++++++++++++
 builtin/pull.c             | 18 ++++++++++++++----
 t/t5520-pull.sh            | 19 +++++++++++++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a62a2a6..06e5ddd 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -128,6 +128,21 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+--autostash::
+--no-autostash::
+	Before starting rebase, stash local modifications away (see
+	linkgit:git-stash.txt[1]) if needed, and apply the stash when
+	done.
++
+This option is only valid when '--rebase' is used.
++
+'--no-autostash' is useful to override the 'rebase.autoStash'
+configuration variable (see linkgit:git-config[1]).
++
+[NOTE]
+Use with care: the final stash application after a successful
+rebase might result in non-trivial conflicts.
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..e3f5fbf 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -85,6 +85,7 @@ static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
+static int opt_autostash = -1;
 static char *opt_verify_signatures;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
@@ -146,6 +147,8 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_BOOL(0, "autostash", &opt_autostash,
+		N_("automatically stash/stash pop before and after rebase")),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -789,6 +792,10 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	if (opt_autostash == 1)
+		argv_array_push(&args, "--autostash");
+	else if (opt_autostash == 0)
+		argv_array_push(&args, "--no-autostash");
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
@@ -835,17 +842,20 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		hashclr(orig_head);
 
 	if (opt_rebase) {
-		int autostash = 0;
-
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		git_config_get_bool("rebase.autostash", &autostash);
-		if (!autostash)
+		if (opt_autostash == -1)
+			git_config_get_bool("rebase.autostash", &opt_autostash);
+
+		if (opt_autostash == 0 || opt_autostash == -1)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
+	} else {
+		if (opt_autostash != -1)
+			die(_("--[no-]autostash option is only valid with --rebase."));
 	}
 
 	if (run_fetch(repo, refspecs))
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c952d5e..f5d1d31 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -245,6 +245,25 @@ test_expect_success '--rebase fails with multiple branches' '
 	test modified = "$(git show HEAD:file)"
 '
 
+test_expect_success 'pull --rebase --no-autostash fails with dirty working directory and rebase.autstash set true' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy
+'
+
+test_expect_success 'pull --rebase --autostash succeeds with dirty working directory and rebase.autstash set false' '
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
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
 	test_config rebase.autostash true &&
 	git reset --hard before-rebase &&
-- 
2.7.1.340.g69eb491.dirty
