From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/3] pull: allow interactive rebase with
 --rebase=interactive
Date: Wed, 13 Jan 2016 13:17:15 +0100 (CET)
Message-ID: <a8e173aeb747369f554eeede1955060deadd3550.1452687410.git.johannes.schindelin@gmx.de>
References: <cover.1452668201.git.johannes.schindelin@gmx.de> <cover.1452687410.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:17:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJKMq-00021l-I4
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 13:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbcAMMR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 07:17:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:63908 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbcAMMR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 07:17:28 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LomuB-1Zhp1E3AdP-00gp86; Wed, 13 Jan 2016 13:17:15
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452687410.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:yOEZegk8Vj0/afiIhkUkY424vOMkwR+2ZjBw1Z6O3mlv9PM/NjD
 AEFO/ttU2I5nTwAyhwhmM8Y46AMUqX26cSe7qWlvdArSLfQOobqXWWWrEjJw0POrrQgNP/0
 3HGKQtfjCMlXwi3Egb8Dh4Ysa5rkxtXiyihqbuoDLqM4xE9X9KknCmKpzlDnPR0vOPoJ2CV
 4I5A1q4j+t7xX0e/pIODQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6wuL0gzi/bQ=:9EDvl+Ida2bnaCQmr5QFLJ
 yIm6GGCdm6MC/7nir9AUukBQVv2ZDTw2JdFH5tlkEzwv4jdjpLuUjEns0NNyODJwrdSAyry/7
 Ji8Z/XcqtcVpxXaRNEnlQ5jjABzxJ12fgzUoJRbyL+02miR4WSSBXi2Omw3UdcbEemN81S+Oz
 widYkShXdXWQ6XxVbbfOkzU/58Iuvnhz8r695j1XTqqHFh//bm+1VDv9fL3eo8cTumeCMj5cj
 vVJyiiMLohESSm16cOlGz8IQrO5LWoqaLAtiCbelz0naagPU/Wn3hxqhcQLnC0PFzMcgSbOyZ
 lMDpPNN6udFCDE39WB7j7BB5rP8lfxsFp3xyCoDXMFaZdF+dmvvsc/keMOLnQETtKDSEq/S4+
 X95AGUUEJkZKX589isr9l1IVFXVDaxnLTp7nNjvTgFmxoTgSQG+jZSBTw7pvCXPbbszc9VE41
 rVk0cdlJ/5nSiCy5MjEbSxWByPeXehZ4/frL1ZSIogG7Ak81hFd3ZoX8jLpCg6zgY0Gxjg3WV
 gdqdAfKws41yzMpu1axijoxD6lp19IFDR38+5QKrdBEOhjNu7yqu8aZjy2MKlVtt4X0btra4J
 1ppc2xia9oEsoIlC9OTkKdLGICG/CMKFGVz6cMrHVKAf+RVUk/MR+XG40WlduRH0NbsIG58s9
 XbCmfzEI0ui2o1G9hPY2xuTekNBdbPpUMUXdmV5n+yvM+MbXJ7bwVpGQFaeDta/LYEIrLU9A0
 +UuXu2zi4FEX+0LcTap8yXmwdsfl/n2Pevxzy5bJAa4r2fcWgVRisXiXh9WiXsGrqqAn+6R3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283907>

The way builtin pull works, this change also supports the value
'interactive' for the 'branch.<name>.rebase' config variable, which
is a neat thing because users can now configure given branches for
interactively-rebasing pulls without having to type out the complete
`--rebase=interactive` option every time they pull.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt   |  4 ++++
 Documentation/git-pull.txt |  4 +++-
 builtin/pull.c             |  9 +++++++--
 t/t5520-pull.sh            | 10 ++++++++++
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 07f7a3b..0f710ca 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -870,6 +870,8 @@ When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
 +
+When the value is `interactive`, the rebase is run in interactive mode.
++
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
@@ -2157,6 +2159,8 @@ When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
 +
+When the value is `interactive`, the rebase is run in interactive mode.
++
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 93c72a2..a62a2a6 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -101,7 +101,7 @@ Options related to merging
 include::merge-options.txt[]
 
 -r::
---rebase[=false|true|preserve]::
+--rebase[=false|true|preserve|interactive]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
@@ -113,6 +113,8 @@ to `git rebase` so that locally created merge commits will not be flattened.
 +
 When false, merge the current branch into the upstream branch.
 +
+When `interactive`, enable the interactive mode of rebase.
++
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
 `--rebase` instead of merging.
diff --git a/builtin/pull.c b/builtin/pull.c
index 9e3c738..c713fe0 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -22,7 +22,8 @@ enum rebase_type {
 	REBASE_INVALID = -1,
 	REBASE_FALSE = 0,
 	REBASE_TRUE,
-	REBASE_PRESERVE
+	REBASE_PRESERVE,
+	REBASE_INTERACTIVE
 };
 
 /**
@@ -42,6 +43,8 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		return REBASE_TRUE;
 	else if (!strcmp(value, "preserve"))
 		return REBASE_PRESERVE;
+	else if (!strcmp(value, "interactive"))
+		return REBASE_INTERACTIVE;
 
 	if (fatal)
 		die(_("Invalid value for %s: %s"), key, value);
@@ -113,7 +116,7 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
-	  "false|true|preserve",
+	  "false|true|preserve|interactive",
 	  N_("incorporate changes by rebasing rather than merging"),
 	  PARSE_OPT_OPTARG, parse_opt_rebase },
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
@@ -778,6 +781,8 @@ static int run_rebase(const unsigned char *curr_head,
 	/* Options passed to git-rebase */
 	if (opt_rebase == REBASE_PRESERVE)
 		argv_array_push(&args, "--preserve-merges");
+	else if (opt_rebase == REBASE_INTERACTIVE)
+		argv_array_push(&args, "--interactive");
 	if (opt_diffstat)
 		argv_array_push(&args, opt_diffstat);
 	argv_array_pushv(&args, opt_strategies.argv);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a0013ee..c952d5e 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -326,6 +326,16 @@ test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
 	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
 '
 
+test_expect_success 'pull.rebase=interactive' '
+	write_script "$TRASH_DIRECTORY/fake-editor" <<-\EOF &&
+	echo I was here >fake.out &&
+	false
+	EOF
+	test_set_editor "$TRASH_DIRECTORY/fake-editor" &&
+	test_must_fail git pull --rebase=interactive . copy &&
+	test "I was here" = "$(cat fake.out)"
+'
+
 test_expect_success 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
-- 
2.6.3.windows.1.300.g1c25e49
