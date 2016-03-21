From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Tue, 22 Mar 2016 01:42:50 +0530
Message-ID: <1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
Cc: gitster@pobox.com, Matthieu.Moy@grenoble-inp.fr,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 21:13:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai6CU-0001oO-Ou
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757789AbcCUUNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:13:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34812 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746AbcCUUNN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:13:13 -0400
Received: by mail-pf0-f196.google.com with SMTP id n5so31904788pfn.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=azNolrQm6J3ax6NzIEe2ieOM+WlAyj2ZDeGdNqm2ngE=;
        b=AbhBR6auYZJH2WU9C2RgpQ6vPKRPcHBREw+lGrB9P3Ub7lYyoKYZbRJSB6OjE4aqKe
         vtasqC7PbrbQFKOfgs/nX7rqbrI5VJxVaJwb1cEo577iuit0VpsVXd6PRYmRanW7Q4oL
         qBl1gJMFbc+9PvOWWFUH90hrW6giMl0csQlugNBA6ahwCAeT9tTos8rnkdktoGgasLXa
         gyCy4P46Qq6oawSPiBEX1p9u0+cYV1wX7DGOl4saWh26LI4y8izmPtUbaiNIkh35b1+l
         kcAVmJiQ8GuOE2Os6EwpXrU+mzc4mIuzrpRonaDkgttrGEFLfBw8tiPt4ZrMTV47Cxwj
         R0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=azNolrQm6J3ax6NzIEe2ieOM+WlAyj2ZDeGdNqm2ngE=;
        b=ORUCZJYgIBmSfhGdwdJ1UCRrnh3Nw3eFuJg1PuiCqS9I/bL4cZLpr10Q/fL1zIn4GW
         0yzl2ybq/NZ2XdDbles0XA2m+Q6X+s75AW5ubf2N+8FO0cyx7jO37nbXaIUCiHKcJ01X
         fyTrP8h0HfMYk/Hdnm755uJpK8Y+BRCaB6SmIIOH+KoqaegSO/5L6tpzXyMbRCPiz6M1
         5q0/GoAjhQegxugEU8bZqsBfpRk/oQrZlLfem0HY6fXOl3YFz2jjyCn4wbGGrveey5xP
         UdcctBUjm0+cgWuwr8N71IYC9Y7+DQVzx+MAwx4vHZqj2KVXhmhVpkv16V30Bz/pwT9U
         kqqg==
X-Gm-Message-State: AD7BkJJ23wbGrImvYvgmoNAbcGh5JcY7PLt/9N132tOGOfd8WR0k+XnEKuqnB0suf2wUNQ==
X-Received: by 10.98.16.210 with SMTP id 79mr47936950pfq.69.1458591192354;
        Mon, 21 Mar 2016 13:13:12 -0700 (PDT)
Received: from localhost.localdomain ([1.39.38.167])
        by smtp.gmail.com with ESMTPSA id b11sm14550864pfj.4.2016.03.21.13.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 13:13:11 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289453>

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
 Documentation/git-pull.txt |  9 ++++++
 builtin/pull.c             | 12 ++++++++
 t/t5520-pull.sh            | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a62a2a6..3914507 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -128,6 +128,15 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+--autostash::
+--no-autostash::
+	Before starting rebase, stash local modifications away (see
+	linkgit:git-stash[1]) if needed, and apply the stash when
+	done. `--no-autostash` is useful to override the `rebase.autoStash`
+	configuration variable (see linkgit:git-config[1]).
++
+This option is only valid when "--rebase" is used.
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index c21897d..d98f481 100644
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
@@ -802,6 +805,10 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
+	if (opt_autostash == 0)
+		argv_array_push(&args, "--no-autostash");
+	else if (opt_autostash == 1)
+		argv_array_push(&args, "--autostash");
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
@@ -847,8 +854,13 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_sha1("HEAD", orig_head))
 		hashclr(orig_head);
 
+	if (!opt_rebase && opt_autostash != -1)
+		die(_("--[no-]autostash option is only valid with --rebase."));
+
 	if (opt_rebase) {
 		int autostash = config_autostash;
+		if (opt_autostash != -1)
+			autostash = opt_autostash;
 
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c952d5e..745e59e 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -256,6 +256,76 @@ test_expect_success 'pull --rebase succeeds with dirty working directory and reb
 	test "$(cat file)" = "modified again"
 '
 
+test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
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
+test_expect_success 'pull --rebase --autostash & rebase.autoStash=false' '
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
+test_expect_success 'pull --rebase: --autostash & rebase.autoStash unset' '
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase --autostash . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
+test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
+
+test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
+	test_config rebase.autostash false &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
+
+test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
+
+test_expect_success 'pull --autostash (without --rebase) should error out' '
+	test_must_fail git pull --autostash . copy 2>actual &&
+	echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
+	test_i18ncmp actual expect
+'
+
+test_expect_success 'pull --no-autostash (without --rebase) should error out' '
+	test_must_fail git pull --no-autostash . copy 2>actual &&
+	echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
+	test_i18ncmp actual expect
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.7.1.340.g69eb491.dirty
