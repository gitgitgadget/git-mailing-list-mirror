Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0A3C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 15:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbiC1PpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbiC1PpG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 11:45:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5425F46B3C
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 08:43:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso3126052wme.5
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fixe4ZL55oCGT7sBFP/45svW/y9gzZoimVIO3hfGh/w=;
        b=dAuJ+3XRAJ8+rxLugnzectPoXEO0jDievJVTsGJKjf2mrC05/9OsT4Uzu+zwb92TuF
         HHmB8Fo92Lq/XJlA3cMRNq8iCse1xBSXbL2wdx8Qy28OvE+9sV7gI6mUHnwGXgOG0Q+L
         HD1ZLq3PtGhH1DC6dWbjVt+6frjq+GpxohnTF3w499v3oRMNfXRb1wveN0Dgh7yd7BDJ
         BNpDnODYGkwtKTA9ZqKwsvisQZqgrCVKMYKy76vJVJDqAICGGZBZD6kBgC56k9xaPmln
         IygAbWohc035fxdMmbkowYoH5h+21y39d0X+Iby6wOC8kEHbLbOH5Bh/3qVlgUfL8X5u
         UtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fixe4ZL55oCGT7sBFP/45svW/y9gzZoimVIO3hfGh/w=;
        b=M+7BuIuDPvZB7nKErNja1w+dM2dZAl/n3n8p/HgYkummPBeJKeoa3BXBfxAuYlWHU1
         E4Y4WbG+XNNKSn8N791aYrE1BgQ1Kdh359YSbgy2rPmTcwRKOGWEmFPJ2Vlr0cN7gqd9
         SBBjtkLeyInGf9xcQ7knOBVwliOSL5G0D3nvxzr7trfApWf7jUoa409vYZLN/FmlcX92
         FDxx3/5oeSvk8jfXYRszp6i3sAV7vTYe8aVZZV0bcJrNcodLuTEK/50PHuDKk8Ytt/mL
         fuixCkM/PXOqUazGYXy7FY+EOwiCCpHeGoZhn2F4HTJ5Lc0aKMa9MGlZLSvK3slovUjn
         wedw==
X-Gm-Message-State: AOAM532zrQyo5oTrYz71ECoadt4F7be15xbIXnRduzndD5YJrOAHbYok
        BaSElHdap3Ih6oyGsl4SDv5BC6tbvxs=
X-Google-Smtp-Source: ABdhPJwj21MDR5HczMMv9+/Mzn4SHgYn3da45au19j1RUsA9w12cq5uK1mo5S7l0NlEbye+cmGPW0Q==
X-Received: by 2002:a05:600c:4e06:b0:38d:6ff:62df with SMTP id b6-20020a05600c4e0600b0038d06ff62dfmr8345419wmq.145.1648482202263;
        Mon, 28 Mar 2022 08:43:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg18-20020a05600c3c9200b0037c2ef07493sm13250417wmb.3.2022.03.28.08.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 08:43:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] pack-objects: lazily set up "struct rev_info", don't leak
Date:   Mon, 28 Mar 2022 17:43:18 +0200
Message-Id: <patch-v2-1.1-9951d92176e-20220328T154049Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1541.g9c2d54e20ab
In-Reply-To: <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
References: <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding [1] (pack-objects: move revs out of
get_object_list(), 2022-03-22) the "repo_init_revisions()" was moved
to cmd_pack_objects() so that it unconditionally took place for all
invocations of "git pack-objects".

We'd thus start leaking memory, which is easily reproduced in
e.g. git.git by feeding e83c5163316 (Initial revision of "git", the
information manager from hell, 2005-04-07) to "git pack-objects";

    $ echo e83c5163316f89bfbde7d9ab23ca2e25604af290 | ./git pack-objects initial
    [...]
	==19130==ERROR: LeakSanitizer: detected memory leaks

	Direct leak of 7120 byte(s) in 1 object(s) allocated from:
	    #0 0x455308 in __interceptor_malloc (/home/avar/g/git/git+0x455308)
	    #1 0x75b399 in do_xmalloc /home/avar/g/git/wrapper.c:41:8
	    #2 0x75b356 in xmalloc /home/avar/g/git/wrapper.c:62:9
	    #3 0x5d7609 in prep_parse_options /home/avar/g/git/diff.c:5647:2
	    #4 0x5d415a in repo_diff_setup /home/avar/g/git/diff.c:4621:2
	    #5 0x6dffbb in repo_init_revisions /home/avar/g/git/revision.c:1853:2
	    #6 0x4f599d in cmd_pack_objects /home/avar/g/git/builtin/pack-objects.c:3980:2
	    #7 0x4592ca in run_builtin /home/avar/g/git/git.c:465:11
	    #8 0x457d81 in handle_builtin /home/avar/g/git/git.c:718:3
	    #9 0x458ca5 in run_argv /home/avar/g/git/git.c:785:4
	    #10 0x457b40 in cmd_main /home/avar/g/git/git.c:916:19
	    #11 0x562259 in main /home/avar/g/git/common-main.c:56:11
	    #12 0x7fce792ac7ec in __libc_start_main csu/../csu/libc-start.c:332:16
	    #13 0x4300f9 in _start (/home/avar/g/git/git+0x4300f9)

	SUMMARY: LeakSanitizer: 7120 byte(s) leaked in 1 allocation(s).
	Aborted

