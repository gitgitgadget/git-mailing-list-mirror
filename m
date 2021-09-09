Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D10C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5866113A
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhIIJih (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhIIJih (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 05:38:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891DC061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 02:37:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bt14so2331583ejb.3
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 02:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iK6YHFGa3Ltq7CE4shyQMYHfGkpXllayUH/osr7IAyY=;
        b=pgSznBy/bWKXuU8Rob8MqUWL2zK4nftmeHTvKAb4OZ9DaA81B9oX+edkgXBVNb9ugN
         84BUBSxAJb9HA7MEUC4K0DpYvQp6HBauM4ISTuasW6I2CbfgrbF/y0Z7jSs+gODwkMPZ
         kgwdao+PcdiUtAMr8OBz5EADsn5vXjexhrs+zHuH1C/kLWMULCiwRhOOhn4gxypGc2Re
         ljBOi/rnvQo7i5WQdgIAb6VxCcftmROeOxch/XZ140LcJl2/rXCb9jOPqQxnkRNP3Y/G
         6/nA9W9LNQUHvM7GLuObH1E+VadWEul8dtkvgiLSrcmmgXEv6LH+Hliq3RvWS3awib+R
         ZHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iK6YHFGa3Ltq7CE4shyQMYHfGkpXllayUH/osr7IAyY=;
        b=yO7iTRmFc3KOH7dNHFEQ1K6vvanuqQIQAqsURErhTjldcGoonEIH25BWwbzDmtKelO
         XNgJvN7c1KT8jmogd8s0Xm6/RFHRxiYIMiRT4rfvSpfA7E+e0FCeoHonM9RyeaG0fdXu
         Qai8mACoLqyQvaYEbfMnmxGGHI20BrU4oxxI2na2NX6hKGswvBhgIlyGyJLinuuOdy6K
         6JTZ+kABOulE/ePKBBlSf1Tb5dcC0oKwVUzCUdyu81Sk+pWAVo4VUm05EnPniyS/5eL+
         hKSqeIYg6b2dVnNsmbXhMsVTvQxJdpo7vG6Dl1n1dcL2yWURwSB/rkH0srAItii1AQuG
         zl6w==
X-Gm-Message-State: AOAM533tKGW7LdqNAqkphQ6qhASzKbX00GWXmNT3PQ00G/0oaAqV6kzw
        zcEnfbcD+gdB66pmWD9Ci7Y/TxZ0F63aiQ==
X-Google-Smtp-Source: ABdhPJxwg0yVj4dfuiU0pgN/zigmKCOCjAIHpDYC3yqyj4P2pwVDPK0AxTczM/x5pqGlQDBtiimPCQ==
X-Received: by 2002:a17:906:4346:: with SMTP id z6mr2370077ejm.403.1631180246031;
        Thu, 09 Sep 2021 02:37:26 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qt23sm644883ejb.26.2021.09.09.02.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 02:37:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/4] midx.c: respect 'pack.writeBitmapHashcache' when
 writing bitmaps
Date:   Thu, 09 Sep 2021 11:34:16 +0200
References: <cover.1631049462.git.me@ttaylorr.com>
 <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
 <874kavkfjg.fsf@evledraar.gmail.com> <YTgfuAKJv1rXXm7i@nand.local>
 <87zgsmdu6d.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87zgsmdu6d.fsf@evledraar.gmail.com>
Message-ID: <87v93adr8r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 09 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Sep 07 2021, Taylor Blau wrote:
>
>> On Wed, Sep 08, 2021 at 03:40:19AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>>
>>> On Tue, Sep 07 2021, Taylor Blau wrote:
>>>
>>> > +static int git_multi_pack_index_write_config(const char *var, const =
char *value,
>>> > +					     void *cb)
>>> > +{
>>> > +	if (!strcmp(var, "pack.writebitmaphashcache")) {
>>> > +		if (git_config_bool(var, value))
>>> > +			opts.flags |=3D MIDX_WRITE_BITMAP_HASH_CACHE;
>>> > +		else
>>> > +			opts.flags &=3D ~MIDX_WRITE_BITMAP_HASH_CACHE;
>>> > +	}
>>> > +
>>> > +	/*
>>> > +	 * No need to fall-back to 'git_default_config', since this was alr=
eady
>>> > +	 * called in 'cmd_multi_pack_index()'.
>>> > +	 */
>>> > +	return 0;
>>> > +}
>>> > +
>>> >  static int cmd_multi_pack_index_write(int argc, const char **argv)
>>> >  {
>>> >  	struct option *options;
>>> > @@ -73,6 +90,10 @@ static int cmd_multi_pack_index_write(int argc, co=
nst char **argv)
>>> >  		OPT_END(),
>>> >  	};
>>> >
>>> > +	opts.flags |=3D MIDX_WRITE_BITMAP_HASH_CACHE;
>>> > +
>>> > +	git_config(git_multi_pack_index_write_config, NULL);
>>> > +
>>>
>>> Since this is a write-only config option it would seem more logical to
>>> just call git_config() once, and have a git_multip_pack_index_config,
>>> which then would fall back on git_default_config, so we iterate it once,
>>> and no need for a comment about the oddity.
>>
>> Perhaps, but I'm not crazy about each sub-command having to call
>> git_config() itself when 'write' is the only one that actually has any
>> values to read.
>>
>> FWIW, the commit-graph builtin does the same thing as is written here
>> (calling git_config() twice, once in cmd_commit_graph() with
>> git_default_config as the callback and again in cmd_commit_graph_write()
>> with git_commit_graph_write_config as the callback).
>
> I didn't notice your earlier d356d5debe5 (commit-graph: introduce
> 'commitGraph.maxNewFilters', 2020-09-17). As an aside the test added in
> that commit seems to be broken or not testing that code change at all,
> if I comment out the git_config(git_commit_graph_write_config, &opts)
> it'll pass.
>
> As a comment on this series I'd find 4/4 squashed into 3/4 easier to
> read, when I did a "git blame" and found d356d5debe5 I discovered the
> test right away, if and when this gets merged someone might do the same,
> but not find the test as easily (they'd probably then grep the config
> variable name and find it eventually...).
>
> More importantly, the same issue with the commit-graph test seems to be
> the case here, if I comment out the added config reading code it'll
> still pass, it seems to be testing something, but not that the config is
> being read.
>
>> So I'm not opposed to cleaning it up, but I'd rather be consistent with
>> the existing behavior. To be honest, I'm not at all convinced that
>> reading the config twice is a bottleneck here when compared to
>> generating a MIDX.
>
> It's never going to matter at all for performance, I should have been
> clearer with my comments. I meant them purely as a "this code is hard to
> follow" comment.
>
> I.e. since we read the config twice, and in both commit-graph.c and
> multi-pack-index.c munge and write to the "opts" struct on
> parse_options(), you'll need to follow logic like:
>
>     1. Read config in cmd_X(), might set variable xyz
>     2. Do parse_options() in cmd_X(), might set variable xyz also
>     3. Now in cmd_X_subcmd(), read config, might set variable xyz
>     4. Do parse_options() in cmd_X(), migh set variable xyz also
>
> Of course in this case the relevant opts.flags only matters for the
> "write" subcommand, so on more careful reading we don't need to worry
> about the value flip-flopping between config defaults and getopts
> settings, but just in terms of establishing a pattern we'll be following
> in the subcommand built-ins I think this is setting us up for more
> complexity than is needed.
>
> As far as being consistent with existing behavior, in git-worktree,
> git-stash which are both similarly structured subcommands we follow the
> pattern of calling git_config() once, it seems to me better to follow
> that pattern than the one in d356d5debe5 if the config can be
> unambiguously parsed in one pass.

