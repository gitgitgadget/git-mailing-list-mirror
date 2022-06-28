Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F05FC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 09:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbiF1JHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbiF1JHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 05:07:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCF51274C
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:07:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u15so24344663ejc.10
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RHG9rcNgLA0gO6vgzKrvdebI+4zlyQ30om4ah8Ja95c=;
        b=ToFMvM4Tz4B2AtgDiie6aCIMMXRQKbJF4aw4AqUSseG6bg4eQo97oJFnUVKpXzGwoh
         PfTrz0wSN1HlW42MrzNJ9Om5U7N3T4sCNNtbhHLA7vnhP7gAysm9P2z8sF8GzTu1rsqY
         T2ATPLoZLPi2gJx/xqC0Swxy0apPiVNWV1hFkHCK1VP34CTGPjAUufPoXmFIulDM3xIA
         pWlY1IBZ/Nj0q7Uat1SPYqHzZ04lVhGVifjr+6cKXvaMME1tECXoIvtYx+D/eP5e00GS
         sSvawPKfwAgbvXYoYB/AcmTIS5ponYvKYOMjXqQ1U/eBZtzoCirUPrQnrDLWadw8N+wF
         dflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RHG9rcNgLA0gO6vgzKrvdebI+4zlyQ30om4ah8Ja95c=;
        b=gPgM2ZUKhT6OvTRbgRrt+uDN/GTUjUvl6rk5v2X8Xu6HcuyN2OT0hjwmZ57krDC65C
         dynxQ4BLke1icBC+VrcSFClWz+O0tLGRFXIVxt7avbcb2xre2pwLJXdekgCY3OJ9XVTN
         DJgwotCQH3S0kEpTV57/bcWjM+6cRjIuliia8EsvIYbf0qcmBeOfWJM5HTTZkS2UgF66
         kGmWHtlD3rDp8uBQnSCe8b9W8cBHsSIJNpm3nfYjC2BGhCrKcws4Ra0VOuhObzzX7ciT
         mzeR7wzbS8d3sHk9eZ3Uv8Qs76ADmoh5gZYj7hWOrZivHj5s/0uICOJdCBzsU7luCzdy
         zlag==
X-Gm-Message-State: AJIora8zIj6t8GZ8/bhnZgIPVojMGzcB6QvYr+1EVfXp3Fmmj0ggESFu
        PsmEjm9OXa5GHhBMVkvualVq97UGqIQ=
X-Google-Smtp-Source: AGRyM1t9J/MaGdC+KZ+zAg30wQXYX29vzZowWqJaE8GdkCTd52LoRyPUgDWTMqtUz3a4fbAQnqIsiA==
X-Received: by 2002:a17:906:58c7:b0:722:f4bf:cb75 with SMTP id e7-20020a17090658c700b00722f4bfcb75mr17265269ejs.450.1656407223705;
        Tue, 28 Jun 2022 02:07:03 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id le23-20020a170906ae1700b006f3ef214dbesm6135174ejb.36.2022.06.28.02.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:07:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o67BW-001mEV-AS;
        Tue, 28 Jun 2022 11:07:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com, git@jeffhostetler.com
Subject: Re: [PATCH v5 4/5] pack-bitmap.c: retrieve missing i18n translations
Date:   Tue, 28 Jun 2022 10:58:56 +0200
References: <cover.1656403084.git.dyroneteng@gmail.com>
 <065b7c9ccb5a412526a934f9b67c8be64a40fc7f.1656403084.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <065b7c9ccb5a412526a934f9b67c8be64a40fc7f.1656403084.git.dyroneteng@gmail.com>
Message-ID: <220628.86sfnpf96x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 28 2022, Teng Long wrote:

> In pack-bitmap.c, some printed texts are translated,some are not.
> Let's support the translations of the bitmap related output.

Usually we don't go for cleanup-while-at-it, but in this case we're
marking messages that don't conform to our CodingGudielines for
translation, mostly because they're error messages that start with an
upper-case letter.

