Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F2BC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136D8610C7
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbhHFMCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhHFMCp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 08:02:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CADC061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 05:02:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e5so6747015pld.6
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZuMVtOr8Mn1QVWL+U/INmQhUKsfidFreMBXKWK6obU=;
        b=ewI4/Ucrhy7IaAlv40QWH0TRZUMAif0rq1NbFuoTJkLItJTr6oYsEX+J/2X58GseF6
         DLfXzYWN0Z8MUGGa2NoTsP638yOyFWwoI0FTkoMIRnNJ3Q4ywbVjD133tOsmqOc9VL4E
         6AfolKaOUmeyZQXLjAoFfOs5HDkrf+MWiBSfbzLRBbS1eYEPb6BpI87tJoANHeUn0aPk
         ZzGLFIzrX2xrfuHULJm0JfKykZi9Oz1OTX3QXZRUroxRd+PdhxB9ckajMf5Gnx5Eyyhv
         69In9U5B11bEJNEai9If+fKEQkwdh+/xN3O1RHdPscRGzvXT8JK+4XklOiRpjK4kTfj0
         hUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZuMVtOr8Mn1QVWL+U/INmQhUKsfidFreMBXKWK6obU=;
        b=NYRDh1KCwSu8pRLOLNmT1QQ6BaTRezzfii0Lh+Ld83gg4r1fdLaceU4Y313rR2fNvP
         u/xmhkjeReuC7R7zsaCINhzYy3pZ8gWeU0W6GuT3WckJaqvtGbOeZGlThLvf/eANdRlH
         rlJalYGsxSHlWu5ZxZPj2Zjy0+ExHGKfZf3L5LSDZw5rd2RbbVMV8sg8RzOpNuSZipcs
         wno9Ikhr+02ogGkdbsDvNMltHkHzbF2z/a/rY5LDAfpzIgPa5UaxkHEBzwnu3+NF9bY4
         g4RHeFJgrm7vzZDedvlMPXJrPoznbL3QOrotCZMUHzmqP0BDgOsNi+K33plDrMQ5iLgi
         0erw==
X-Gm-Message-State: AOAM533eufKeEILBSqLuVGpkwgwesg88s5ndjgqNaH/AkqVWd0qkQxy1
        vo1QqLJreb4NmYaKj6lvLRA=
X-Google-Smtp-Source: ABdhPJx2yX9bRNSphFyqkb3EjuYYDho6emtAIMLCaizQ0y94nbycyjAeYqilIA33V4hh3JBBhBtOjA==
X-Received: by 2002:a17:902:a50f:b029:11a:b033:e158 with SMTP id s15-20020a170902a50fb029011ab033e158mr8340907plq.26.1628251348988;
        Fri, 06 Aug 2021 05:02:28 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id z8sm10338162pfa.113.2021.08.06.05.02.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:02:28 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v3 5/8] submodule--helper: convert the bulk of cmd_add() to C
Date:   Fri,  6 Aug 2021 17:31:44 +0530
Message-Id: <20210806120147.73349-6-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806120147.73349-1-raykar.ath@gmail.com>
References: <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210806120147.73349-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the 'add' subcommand to `submodule--helper.c` that does all
the work 'submodule add' past the parsing of flags.

We also remove the constness of the sm_path field of the `add_data`
struct. This is needed so that it can be modified by
normalize_path_copy().

