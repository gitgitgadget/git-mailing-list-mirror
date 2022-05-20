Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB72C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 17:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351940AbiETRAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347721AbiETRAe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 13:00:34 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E0C17CCB0
        for <git@vger.kernel.org>; Fri, 20 May 2022 10:00:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id y15so3055098qtx.4
        for <git@vger.kernel.org>; Fri, 20 May 2022 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8MSK4XX6yGKVAyNbhkrx8BKFpt+CG+FbF/oGR4ioocs=;
        b=XhEiX1DtIMNgPvKRkOUrPy0A9S0vz2XhuQvznXwYfsbfxyiYmjARkaJjj0Kt7ZgeRL
         lL5K1fbcIx+wcEM15+fLwTt/MwcyupC2PnEUDruy+yFKY9d6NbiHPcoKGQqSDGKxezAf
         UjYD7Aw7AO5HeM4+a9rVWmMxGYcl2OPx6TuXnIV47RRHncstkIbWIt7RusXTVSAWbTDs
         +cSYlMcD5cSnLgRS/xWDICpmJFBouds7s72+k2RsK23+b36huA3cmZ2XjbTlvvSqx0x5
         8IeGfgSrl0qQd283jkydRDRbvdp6EpqXPNNTo2f2MvMDcrkx2gbRFWYlMMszEu89C5md
         68Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8MSK4XX6yGKVAyNbhkrx8BKFpt+CG+FbF/oGR4ioocs=;
        b=kgZwEc74emPwZTUSTrJnEiURhEJykf0h+4nUfj8Qp+2Es6Kh6xg2R9MPbDbCn0t5kA
         NRpk+8PN6y04aw2sh32w8tjN/E53vGrWMzlvSTBjGezgObkst5OCGwOg9dsaw6wkk4tF
         w+cbNbU/d0fsibMYMEiAawiBR7t7Jeb5gxF6fNoIHqlx4qo5xgd5l9BwNBh7MaPMVVOf
         yAxZCN3EtWlt0IhjfMgl+evMvG8JSVulbcbXzKzm6kV1P5BuL0o7yd/7jVJFhXbR1T3b
         7e/9Z3mIROfmmTqsa0XQAaVKC+PJ6sZWNVlGA4tX8l8KW34cmE+pGFX93eSKGXpnJmF9
         UDRA==
X-Gm-Message-State: AOAM531JmscMxBxsFfN+XWwKsvW7JnHofhB0RapMPAI2A4OM25qZbyZI
        PkmSZDSsjn8rMuTjxhXqbvgiW9hLv83/mP97
X-Google-Smtp-Source: ABdhPJy4alM/TQPvd8idv3HIjIiQZlzh4gegp6Nz/M3tvZeZh/9iLTzAaaQ1Bbtn6B3S4K8k5VjKMw==
X-Received: by 2002:ac8:5b51:0:b0:2f3:d5a9:fde with SMTP id n17-20020ac85b51000000b002f3d5a90fdemr8402962qtw.60.1653066031337;
        Fri, 20 May 2022 10:00:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y10-20020ac8128a000000b002f3dc9ebb4bsm3178347qti.65.2022.05.20.10.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 10:00:30 -0700 (PDT)
Date:   Fri, 20 May 2022 13:00:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] repack: respect --keep-pack with geometric repack
Message-ID: <YofJLv8+x5J7yPmf@nand.local>
References: <pull.1235.git.1653064572170.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1235.git.1653064572170.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Fri, May 20, 2022 at 04:36:12PM +0000, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
>
> Update 'repack' to ignore packs named on the command line with the
> '--keep-pack' option. Specifically, modify 'init_pack_geometry()' to treat
> command line-kept packs the same way it treats packs with an on-disk '.keep'
> file (that is, skip the pack and do not include it in the 'geometry'
> structure).
>
> Without this handling, a '--keep-pack' pack would be included in the
> 'geometry' structure. If the pack is *before* the geometry split line (with
> at least one other pack and/or loose objects present), 'repack' assumes the
> pack's contents are "rolled up" into another pack via 'pack-objects'.
> However, because the internally-invoked 'pack-objects' properly excludes
> '--keep-pack' objects, any new pack it creates will not contain the kept
> objects. Finally, 'repack' deletes the '--keep-pack' as "redundant" (since
> it assumes 'pack-objects' created a new pack with its contents), resulting
> in possible object loss and repository corruption.

Nicely found and explained. Having discussed this fix with you already
off-list, this approach (to treat kept packs as excluded from the list
of packs in the `geometry` structure regardless of whether they are kept
on disk or in-core) makes sense to me.

I left a couple of small notes on the patch below, but since I have some
patches that deal with a separate issue in the `git repack --geometric`
code coming, do you want to combine forces (and I can send a
lightly-reworked version of this patch as a part of my series)?

