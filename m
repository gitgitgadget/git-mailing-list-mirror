Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD56C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 04:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA58220732
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 04:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W96kqvVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgC3EG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 00:06:27 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:42185 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3EG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 00:06:27 -0400
Received: by mail-ua1-f73.google.com with SMTP id x22so7265937ual.9
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 21:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=dur5fMHifWoLG3xFe0mN9BjCYDsQhLgci5WdrLSINlY=;
        b=W96kqvVHP0QPskn+Yo+UYoS6UsNxh/XvFZUbcf0wWpK1xl7YkjwKcjo+U+lNtSm2TC
         IxALqgzhMbuh8EpGFlBpQ46tK0bu14IFBQDB1GJO/zo+ZMORjB+LW5yBZz+OWeoLBjXk
         fq9S1j7m6ro7mLaSoQN2xYoBGaTcIvwAYOFaRuMG/kwD59T0hpFR4/uL1U3MZHCxBTTS
         w+p9WF8277wM8fG4vEjboY808QHn/7J496aCNOHi6waG4msj7gqhkGgLSp9QT516Axws
         0qRqM2OLwVtp3pvAZROLNiZk0d9vC3XEPlRU+bC4EzqTbK5cTcMR0K86m1gxjKlijylm
         3ptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=dur5fMHifWoLG3xFe0mN9BjCYDsQhLgci5WdrLSINlY=;
        b=C9ytJrx92vwV8CKh0StL8fpBYaJpzMTMrF4Xy3QnvdQE6iQ+OOiPX5mrNwmr1/QL6E
         Xxg4R8L2vGUUneWsFjyl6weG2uPwcmKj93OPch6vHwo1BRF1uf4rNxaw2LgRKbNzjK2P
         S02IdTuAW6s2CRhOWQjlY0yKps7To/gX/s7NDClXsi6E64G065jAKRedIia2jIenR5EY
         2diF6RX0dLh4+EmmeuZMUJGUEx2N37DZhdmfncFlaLRCsMEoOReyEHdUOoeH1DIGErwO
         pJQBkXf0OQ28jQlnRT083A2t1vnBn8LE/D6BpZFSBIViD5pJ5HFLABFc66598LPaNNsN
         iy5A==
X-Gm-Message-State: AGi0PuZ3j2slGgbotbNkPEawBIzSzb3g8TrM+uTjzCKOSwqHqZo+Th/i
        runHmA+Lmh5385l+ZGP7cZsBmwlaegi9lo8R1hqk9YbkNXBx17bgZCs3XBUVFChwKbS+uHm0DJW
        exAqVAQaIZVGB8vVj4+Pb+TDvmMTiCaVVpjI7TKIt1QY8inVeP0m111eioLoQm4LQ4gOOPSAuSp
        Wh
X-Google-Smtp-Source: APiQypJyIt0gX9VQhOQ7ws3lesg8XiH4uhJtemacXtgj/eXkFwK01rBCmcGvVa6pNOx36f86eYTbk8VHTfxJvGdggiwR
X-Received: by 2002:ab0:1158:: with SMTP id g24mr5960065uac.55.1585541185063;
 Sun, 29 Mar 2020 21:06:25 -0700 (PDT)
Date:   Sun, 29 Mar 2020 21:06:21 -0700
In-Reply-To: <20200309205523.121319-1-jonathantanmy@google.com>
Message-Id: <20200330040621.13701-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200309205523.121319-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, congdanhqx@gmail.com,
        newren@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebasing against an upstream that has had many commits since the
original branch was created:

 O -- O -- ... -- O -- O (upstream)
  \
   -- O (my-dev-branch)

it must read the contents of every novel upstream commit, in addition to
the tip of the upstream and the merge base, because "git rebase"
attempts to exclude commits that are duplicates of upstream ones. This
can be a significant performance hit, especially in a partial clone,
wherein a read of an object may end up being a fetch.

Add a flag to "git rebase" to allow suppression of this feature. This
flag only works when using the "merge" backend.

This flag changes the behavior of sequencer_make_script(), called from
do_interactive_rebase() <- run_rebase_interactive() <-
run_specific_rebase() <- cmd_rebase(). With this flag, limit_list()
(indirectly called from sequencer_make_script() through
prepare_revision_walk()) will no longer call cherry_pick_list(), and
thus PATCHSAME is no longer set. Refraining from setting PATCHSAME both
means that the intermediate commits in upstream are no longer read (as
shown by the test) and means that no PATCHSAME-caused skipping of
commits is done by sequencer_make_script(), either directly or through
make_script_with_merges().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
This commit contains Junio's sign-off because I based it on
jt/rebase-allow-duplicate.

