Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ADAC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiBJJ3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbiBJJ3D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:03 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355D910B4
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:01 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id n9-20020a17090a73c900b001b5cafefa27so3886405pjk.2
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=KtVdYHgHYdpKDN+uE8Vjf4NJtM9JXHAqmyaEt4fA0kc=;
        b=pw/0TI7pPN7ykV8RxavbqU7Wdqjv7uoIv8yGt7TRLiHVUCEHNDD6+C3ss6JjM56g0S
         gpzatP0zKIbhNrQrp04WfGuviqVS3cchtVwrDo+4cPXEb7zDPjLfgWLerJYhzVrlTBjM
         60z5iylJzHWqimQqBuV5W6euF50stTW6iXl533s/vDEmlsXy8KSJw94cKP7qCHwKP2wc
         HihZxLIS//UdZuX6pgzN7tUsGqsGNh97l3t6NO/dzT3Kq76jFEsOSXYzB8YAslyqBUTW
         +WCyguQbycRdT7+0ZT8SnZj35GjadDWuexyZVtLw7jVjWglHiHyumsOZF4NHpPyaUs4f
         9EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=KtVdYHgHYdpKDN+uE8Vjf4NJtM9JXHAqmyaEt4fA0kc=;
        b=pZL+iqWuDyAYyYCG0UdC3j0gghlJ7mJJ4R+s0K3HVKRdYJM+MTTDwdYKsAiAms6fD3
         4Zm+LmN+ZPr7VmhUKGezjnIoMcZuESi0tkIyeaweUFuDUqiseUfXEX6abZtw3L/JM3Di
         zbknHnAjGnDs35p0b1DQyQzuyK2mcziBjtn5f2aWfRBTVwyyNfqHivYk7TtRL1ydY+iG
         fCkgrxnLI8XEhlfI+5rgCSEQVHldrhq5C1sdKe7x75RvAKk0w2ticJrg6MewK59fsRxj
         jtYhrewlNWOk7hgeCL5xlmvPPM6aW+TTZWTJ8dLbXjDjfzTlou4JlRrNYhHea3dPA7QR
         Krzg==
X-Gm-Message-State: AOAM530vpg33rhpJzr6yxMzhOHap4kWdlGVeIm15t3ZzsrzdhwPGLNo6
        ZduwEAOt2h2sWBoVAmeLbUCpA6VGxaJDFwUvTnWlGRiLLa0JdvyDgnQKlmgkK8szFV6VugkHbiv
        87Qi03ujTGsPsZ1T13z4GZE9RFL2rKwGsmRmaeq7yG+TPbCksC4EGVD5QXZZlle8=
X-Google-Smtp-Source: ABdhPJxuQNGZTPYr2MsA0p/mbDOwksW83wlo/Jpu6mzV9kgNfjyYnEr5rqyqQbtV4mbQo6IxHuR2Zn72D8YoCQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:15c5:: with SMTP id
 188mr6715954pfv.84.1644485340625; Thu, 10 Feb 2022 01:29:00 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:19 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 06/20] builtin/submodule--helper.c: rename option variables
 to "opt"
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Rename the "suc" variable in update_clone() to "opt", and do the same
for the "update_data" variable in run_update_procedure().