As with the previous conversions, this is meant to be a faithful
conversion with no modification to the behaviour of `submodule add`.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Based-on-patch-by: Shourya Shukla <periperidip@gmail.com>
Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 165 +++++++++++++++++++++++++++++++++++-
 git-submodule.sh            |  96 +--------------------
 2 files changed, 166 insertions(+), 95 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9b676c12f8..f31e5a9bde 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2748,7 +2748,7 @@ struct add_data {
 	const char *prefix;
 	const char *branch;
 	const char *reference_path;
-	const char *sm_path;
+	char *sm_path;
 	const char *sm_name;
 	const char *repo;
 	const char *realrepo;
@@ -3046,6 +3046,168 @@ static int add_config(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void die_on_index_match(const char *path, int force)
+{
+	struct pathspec ps;
+	const char *args[] = { path, NULL };
+	parse_pathspec(&ps, 0, PATHSPEC_PREFER_CWD, NULL, args);
+
+	if (read_cache_preload(NULL) < 0)
+		die(_("index file corrupt"));
+
+	if (ps.nr) {
+		int i;
+		char *ps_matched = xcalloc(ps.nr, 1);
+
+		/* TODO: audit for interaction with sparse-index. */
+		ensure_full_index(&the_index);
+
+		/*
+		 * Since there is only one pathspec, we just need
+		 * need to check ps_matched[0] to know if a cache
+		 * entry matched.
+		 */
+		for (i = 0; i < active_nr; i++) {
+			ce_path_match(&the_index, active_cache[i], &ps,
+				      ps_matched);
+
+			if (ps_matched[0]) {
+				if (!force)
+					die(_("'%s' already exists in the index"),
+					    path);
+				if (!S_ISGITLINK(active_cache[i]->ce_mode))
+					die(_("'%s' already exists in the index "
+					      "and is not a submodule"), path);
+				break;
+			}
+		}
+		free(ps_matched);
+	}
+}
+
+static void die_on_repo_without_commits(const char *path)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_addstr(&sb, path);
+	if (is_nonbare_repository_dir(&sb)) {
+		struct object_id oid;
+		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
+			die(_("'%s' does not have a commit checked out"), path);
+	}
+}
+
+static int module_add(int argc, const char **argv, const char *prefix)
+{
+	int force = 0, quiet = 0, progress = 0, dissociate = 0;
+	struct add_data add_data = ADD_DATA_INIT;
+
+	struct option options[] = {
+		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
+			   N_("branch of repository to add as submodule")),
+		OPT__FORCE(&force, N_("allow adding an otherwise ignored submodule path"),
+			   PARSE_OPT_NOCOMPLETE),
+		OPT__QUIET(&quiet, N_("print only error messages")),
+		OPT_BOOL(0, "progress", &progress, N_("force cloning progress")),
+		OPT_STRING(0, "reference", &add_data.reference_path, N_("repository"),
+			   N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from reference repositories")),
+		OPT_STRING(0, "name", &add_data.sm_name, N_("name"),
+			   N_("sets the submodule’s name to the given string "
+			      "instead of defaulting to its path")),
+		OPT_INTEGER(0, "depth", &add_data.depth, N_("depth for shallow clones")),
+		OPT_END()
+	};
+
+	const char *const usage[] = {
+		N_("git submodule--helper add [<options>] [--] <repository> [<path>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (!is_writing_gitmodules_ok())
+		die(_("please make sure that the .gitmodules file is in the working tree"));
+
+	if (prefix && *prefix &&
+	    add_data.reference_path && !is_absolute_path(add_data.reference_path))
+		add_data.reference_path = xstrfmt("%s%s", prefix, add_data.reference_path);
+
+	if (argc == 0 || argc > 2)
+		usage_with_options(usage, options);
+
+	add_data.repo = argv[0];
+	if (argc == 1)
+		add_data.sm_path = guess_target_dir_from_git_url(add_data.repo, 0, 0);
+	else
+		add_data.sm_path = xstrdup(argv[1]);
+
+	if (prefix && *prefix && !is_absolute_path(add_data.sm_path))
+		add_data.sm_path = xstrfmt("%s%s", prefix, add_data.sm_path);
+
+	if (starts_with_dot_dot_slash(add_data.repo) ||
+	    starts_with_dot_slash(add_data.repo)) {
+		if (prefix)
+			die(_("Relative path can only be used from the toplevel "
+			      "of the working tree"));
+
+		/* dereference source url relative to parent's url */
+		add_data.realrepo = compute_submodule_clone_url(add_data.repo, NULL, 1);
+	} else if (is_dir_sep(add_data.repo[0]) || strchr(add_data.repo, ':')) {
+		add_data.realrepo = add_data.repo;
+	} else {
+		die(_("repo URL: '%s' must be absolute or begin with ./|../"),
+		    add_data.repo);
+	}
+
+	/*
+	 * normalize path:
+	 * multiple //; leading ./; /./; /../;
+	 */
+	normalize_path_copy(add_data.sm_path, add_data.sm_path);
+	strip_dir_trailing_slashes(add_data.sm_path);
+
+	die_on_index_match(add_data.sm_path, force);
+	die_on_repo_without_commits(add_data.sm_path);
+
+	if (!force) {
+		int exit_code = -1;
+		struct strbuf sb = STRBUF_INIT;
+		struct child_process cp = CHILD_PROCESS_INIT;
+		cp.git_cmd = 1;
+		cp.no_stdout = 1;
+		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
+			     "--no-warn-embedded-repo", add_data.sm_path, NULL);
+		if ((exit_code = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
+			strbuf_complete_line(&sb);
+			fputs(sb.buf, stderr);
+			free(add_data.sm_path);
+			return exit_code;
+		}
+		strbuf_release(&sb);
+	}
+
+	if(!add_data.sm_name)
+		add_data.sm_name = add_data.sm_path;
+
+	if (check_submodule_name(add_data.sm_name))
+		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
+
+	add_data.prefix = prefix;
+	add_data.force = !!force;
+	add_data.quiet = !!quiet;
+	add_data.progress = !!progress;
+	add_data.dissociate = !!dissociate;
+
+	if (add_submodule(&add_data)) {
+		free(add_data.sm_path);
+		return 1;
+	}
+	configure_added_submodule(&add_data);
+	free(add_data.sm_path);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -3060,6 +3222,7 @@ static struct cmd_struct commands[] = {
 	{"clone", module_clone, 0},
 	{"add-clone", add_clone, 0},
 	{"add-config", add_config, 0},
+	{"add", module_add, SUPPORT_SUPER_PREFIX},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 8c219ef382..1070540525 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -145,104 +145,12 @@ cmd_add()
 		shift
 	done
 
-	if ! git submodule--helper config --check-writeable >/dev/null 2>&1
+	if test -z "$1"
 	then
-		 die "fatal: $(eval_gettext "please make sure that the .gitmodules file is in the working tree")"
-	fi
-
-	if test -n "$reference_path"
-	then
-		is_absolute_path "$reference_path" ||
-		reference_path="$wt_prefix$reference_path"
-
-		reference="--reference=$reference_path"
-	fi
-
-	repo=$1
-	sm_path=$2
-
-	if test -z "$sm_path"; then
-		sm_path=$(printf '%s\n' "$repo" |
-			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
-	fi
-
-	if test -z "$repo" || test -z "$sm_path"; then
 		usage
 	fi
 
-	is_absolute_path "$sm_path" || sm_path="$wt_prefix$sm_path"
-
-	# assure repo is absolute or relative to parent
-	case "$repo" in
-	./*|../*)
-		test -z "$wt_prefix" ||
-		die "fatal: $(gettext "Relative path can only be used from the toplevel of the working tree")"
-
-		# dereference source url relative to parent's url
-		realrepo=$(git submodule--helper resolve-relative-url "$repo") || exit
-		;;
-	*:*|/*)
-		# absolute url
-		realrepo=$repo
-		;;
-	*)
-		die "fatal: $(eval_gettext "repo URL: '\$repo' must be absolute or begin with ./|../")"
-	;;
-	esac
-
-	# normalize path:
-	# multiple //; leading ./; /./; /../; trailing /
-	sm_path=$(printf '%s/\n' "$sm_path" |
-		sed -e '
-			s|//*|/|g
-			s|^\(\./\)*||
-			s|/\(\./\)*|/|g
-			:start
-			s|\([^/]*\)/\.\./||
-			tstart
-			s|/*$||
-		')
-	if test -z "$force"
-	then
-		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
-		die "fatal: $(eval_gettext "'\$sm_path' already exists in the index")"
-	else
-		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
-		die "fatal: $(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
-	fi
-
-	if test -d "$sm_path" &&
-		test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null)
-	then
-	    git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null ||
-	    die "fatal: $(eval_gettext "'\$sm_path' does not have a commit checked out")"
-	fi
-
-	if test -z "$force"
-	then
-	    dryerr=$(git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path" 2>&1 >/dev/null)
-	    res=$?
-	    if test $res -ne 0
-	    then
-		 echo >&2 "$dryerr"
-		 exit $res
-	    fi
-	fi
-
-	if test -n "$custom_name"
-	then
-		sm_name="$custom_name"
-	else
-		sm_name="$sm_path"
-	fi
-
-	if ! git submodule--helper check-name "$sm_name"
-	then
-		die "fatal: $(eval_gettext "'$sm_name' is not a valid submodule name")"
-	fi
-
-	git submodule--helper add-clone ${GIT_QUIET:+--quiet} ${force:+"--force"} ${progress:+"--progress"} ${branch:+--branch "$branch"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
-	git submodule--helper add-config ${force:+--force} ${branch:+--branch "$branch"} --url "$repo" --resolved-url "$realrepo" --path "$sm_path" --name "$sm_name"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
 }
 
 #
-- 
2.32.0

