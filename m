Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75144C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiFVO3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357953AbiFVO2O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2C35FB3
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i10so19916084wrc.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8viyUccyrinJwS5tFPjdLzX3IrZaWH8CwQqDVlprEAc=;
        b=mwXQpqz0oyz3xju5NDvNdKSskwHwvTXtIrkvqDd/bhL29Z4LxVgHsoyKsLtenHteIa
         LutpcH6nqTqXAkuXFMFzUA1iVnFDmKD4ClU0Ys8antXAaZJPjpGtzjzbIKZcsNx327E4
         bypd4NzZOJd90D2h6he43OG4RQdSvqH0YY97GskARGhT+VravXuEfX8s0JQWjDJrOmkn
         W6wdLQKxn+o76Wu5loF8s+vQL3FNsRttCpplj0UO9cY5Vxsmr7IjK1X3OT3iZvNQmGC3
         47Gfwg6v1vu6h4WJjDLAa4IhOdMXrBNc22o4XnJEEmbQqJ27CekTpLGfbPZynytMMdu/
         TYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8viyUccyrinJwS5tFPjdLzX3IrZaWH8CwQqDVlprEAc=;
        b=Ho7MPriySJEBe/7LN6EcUSm58aiPueKqnV95uOeOvOsiV6l0QzFekLVe8cBwTSZ6Zy
         QLE9Nt0rVxV++zbngdxndFGP+Z3jV+BsaJF72uwaD4oV54ITpp/1yA2yDWrOKR/IgP2F
         J8xJN6ERZTJ0eAYXzEtqNI0/O3pYUvU6JNNBJLjWuAGYfqRxIBALvHCI9JJp4TECvuSz
         beQf9TIU2gRWK+WA72zKtRzDTKacWFhQ+ABiTwdlE0OqbuAc6+IQpRrCtSeKdI52NYqS
         LySGkBgnSTn6FtQzmNayDaTu7KwrENgflSGzhFcmyfMJ+SvLKbxVTfyUNyEqD7+7DOi2
         icHQ==
X-Gm-Message-State: AJIora9BR5/too4tQ1DDoEWPvHXQsHDphx3xiGeMqi0jqTkEoCWYb6zo
        xHiHkPuJmDJsktNxhBQiR42+8e7v7wBGig==
X-Google-Smtp-Source: AGRyM1sINV4X1C+x+4zOzFexJXcElRJtoB9Z7SkkHboX4hgR8DeTpr3qgHN2+gjw/kGrUav2q3Dllg==
X-Received: by 2002:a5d:644e:0:b0:21b:9439:bae5 with SMTP id d14-20020a5d644e000000b0021b9439bae5mr3492642wrw.507.1655908090460;
        Wed, 22 Jun 2022 07:28:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/12] submodule: make "git submodule--helper" behave like "git submodule"
Date:   Wed, 22 Jun 2022 16:27:55 +0200
Message-Id: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are preparatory changes to make "git submodule--helper"'s
behavior align with that of "git submodule". The next step after this
is to get rid of git-submodule.sh entirely, and make "git submodule" a
built-in.

The last two patches here are post-cleanup of related submodule code
that isn't strictly necessary, but good to do. Similarly this starts
with the removal of some dead code in the area.

The goal is to make these changes as small as possible, and as
obviously correct as possible. This will help to make the meaty
changes that follow easier to review.

See
https://lore.kernel.org/git/RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com/
for the larger RFC series which does the "git-submodule.sh to
built-in" migration. It will need to be rebased on this series, which
has evolved since the initial RFC.

Changes since v2:

 * Clarify that removing the --super-prefix code is safe in the commit message.
 * Typo/grammar etc. fixes.
 * I changed the authorship of the "-v" removal from Glen to myself,
   as requested by Glen.
 * I said I'd drop 08/2, but I've kept a much amended version of it. I
   think the "-h" output fixes make sense, but now we only change the
   user-exposed commands, not those internal to "git
   submodule--helper".
 * Glen suggested I squash 09-10/12, but instead I've created a helper
   function in 09/12 that we can keep using, and thus avoid much of
   the churn. I think splitting up the change we need for
   "git-submodule.sh" from the internal interface concerns still make
   sense.

