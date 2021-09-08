Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71245C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A52160C51
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbhIHKMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhIHKML (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 06:12:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8610BC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 03:11:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id me10so3024249ejb.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KVoFJ8TAMo7pJuUBZfTBNfuw0nGDPlwV3BrwR1LzTs8=;
        b=eFPWgpG/DxNBCo4U7dwxXux2gjX7dhjRFYDTXF0ojb7uelA6enIwd86qKa7VnZEBlA
         T2JGWYUp6DSPRMGUMJbsa5wCK1q4bTh50YnpvHlTo37iMhina+lwh1Z+gzB7hxC6YP0O
         CyzRiCTKvUfZzNUkzXAl1ycZUPDNVd91OtKUg1ld9e+UqyXwP2rekCIMoADXthQ3d5LU
         2q3t7H4rDNhzBi6fC2o0J/BpEv5g5dvPknF+S1qKFlsA6HeGeCChOWowNUUusOhOzWqq
         n2LkL/EABzdM4WtqbcGR7u72kh3eLs+r92xEyuezw2yZxqFZua/wr5e7C5r+v++1iN/V
         M30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KVoFJ8TAMo7pJuUBZfTBNfuw0nGDPlwV3BrwR1LzTs8=;
        b=PtFDnGwjGrr7MtglHY3VMPsoZDzZjej4LLbDBpk3nD+CvKe+6isPytkXXcVmDqexLJ
         VcfVtnwDbKTefZhlWErn3SnKGAPd1wnJIrh4F4QhYPnNkO9AmJVX2zflX+nSptP7YZ0+
         ZodqOmeeYkvNTMHCjKPKQsMZ0lu4SJerue8jFgaDmP0aNfbrslHzIBK589YF1ca1qeoQ
         haQylpkvW8isMeQcy7vLJKZpRGee0W1sbt5jRPewOalTYXXN73K2lOOxIbhtfugHKyII
         4TEQE9JmkxOQAjIBeHsj19R3sasUsHp98uPAxevuCnC/dL6hDfvU87JGpxC6yGrMCKUR
         JCCQ==
X-Gm-Message-State: AOAM533ELp0sNJsWgyC/4UL3JHHfbmKcAB8W+ax6FbsZ74y6ML3zuDlL
        A2GAaOunMemEnXyo6ItsAtjH0PGdBCUJsg==
X-Google-Smtp-Source: ABdhPJwS/pCYuE7fRGYOGUTjtl2CIVQfFzF4FlRh1iqmYL2Q79TuLoWpjRk+fmctQ/xpaZXOeGywNA==
X-Received: by 2002:a17:906:9914:: with SMTP id zl20mr3199486ejb.263.1631095861673;
        Wed, 08 Sep 2021 03:11:01 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bj21sm776442ejb.42.2021.09.08.03.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 03:11:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] pack-write: rename *.idx file into place last
 (really!)
Date:   Wed, 08 Sep 2021 11:18:19 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
 <patch-v2-4.4-70f4a9767d-20210908T003631Z-avarab@gmail.com>
 <87lf47kgkh.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87lf47kgkh.fsf@evledraar.gmail.com>
Message-ID: <87v93bidhn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Sep 08 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Follow-up a preceding commit (pack-write.c: rename `.idx` file into
>> place last, 2021-08-16)[1] and rename the *.idx file in-place after we
>> write the *.bitmap. The preceding commit fixed the issue of *.idx
>> being written before *.rev files, but did not do so for *.idx files.
>>
>> See 7cc8f971085 (pack-objects: implement bitmap writing, 2013-12-21)
>> for commentary at the time when *.bitmap was implemented about how
>> those files are written out, nothing in that commit contradicts what's
>> being done here.
>>
>> Note that the referenced earlier commit[1] is overly optimistic about
>> "clos[ing the] race", i.e. yes we'll now write the files in the right
>> order, but we might still race due to our sloppy use of fsync(). See
>> the thread at [2] for a rabbit hole of various discussions about
>> filesystem races in the face of doing and not doing fsync() (and if
>> doing fsync(), not doing it properly).
>
> Actually I think it's a bit worse than that, we will unconditionally
> fsync() the *.pack we write out, but in stage_tmp_packfiles() (the
> behavior pre-dates both this series and its parent, I just think my
> stage_tmp_packfiles() is easier to follow) we'll not write the *.idx
> file with fsync() since we won't pass WRITE_IDX_VERIFY.
>
> The same goes for *.rev (which oddly makes its fsync() conditional on
> WRITE_IDX_VERIFY), but not *.bitmap, which fsyncs unconditionally just
> like *.pack does.