The only reason for this change is to make the subsequent commit's
diff smaller, by doing this rename we can "anchor" the diff better, as
it "borrow" most of the options declared here as-is as far as the diff
rename detection is concerned.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 74 ++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9f79bdf4d5..c2d4fd0347 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2517,36 +2517,36 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
 {
 	const char *update =3D NULL;
 	struct pathspec pathspec;
-	struct submodule_update_clone suc =3D SUBMODULE_UPDATE_CLONE_INIT;
+	struct submodule_update_clone opt =3D SUBMODULE_UPDATE_CLONE_INIT;
=20
 	struct option module_update_clone_options[] =3D {
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
-		OPT_STRING(0, "recursive-prefix", &suc.recursive_prefix,
+		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
 			   N_("path"),
 			   N_("path into the working tree, across nested "
 			      "submodule boundaries")),
 		OPT_STRING(0, "update", &update,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
-		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
+		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
-		OPT_BOOL(0, "dissociate", &suc.dissociate,
+		OPT_BOOL(0, "dissociate", &opt.dissociate,
 			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &suc.depth, "<depth>",
+		OPT_STRING(0, "depth", &opt.depth, "<depth>",
 			   N_("create a shallow clone truncated to the "
 			      "specified number of revisions")),
-		OPT_INTEGER('j', "jobs", &suc.max_jobs,
+		OPT_INTEGER('j', "jobs", &opt.max_jobs,
 			    N_("parallel jobs")),
-		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
+		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
 			    N_("whether the initial clone should follow the shallow recommendat=
ion")),
-		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
-		OPT_BOOL(0, "progress", &suc.progress,
+		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
+		OPT_BOOL(0, "progress", &opt.progress,
 			    N_("force cloning progress")),
-		OPT_BOOL(0, "require-init", &suc.require_init,
+		OPT_BOOL(0, "require-init", &opt.require_init,
 			   N_("disallow cloning into non-empty directory")),
-		OPT_BOOL(0, "single-branch", &suc.single_branch,
+		OPT_BOOL(0, "single-branch", &opt.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
 		OPT_END()
 	};
@@ -2555,32 +2555,32 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
 		N_("git submodule--helper update-clone [--prefix=3D<path>] [<path>...]")=
,
 		NULL
 	};
-	suc.prefix =3D prefix;
+	opt.prefix =3D prefix;
=20
-	update_clone_config_from_gitmodules(&suc.max_jobs);
-	git_config(git_update_clone_config, &suc.max_jobs);
+	update_clone_config_from_gitmodules(&opt.max_jobs);
+	git_config(git_update_clone_config, &opt.max_jobs);
=20
 	argc =3D parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
=20
 	if (update)
-		if (parse_submodule_update_strategy(update, &suc.update) < 0)
+		if (parse_submodule_update_strategy(update, &opt.update) < 0)
 			die(_("bad value for update parameter"));
=20
-	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
+	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0)
 		return 1;
=20
 	if (pathspec.nr)
-		suc.warn_if_uninitialized =3D 1;
+		opt.warn_if_uninitialized =3D 1;
=20
-	return update_submodules(&suc);
+	return update_submodules(&opt);
 }
=20
 static int run_update_procedure(int argc, const char **argv, const char *p=
refix)
 {
 	int force =3D 0, quiet =3D 0, nofetch =3D 0, just_cloned =3D 0;
 	char *prefixed_path, *update =3D NULL;
-	struct update_data update_data =3D UPDATE_DATA_INIT;
+	struct update_data opt =3D UPDATE_DATA_INIT;
=20
 	struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
@@ -2589,20 +2589,20 @@ static int run_update_procedure(int argc, const cha=
r **argv, const char *prefix)
 			 N_("don't fetch new objects from the remote site")),
 		OPT_BOOL(0, "just-cloned", &just_cloned,
 			 N_("overrides update mode in case the repository is a fresh clone")),
-		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch"=
)),
+		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
 		OPT_STRING(0, "update", &update,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("pat=
h"),
+		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix, N_("path"),
 			   N_("path into the working tree, across nested "
 			      "submodule boundaries")),
-		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
+		OPT_CALLBACK_F(0, "oid", &opt.oid, N_("sha1"),
 			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
 			       parse_opt_object_id),
-		OPT_CALLBACK_F(0, "suboid", &update_data.suboid, N_("subsha1"),
+		OPT_CALLBACK_F(0, "suboid", &opt.suboid, N_("subsha1"),
 			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
 			       parse_opt_object_id),
 		OPT_END()
@@ -2618,27 +2618,27 @@ static int run_update_procedure(int argc, const cha=
r **argv, const char *prefix)
 	if (argc !=3D 1)
 		usage_with_options(usage, options);
=20
-	update_data.force =3D !!force;
-	update_data.quiet =3D !!quiet;
-	update_data.nofetch =3D !!nofetch;
-	update_data.just_cloned =3D !!just_cloned;
-	update_data.sm_path =3D argv[0];
+	opt.force =3D !!force;
+	opt.quiet =3D !!quiet;
+	opt.nofetch =3D !!nofetch;
+	opt.just_cloned =3D !!just_cloned;
+	opt.sm_path =3D argv[0];
=20
-	if (update_data.recursive_prefix)
-		prefixed_path =3D xstrfmt("%s%s", update_data.recursive_prefix, update_d=
ata.sm_path);
+	if (opt.recursive_prefix)
+		prefixed_path =3D xstrfmt("%s%s", opt.recursive_prefix, opt.sm_path);
 	else
-		prefixed_path =3D xstrdup(update_data.sm_path);
+		prefixed_path =3D xstrdup(opt.sm_path);
=20
-	update_data.displaypath =3D get_submodule_displaypath(prefixed_path, pref=
ix);
+	opt.displaypath =3D get_submodule_displaypath(prefixed_path, prefix);
=20
-	determine_submodule_update_strategy(the_repository, update_data.just_clon=
ed,
-					    update_data.sm_path, update,
-					    &update_data.update_strategy);
+	determine_submodule_update_strategy(the_repository, opt.just_cloned,
+					    opt.sm_path, update,
+					    &opt.update_strategy);
=20
 	free(prefixed_path);
=20
-	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
-		return do_run_update_procedure(&update_data);
+	if (!oideq(&opt.oid, &opt.suboid) || opt.force)
+		return do_run_update_procedure(&opt);
=20
 	return 3;
 }
--=20
2.33.GIT