Narrowly fixing that commit would have been easy, just add call
repo_init_revisions() right before get_object_list(), which is
effectively what was done before that commit.

But an unstated constraint when setting it up early is that it was
needed for the subsequent [2] (pack-objects: parse --filter directly
into revs.filter, 2022-03-22), i.e. we might have a --filter
command-line option, and need to either have the "struct rev_info"
setup when we encounter that option, or later.

Let's just change the control flow so that we'll instead set up the
"struct rev_info" only when we need it. Doing so leads to a bit more
verbosity, but it's a lot clearer what we're doing and why.

An earlier version of this commit[3] went behind
opt_parse_list_objects_filter()'s back by faking up a "struct option"
before calling it. Let's avoid that and instead create a blessed API
for this pattern.

We could furthermore combine the two get_object_list() invocations
here by having repo_init_revisions() invoked on &pfd.revs, but I think
clearly separating the two makes the flow clearer. Likewise
redundantly but explicitly (i.e. redundant v.s. a "{ 0 }") "0" to
"have_revs" early in cmd_pack_objects().

While we're at it add parentheses around the arguments to the OPT_*
macros in in list-objects-filter-options.h, as we need to change those
lines anyway. It doesn't matter in this case, but is good general
practice.

1. https://lore.kernel.org/git/619b757d98465dbc4995bdc11a5282fbfcbd3daa.1647970119.git.gitgitgadget@gmail.com
2. https://lore.kernel.org/git/97de926904988b89b5663bd4c59c011a1723a8f5.1647970119.git.gitgitgadget@gmail.com
3. https://lore.kernel.org/git/patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Hopefully this v2 addresses enough of the concern on v1 to move
forward with squashing the linux-leaks failure in "seen" currently.

There's still "struct rev_info" in play here, which I still think
makes sense, but this gets entirely rid of the evil magic trickery
with faking up a "struct option" in favor of a defined API for doing
the lazy initialization.