I was confused here, we use fsync() with *.bitmap because there's no
--verify mode for it, i.e. we'll always fsync() the *.rev files if we're
actually writing them "for real", the non-fsync() path is when we're
doing the "noop-write" to /dev/null with "index-pack --verify",
i.e. writing to an FD without an associated "real" filename.

That we use WRITE_IDX_VERIFY to decide on that fsync() for the *.rev
files, as opposed to WRITE_REV_VERIFY is a bug in 8ef50d9958
(pack-write.c: prepare to write 'pack-*.rev' files, 2021-01-25).

In practice if WRITE_REV_VERIFY is true then WRITE_IDX_VERIFY is true as
well. See e37d0b8730 (builtin/index-pack.c: write reverse indexes,
2021-01-25) and its interaction with 68be2fea50 (receive-pack,
fetch-pack: reject bogus pack that records objects twice,
2011-11-16). I.e. both flags are set if --verify is there.

So it's not a bug as far as the behavior of the program goes, it just
makes for some very confusing code. Why should *.rev fsyncing be
contingent on whether or not we want to fsync *.idx files on writes? It
shouldn't, but it turns out those two flags always go hand in hand if
we're writing *.rev at all.

But re the thread started at
<patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com> about how
exactly we inspect these flags I think we should just take that change
as-is for now, and refactor & fix this properly later.

Once write_rev_file{_order}() don't pretend to take the trie-state
bitflags of WRITE_REV|WRITE_REV_VERIFY|WRITE_IDX_VERIFY but just take a
boolean "int write_file" the whole callchain & confusion around "do we
have more than 1 flag?" goes away.

I.e. something like the end-state shown by this patch, which I'm not
submitting now because it conflicts with the other in-flight topic (and
it's on top of some trivial but not-included whitespace changes in
pack.h):

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 20406f6775..69301fc044 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -778,7 +778,7 @@ static const char *create_index(void)
 		die("internal consistency error creating the index");
=20
 	tmpfile =3D write_idx_file(NULL, idx, object_count, &pack_idx_opts,
-				 pack_data->hash);
+				 pack_data->hash, 0);
 	free(idx);
 	return tmpfile;
 }
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8336466865..b9c2a21216 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1590,12 +1590,9 @@ static int git_index_pack_config(const char *k, cons=
t char *v, void *cb)
 		}
 		return 0;
 	}
-	if (!strcmp(k, "pack.writereverseindex")) {
-		if (git_config_bool(k, v))
-			opts->flags |=3D WRITE_REV;
-		else
-			opts->flags &=3D ~WRITE_REV;
-	}
+	if (!strcmp(k, "pack.writereverseindex"))
+		opts->write_rev =3D git_config_bool(k, v);
+
 	return git_default_config(k, v, cb);
 }
=20
@@ -1713,7 +1710,7 @@ static void show_pack_info(int stat_only)
=20
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, fix_thin_pack =3D 0, verify =3D 0, stat_only =3D 0, rev_index;
+	int i, fix_thin_pack =3D 0, verify =3D 0, stat_only =3D 0;
 	const char *curr_index;
 	const char *curr_rev_index =3D NULL;
 	const char *index_name =3D NULL, *pack_name =3D NULL, *rev_index_name =3D=
 NULL;
