Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB25EC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351864AbiCOVK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351859AbiCOVK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:10:56 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97AB574A5
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:43 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y7-20020a626407000000b004f6d39f1b0fso342727pfb.5
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=/75d9BKpTt7yJdqfO4G3M6Smj/srhohQP25jo6L4jFo=;
        b=a7piMJFt+APBM6z9+dkUHJt0VyvqyUk1+UMKaPUzh+7yKORITQd4CNxfHMtf4Pk/PW
         UkM1kXmmaH/cpnn3Hz0soeUVi73aFqd0edFCwPO7ZZR+be29pAuMk5TyaRLv/BK0gWLb
         M2WDGpmlQub2O9or1V+ErOugsXMbq/csC2wpWMfkeWIJ5EC2fYIfix7iUlzUZdTBy1e6
         TM1Tavis4Z+YTlsT7yOCvnbdSuIRXWfdX2B9ZhylMn5biJQ0SDcd/jE6Ar9QJRC6wXTv
         h5aIFSWCYA36iReNSQr7EqrZLUcoYro2zB5NSD2SeJ1BSYVnRDhc5b6ZSAZ5SY5GzHSR
         1J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=/75d9BKpTt7yJdqfO4G3M6Smj/srhohQP25jo6L4jFo=;
        b=h2adFZidTkJTZMaqBu5Jz1l/1VMJVEgmkgOzUFLvTS7iNBslUkCL3S51/VgtabwAen
         XdmJCa3FJwNIUqwpFxLJSDaeHjZ9dqh6hIMaoEAXr3Pj02QUUNJyFiph6igFmxzMuazd
         sAvGKHy0JeKxxV7jhHWzdTTXfiTUw/DkAgGXTL0DDroGSwLRustQLYboeF6zUK1dx5G6
         AwdV4ycpHWwv5XtP8xnlDuwy9lC0eCKQFkmSiPRNTl0Dox75VlsmIhRvSQoh0QrKQ7ty
         OYcDf9bvgFoaB9NnexluLpoSk5hEkYlu/MGq1DBpLFIZws1FnEPzkbHn2d9rIr/R4ThN
         RKJg==
X-Gm-Message-State: AOAM530aONW6soFsYmUB3SMSx0OnFdLcsHfmklklgozB/oDE636VuUXr
        pKbnxFKu4mSgN5FgHTX+pB6+XGtYp7Iz4P2GHdPe22pUxVMdbfKdckfpHKYY8Z7VlDhSM+Q8V3t
        vCzs7Bbm1KkT3/N230qfBQqLivG0fYK6/B4D1o4LPLMW4XAmdlN85aqxHADUb8qk=
X-Google-Smtp-Source: ABdhPJxoSN6f8SkASFdUv4m6t97DfqKgRkrTO3v2YL7k06PC6T4FThLMm1ByZiZzx+YYJ/tPC3cpvtiOHivmCA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d652:b0:153:ad02:741c with SMTP
 id y18-20020a170902d65200b00153ad02741cmr2324212plh.135.1647378583143; Tue,
 15 Mar 2022 14:09:43 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:09:21 -0700
In-Reply-To: <20220315210925.79289-1-chooglen@google.com>
Message-Id: <20220315210925.79289-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220315210925.79289-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 3/7] builtin/submodule--helper.c: rename option struct to "opt"
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

In a later commit, update_clone()'s options will be stored in a struct
update_data instead of submodule_update_clone. Preemptively rename the
options struct to "opt" to shrink that commit's diff.

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
This is the successor to
https://lore.kernel.org/git/20220210092833.55360-7-chooglen@google.com.
In that patch, we noted that renaming both functions' variables anchors
the final diff better, but patch 6 in this series shows that
run_update_procedure() is altogether deleted, so there's no point
changing that function.

 builtin/submodule--helper.c | 52 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index af1d90af7c..0e3cafb500 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2498,40 +2498,40 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
 {
 	const char *update =3D NULL;
 	struct pathspec pathspec;
-	struct submodule_update_clone suc =3D SUBMODULE_UPDATE_CLONE_INIT;
+	struct submodule_update_clone opt =3D SUBMODULE_UPDATE_CLONE_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
=20
 	struct option module_update_clone_options[] =3D {
-		OPT_BOOL(0, "init", &suc.init,
+		OPT_BOOL(0, "init", &opt.init,
 			 N_("initialize uninitialized submodules before update")),
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
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
@@ -2546,16 +2546,16 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
 		" [--recursive] [--[no-]single-branch] [--] [<path>...]"),
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
 	memset(&filter_options, 0, sizeof(filter_options));
 	argc =3D parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
=20
-	if (filter_options.choice && !suc.init) {
+	if (filter_options.choice && !opt.init) {
 		/*
 		 * NEEDSWORK: Don't use usage_with_options() because the
 		 * usage string is for "git submodule update", but the
@@ -2567,25 +2567,25 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
 		usage(git_submodule_helper_usage[0]);
 	}
=20
-	suc.filter_options =3D &filter_options;
+	opt.filter_options =3D &filter_options;
=20
 	if (update)
-		if (parse_submodule_update_strategy(update, &suc.update) < 0)
+		if (parse_submodule_update_strategy(update, &opt.update) < 0)
 			die(_("bad value for update parameter"));
=20
-	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0) {
+	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
 		list_objects_filter_release(&filter_options);
 		return 1;
 	}
=20
 	if (pathspec.nr)
-		suc.warn_if_uninitialized =3D 1;
+		opt.warn_if_uninitialized =3D 1;
=20
-	if (suc.init) {
+	if (opt.init) {
 		struct module_list list =3D MODULE_LIST_INIT;
 		struct init_cb info =3D INIT_CB_INIT;
=20
-		if (module_list_compute(argc, argv, suc.prefix,
+		if (module_list_compute(argc, argv, opt.prefix,
 					&pathspec, &list) < 0)
 			return 1;
=20
@@ -2596,15 +2596,15 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
 		if (!argc && git_config_get_value_multi("submodule.active"))
 			module_list_active(&list);
=20
-		info.prefix =3D suc.prefix;
-		info.superprefix =3D suc.recursive_prefix;
-		if (suc.quiet)
+		info.prefix =3D opt.prefix;
+		info.superprefix =3D opt.recursive_prefix;
+		if (opt.quiet)
 			info.flags |=3D OPT_QUIET;
=20
 		for_each_listed_submodule(&list, init_submodule_cb, &info);
 	}
=20
-	ret =3D update_submodules(&suc);
+	ret =3D update_submodules(&opt);
 	list_objects_filter_release(&filter_options);
 	return ret;
 }
--=20
2.33.GIT