This does not include the fix by =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh=
. If we want all
commits to pass all tests (whether run by Busybox or not) it seems like
we should squash that patch instead of having it as a separate commit.
If we do squash, maybe include a "Helped-by" with =C4=90o=C3=A0n Tr=E1=BA=
=A7n C=C3=B4ng Danh's
name.

Junio wrote [1]:

> Sounds much better to me.  I do not mind --[no-]keep-cherry-pick,
> either, by the way.  I know I raised the possibility of having to
> make it non-bool later, but since then I haven't thought of a good
> third option myself anyway, so...

In that case, I think it's better to stick to bool. This also means that
the change from the version in jt/rebase-allow-duplicate is very small,
hopefully aiding reviewers - mostly a replacement of
--skip-cherry-pick-detection with --keep-cherry-pick (which mean the
same thing).

[1] https://lore.kernel.org/git/xmqq4kuakjcn.fsf@gitster.c.googlers.com/
---
 Documentation/git-rebase.txt | 21 +++++++++-
 builtin/rebase.c             |  7 ++++
 sequencer.c                  |  3 +-
 sequencer.h                  |  2 +-
 t/t3402-rebase-merge.sh      | 77 ++++++++++++++++++++++++++++++++++++
 5 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0c4f038dd6..f4f8afeb9a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -318,6 +318,21 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
=20
+--keep-cherry-pick::
+--no-keep-cherry-pick::
+	Control rebase's behavior towards commits in the working
+	branch that are already present upstream, i.e. cherry-picks.
++
+By default, these commits will be dropped. Because this necessitates
+reading all upstream commits, this can be expensive in repos with a
+large number of upstream commits that need to be read.
++
+If `--keep-cherry-pick is given`, all commits (including these) will be
+re-applied. This allows rebase to forgo reading all upstream commits,
+potentially improving performance.
++
+See also INCOMPATIBLE OPTIONS below.
+
 --rerere-autoupdate::
 --no-rerere-autoupdate::
 	Allow the rerere mechanism to update the index with the
@@ -568,6 +583,9 @@ In addition, the following pairs of options are incompa=
tible:
  * --keep-base and --onto
  * --keep-base and --root
=20
+Also, the --keep-cherry-pick option requires the use of the merge backend
+(e.g., through --merge).
+
 BEHAVIORAL DIFFERENCES
 -----------------------
=20
@@ -866,7 +884,8 @@ Only works if the changes (patch IDs based on the diff =
contents) on
 'subsystem' did.
=20
 In that case, the fix is easy because 'git rebase' knows to skip
-changes that are already present in the new upstream.  So if you say
+changes that are already present in the new upstream (unless
+`--keep-cherry-pick` is given). So if you say
 (assuming you're on 'topic')
 ------------
     $ git rebase subsystem
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8081741f8a..626549b0b2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -88,6 +88,7 @@ struct rebase_options {
 	struct strbuf git_format_patch_opt;
 	int reschedule_failed_exec;
 	int use_legacy_rebase;
+	int keep_cherry_pick;
 };
=20
 #define REBASE_OPTIONS_INIT {			  	\
@@ -381,6 +382,7 @@ static int run_rebase_interactive(struct rebase_options=
 *opts,
 	flags |=3D opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |=3D opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
 	flags |=3D command =3D=3D ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0=
;
+	flags |=3D opts->keep_cherry_pick ? TODO_LIST_KEEP_CHERRY_PICK : 0;
=20
 	switch (command) {
 	case ACTION_NONE: {
@@ -1515,6 +1517,8 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 		OPT_BOOL(0, "reschedule-failed-exec",
 			 &reschedule_failed_exec,
 			 N_("automatically re-schedule any `exec` that fails")),
+		OPT_BOOL(0, "keep-cherry-pick", &options.keep_cherry_pick,
+			 N_("apply all changes, even those already present upstream")),
 		OPT_END(),
 	};
 	int i;
@@ -1848,6 +1852,9 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 			      "interactive or merge options"));
 	}