@@ -1747,10 +1744,8 @@ int cmd_index_pack(int argc, const char **argv, cons=
t char *prefix)
 	if (prefix && chdir(prefix))
 		die(_("Cannot come back to cwd"));
=20
-	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
-		rev_index =3D 1;
-	else
-		rev_index =3D !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
+	opts.write_rev =3D git_env_bool(GIT_TEST_WRITE_REV_INDEX,
+				       opts.write_rev);
=20
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
@@ -1831,9 +1826,9 @@ int cmd_index_pack(int argc, const char **argv, const=
 char *prefix)
 					die(_("unknown hash algorithm '%s'"), arg);
 				repo_set_hash_algo(the_repository, hash_algo);
 			} else if (!strcmp(arg, "--rev-index")) {
-				rev_index =3D 1;
+				opts.write_rev =3D 1;
 			} else if (!strcmp(arg, "--no-rev-index")) {
-				rev_index =3D 0;
+				opts.write_rev =3D 0;
 			} else
 				usage(index_pack_usage);
 			continue;
@@ -1855,9 +1850,7 @@ int cmd_index_pack(int argc, const char **argv, const=
 char *prefix)
 	if (!index_name && pack_name)
 		index_name =3D derive_filename(pack_name, "pack", "idx", &index_name_buf=
);
=20
-	opts.flags &=3D ~(WRITE_REV | WRITE_REV_VERIFY);
-	if (rev_index) {
-		opts.flags |=3D verify ? WRITE_REV_VERIFY : WRITE_REV;
+	if (opts.write_rev) {
 		if (index_name)
 			rev_index_name =3D derive_filename(index_name,
 							 "idx", "rev",
@@ -1868,10 +1861,9 @@ int cmd_index_pack(int argc, const char **argv, cons=
t char *prefix)
 		if (!index_name)
 			die(_("--verify with no packfile name given"));
 		read_idx_option(&opts, index_name);
-		opts.flags |=3D WRITE_IDX_VERIFY | WRITE_IDX_STRICT;
 	}
 	if (strict)
-		opts.flags |=3D WRITE_IDX_STRICT;
+		opts.write_idx_strict =3D 1;
=20
 	if (HAVE_THREADS && !nr_threads) {
 		nr_threads =3D online_cpus();
@@ -1915,11 +1907,12 @@ int cmd_index_pack(int argc, const char **argv, con=
st char *prefix)
 	ALLOC_ARRAY(idx_objects, nr_objects);
 	for (i =3D 0; i < nr_objects; i++)
 		idx_objects[i] =3D &objects[i].idx;
-	curr_index =3D write_idx_file(index_name, idx_objects, nr_objects, &opts,=
 pack_hash);
-	if (rev_index)
+	curr_index =3D write_idx_file(index_name, idx_objects, nr_objects, &opts,
+				    pack_hash, verify);
+	if (opts.write_rev)
 		curr_rev_index =3D write_rev_file(rev_index_name, idx_objects,
 						nr_objects, pack_hash,
-						opts.flags);
+						verify);
 	free(idx_objects);
=20
 	if (!verify)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index df49f656b9..1dae01800f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3139,10 +3139,7 @@ static int git_pack_config(const char *k, const char=
 *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "pack.writereverseindex")) {
-		if (git_config_bool(k, v))
-			pack_idx_opts.flags |=3D WRITE_REV;
-		else
-			pack_idx_opts.flags &=3D ~WRITE_REV;
+		pack_idx_opts.write_rev =3D git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
@@ -4030,8 +4027,8 @@ int cmd_pack_objects(int argc, const char **argv, con=
st char *prefix)
=20
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
-	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
-		pack_idx_opts.flags |=3D WRITE_REV;
+	pack_idx_opts.write_rev =3D git_env_bool(GIT_TEST_WRITE_REV_INDEX,
+					       pack_idx_opts.write_rev);
=20
 	progress =3D isatty(2);
 	argc =3D parse_options(argc, argv, prefix, pack_objects_options,
diff --git a/midx.c b/midx.c
index 321c6fdd2f..63da740cd4 100644
--- a/midx.c
+++ b/midx.c
@@ -874,7 +874,7 @@ static void write_midx_reverse_index(char *midx_name, u=
nsigned char *midx_hash,
 	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
=20
 	tmp_file =3D write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
-					midx_hash, WRITE_REV);
+					midx_hash, 0);
=20
 	if (finalize_object_file(tmp_file, buf.buf))
 		die(_("cannot store reverse index file"));
diff --git a/pack-write.c b/pack-write.c
index 1883848e7c..4f54191499 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -44,7 +44,7 @@ static int need_large_offset(off_t offset, const struct p=
ack_idx_option *opts)
  */
 const char *write_idx_file(const char *index_name, struct pack_idx_entry *=
*objects,
 			   int nr_objects, const struct pack_idx_option *opts,
-			   const unsigned char *sha1)
+			   const unsigned char *sha1, int verify)
 {
 	struct hashfile *f;
 	struct pack_idx_entry **sorted_by_sha, **list, **last;
@@ -65,7 +65,7 @@ const char *write_idx_file(const char *index_name, struct=
 pack_idx_entry **objec
 	else
 		sorted_by_sha =3D list =3D last =3D NULL;
=20
-	if (opts->flags & WRITE_IDX_VERIFY) {
+	if (verify) {
 		assert(index_name);
 		f =3D hashfd_check(index_name);
 	} else {
@@ -119,7 +119,7 @@ const char *write_idx_file(const char *index_name, stru=
ct pack_idx_entry **objec
 		if (index_version < 2)
 			hashwrite_be32(f, obj->offset);
 		hashwrite(f, obj->oid.hash, the_hash_algo->rawsz);
-		if ((opts->flags & WRITE_IDX_STRICT) &&
+		if (opts->write_idx_strict &&
 		    (i && oideq(&list[-2]->oid, &obj->oid)))
 			die("The same object %s appears twice in the pack",
 			    oid_to_hex(&obj->oid));
@@ -162,8 +162,7 @@ const char *write_idx_file(const char *index_name, stru=
ct pack_idx_entry **objec
=20
 	hashwrite(f, sha1, the_hash_algo->rawsz);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
-				    ((opts->flags & WRITE_IDX_VERIFY)
-				    ? 0 : CSUM_FSYNC));
+			  (verify ? 0 : CSUM_FSYNC));
 	return index_name;
 }
=20
@@ -218,22 +217,19 @@ const char *write_rev_file(const char *rev_name,
 			   struct pack_idx_entry **objects,
 			   uint32_t nr_objects,
 			   const unsigned char *hash,
-			   unsigned flags)
+			   int verify)
 {
 	uint32_t *pack_order;
 	uint32_t i;
 	const char *ret;
=20
-	if (!(flags & WRITE_REV) && !(flags & WRITE_REV_VERIFY))
-		return NULL;
-
 	ALLOC_ARRAY(pack_order, nr_objects);
 	for (i =3D 0; i < nr_objects; i++)
 		pack_order[i] =3D i;
 	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);
=20
 	ret =3D write_rev_file_order(rev_name, pack_order, nr_objects, hash,
-				   flags);
+				   verify);
=20
 	free(pack_order);
=20
@@ -244,15 +240,12 @@ const char *write_rev_file_order(const char *rev_name,
 				 uint32_t *pack_order,
 				 uint32_t nr_objects,
 				 const unsigned char *hash,
-				 unsigned flags)
+				 int verify)
 {
 	struct hashfile *f;
 	int fd;
=20
-	if ((flags & WRITE_REV) && (flags & WRITE_REV_VERIFY))
-		die(_("cannot both write and verify reverse index"));
-
-	if (flags & WRITE_REV) {
+	if (!verify) {
 		if (!rev_name) {
 			struct strbuf tmp_file =3D STRBUF_INIT;
 			fd =3D odb_mkstemp(&tmp_file, "pack/tmp_rev_XXXXXX");
@@ -264,7 +257,7 @@ const char *write_rev_file_order(const char *rev_name,
 				die_errno("unable to create '%s'", rev_name);
 		}
 		f =3D hashfd(fd, rev_name);
-	} else if (flags & WRITE_REV_VERIFY) {
+	} else {
 		struct stat statbuf;
 		if (stat(rev_name, &statbuf)) {
 			if (errno =3D=3D ENOENT) {
@@ -274,8 +267,7 @@ const char *write_rev_file_order(const char *rev_name,
 				die_errno(_("could not stat: %s"), rev_name);
 		}
 		f =3D hashfd_check(rev_name);
-	} else
-		return NULL;
+	}
=20
 	write_rev_header(f);
=20
@@ -286,7 +278,7 @@ const char *write_rev_file_order(const char *rev_name,
 		die(_("failed to make %s readable"), rev_name);
=20
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
-				    ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
+			  (verify ? 0 : CSUM_FSYNC));
=20
 	return rev_name;
 }
@@ -479,12 +471,13 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 		die_errno("unable to make temporary pack file readable");
=20
 	idx_tmp_name =3D write_idx_file(NULL, written_list, nr_written,
-				      pack_idx_opts, hash);
+				      pack_idx_opts, hash, 0);
 	if (adjust_shared_perm(idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
=20
-	rev_tmp_name =3D write_rev_file(NULL, written_list, nr_written, hash,
-				      pack_idx_opts->flags);
+	if (pack_idx_opts->write_rev)
+		rev_tmp_name =3D write_rev_file(NULL, written_list, nr_written, hash,
+					      0);
=20
 	strbuf_addf(name_buffer, "%s.pack", hash_to_hex(hash));
=20
diff --git a/pack.h b/pack.h
index aa23be74df..e096dea4c9 100644
--- a/pack.h
+++ b/pack.h
@@ -38,12 +38,8 @@ struct pack_header {
 #define PACK_IDX_SIGNATURE 0xff744f63	/* "\377tOc" */
=20
 struct pack_idx_option {
-	unsigned flags;
-	/* flag bits */
-#define WRITE_IDX_VERIFY 01 /* verify only, do not write the idx file */
-#define WRITE_IDX_STRICT 02
-#define WRITE_REV 04
-#define WRITE_REV_VERIFY 010
+	unsigned int write_idx_strict:1,
+		     write_rev:1;
=20
 	uint32_t version;
 	uint32_t off32_limit;
@@ -84,7 +80,8 @@ typedef int (*verify_fn)(const struct object_id *, enum o=
bject_type, unsigned lo
 const char *write_idx_file(const char *index_name,
 			   struct pack_idx_entry **objects, int nr_objects,
 			   const struct pack_idx_option *opts,
-			   const unsigned char *sha1);
+			   const unsigned char *sha1,
+			   int verify);
 int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_=
t offset, off_t len, unsigned int nr);
 int verify_pack_index(struct packed_git *);
 int verify_pack(struct repository *, struct packed_git *, verify_fn fn, st=
ruct progress *, uint32_t);
@@ -99,11 +96,11 @@ void write_promisor_file(const char *promisor_name, str=
uct ref **sought, int nr_
 const char *write_rev_file(const char *rev_name,
 			   struct pack_idx_entry **objects,
 			   uint32_t nr_objects,
-			   const unsigned char *hash, unsigned flags);
+			   const unsigned char *hash, int verify);
 const char *write_rev_file_order(const char *rev_name, uint32_t *pack_orde=
r,
 				 uint32_t nr_objects,
 				 const unsigned char *hash,
-				 unsigned flags);
+				 int verify);
=20
 /*
  * The "hdr" output buffer should be at least this big, which will handle =
sizes