So I think we should fix those issues first, to avoid double-work for
translators (well, a bit less, since they're the translation memory, but
it's quite a bit of churn...).

> -		error("Failed to load bitmap index (corrupted?)");
> +		error(_("Failed to load bitmap index (corrupted?)"));

e.g. here.

> -		return error("Corrupted bitmap index (too small)");
> +		return error(_("Corrupted bitmap index (too small)"));

..and here, etc. etc.

> -		return error("Unsupported version for bitmap index file (%d)", index->version);
> +		return error(_("Unsupported version for bitmap index file (%d)"), index->version);

Let's say "unsupported version '%d' for ..." instead?

> -			return error("Unsupported options for bitmap index file "
> -				"(Git requires BITMAP_OPT_FULL_DAG)");
> +			return error(_("Unsupported options for bitmap index file "
> +				"(Git requires BITMAP_OPT_FULL_DAG)"));

I'm not sure, but shouldn't this be a BUG()?

> -		error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
> +		error(_("Duplicate entry in bitmap index: %s"), oid_to_hex(oid));

Ditto upper-case, but add '%s' while at it.

>  	if (!strip_suffix(p->pack_name, ".pack", &len))
> -		BUG("pack_name does not end in .pack");
> +		BUG(_("pack_name does not end in .pack"));

Do not translate BUG() messages.

> -		warning("ignoring extra bitmap file: %s", buf.buf);
> +		warning(_("ignoring extra bitmap file: %s"), buf.buf);

Quote the name.

> -		warning("ignoring extra bitmap file: %s", packfile->pack_name);
> +		warning(_("ignoring extra bitmap file: %s"), packfile->pack_name);

ditto.

>  		if (prepare_revision_walk(revs))
> -			die("revision walk setup failed");
> +			die(_("revision walk setup failed"));

Looks good, but aside from this we should really have a tree-wide
xprepare_revision_walk() or something, we have this copy/pasted all over
the place...


> -		BUG("filter_bitmap_tree_depth given non-zero limit");
> +		BUG(_("filter_bitmap_tree_depth given non-zero limit"));

Ditto BUG.
>  
>  	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter,
>  				   OBJ_TREE);
> @@ -1148,7 +1148,7 @@ static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
>  				      enum object_type object_type)
>  {
>  	if (object_type < OBJ_COMMIT || object_type > OBJ_TAG)
> -		BUG("filter_bitmap_object_type given invalid object");
> +		BUG(_("filter_bitmap_object_type given invalid object"));
>  
>  	if (object_type != OBJ_TAG)
>  		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_TAG);
> @@ -1304,14 +1304,14 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
>  		revs->ignore_missing_links = 0;
>  
>  		if (haves_bitmap == NULL)
> -			BUG("failed to perform bitmap walk");
> +			BUG(_("failed to perform bitmap walk"));
>  	}

etc. etc.