In similar spirit as my
https://lore.kernel.org/git/87v93bidhn.fsf@evledraar.gmail.com/ I
started seeing if not doing the flags via getopt but instead variables &
setting the flags later was better, and came up with this on top. Not
for this series, more to muse on how we can write these subcommands in a
simpler manner (or not).

I may have discovered a subtle bug in the process, in
cmd_multi_pack_index_repack() we end up calling write_midx_internal(),
which cares about MIDX_WRITE_REV_INDEX, but only
cmd_multi_pack_index_write() will set that flag, both before & after my
patch. Are we using the wrong flags during repack as a result?

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index dd1652531bf..1b97b2ee4e1 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -45,14 +45,16 @@ static char const * const builtin_multi_pack_index_usag=
e[] =3D {
 static struct opts_multi_pack_index {
 	const char *object_dir;
 	const char *preferred_pack;
-	unsigned long batch_size;
-	unsigned flags;
-} opts;
+	int progress;
+	int write_bitmap_hash_cache;
+} opts =3D {
+	.write_bitmap_hash_cache =3D -1,
+};
=20
 static struct option common_opts[] =3D {
 	OPT_FILENAME(0, "object-dir", &opts.object_dir,
 	  N_("object directory containing set of packfile and pack-index pairs")),
-	OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"), MIDX_=
PROGRESS),
+	OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 	OPT_END(),
 };