=20
+	if (options.keep_cherry_pick && !is_interactive(&options))
+		die(_("--keep-cherry-pick does not work with the 'apply' backend"));
+
 	if (options.signoff) {
 		if (options.type =3D=3D REBASE_PRESERVE_MERGES)
 			die("cannot combine '--signoff' with "
diff --git a/sequencer.c b/sequencer.c
index b9dbf1adb0..7bbb63f444 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4800,12 +4800,13 @@ int sequencer_make_script(struct repository *r, str=
uct strbuf *out, int argc,
 	int keep_empty =3D flags & TODO_LIST_KEEP_EMPTY;
 	const char *insn =3D flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges =3D flags & TODO_LIST_REBASE_MERGES;
+	int keep_cherry_pick =3D flags & TODO_LIST_KEEP_CHERRY_PICK;
=20
 	repo_init_revisions(r, &revs, NULL);
 	revs.verbose_header =3D 1;
 	if (!rebase_merges)
 		revs.max_parents =3D 1;
-	revs.cherry_mark =3D 1;
+	revs.cherry_mark =3D !keep_cherry_pick;
 	revs.limited =3D 1;
 	revs.reverse =3D 1;
 	revs.right_only =3D 1;
diff --git a/sequencer.h b/sequencer.h
index 9f9ae291e3..298b7de1c8 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -148,7 +148,7 @@ int sequencer_remove_state(struct replay_opts *opts);
  * `--onto`, we do not want to re-generate the root commits.
  */
 #define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
-
+#define TODO_LIST_KEEP_CHERRY_PICK (1U << 7)
=20
 int sequencer_make_script(struct repository *r, struct strbuf *out, int ar=
gc,
 			  const char **argv, unsigned flags);
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index a1ec501a87..64200c5f20 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -162,4 +162,81 @@ test_expect_success 'rebase --skip works with two conf=
licts in a row' '
 	git rebase --skip
 '
=20
+test_expect_success '--keep-cherry-pick' '
+	git init repo &&
+
+	# O(1-10) -- O(1-11) -- O(0-10) master
+	#        \
+	#         -- O(1-11) -- O(1-12) otherbranch
+
+	printf "Line %d\n" $(test_seq 1 10) >repo/file.txt &&
+	git -C repo add file.txt &&
+	git -C repo commit -m "base commit" &&
+
+	printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
+	git -C repo commit -a -m "add 11" &&
+
+	printf "Line %d\n" $(test_seq 0 10) >repo/file.txt &&
+	git -C repo commit -a -m "add 0 delete 11" &&
+
+	git -C repo checkout -b otherbranch HEAD^^ &&
+	printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
+	git -C repo commit -a -m "add 11 in another branch" &&
+
+	printf "Line %d\n" $(test_seq 1 12) >repo/file.txt &&
+	git -C repo commit -a -m "add 12 in another branch" &&
+
+	# Regular rebase fails, because the 1-11 commit is deduplicated
+	test_must_fail git -C repo rebase --merge master 2> err &&
+	test_i18ngrep "error: could not apply.*add 12 in another branch" err &&
+	git -C repo rebase --abort &&
+
+	# With --keep-cherry-pick, it works
+	git -C repo rebase --merge --keep-cherry-pick master
+'
+
+test_expect_success '--keep-cherry-pick refrains from reading unneeded blo=
bs' '
+	git init server &&
+
+	# O(1-10) -- O(1-11) -- O(1-12) master
+	#        \
+	#         -- O(0-10) otherbranch
+
+	printf "Line %d\n" $(test_seq 1 10) >server/file.txt &&
+	git -C server add file.txt &&
+	git -C server commit -m "merge base" &&
+
+	printf "Line %d\n" $(test_seq 1 11) >server/file.txt &&
+	git -C server commit -a -m "add 11" &&
+
+	printf "Line %d\n" $(test_seq 1 12) >server/file.txt &&
+	git -C server commit -a -m "add 12" &&
+
+	git -C server checkout -b otherbranch HEAD^^ &&
+	printf "Line %d\n" $(test_seq 0 10) >server/file.txt &&
+	git -C server commit -a -m "add 0" &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+
+	git clone --filter=3Dblob:none "file://$(pwd)/server" client &&
+	git -C client checkout origin/master &&
+	git -C client checkout origin/otherbranch &&
+
+	# Sanity check to ensure that the blobs from the merge base and "add
+	# 11" are missing
+	git -C client rev-list --objects --all --missing=3Dprint >missing_list &&
+	MERGE_BASE_BLOB=3D$(git -C server rev-parse master^^:file.txt) &&
+	ADD_11_BLOB=3D$(git -C server rev-parse master^:file.txt) &&
+	grep "\\?$MERGE_BASE_BLOB" missing_list &&
+	grep "\\?$ADD_11_BLOB" missing_list &&
+
+	git -C client rebase --merge --keep-cherry-pick origin/master &&
+
+	# The blob from the merge base had to be fetched, but not "add 11"
+	git -C client rev-list --objects --all --missing=3Dprint >missing_list &&
+	! grep "\\?$MERGE_BASE_BLOB" missing_list &&
+	grep "\\?$ADD_11_BLOB" missing_list
+'
+
 test_done
--=20
2.26.0.rc2.310.g2932bb562d-goog

