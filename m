Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEC4A1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 22:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfHEWnv (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 18:43:51 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42947 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHEWnv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 18:43:51 -0400
Received: by mail-pf1-f202.google.com with SMTP id 21so54439075pfu.9
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=804btAKQYijpGXbztWgXaMENWnVIMZchvAbFQB6y/yE=;
        b=GvkQuvX6HY3s+3Q2pUm5av/5ogxciZEWvLpTeVACvvOoR/i0ljfMIh430hJUUAH18y
         B3zEVG/VlFjGCiK9XBdW01buAwHCqem9M+CYo53HccCAn1wX6rmYf3X/isGguM6tYFnG
         q8bXMdDYVqYgGvfRrTzgK4F2h5FsOLIdtcpWxz9grdiVu6tQYheh2dEUYAcwcAnFXJix
         y/Uk28IfpkGe5xUi3+rYlZZpp2W/FHkmZ5jb7v6lo+WEtBJBJOX2/gmSbaxo7cgxdvAE
         PDJWqSeU88Go5+8aV2tZGDL3cOFfUt6ItELCg5CKNf9b6sB9/gpQSKd/CLwntLz/fXQZ
         8iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=804btAKQYijpGXbztWgXaMENWnVIMZchvAbFQB6y/yE=;
        b=m7fR1wqEQDXlk4XdkBZ15miR7JRobVea5meV4gDikUxM7rept+sukHCin4OFI3/zlO
         D3NTnpgRbE8UFZ6zy3nb91lWEF4MbuWTEb0lpNjJgDprmoV4SG6jifKP3r4QEaExOI+c
         nf421BLFM50FPJADjprLwBw0pfAirfvJsR6EPkyNY3YZRzv/baGxyhqaIJ6ZaERxz2cd
         ptsPGwFyJszc0ZjbksetJs8E+IDa0V9uhX3GINAtNkzwyXTTtLwvWYxaOOwMY4UdKRYL
         /nplOqXPJS0/1H6ozVpPcmNrFgGwJzQWclReQDW4DDX0atDeZIWezMB2hj5zlT4Sql6k
         Qphg==
X-Gm-Message-State: APjAAAUEQQXBxjIAggAlTVRc4THA12PokEzvGwiZ/TFNCr5Drg8r5rFg
        i+1D2MAwb2xIFV+6SDUwYcYwK/zP8+vZgXjoeb7AvZzpiA5y52egFXItQ3no3/c5sun/eROPzoI
        zTlZKGs7vKaqXadpnG3aL2BltUU423m6yvnO90iTs/ZIsfhWfNeVORCRvjk5uRiM=
X-Google-Smtp-Source: APXvYqx7ya5PciAsLjrorE3NmtA+AzNgGi3qKSZ+SXUwrmvIG2bDOplrdzwB829yV2v6f2CaEXyLwPoqrbCMxw==
X-Received: by 2002:a63:6d8d:: with SMTP id i135mr156786pgc.303.1565045029816;
 Mon, 05 Aug 2019 15:43:49 -0700 (PDT)
Date:   Mon,  5 Aug 2019 15:43:38 -0700
In-Reply-To: <cover.1565044345.git.steadmon@google.com>
Message-Id: <9210421fbb74c43a8b5e48478229a77ddd50ed3e.1565044345.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1564695892.git.steadmon@google.com> <cover.1565044345.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v4 3/4] git-merge: honor pre-merge-commit hook
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael J Gruber <git@drmicha.warpmail.net>

git-merge does not honor the pre-commit hook when doing automatic merge
commits, and for compatibility reasons this is going to stay.

Introduce a pre-merge-commit hook which is called for an automatic merge
commit just like pre-commit is called for a non-automatic merge commit
(or any other commit).

[js: * renamed hook from "pre-merge" to "pre-merge-commit"
     * only discard the index if the hook is actually present
     * expanded githooks documentation entry
     * clarified that hook should write messages to stderr
     * squashed test changes from the original series' patch 4/4
     * modified tests to follow new pattern from this series' patch 1/4
     * added a test case for non-executable merge hooks
     * added a test case for failed merges
     * when testing that the merge hook did not run, make sure we
       actually have a merge to perform (by resetting the "side" branch
       to its original state).
     * reworded commit message
]

