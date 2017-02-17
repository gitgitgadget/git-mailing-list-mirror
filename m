Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED50020136
	for <e@80x24.org>; Fri, 17 Feb 2017 16:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934274AbdBQQ72 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 11:59:28 -0500
Received: from mout.gmx.net ([212.227.15.15]:60425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934087AbdBQQ70 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 11:59:26 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmKOI-1c59sR3Rg2-00ZvFe; Fri, 17
 Feb 2017 17:59:21 +0100
Date:   Fri, 17 Feb 2017 17:59:06 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3 2/2] rev-parse: fix several options when running in a
 subdirectory
In-Reply-To: <cover.1487350582.git.johannes.schindelin@gmx.de>
Message-ID: <e5fddea216960a53519ba152696d76f509c54bee.1487350582.git.johannes.schindelin@gmx.de>
References: <cover.1486740772.git.johannes.schindelin@gmx.de> <cover.1487350582.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u+NeiIyHllWQplV/RFiM8aB1VBe74dwQboot1WfjM10Dj38R0YJ
 77bvsLxOL8Khvb/FBADyfFi9D8Bv1V6m7gbgGuJjZn2T+gTtUzeq2H05T80+hftJ2L437gX
 VWyn/gsoAjQywGns4An6aGFFmwAICUP2brWzxMKGoh6PEcYqay1yIOPQyan/h4ECmbOgTy1
 bD3wms+6fVmPoqavE3mJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:13MbdyiqDeE=:2n8NxsNKBUwKs/9nphwA2Z
 +akR5LwB6mSf7tczRRo/oZhy6BUfjv52USfoSAGg+WvwLzs0E1P2yRow9AmmsJDAF2IRu55ru
 BgkTiR/9ctTS/HELq8szW3J6Qj/trof7WKhie2AYjqsP45NvtacL095jOqdO28OwL0rZ/YT/X
 5HuVsALE6fSYwLel3hZqpo4JW/nXn2Q/I9SDZsEsmJvGZu4XpfdSQmCPIL9JeK0RULhoECBYz
 mQuwM+5Xcz3PZp16AZrD181MWhx7caxuw2QDN+G0neQxbjRtgnhqBdFTBfhr4cZfEQSXqedhZ
 ufO9LWuFWkYddY25zv2syoAGsJprTy77r6opix4QmWESrVtFcly0/w82iONj5NWUSl2rLM+ss
 uKTh1OxGdpqTNRvkfwZQSrdY51Ct83iPrtTRje+XoMomEKaRfG3zVZytrBgxRXJX446aFeskk
 SxsTkrdOjpzU0WDa48/S7lpWn+dCXucNHQ8u2JQTXhdOpCsgPqdP9ZOfP3SxVDrhAgM8c02iX
 ZhOr4X4lwTI6YqjH90BDzDOYjou1SN0XQELyvBaK/ln4suHePogJUX/RU+HPk2N3XEPBPt/eu
 bt7kgNY9C6UAV/aQ8yFcDSFaUJ6jXtoSaViYrMlULpN0PVhy4C4aFc4Z4j2K0VLfXijYvPuCS
 WUggwDNrN1xcjp4R9S5n/hHUjtTx45HmySYb4Syk75KO2LUcAHRhomYK8cPWM3EW57KjC9Jlu
 EevEOwG91cFahygcYRW/4VJZOtwYDlsnk5IMaBdCb+2m635+1mPfGUa/Nc5ZCMQrvqc7hnHRV
 ouXiVMm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In addition to making git_path() aware of certain file names that need
to be handled differently e.g. when running in worktrees, the commit
557bd833bb (git_path(): be aware of file relocation in $GIT_DIR,
2014-11-30) also snuck in a new option for `git rev-parse`:
`--git-path`.

On the face of it, there is no obvious bug in that commit's diff: it
faithfully calls git_path() on the argument and prints it out, i.e. `git
rev-parse --git-path <filename>` has the same precise behavior as
calling `git_path("<filename>")` in C.

The problem lies deeper, much deeper. In hindsight (which is always
unfair), implementing the .git/ directory discovery in
`setup_git_directory()` by changing the working directory may have
allowed us to avoid passing around a struct that contains information
about the current repository, but it bought us many, many problems.

In this case, when being called in a subdirectory, `git rev-parse`
changes the working directory to the top-level directory before calling
`git_path()`. In the new working directory, the result is correct. But
in the working directory of the calling script, it is incorrect.

Example: when calling `git rev-parse --git-path HEAD` in, say, the
Documentation/ subdirectory of Git's own source code, the string
`.git/HEAD` is printed.