=20
@@ -61,38 +63,29 @@ static struct option *add_common_options(struct option =
*prev)
 	return parse_options_concat(common_opts, prev);
 }
=20
-static int git_multi_pack_index_write_config(const char *var, const char *=
value,
-					     void *cb)
+static int git_multi_pack_index_config(const char *var, const char *value,
+				       void *cb)
 {
 	if (!strcmp(var, "pack.writebitmaphashcache")) {
-		if (git_config_bool(var, value))
-			opts.flags |=3D MIDX_WRITE_BITMAP_HASH_CACHE;
-		else
-			opts.flags &=3D ~MIDX_WRITE_BITMAP_HASH_CACHE;
+		opts.write_bitmap_hash_cache =3D git_config_bool(var, value);
+		return 0;
 	}
=20
-	/*
-	 * No need to fall-back to 'git_default_config', since this was already
-	 * called in 'cmd_multi_pack_index()'.
-	 */
-	return 0;
+	return git_default_config(var, value, NULL);
 }
=20
 static int cmd_multi_pack_index_write(int argc, const char **argv)
 {
 	struct option *options;
+	static int write_bitmap =3D 0;
 	static struct option builtin_multi_pack_index_write_options[] =3D {
 		OPT_STRING(0, "preferred-pack", &opts.preferred_pack,
 			   N_("preferred-pack"),
 			   N_("pack for reuse when computing a multi-pack bitmap")),
-		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
-			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
+		OPT_BOOL(0, "bitmap", &write_bitmap, N_("write multi-pack bitmap")),
 		OPT_END(),
 	};
-
-	opts.flags |=3D MIDX_WRITE_BITMAP_HASH_CACHE;
-
-	git_config(git_multi_pack_index_write_config, NULL);
+	unsigned flags =3D 0;
=20
 	options =3D add_common_options(builtin_multi_pack_index_write_options);
=20
@@ -107,8 +100,15 @@ static int cmd_multi_pack_index_write(int argc, const =
char **argv)
=20
 	FREE_AND_NULL(options);
=20
-	return write_midx_file(opts.object_dir, opts.preferred_pack,
-			       opts.flags);
+	if (opts.progress)
+		flags |=3D MIDX_PROGRESS;
+	/* Both -1 default and 1 via config */
+	if (!opts.write_bitmap_hash_cache)
+		flags |=3D MIDX_WRITE_BITMAP_HASH_CACHE;
+	if (write_bitmap)
+		flags |=3D MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX;
+
+	return write_midx_file(opts.object_dir, opts.preferred_pack, flags);
 }
=20
 static int cmd_multi_pack_index_verify(int argc, const char **argv)
@@ -124,7 +124,7 @@ static int cmd_multi_pack_index_verify(int argc, const =
char **argv)
 		usage_with_options(builtin_multi_pack_index_verify_usage,
 				   options);
=20
-	return verify_midx_file(the_repository, opts.object_dir, opts.flags);
+	return verify_midx_file(the_repository, opts.object_dir, opts.progress);
 }
=20
 static int cmd_multi_pack_index_expire(int argc, const char **argv)
@@ -140,14 +140,15 @@ static int cmd_multi_pack_index_expire(int argc, cons=
t char **argv)
 		usage_with_options(builtin_multi_pack_index_expire_usage,
 				   options);
=20
-	return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
+	return expire_midx_packs(the_repository, opts.object_dir, opts.progress);
 }