>  
>  	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap,
>  				    filter);
>  
>  	if (!wants_bitmap)
> -		BUG("failed to perform bitmap walk");
> +		BUG(_("failed to perform bitmap walk"));
>  
>  	if (haves_bitmap)
>  		bitmap_and_not(wants_bitmap, haves_bitmap);
> @@ -1432,7 +1432,7 @@ uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
>  {
>  	struct multi_pack_index *m = bitmap_git->midx;
>  	if (!m)
> -		BUG("midx_preferred_pack: requires non-empty MIDX");
> +		BUG(_("midx_preferred_pack: requires non-empty MIDX"));

etc. etc.

>  	return nth_midxed_pack_int_id(m, pack_pos_to_midx(bitmap_git->midx, 0));
>  }
>  
> @@ -1629,15 +1629,15 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
>  	}
>  
>  	if (bitmap_type == OBJ_NONE)
> -		die("object %s not found in type bitmaps",
> +		die(_("object %s not found in type bitmaps"),
>  		    oid_to_hex(&obj->oid));
>  
>  	if (bitmaps_nr > 1)
> -		die("object %s does not have a unique type",
> +		die(_("object %s does not have a unique type"),
>  		    oid_to_hex(&obj->oid));
>  
>  	if (bitmap_type != obj->type)
> -		die("object %s: real type %s, expected: %s",
> +		die(_("object %s: real type %s, expected: %s"),
>  		    oid_to_hex(&obj->oid),
>  		    type_name(obj->type),
>  		    type_name(bitmap_type));

quote %s for these.

> @@ -1651,7 +1651,7 @@ static void test_show_object(struct object *object, const char *name,
>  
>  	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
>  	if (bitmap_pos < 0)
> -		die("Object not in bitmap: %s\n", oid_to_hex(&object->oid));
> +		die(_("Object not in bitmap: %s\n"), oid_to_hex(&object->oid));

Lose the \n here, in addition to lower-case & quote %s.

>  	test_bitmap_type(tdata, object, bitmap_pos);
>  
>  	bitmap_set(tdata->base, bitmap_pos);
> @@ -1666,7 +1666,7 @@ static void test_show_commit(struct commit *commit, void *data)
>  	bitmap_pos = bitmap_position(tdata->bitmap_git,
>  				     &commit->object.oid);
>  	if (bitmap_pos < 0)
> -		die("Object not in bitmap: %s\n", oid_to_hex(&commit->object.oid));
> +		die(_("Object not in bitmap: %s\n"), oid_to_hex(&commit->object.oid));

Ditto.

>  	test_bitmap_type(tdata, &commit->object, bitmap_pos);
>  
>  	bitmap_set(tdata->base, bitmap_pos);
> @@ -1683,26 +1683,26 @@ void test_bitmap_walk(struct rev_info *revs)
>  	struct ewah_bitmap *bm;
>  
>  	if (!(bitmap_git = prepare_bitmap_git(revs->repo)))
> -		die("failed to load bitmap indexes");
> +		die(_("failed to load bitmap indexes"));
>  
>  	if (revs->pending.nr != 1)
> -		die("you must specify exactly one commit to test");
> +		die(_("you must specify exactly one commit to test"));
>  
> -	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
> +	fprintf(stderr, _("Bitmap v%d test (%d entries loaded)\n"),
>  		bitmap_git->version, bitmap_git->entry_count);
>  
>  	root = revs->pending.objects[0].item;
>  	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
>  
>  	if (bm) {
> -		fprintf(stderr, "Found bitmap for %s. %d bits / %08x checksum\n",
> +		fprintf(stderr, _("Found bitmap for %s. %d bits / %08x checksum\n"),
>  			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
>  
>  		result = ewah_to_bitmap(bm);
>  	}
>  
>  	if (result == NULL)
> -		die("Commit %s doesn't have an indexed bitmap", oid_to_hex(&root->oid));
> +		die(_("Commit %s doesn't have an indexed bitmap"), oid_to_hex(&root->oid));
>  
>  	revs->tag_objects = 1;
>  	revs->tree_objects = 1;
> @@ -1711,7 +1711,7 @@ void test_bitmap_walk(struct rev_info *revs)
>  	result_popcnt = bitmap_popcount(result);
>  
>  	if (prepare_revision_walk(revs))
> -		die("revision walk setup failed");
> +		die(_("revision walk setup failed"));
>  
>  	tdata.bitmap_git = bitmap_git;
>  	tdata.base = bitmap_new();
> @@ -1719,7 +1719,7 @@ void test_bitmap_walk(struct rev_info *revs)
>  	tdata.trees = ewah_to_bitmap(bitmap_git->trees);
>  	tdata.blobs = ewah_to_bitmap(bitmap_git->blobs);
>  	tdata.tags = ewah_to_bitmap(bitmap_git->tags);
> -	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
> +	tdata.prg = start_progress(_("Verifying bitmap entries"), result_popcnt);

Good catch!
>  	tdata.seen = 0;
>  
>  	traverse_commit_list(revs, &test_show_commit, &test_show_object, &tdata);
> @@ -1727,9 +1727,9 @@ void test_bitmap_walk(struct rev_info *revs)
>  	stop_progress(&tdata.prg);
>  
>  	if (bitmap_equals(result, tdata.base))
> -		fprintf(stderr, "OK!\n");
> +		fprintf(stderr, _("OK!\n"));

Ditto don't include \n.
>  	else
> -		die("mismatch in bitmap results");
> +		die(_("mismatch in bitmap results"));
>  
>  	bitmap_free(result);
>  	bitmap_free(tdata.base);
> @@ -1747,7 +1747,7 @@ int test_bitmap_commits(struct repository *r)
>  	MAYBE_UNUSED void *value;
>  
>  	if (!bitmap_git)
> -		die("failed to load bitmap indexes");
> +		die(_("failed to load bitmap indexes"));
>  
>  	kh_foreach(bitmap_git->bitmaps, oid, value, {
>  		printf("%s\n", oid_to_hex(&oid));
> @@ -1825,8 +1825,8 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
>  	if (!bitmap_is_midx(bitmap_git))
>  		load_reverse_index(bitmap_git);
>  	else if (load_midx_revindex(bitmap_git->midx) < 0)
> -		BUG("rebuild_existing_bitmaps: missing required rev-cache "
> -		    "extension");
> +		BUG(_("rebuild_existing_bitmaps: missing required rev-cache "
> +		    "extension"));
>  

Ditto don't translate BUG().