Improved-by: Martin =C3=85gren <martin.agren@gmail.com>
Signed-off-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/githooks.txt                    | 21 +++++
 builtin/merge.c                               | 12 +++
 ...-pre-commit-and-pre-merge-commit-hooks.sh} | 84 ++++++++++++++++++-
 templates/hooks--pre-merge-commit.sample      | 13 +++
 4 files changed, 129 insertions(+), 1 deletion(-)
 rename t/{t7503-pre-commit-hook.sh =3D> t7503-pre-commit-and-pre-merge-com=
mit-hooks.sh} (63%)
 create mode 100755 templates/hooks--pre-merge-commit.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 82cd573776..d9da474fb0 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -103,6 +103,27 @@ The default 'pre-commit' hook, when enabled--and with =
the
 `hooks.allownonascii` config option unset or set to false--prevents
 the use of non-ASCII filenames.
=20
+pre-merge-commit
+~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-merge[1]. It takes no parameters, and =
is
+invoked after the merge has been carried out successfully and before
+obtaining the proposed commit log message to
+make a commit.  Exiting with a non-zero status from this script
+causes the `git merge` command to abort before creating a commit.
+
+The default 'pre-merge-commit' hook, when enabled, runs the
+'pre-commit' hook, if the latter is enabled.
+
+This hook is invoked with the environment variable
+`GIT_EDITOR=3D:` if the command will not bring up an editor
+to modify the commit message.
+
+If the merge cannot be carried out automatically, the conflicts
+need to be resolved and the result committed separately (see
+linkgit:git-merge[1]). At that point, this hook will not be executed,
+but the 'pre-commit' hook will, if it is enabled.
+
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
=20
diff --git a/builtin/merge.c b/builtin/merge.c
index 4425a7a12e..bf0ae68c40 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -816,6 +816,18 @@ static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg =3D STRBUF_INIT;
+	const char *index_file =3D get_index_file();
+
+	if (run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL=
))
+		abort_commit(remoteheads, NULL);
+	/*
+	 * Re-read the index as pre-merge-commit hook could have updated it,
+	 * and write it out as a tree.  We must do this before we invoke
+	 * the editor and after we invoke run_status above.
+	 */
+	if (find_hook("pre-merge-commit"))
+		discard_cache();
+	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
 	if (squash)
 		BUG("the control must not reach here under --squash");
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-and-pre-merge-=
commit-hooks.sh
similarity index 63%
rename from t/t7503-pre-commit-hook.sh
rename to t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index a71ec31222..0700604f03 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -1,11 +1,12 @@
 #!/bin/sh
=20
-test_description=3D'pre-commit hook'
+test_description=3D'pre-commit and pre-merge-commit hooks'
=20
 . ./test-lib.sh
=20
 HOOKDIR=3D"$(git rev-parse --git-dir)/hooks"
 PRECOMMIT=3D"$HOOKDIR/pre-commit"
+PREMERGE=3D"$HOOKDIR/pre-merge-commit"
=20
 # Prepare sample scripts that write their $0 to actual_hooks
 test_expect_success 'sample script setup' '
@@ -34,6 +35,30 @@ test_expect_success 'sample script setup' '
 	EOF
 '
=20
+test_expect_success 'root commit' '
+	echo "root" >file &&
+	git add file &&
+	git commit -m "zeroth" &&
+	git checkout -b side &&
+	echo "foo" >foo &&
+	git add foo &&
+	git commit -m "make it non-ff" &&
+	git branch side-orig side &&
+	git checkout master
+'
+
+test_expect_success 'setup conflicting branches' '
+	test_when_finished "git checkout master" &&
+	git checkout -b conflicting-a master &&
+	echo a >conflicting &&
+	git add conflicting &&
+	git commit -m conflicting-a &&
+	git checkout -b conflicting-b master &&
+	echo b >conflicting &&
+	git add conflicting &&
+	git commit -m conflicting-b
+'
+
 test_expect_success 'with no hook' '
 	test_when_finished "rm -f actual_hooks" &&
 	echo "foo" >file &&