=20
 static int cmd_multi_pack_index_repack(int argc, const char **argv)
 {
+	static unsigned long batch_size =3D 0;
 	struct option *options;
 	static struct option builtin_multi_pack_index_repack_options[] =3D {
-		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
+		OPT_MAGNITUDE(0, "batch-size", &batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch tha=
t is larger than this size")),
 		OPT_END(),
 	};
@@ -167,7 +168,8 @@ static int cmd_multi_pack_index_repack(int argc, const =
char **argv)
 	FREE_AND_NULL(options);
=20
 	return midx_repack(the_repository, opts.object_dir,
-			   (size_t)opts.batch_size, opts.flags);
+			   (size_t)batch_size,
+			   opts.progress ? MIDX_PROGRESS : 0);
 }
=20
 int cmd_multi_pack_index(int argc, const char **argv,
@@ -175,10 +177,10 @@ int cmd_multi_pack_index(int argc, const char **argv,
 {
 	struct option *builtin_multi_pack_index_options =3D common_opts;
=20
-	git_config(git_default_config, NULL);
+	git_config(git_multi_pack_index_config, NULL);
=20
 	if (isatty(2))
-		opts.flags |=3D MIDX_PROGRESS;
+		opts.progress =3D 1;
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_multi_pack_index_options,
 			     builtin_multi_pack_index_usage,
diff --git a/midx.c b/midx.c
index 6c35dcd557c..3e722888d69 100644
--- a/midx.c
+++ b/midx.c
@@ -1482,7 +1482,7 @@ static int compare_pair_pos_vs_id(const void *_a, con=
st void *_b)
 			display_progress(progress, _n); \
 	} while (0)
=20
-int verify_midx_file(struct repository *r, const char *object_dir, unsigne=
d flags)
+int verify_midx_file(struct repository *r, const char *object_dir, int opt=
_progress)
 {
 	struct pair_pos_vs_id *pairs =3D NULL;
 	uint32_t i;
@@ -1505,7 +1505,7 @@ int verify_midx_file(struct repository *r, const char=
 *object_dir, unsigned flag
 	if (!midx_checksum_valid(m))
 		midx_report(_("incorrect checksum"));
=20
-	if (flags & MIDX_PROGRESS)
+	if (opt_progress)
 		progress =3D start_delayed_progress(_("Looking for referenced packfiles"=
),
 					  m->num_packs);
 	for (i =3D 0; i < m->num_packs; i++) {
@@ -1534,7 +1534,7 @@ int verify_midx_file(struct repository *r, const char=
 *object_dir, unsigned flag
 		return verify_midx_error;
 	}
=20
-	if (flags & MIDX_PROGRESS)
+	if (opt_progress)
 		progress =3D start_sparse_progress(_("Verifying OID order in multi-pack-=
index"),
 						 m->num_objects - 1);
 	for (i =3D 0; i < m->num_objects - 1; i++) {
@@ -1563,14 +1563,14 @@ int verify_midx_file(struct repository *r, const ch=
ar *object_dir, unsigned flag
 		pairs[i].pack_int_id =3D nth_midxed_pack_int_id(m, i);
 	}
=20
-	if (flags & MIDX_PROGRESS)
+	if (opt_progress)
 		progress =3D start_sparse_progress(_("Sorting objects by packfile"),
 						 m->num_objects);
 	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
 	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
 	stop_progress(&progress);
=20
-	if (flags & MIDX_PROGRESS)
+	if (opt_progress)
 		progress =3D start_sparse_progress(_("Verifying object offsets"), m->num=
_objects);
 	for (i =3D 0; i < m->num_objects; i++) {
 		struct object_id oid;
diff --git a/midx.h b/midx.h
index 541d9ac728d..0dfe6a54ef3 100644
--- a/midx.h
+++ b/midx.h
@@ -64,7 +64,7 @@ int prepare_multi_pack_index_one(struct repository *r, co=
nst char *object_dir, i
=20
 int write_midx_file(const char *object_dir, const char *preferred_pack_nam=
e, unsigned flags);
 void clear_midx_file(struct repository *r);
-int verify_midx_file(struct repository *r, const char *object_dir, unsigne=
d flags);
+int verify_midx_file(struct repository *r, const char *object_dir, int opt=
_progress);
 int expire_midx_packs(struct repository *r, const char *object_dir, unsign=
ed flags);
 int midx_repack(struct repository *r, const char *object_dir, size_t batch=
_size, unsigned flags);
=20
