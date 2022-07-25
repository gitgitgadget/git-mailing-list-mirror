Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC85C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiGYMxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiGYMvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:51:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C44DBE04
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:51:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sz17so20387348ejc.9
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jGr9RHpnG/ryJjWtUqBR2Mrca3Q4/ttQAmmomJ4La7k=;
        b=NDvTGRNMs13C/qsZFzEItzUicraryjLc5S+7MwK+aZjy8obo1c73E+mbtbivGnSTKR
         E33DX/d8RZo+UZjRm4ju3In7YRuhelVNfZRDBPygqf7u2gBzRR+GFA9+lcGYk8a+KoZ2
         J3f41Fh54PNLCHWdfAoXO6oEXGXhkgqgQ2kO1nFhNh9TTVaOifxjTnZ3UpU0WNnzUc8j
         HyVw5OwCQTyYdmL6gHTv4GBbwnPzxrbXi9jzropkIKSiolpA8GX/Yy/yPp6BdH5dIjw/
         em6xzu6nGU8xaLpm0nxaG1qbFShmRd7BICy+acJYCAUXYW7A77JrJw7iQSdEOq4gIODv
         4ESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jGr9RHpnG/ryJjWtUqBR2Mrca3Q4/ttQAmmomJ4La7k=;
        b=nVYDdJc2NgGEnSIrU9RTeRiea4dP6CTCzl9uBMu2Gh0lqm0Rvuw8MjAy8nlZHPiRDv
         YOxFZZD75IEv8mmz++/rIZwsYdBMob0F31HF8R4tfRNvnaqAppuQgnhTXtxHtwU35MTn
         IyVCH/ZCxaatHGCUT3xI90Wyidyu90LZV7/hQezsa+bKnPGi4J4TAwmV+I9Zx9ZMWyjL
         D3QQa/19TDxie2ybsmbQELOOQXAMFW9phhQ+VnLZrBM2Nz/wcJRNdffkCk+F4jOhKs77
         pFbJJgtA2Da3Rqm4OSJv8dlMrY6r+mGWZK2HTNgN9jrgSXB8mW6bHsD68Z2czd/m5b1H
         WtBA==
X-Gm-Message-State: AJIora/JV7G9sKw4fVXzxDm7WqdsytZxeNRpUZwYzMuyCFqDnQn4+PZU
        PTiFMjpjFtfKG8q4sOdNWKFjxHMAKyM=
X-Google-Smtp-Source: AGRyM1uuqz2BYMtOT7MBeLvuzgoZY1CiEAqJwYM5SWOQAA8XX/lPWVKL5l34p2o0ra1yCxpQI1ciIg==
X-Received: by 2002:a17:907:c06:b0:701:eb60:ded with SMTP id ga6-20020a1709070c0600b00701eb600dedmr10303975ejc.178.1658753467267;
        Mon, 25 Jul 2022 05:51:07 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id dm21-20020a05640222d500b0043ab81e4230sm7029976edb.50.2022.07.25.05.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:51:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oFxY9-005hF6-Sj;
        Mon, 25 Jul 2022 14:51:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, gitster@pobox.com,
        newren@gmail.com, levraiphilippeblain@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5] submodule merge: update conflict error message
Date:   Mon, 25 Jul 2022 14:11:34 +0200
References: <20220712231935.2979727-1-calvinwan@google.com>
 <20220718214349.3379328-1-calvinwan@google.com>
 <220725.868rohragt.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <220725.868rohragt.gmgdl@evledraar.gmail.com>