If there's any outstanding feedback that's unadressed that wasn't the
intent, so please point out if I've missed anything. Thanks!

Glen Choo (1):
  submodule--helper: eliminate internal "--update" option

Ævar Arnfjörð Bjarmason (11):
  git-submodule.sh: remove unused sanitize_submodule_env()
  git-submodule.sh: remove unused $prefix var and --super-prefix
  git-submodule.sh: make the "$cached" variable a boolean
  git-submodule.sh: remove unused top-level "--branch" argument
  submodule--helper: have --require-init imply --init
  submodule update: remove "-v" option
  submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
  submodule--helper: report "submodule" as our name in some "-h" output
  submodule--helper: understand --checkout, --merge and --rebase
    synonyms
  git-submodule.sh: use "$quiet", not "$GIT_QUIET"
  git-sh-setup.sh: remove "say" function, change last users

 builtin/submodule--helper.c    | 125 +++++++++++++++++++--------------
 contrib/subtree/git-subtree.sh |  15 +++-
 git-instaweb.sh                |   2 +-
 git-sh-setup.sh                |  16 -----
 git-submodule.sh               |  88 ++++++++---------------
 submodule.c                    |   2 +-
 t/t7406-submodule-update.sh    |   2 +-
 7 files changed, 117 insertions(+), 133 deletions(-)