Side note: that bug is hidden when running in a subdirectory of a
worktree that was added by the `git worktree` command: in that case, the
(correct) absolute path of the `HEAD` file is printed.

In the interest of time, this patch does not go the "correct" route to
introduce a struct with repository information (and removing global
state in the process), instead this patch chooses to detect when the
command was called in a subdirectory and forces the result to be an
absolute path.

While at it, we are also fixing the output of --git-common-dir and
--shared-index-path.

Lastly, please note that we reuse the same strbuf for all of the
relative_path() calls; this avoids frequent allocation (and duplicated
code), and it does not risk memory leaks, for two reasons: 1) the
cmd_rev_parse() function does not return anywhere between the use of
the new strbuf instance and its final release, and 2) git-rev-parse is
one of these "one-shot" programs in Git, i.e. it exits after running
for a very short time, meaning that all allocated memory is released
with the exit() call anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rev-parse.c      | 15 +++++++++++----
 t/t1500-rev-parse.sh     |  4 ++--
 t/t1700-split-index.sh   |  2 +-
 t/t2027-worktree-list.sh |  4 ++--
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ff13e59e1db..2cfd8d2aae4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -545,6 +545,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	unsigned int flags = 0;
 	const char *name = NULL;
 	struct object_context unused;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
@@ -599,7 +600,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--git-path")) {
 			if (!argv[i + 1])
 				die("--git-path requires an argument");
-			puts(git_path("%s", argv[i + 1]));
+			strbuf_reset(&buf);
+			puts(relative_path(git_path("%s", argv[i + 1]),
+					   prefix, &buf));
 			i++;
 			continue;
 		}
@@ -821,8 +824,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				const char *pfx = prefix ? prefix : "";
-				puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
+				strbuf_reset(&buf);
+				puts(relative_path(get_git_common_dir(),
+						   prefix, &buf));
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
@@ -845,7 +849,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					die(_("Could not read the index"));
 				if (the_index.split_index) {
 					const unsigned char *sha1 = the_index.split_index->base_sha1;
-					puts(git_path("sharedindex.%s", sha1_to_hex(sha1)));
+					const char *path = git_path("sharedindex.%s", sha1_to_hex(sha1));
+					strbuf_reset(&buf);
+					puts(relative_path(path, prefix, &buf));
 				}
 				continue;
 			}
@@ -897,6 +903,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			continue;
 		verify_filename(prefix, arg, 1);
 	}
+	strbuf_release(&buf);
 	if (verify) {
 		if (revs_count == 1) {
 			show_rev(type, sha1, name);
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index f39f783f2db..d74f09ad93e 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -93,7 +93,7 @@ test_expect_success 'git-common-dir from worktree root' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git-common-dir inside sub-dir' '
+test_expect_success 'git-common-dir inside sub-dir' '
 	mkdir -p path/to/child &&
 	test_when_finished "rm -rf path" &&
 	echo "$(git -C path/to/child rev-parse --show-cdup).git" >expect &&
@@ -107,7 +107,7 @@ test_expect_success 'git-path from worktree root' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git-path inside sub-dir' '
+test_expect_success 'git-path inside sub-dir' '
 	mkdir -p path/to/child &&
 	test_when_finished "rm -rf path" &&
 	echo "$(git -C path/to/child rev-parse --show-cdup).git/objects" >expect &&
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index b754865a618..6096f2c6309 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -200,7 +200,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure 'rev-parse --shared-index-path' '
+test_expect_success 'rev-parse --shared-index-path' '
 	test_create_repo split-index &&
 	(
 		cd split-index &&
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index c1a072348e7..848da5f3684 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -8,7 +8,7 @@ test_expect_success 'setup' '
 	test_commit init
 '
 
-test_expect_failure 'rev-parse --git-common-dir on main worktree' '
+test_expect_success 'rev-parse --git-common-dir on main worktree' '
 	git rev-parse --git-common-dir >actual &&
 	echo .git >expected &&
 	test_cmp expected actual &&
@@ -18,7 +18,7 @@ test_expect_failure 'rev-parse --git-common-dir on main worktree' '
 	test_cmp expected2 actual2
 '
 
-test_expect_failure 'rev-parse --git-path objects linked worktree' '
+test_expect_success 'rev-parse --git-path objects linked worktree' '
 	echo "$(git rev-parse --show-toplevel)/.git/objects" >expect &&
 	test_when_finished "rm -rf linked-tree && git worktree prune" &&
 	git worktree add --detach linked-tree master &&
-- 
2.11.1.windows.1.2.g87ad093.dirty