Message-ID: <220725.86r129pd8m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Jul 18 2022, Calvin Wan wrote:
>
>
> One of the CI failures in "seen" is because of my topic to mark (among
> other things) t1500*.sh as passing with SANITIZE=3Dleak, and this change.
>
> Because...
>
>> ..
>>  	object_array_clear(&merges);
>>  cleanup:
>> +	if (!ret) {
>> +		if (!csub) {
>> +			CALLOC_ARRAY(csub, 1);
>> +		}
>> +		csub_item.oid =3D xstrdup(repo_find_unique_abbrev(&subrepo, b, DEFAUL=
T_ABBREV));
>> +		csub_item.path =3D xstrdup(path);
>> +		csub_item.resolution_exists =3D resolution_exists;
>> +		ALLOC_GROW(csub->items, csub->nr + 1, csub->alloc);
>
> ... in "cleanup" we're ALLOC_GROW()-ing? I haven't looked into this yet,
> but this seems susppect. This is line 1879 in the following stacktrace:
>=20=09
> 	+ git -C super merge branch1
> 	Failed to merge submodule dir/sub
> 	CONFLICT (submodule): Merge conflict in dir/sub
> 	Recursive merging with submodules currently only supports trivial cases.
> 	Please manually handle the merging of each conflicted submodule.
> 	This can be accomplished with the following steps:
> 	 - go to submodule (dir/sub), and either merge commit 7018b5f
> 	or update to an existing commit which has merged those changes
> 	 - come back to superproject, and `git add dir/sub` to record the above =
merge or update
> 	 - resolve any other conflicts in the superproject
> 	 - commit the resulting index in the superproject
> 	Automatic merge failed; fix conflicts and then commit the result.
>=20=09
> 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	=3D=3D31261=3D=3DERROR: LeakSanitizer: detected memory leaks
>=20=09
> 	Direct leak of 576 byte(s) in 1 object(s) allocated from:
> 	    #0 0x4565ad in __interceptor_realloc (git+0x4565ad)
> 	    #1 0x76ecfd in xrealloc wrapper.c:136:8
> 	    #2 0x64fcd3 in merge_submodule merge-ort.c:1879:3
> 	    #3 0x64ee9b in handle_content_merge merge-ort.c:2118:11
> 	    #4 0x651c14 in process_entry merge-ort.c:4056:17
> 	    #5 0x648c05 in process_entries merge-ort.c:4267:4
> 	    #6 0x646c03 in merge_ort_nonrecursive_internal merge-ort.c:4893:2
> 	    #7 0x6470f3 in merge_ort_internal merge-ort.c:4982:2
> 	    #8 0x646de0 in merge_incore_recursive merge-ort.c:5033:2
> 	    #9 0x652d1a in merge_ort_recursive merge-ort-wrappers.c:57:2
> 	    #10 0x4ec0f6 in try_merge_strategy builtin/merge.c:764:12
> 	    #11 0x4e9bf2 in cmd_merge builtin/merge.c:1710:9
> 	    #12 0x45a3aa in run_builtin git.c:466:11
> 	    #13 0x458e41 in handle_builtin git.c:720:3
> 	    #14 0x459d85 in run_argv git.c:787:4
> 	    #15 0x458bfa in cmd_main git.c:920:19
> 	    #16 0x56a049 in main common-main.c:56:11
> 	    #17 0x7fe592bca81c in __libc_start_main csu/../csu/libc-start.c:332:=
16
> 	    #18 0x431139 in _start (git+0x431139)

Looking at this a bit more this fixes it, and also the NIH allocation
pattern & what we can do with a "struct string_list" instead of managing
our own allocations.

I did wonder why you need to allocate the "oid" at all, i.e. at the time
of merge_submodules() can't we just squirrel away the "const struct
object_id *" and only when we emit the message later run
repo_find_unique_abbrev()?

I think we can do that, but it means re-init-ing the submodule, and I'm
not sure if there's any edge cases with the state changing between us
trying merge_submodules() and the eventual messages we emit.

But it would mean that we'd just need to allocate a pointer to that oid
+ resolution_exists.

Perhaps we could also continue down that path and do this with just one
allocation for that "oid/resolution_exists" side-data. I.e. you'd have a
second string_list in the struct, have a non-NULL util mean "resolution
exists", and the "string" there would be nodup'd (we could refer to the
"string" in the first one).

But I think all of that probably isn't worth it, but the below seems
like a good trade-off & good place to stop, and fixes the memory leak
this topic introduces.

 merge-ort.c | 69 +++++++++++++++++++++++++++++++++++----------------------=
----
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 154d33f2f45..5cf87f70b58 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -293,16 +293,17 @@ struct rename_info {
 };
=20
 struct conflicted_submodule_item {
-	char *oid;
-	char *path;
-	int resolution_exists;
+	char *abbrev;
+	int resolution_exists:1;
 };
=20
-struct conflicted_submodule_list {
-	struct conflicted_submodule_item *items;
-	size_t nr;
-	size_t alloc;
-};
+static void conflicted_submodule_item_free(void *util, const char *str)
+{
+	struct conflicted_submodule_item *item =3D util;
+
+	free(item->abbrev);
+	free(item);
+}
=20
 struct merge_options_internal {
 	/*
@@ -401,7 +402,7 @@ struct merge_options_internal {
 	int call_depth;
=20
 	/* field that holds submodule conflict information */
-	struct conflicted_submodule_list conflicted_submodules;
+	struct string_list conflicted_submodules;
 };