Range-diff against v2:
 1:  c5afc72e075 =  1:  ed487469d62 git-submodule.sh: remove unused sanitize_submodule_env()
 2:  e127803d59d !  2:  082e015781e git-submodule.sh: remove unused $prefix var and --super-prefix
    @@ Commit message
         "--super-prefix" is not passing the option to
         "cmd_submodule__helper()", rather it's an argument to "git" itself.
     
    +    One way to verify that this is indeed dead code is to try to check out
    +    b3c5f5cb048^ and apply this change to a part of the code being removed
    +    here:
    +
    +            -#define SUPPORT_SUPER_PREFIX (1<<0)
    +            +#define SUPPORT_SUPER_PREFIX 0
    +
    +    Doing that will cause t7406-submodule-update.sh to fail with errors
    +    such as:
    +
    +            -Submodule path '../super': checked out 'e1c658656b91df52a4634fbffeaa739807ce3521'
    +            +Submodule path 'super': checked out 'e1c658656b91df52a4634fbffeaa739807ce3521'
    +
    +    I.e. the removal of the --super-prefix handling broke those cases, but
    +    when doing the same ad-hoc test with b3c5f5cb048 all of our tests will
    +    pass, since the "--super-prefix" will now be handled by earlier by
    +    "git" itself.
    +
    +    So this is just one of the things that were overly complex in "git
    +    submodule--helper", because parts of it had to bridge the gap between
    +    *.sh and *.c land, but once we moved more parts to C we ended up
    +    getting that for free.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
 3:  d5c8613c654 !  3:  3948aa5d782 git-submodule.sh: make "$cached" variable a boolean
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git-submodule.sh: make "$cached" variable a boolean
    +    git-submodule.sh: make the "$cached" variable a boolean
     
         Remove the assignment of "$1" to the "$cached" variable. As seen in
         the initial implementation in 70c7ac22de6 (Add git-submodule command,
 4:  fd328329b68 !  4:  b5967afd59f git-submodule.sh: remove unused top-level "--branch" argument
    @@ Commit message
         we have "--branch" here already we'll emit usage, even for "add" and
         "set-branch".
     
    -    So in addition to never having documented this form it hasn't worked
    -    since b57e8119e6e was released with v2.22.0 it's safe to remove this
    -    code. I.e. we don't want to support the form noted above, but only:
    +    So in addition to never having documented this form, it hasn't worked
    +    since b57e8119e6e was released with v2.22.0.
    +
    +    So it's safe to remove this code. I.e. we don't want to support the
    +    form noted above, but only:
     
             git submodule (add | set-branch) --branch <branch> [<options>]
     
 5:  ef3265a588e !  5:  64e4aa41d21 submodule--helper: have --require-init imply --init
    @@ Commit message
     
         We'll still need to keep the distinction between "--init" and
         "--require-init" in git-submodule.sh. Once cmd_update() gets
    -    re-implemented in C we'll be able to variables and other code related
    -    to that, but not yet.
    +    re-implemented in C we'll be able to change variables and other code
    +    related to that, but not yet.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 6:  025694644fc !  6:  b82faad77bb submodule update: remove "-v" option
    @@
      ## Metadata ##
    -Author: Glen Choo <chooglen@google.com>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
         submodule update: remove "-v" option
    @@ Commit message
         "--quiet", 2020-09-30), it wasn't per-se testing --quiet, but fixing a
         bug in e84c3cf3dc3: It used to set "GIT_QUIET=0" instead of unsetting
         it on "-v", and thus we'd end up passing "--quiet" to "git
    -    submodule--helper" on "-v", since the "--quiet" option was passed sing
    -    the ${parameter:+word} construct.
    +    submodule--helper" on "-v", since the "--quiet" option was passed
    +    using the ${parameter:+word} construct.
     
         Furthermore, even if someone had used the "-v" option they'd only be
         getting the default output. Our default in both git-submodule.sh and
    @@ Commit message
     
         I.e. to undo the effect of a previous "--quiet" on the command-line.
     
    -    Signed-off-by: Glen Choo <chooglen@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## git-submodule.sh ##
 7:  63155ab5026 =  7:  ff557f3c81a submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
 8:  99ac52d810f !  8:  bb1310b9abe submodule--helper: report "submodule" as our name in "-h" output
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: report "submodule" as our name in "-h" output
    +    submodule--helper: report "submodule" as our name in some "-h" output
     
    -    Change the rest of the usage output for "git submodule--helper" so
    -    that it will pretend to be named "git submodule", which it already did
    -    e.g. in the case of "status", "deinit" and "update".
    +    Change the user-facing "git submodule--helper" commands so that
    +    they'll report their name as being "git submodule". To a user these
    +    commands are internal implementation details, and it doesn't make
    +    sense to emit usage about an internal helper when "git submodule" is
    +    invoked with invalid options.
     
    -    This will allow us to eventually dispatch further into "git
    -    submodule--helper" from git-submodule.sh, while emitting the correct
    -    usage output.
    -
    -    This does make the usage output of "git submodule--helper" itself
    -    "incorrect", but since nothing user-facing invokes it directly it
    -    makes sense to continue to elide that difference entirely. A user
    -    isn't served by us exposing this internal implementation detail.
    -
    -    This fixes a bug that's been there ever since "git submodule
    -    absorbgitdirs" was added in f6f85861400 (submodule: add absorb-git-dir
    -    function, 2016-12-12). Before this we'd emit e.g. this on invalid
    -    usage:
    +    Before this we'd emit e.g.:
     
                 $ git submodule absorbgitdirs --blah
                 error: unknown option `blah'
                 usage: git submodule--helper absorbgitdirs [<options>] [<path>...]
    +            [...]
    +    And:
    +
    +            $ git submodule set-url -- --
    +            usage: git submodule--helper set-url [--quiet] <path> <newurl>
    +            [...]
     
    -    Now we'll emit the same, except that the usage line is now referring
    -    to the correct command run by the user:
    +    Now we'll start with "usage: git submodule [...]" in both of those
    +    cases. This change does not alter the "list", "name", "clone",
    +    "config" and "create-branch" commands, those are internal-only (as an
    +    aside; their usage info should probably invoke BUG(...)). This only
    +    changes the user-facing commands.
     
    -            usage: git submodule absorbgitdirs [<options>] [<path>...]
    -            [.. same usage output ...]
    +    The "status", "deinit" and "update" commands are not included in this
    +    change, because their usage information already used "submodule"
    +    rather than "submodule--helper".
    +
    +    I don't think it's currently possible to emit some of this usage
    +    information in practice, as git-submodule.sh will catch unknown
    +    options, and e.g. it doesn't seem to be possible to get "add" to emit
    +    its usage information from "submodule--helper".
    +
    +    Though that change may be superfluous now, it's also harmless, and
    +    will allow us to eventually dispatch further into "git
    +    submodule--helper" from git-submodule.sh, while emitting the correct
    +    usage output.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int module_list(int argc, const char **argv, const char *prefix)
    - 	};
    - 
    - 	const char *const git_submodule_helper_usage[] = {
    --		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
    -+		N_("git submodule list [--prefix=<path>] [<path>...]"),
    - 		NULL
    - 	};
    - 
     @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **argv, const char *prefix)
      	};
      
    @@ builtin/submodule--helper.c: static int module_init(int argc, const char **argv,
      		NULL
      	};
      
    -@@ builtin/submodule--helper.c: static int module_name(int argc, const char **argv, const char *prefix)
    - 	const struct submodule *sub;
    - 
    - 	if (argc != 2)
    --		usage(_("git submodule--helper name <path>"));
    -+		usage(_("git submodule name <path>"));
    - 
    - 	sub = submodule_from_path(the_repository, null_oid(), argv[1]);
    - 
     @@ builtin/submodule--helper.c: static int module_summary(int argc, const char **argv, const char *prefix)
      	};
      
    @@ builtin/submodule--helper.c: static int module_sync(int argc, const char **argv,
      		NULL
      	};
      
    -@@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
    - 	};
    - 
    - 	const char *const git_submodule_helper_usage[] = {
    --		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
    -+		N_("git submodule clone [--prefix=<path>] [--quiet] "
    - 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
    - 		   "[--single-branch] [--filter <filter-spec>] "
    - 		   "--url <url> --path <path>"),
     @@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
      	};
      
    @@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **a
      		NULL
      	};
      
    -@@ builtin/submodule--helper.c: static int module_config(int argc, const char **argv, const char *prefix)
    - 		OPT_END()
    - 	};
    - 	const char *const git_submodule_helper_usage[] = {
    --		N_("git submodule--helper config <name> [<value>]"),
    --		N_("git submodule--helper config --unset <name>"),
    --		"git submodule--helper config --check-writeable",
    -+		N_("git submodule config <name> [<value>]"),
    -+		N_("git submodule config --unset <name>"),
    -+		"git submodule config --check-writeable",
    - 		NULL
    - 	};
    - 
     @@ builtin/submodule--helper.c: static int module_set_url(int argc, const char **argv, const char *prefix)
      		OPT_END()
      	};
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
      		NULL
      	};
      
    -@@ builtin/submodule--helper.c: static int module_create_branch(int argc, const char **argv, const char *prefix)
    - 		OPT_END()
    - 	};
    - 	const char *const usage[] = {
    --		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
    -+		N_("git submodule create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
    - 		NULL
    - 	};
    - 
     @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix)
      	};
      
 9:  80536424daa !  9:  e251fc115e1 submodule--helper: understand --checkout, --merge and --rebase synonyms
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: static void ensure_core_worktree(const char *path)
    + 	}
    + }
    + 
    ++static const char *submodule_update_type_to_label(enum submodule_update_type type)
    ++{
    ++	switch (type) {
    ++	case SM_UPDATE_CHECKOUT:
    ++		return "checkout";
    ++	case SM_UPDATE_MERGE:
    ++		return "merge";
    ++	case SM_UPDATE_REBASE:
    ++		return "rebase";
    ++	case SM_UPDATE_UNSPECIFIED:
    ++	case SM_UPDATE_NONE:
    ++	case SM_UPDATE_COMMAND:
    ++		break;
    ++	}
    ++	BUG("unreachable with type %d", type);
    ++}
    ++
    + static void update_data_to_args(struct update_data *update_data, struct strvec *args)
    + {
    + 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
     @@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
      	struct update_data opt = UPDATE_DATA_INIT;
      	struct list_objects_filter_options filter_options;
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
      
      	opt.filter_options = &filter_options;
      
    -+	if (update_type == SM_UPDATE_CHECKOUT)
    -+		opt.update_default = "checkout";
    -+	else if (update_type == SM_UPDATE_MERGE)
    -+		opt.update_default = "merge";
    -+	else if (update_type == SM_UPDATE_REBASE)
    -+		opt.update_default = "rebase";
    ++	if (update_type != SM_UPDATE_UNSPECIFIED)
    ++		opt.update_default = submodule_update_type_to_label(update_type);
     +
      	if (opt.update_default)
      		if (parse_submodule_update_strategy(opt.update_default,
10:  9ce9f78b2d0 ! 10:  66a229227a1 submodule--helper: eliminate internal "--update" option
    @@ builtin/submodule--helper.c: struct update_data {
      	struct object_id suboid;
      	struct string_list references;
      	struct submodule_update_strategy update_strategy;
    -@@ builtin/submodule--helper.c: static void ensure_core_worktree(const char *path)
    +@@ builtin/submodule--helper.c: static const char *submodule_update_type_to_label(enum submodule_update_type typ
      
      static void update_data_to_args(struct update_data *update_data, struct strvec *args)
      {
    -+	enum submodule_update_type ud = update_data->update_default;
    ++	enum submodule_update_type update_type = update_data->update_default;
     +
      	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
      	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
    @@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data
      		strvec_pushf(args, "--depth=%d", update_data->depth);
     -	if (update_data->update_default)
     -		strvec_pushl(args, "--update", update_data->update_default, NULL);
    -+	if (ud == SM_UPDATE_MERGE)
    -+		strvec_push(args, "--merge");
    -+	else if (ud == SM_UPDATE_CHECKOUT)
    -+		strvec_push(args, "--checkout");
    -+	else if (ud == SM_UPDATE_REBASE)
    -+		strvec_push(args, "--rebase");
    -+	else if (ud != SM_UPDATE_UNSPECIFIED)
    -+		BUG("cannot convert update_default=%d to args", ud);
    ++	if (update_type != SM_UPDATE_UNSPECIFIED)
    ++		strvec_pushf(args, "--%s",
    ++			     submodule_update_type_to_label(update_type));
     +
      	if (update_data->references.nr) {
      		struct string_list_item *item;
    @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
      
      	opt.filter_options = &filter_options;
      
    --	if (update_type == SM_UPDATE_CHECKOUT)
    --		opt.update_default = "checkout";
    --	else if (update_type == SM_UPDATE_MERGE)
    --		opt.update_default = "merge";
    --	else if (update_type == SM_UPDATE_REBASE)
    --		opt.update_default = "rebase";
    +-	if (update_type != SM_UPDATE_UNSPECIFIED)
    +-		opt.update_default = submodule_update_type_to_label(update_type);
     -
      	if (opt.update_default)
     -		if (parse_submodule_update_strategy(opt.update_default,
11:  42b107bc9df ! 11:  f8219cd461d git-submodule.sh: use "$quiet", not "$GIT_QUIET"
    @@ Commit message
         "GIT_QUIET".
     
         We still want to support --quiet for our own use though, but let's use
    -    our own variable for that, but now it's obvious that we only care
    -    about passing "--quiet" to "git submodule--helper", and not to change
    -    the output of any "say" invocation.
    +    our own variable for that. Now it's obvious that we only care about
    +    passing "--quiet" to "git submodule--helper", and not to change the
    +    output of any "say" invocation.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
12:  336c6d5dd63 = 12:  ecdd8c6ed28 git-sh-setup.sh: remove "say" function, change last users
-- 
2.36.1.1239.gfba91521d90