> @@ -332,17 +332,34 @@ static int geometry_cmp(const void *va, const void *vb)
>  	return 0;
>  }
>
> -static void init_pack_geometry(struct pack_geometry **geometry_p)
> +static void init_pack_geometry(struct pack_geometry **geometry_p,
> +			       struct string_list *existing_kept_packs)
>  {
>  	struct packed_git *p;
>  	struct pack_geometry *geometry;
> +	struct strbuf buf = STRBUF_INIT;
>
>  	*geometry_p = xcalloc(1, sizeof(struct pack_geometry));
>  	geometry = *geometry_p;
>
> +	string_list_sort(existing_kept_packs);

Would it be worth sorting this as early as in collect_pack_filenames()?
For our purposes in this patch, this works as-is, but it may be
defensive to try and minimize the time that list has unsorted contents.

>  	for (p = get_all_packs(the_repository); p; p = p->next) {
> -		if (!pack_kept_objects && p->pack_keep)
> -			continue;
> +		if (!pack_kept_objects) {
> +			if (p->pack_keep)
> +				continue;

(You mentioned this to me off-list, but I'll repeat it here since it
wasn't obvious to me on first read): this check for `p->pack_keep` isn't
strictly necessary, since any packs that have their `pack_keep` bit set
will appear in the `existing_kept_packs` list.

But it does give us a fast path to avoid having to check that list, so
it's worth checking that bit to avoid a slightly more expensive check
where possible.

> +			/*
> +			 * The pack may be kept via the --keep-pack option;
> +			 * check 'existing_kept_packs' to determine whether to
> +			 * ignore it.
> +			 */
> +			strbuf_reset(&buf);
> +			strbuf_addstr(&buf, pack_basename(p));
> +			strbuf_strip_suffix(&buf, ".pack");
> +
> +			if (string_list_has_string(existing_kept_packs, buf.buf))
> +				continue;

It's too bad that we have to do this check at all, and can't rely on the
`pack_keep_in_core` in the same way as we check `p->pack_keep`. But
lifting that restriction is a more invasive change, so I'm happy to
rely on the contents of existing_kept_packs here in the meantime.

> +		}
>
>  		ALLOC_GROW(geometry->pack,
>  			   geometry->pack_nr + 1,
> @@ -353,6 +370,7 @@ static void init_pack_geometry(struct pack_geometry **geometry_p)
>  	}
>
>  	QSORT(geometry->pack, geometry->pack_nr, geometry_cmp);
> +	strbuf_release(&buf);
>  }
>
>  static void split_pack_geometry(struct pack_geometry *geometry, int factor)
> @@ -714,17 +732,20 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		strbuf_release(&path);
>  	}
>
> +	packdir = mkpathdup("%s/pack", get_object_directory());
> +	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
> +	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
> +
> +	collect_pack_filenames(&existing_nonkept_packs, &existing_kept_packs,
> +			       &keep_pack_list);
> +

Makes sense; we have to initialize existing_kept_packs before arranging
the list of packs for the `--geometric` split. And presumably
`collect_pack_filenames()` relies on `packdir`, `packtmp_name`, and
`packtmp` being setup ahead of time, too.

>  	if (geometric_factor) {
>  		if (pack_everything)
>  			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
> -		init_pack_geometry(&geometry);
> +		init_pack_geometry(&geometry, &existing_kept_packs);
>  		split_pack_geometry(geometry, geometric_factor);
>  	}
>
> -	packdir = mkpathdup("%s/pack", get_object_directory());
> -	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
> -	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
> -
>  	sigchain_push_common(remove_pack_on_signal);
>
>  	prepare_pack_objects(&cmd, &po_args);
> @@ -764,9 +785,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (use_delta_islands)
>  		strvec_push(&cmd.args, "--delta-islands");
>
> -	collect_pack_filenames(&existing_nonkept_packs, &existing_kept_packs,
> -			       &keep_pack_list);
> -
>  	if (pack_everything & ALL_INTO_ONE) {
>  		repack_promisor_objects(&po_args, &names);
>
> diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
> index bdbbcbf1eca..f5ac23413d5 100755
> --- a/t/t7703-repack-geometric.sh
> +++ b/t/t7703-repack-geometric.sh
> @@ -180,6 +180,40 @@ test_expect_success '--geometric ignores kept packs' '
>  	)
>  '
>
> +test_expect_success '--geometric ignores --keep-pack packs' '
> +	git init geometric &&
> +	test_when_finished "rm -fr geometric" &&
> +	(
> +		cd geometric &&
> +
> +		# Create two equal-sized packs
> +		test_commit kept && # 3 objects
> +		test_commit pack && # 3 objects
> +
> +		KEPT=$(git pack-objects --revs $objdir/pack/pack <<-EOF
> +		refs/tags/kept
> +		EOF
> +		) &&
> +		PACK=$(git pack-objects --revs $objdir/pack/pack <<-EOF
> +		refs/tags/pack
> +		^refs/tags/kept
> +		EOF
> +		) &&

Nit; we don't care about the name of $PACK, so it would probably be fine
to avoid storing the `PACK` variable. We could write these packs with
just `git repack -d` after each `test_commit` (which would avoid us
having to call `prune-packed`).

Does it matter which one is kept? I don't think so, since AFAICT the
critical bit is that we mark one of the packs being rolled up as a
`--keep-pack`.

> +		# Prune loose objects that are now packed into PACK and KEEP
> +		git prune-packed &&
> +
> +		git repack --geometric 2 -dm --keep-pack=pack-$KEPT.pack >out &&
> +
> +		# Packs should not have changed (only one non-kept pack, no
> +		# loose objects), but midx should now exist.
> +		test_i18ngrep "Nothing new to pack" out &&

Nit; test_i18ngrep here should just be "grep".

> +		test_path_is_file $midx &&
> +		test_path_is_file $objdir/pack/pack-$KEPT.pack &&
> +		git fsck
> +	)


Thanks,
Taylor