=20
 struct version_info {
@@ -701,6 +702,9 @@ static void clear_or_reinit_internal_opts(struct merge_=
options_internal *opti,
=20
 	mem_pool_discard(&opti->pool, 0);
=20
+	string_list_clear_func(&opti->conflicted_submodules,
+			       conflicted_submodule_item_free);
+
 	/* Clean out callback_data as well. */
 	FREE_AND_NULL(renames->callback_data);
 	renames->callback_data_nr =3D renames->callback_data_alloc =3D 0;
@@ -1756,8 +1760,6 @@ static int merge_submodule(struct merge_options *opt,
 	struct commit *commit_o, *commit_a, *commit_b;
 	int parent_count;
 	struct object_array merges;
-	struct conflicted_submodule_list *csub =3D &opt->priv->conflicted_submodu=
les;
-	struct conflicted_submodule_item csub_item;
 	int resolution_exists =3D 0;
=20
 	int i;
@@ -1870,15 +1872,17 @@ static int merge_submodule(struct merge_options *op=
t,
 	object_array_clear(&merges);
 cleanup:
 	if (!ret) {
-		if (!csub) {
-			CALLOC_ARRAY(csub, 1);
-		}
-		csub_item.oid =3D xstrdup(repo_find_unique_abbrev(&subrepo, b, DEFAULT_A=
BBREV));
-		csub_item.path =3D xstrdup(path);
-		csub_item.resolution_exists =3D resolution_exists;
-		ALLOC_GROW(csub->items, csub->nr + 1, csub->alloc);
-		csub->items[csub->nr++] =3D csub_item;
-		opt->priv->conflicted_submodules =3D *csub;
+		struct string_list *csub =3D &opt->priv->conflicted_submodules;
+		struct conflicted_submodule_item *util;
+		const char *abbrev;
+
+		abbrev =3D repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV);;
+
+		util =3D xmalloc(sizeof(*util));
+		util->abbrev =3D xstrdup(abbrev);
+		util->resolution_exists =3D resolution_exists;
+
+		string_list_append(csub, path)->util =3D util;
 	}
 	repo_clear(&subrepo);
 	return ret;
@@ -4465,23 +4469,26 @@ static int record_conflicted_index_entries(struct m=
erge_options *opt)
 	return errs;
 }
=20
-static void print_submodule_conflict_suggestion(struct conflicted_submodul=
e_list *csub) {
-	if (csub && csub->nr > 0) {
-		int i;
+static void print_submodule_conflict_suggestion(struct string_list *csub) {
+	if (csub->nr > 0) {
+		struct string_list_item *item;
+
 		printf(_("Recursive merging with submodules currently only supports triv=
ial cases.\n"
 			"Please manually handle the merging of each conflicted submodule.\n"
 			"This can be accomplished with the following steps:\n"));
-		for (i =3D 0; i < csub->nr; i++) {
+
+		for_each_string_list_item(item, csub) {
+			struct conflicted_submodule_item *util =3D item->util;
+
 			printf(_(" - go to submodule (%s), and either merge commit %s\n"
 				    "or update to an existing commit which has merged those changes\n"=
),
-					csub->items[i].path,
-					csub->items[i].oid);
-			if (csub->items[i].resolution_exists)
+					item->string, util->abbrev);
+			if (util->resolution_exists)
 				printf(_("such as one listed above\n"));
 		}
 		printf(_(" - come back to superproject, and `git add"));
-		for (i =3D 0; i < csub->nr; i++)
-			printf(_(" %s"), csub->items[i].path);
+		for_each_string_list_item(item, csub)
+			printf(_(" %s"), item->string);
 		printf(_("` to record the above merge or update \n"
 			" - resolve any other conflicts in the superproject\n"
 			" - commit the resulting index in the superproject\n"));
@@ -4538,6 +4545,8 @@ void merge_display_update_messages(struct merge_optio=
ns *opt,
 	string_list_clear(&olist, 0);
=20
 	print_submodule_conflict_suggestion(&opti->conflicted_submodules);
+	string_list_clear_func(&opti->conflicted_submodules,
+			       conflicted_submodule_item_free);
=20
 	/* Also include needed rename limit adjustment now */
 	diff_warn_rename_limit("merge.renamelimit",
@@ -4795,6 +4804,8 @@ static void merge_start(struct merge_options *opt, st=
ruct merge_result *result)
 	 */
 	strmap_init(&opt->priv->conflicts);
=20
+	string_list_init_dup(&opt->priv->conflicted_submodules);
+
 	trace2_region_leave("merge", "allocate/init", opt->repo);
 }
=20