Range-diff against v1:
1:  193534b0f07 ! 1:  9951d92176e pack-objects: lazily set up "struct rev_info", don't leak
    @@ Commit message
         "struct rev_info" only when we need it. Doing so leads to a bit more
         verbosity, but it's a lot clearer what we're doing and why.
     
    +    An earlier version of this commit[3] went behind
    +    opt_parse_list_objects_filter()'s back by faking up a "struct option"
    +    before calling it. Let's avoid that and instead create a blessed API
    +    for this pattern.
    +
         We could furthermore combine the two get_object_list() invocations
         here by having repo_init_revisions() invoked on &pfd.revs, but I think
         clearly separating the two makes the flow clearer. Likewise
         redundantly but explicitly (i.e. redundant v.s. a "{ 0 }") "0" to
         "have_revs" early in cmd_pack_objects().
     
    -    This does add the future constraint to opt_parse_list_objects_filter()
    -    that we'll need to adjust this wrapper code if it looks at any other
    -    value of the "struct option" than the "value" member.
    -
    -    But that regression should be relatively easy to spot. I'm
    -    intentionally not initializing the "struct wrap" with e.g. "{ 0 }" so
    -    that various memory sanity checkers would spot that, we just
    -    initialize the "value" in po_filter_cb(). By doing this e.g. we'll die
    -    on e.g. this test if we were to use another member of "opt" in
    -    opt_parse_list_objects_filter()>
    -
    -        ./t5317-pack-objects-filter-objects.sh -vixd --valgrind-only=3
    -
         While we're at it add parentheses around the arguments to the OPT_*
         macros in in list-objects-filter-options.h, as we need to change those
         lines anyway. It doesn't matter in this case, but is good general
         practice.
     
         1. https://lore.kernel.org/git/619b757d98465dbc4995bdc11a5282fbfcbd3daa.1647970119.git.gitgitgadget@gmail.com
    -    2. https://lore.kernel.org/git/97de926904988b89b5663bd4c59c011a1723a8f5.1647970119.git.gitgitgadget@gmail.com/
    +    2. https://lore.kernel.org/git/97de926904988b89b5663bd4c59c011a1723a8f5.1647970119.git.gitgitgadget@gmail.com
    +    3. https://lore.kernel.org/git/patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/pack-objects.c: static int option_parse_unpack_unreachable(const struct
     +	struct rev_info revs;
     +};
     +
    -+static int po_filter_cb(const struct option *opt, const char *arg, int unset)
    ++static struct list_objects_filter_options *po_filter_revs_init(void *value)
     +{
    -+	struct po_filter_data *data = opt->value;
    -+	struct option wrap; /* don't initialize! */
    ++	struct po_filter_data *data = value;
     +
     +	repo_init_revisions(the_repository, &data->revs, NULL);
    -+	wrap.value = &data->revs.filter;
     +	data->have_revs = 1;
     +
    -+	return opt_parse_list_objects_filter(&wrap, arg, unset);
    ++	return &data->revs.filter;
     +}
     +
      int cmd_pack_objects(int argc, const char **argv, const char *prefix)
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
      			      N_("write a bitmap index if possible"),
      			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
     -		OPT_PARSE_LIST_OBJECTS_FILTER(&revs.filter),
    -+		OPT_PARSE_LIST_OBJECTS_FILTER_CB(&pfd, po_filter_cb),
    ++		OPT_PARSE_LIST_OBJECTS_FILTER_INIT(&pfd, po_filter_revs_init),
      		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
      		  N_("handling for missing objects"), PARSE_OPT_NONEG,
      		  option_parse_missing_action),
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
      	}
      	cleanup_preferred_base();
     
    + ## list-objects-filter-options.c ##
    +@@ list-objects-filter-options.c: int opt_parse_list_objects_filter(const struct option *opt,
    + 				  const char *arg, int unset)
    + {
    + 	struct list_objects_filter_options *filter_options = opt->value;
    ++	opt_lof_init init = (opt_lof_init)opt->defval;
    ++
    ++	if (init)
    ++		filter_options = init(opt->value);
    + 
    + 	if (unset || !arg)
    + 		list_objects_filter_set_no_filter(filter_options);
    +
      ## list-objects-filter-options.h ##
     @@ list-objects-filter-options.h: void parse_list_objects_filter(
    + 	struct list_objects_filter_options *filter_options,
    + 	const char *arg);
    + 
    ++/**
    ++ * The opt->value to opt_parse_list_objects_filter() is either a
    ++ * "struct list_objects_filter_option *" when using
    ++ * OPT_PARSE_LIST_OBJECTS_FILTER().
    ++ *
    ++ * Or, if using no "struct option" field is used by the callback,
    ++ * except the "defval" which is expected to be an "opt_lof_init"
    ++ * function, which is called with the "opt->value" and must return a
    ++ * pointer to the ""struct list_objects_filter_option *" to be used.
    ++ *
    ++ * The OPT_PARSE_LIST_OBJECTS_FILTER_INIT() can be used e.g. the
    ++ * "struct list_objects_filter_option" is embedded in a "struct
    ++ * rev_info", which the "defval" could be tasked with lazily
    ++ * initializing. See cmd_pack_objects() for an example.
    ++ */
      int opt_parse_list_objects_filter(const struct option *opt,
      				  const char *arg, int unset);
    ++typedef struct list_objects_filter_options *(*opt_lof_init)(void *);
    ++#define OPT_PARSE_LIST_OBJECTS_FILTER_INIT(fo, init) \
    ++	{ OPTION_CALLBACK, 0, "filter", (fo), N_("args"), \
    ++	  N_("object filtering"), 0, opt_parse_list_objects_filter, \
    ++	  (intptr_t)(init) }
      
    -+#define OPT_PARSE_LIST_OBJECTS_FILTER_CB(fo, cb) \
    -+	OPT_CALLBACK(0, "filter", (fo), N_("args"), \
    -+		     N_("object filtering"), (cb))
    -+
      #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
     -	OPT_CALLBACK(0, "filter", fo, N_("args"), \
     -	  N_("object filtering"), \
     -	  opt_parse_list_objects_filter)
    -+	OPT_PARSE_LIST_OBJECTS_FILTER_CB((fo), opt_parse_list_objects_filter)
    ++	OPT_PARSE_LIST_OBJECTS_FILTER_INIT((fo), NULL)
      
      /*
       * Translates abbreviated numbers in the filter's filter_spec into their

 builtin/pack-objects.c        | 28 +++++++++++++++++++++++-----
 list-objects-filter-options.c |  4 ++++
 list-objects-filter-options.h | 24 +++++++++++++++++++++---
 3 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d39f668ad56..09680fb6a8b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3857,6 +3857,21 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
+struct po_filter_data {
+	unsigned have_revs:1;
+	struct rev_info revs;
+};
+
+static struct list_objects_filter_options *po_filter_revs_init(void *value)
+{
+	struct po_filter_data *data = value;
+
+	repo_init_revisions(the_repository, &data->revs, NULL);
+	data->have_revs = 1;
+
+	return &data->revs.filter;
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -3867,7 +3882,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int rev_list_index = 0;
 	int stdin_packs = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
-	struct rev_info revs;
+	struct po_filter_data pfd = { .have_revs = 0 };
 
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -3954,7 +3969,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			      &write_bitmap_index,
 			      N_("write a bitmap index if possible"),
 			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
-		OPT_PARSE_LIST_OBJECTS_FILTER(&revs.filter),
+		OPT_PARSE_LIST_OBJECTS_FILTER_INIT(&pfd, po_filter_revs_init),
 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
 		  option_parse_missing_action),
@@ -3973,8 +3988,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 
-	repo_init_revisions(the_repository, &revs, NULL);
-
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
@@ -4076,7 +4089,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (revs.filter.choice) {
+	if (pfd.have_revs && pfd.revs.filter.choice) {
 		if (!pack_to_stdout)
 			die(_("cannot use --filter without --stdout"));
 		if (stdin_packs)
@@ -4152,7 +4165,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			add_unreachable_loose_objects();
 	} else if (!use_internal_rev_list) {
 		read_object_list_from_stdin();
+	} else if (pfd.have_revs) {
+		get_object_list(&pfd.revs, rp.nr, rp.v);
 	} else {
+		struct rev_info revs;
+
+		repo_init_revisions(the_repository, &revs, NULL);
 		get_object_list(&revs, rp.nr, rp.v);
 	}
 	cleanup_preferred_base();
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index f02d8df1422..4b25287886d 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -285,6 +285,10 @@ int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
+	opt_lof_init init = (opt_lof_init)opt->defval;
+
+	if (init)
+		filter_options = init(opt->value);
 
 	if (unset || !arg)
 		list_objects_filter_set_no_filter(filter_options);
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 90e4bc96252..ffc02d77e76 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -104,13 +104,31 @@ void parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg);
 
+/**
+ * The opt->value to opt_parse_list_objects_filter() is either a
+ * "struct list_objects_filter_option *" when using
+ * OPT_PARSE_LIST_OBJECTS_FILTER().
+ *
+ * Or, if using no "struct option" field is used by the callback,
+ * except the "defval" which is expected to be an "opt_lof_init"
+ * function, which is called with the "opt->value" and must return a
+ * pointer to the ""struct list_objects_filter_option *" to be used.
+ *
+ * The OPT_PARSE_LIST_OBJECTS_FILTER_INIT() can be used e.g. the
+ * "struct list_objects_filter_option" is embedded in a "struct
+ * rev_info", which the "defval" could be tasked with lazily
+ * initializing. See cmd_pack_objects() for an example.
+ */
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
+typedef struct list_objects_filter_options *(*opt_lof_init)(void *);
+#define OPT_PARSE_LIST_OBJECTS_FILTER_INIT(fo, init) \
+	{ OPTION_CALLBACK, 0, "filter", (fo), N_("args"), \
+	  N_("object filtering"), 0, opt_parse_list_objects_filter, \
+	  (intptr_t)(init) }
 
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
-	OPT_CALLBACK(0, "filter", fo, N_("args"), \
-	  N_("object filtering"), \
-	  opt_parse_list_objects_filter)
+	OPT_PARSE_LIST_OBJECTS_FILTER_INIT((fo), NULL)
 
 /*
  * Translates abbreviated numbers in the filter's filter_spec into their
-- 
2.35.1.1541.g9c2d54e20ab