@@ -42,6 +67,15 @@ test_expect_success 'with no hook' '
 	test_path_is_missing actual_hooks
 '
=20
+test_expect_success 'with no hook (merge)' '
+	test_when_finished "rm -f actual_hooks" &&
+	git branch -f side side-orig &&
+	git checkout side &&
+	git merge -m "merge master" master &&
+	git checkout master &&
+	test_path_is_missing actual_hooks
+'
+
 test_expect_success '--no-verify with no hook' '
 	test_when_finished "rm -f actual_hooks" &&
 	echo "bar" >file &&
@@ -60,6 +94,34 @@ test_expect_success 'with succeeding hook' '
 	test_cmp expected_hooks actual_hooks
 '
=20
+test_expect_success 'with succeeding hook (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
+	ln -s "success.sample" "$PREMERGE" &&
+	echo "$PREMERGE" >expected_hooks &&
+	git checkout side &&
+	git merge -m "merge master" master &&
+	git checkout master &&
+	test_cmp expected_hooks actual_hooks
+'
+
+test_expect_success 'automatic merge fails; both hooks are available' '
+	test_when_finished "rm -f \"$PREMERGE\" \"$PRECOMMIT\"" &&
+	test_when_finished "rm -f expected_hooks actual_hooks" &&
+	test_when_finished "git checkout master" &&
+	ln -s "success.sample" "$PREMERGE" &&
+	ln -s "success.sample" "$PRECOMMIT" &&
+
+	git checkout conflicting-a &&
+	test_must_fail git merge -m "merge conflicting-b" conflicting-b &&
+	test_path_is_missing actual_hooks &&
+
+	echo "$PRECOMMIT" >expected_hooks &&
+	echo a+b >conflicting &&
+	git add conflicting &&
+	git commit -m "resolve conflict" &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success '--no-verify with succeeding hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
 	ln -s "success.sample" "$PRECOMMIT" &&
@@ -88,6 +150,16 @@ test_expect_success '--no-verify with failing hook' '
 	test_path_is_missing actual_hooks
 '
=20
+test_expect_success 'with failing hook (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
+	ln -s "fail.sample" "$PREMERGE" &&
+	echo "$PREMERGE" >expected_hooks &&
+	git checkout side &&
+	test_must_fail git merge -m "merge master" master &&
+	git checkout master &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success POSIXPERM 'with non-executable hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
 	ln -s "non-exec.sample" "$PRECOMMIT" &&
@@ -106,6 +178,16 @@ test_expect_success POSIXPERM '--no-verify with non-ex=
ecutable hook' '
 	test_path_is_missing actual_hooks
 '
=20
+test_expect_success POSIXPERM 'with non-executable hook (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
+	ln -s "non-exec.sample" "$PREMERGE" &&
+	git branch -f side side-orig &&
+	git checkout side &&
+	git merge -m "merge master" master &&
+	git checkout master &&
+	test_path_is_missing actual_hooks
+'
+
 test_expect_success 'with hook requiring GIT_PREFIX' '
 	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks suc=
cess" &&
 	ln -s "require-prefix.sample" "$PRECOMMIT" &&
diff --git a/templates/hooks--pre-merge-commit.sample b/templates/hooks--pr=
e-merge-commit.sample
new file mode 100755
index 0000000000..399eab1924
--- /dev/null
+++ b/templates/hooks--pre-merge-commit.sample
@@ -0,0 +1,13 @@
+#!/bin/sh
+#
+# An example hook script to verify what is about to be committed.
+# Called by "git merge" with no arguments.  The hook should
+# exit with non-zero status after issuing an appropriate message to
+# stderr if it wants to stop the merge commit.
+#
+# To enable this hook, rename this file to "pre-merge-commit".
+
+. git-sh-setup
+test -x "$GIT_DIR/hooks/pre-commit" &&
+        exec "$GIT_DIR/hooks/pre-commit"
+:
--=20
2.22.0.770.g0f2c4a37fd-goog

