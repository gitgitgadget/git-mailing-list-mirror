Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE847C4167B
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 16:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiLPQK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiLPQJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 11:09:35 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D85CFCDD
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 08:09:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m19so4252935edj.8
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 08:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kaovSXm6rybZQZoNh+POj0XeJOrPETRzTcImD0sK5sw=;
        b=di8pkLurdovyMWxtAjIPK63R+tFBNu1PyAD53ULN45PtztdxF42P0S0R2sJ2dqDtNS
         HpjOJUOTe5Ri4s14xBPj6fWrpkp4Dkxnq7oqLGFbXn+MJtxw0dMLaXOo8KiTF2MQtEgR
         jc5vuTKfxG2duVMm9f0Dwu5cFopJgVaXog2lJa2EscntVi8KPgLzul5kNfTWOEoBLUiG
         4XkIGMts3QEcwU3NFUv74qrjWsnVbSIWgTTiIWTSJWWPTkpZ4HdkNQJRM34MYu0a7Pdt
         TlGPEPNnVfOYkLinL7j/KmJiseh6VbmvSXlctnFV4rB9J9+cbDoojSlpdrpntjGAFWqW
         Y3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaovSXm6rybZQZoNh+POj0XeJOrPETRzTcImD0sK5sw=;
        b=xLkSIXnQATuDPgNDJwOQh0Oae1SjfRuZQOz/2k2Vbts5D/70spRVUwbH1cCBxaeSXA
         qSEZayU3TxeOl8LA2Ppem0OrywzmQwoEGiySjxpFO7GcVbCYiGw1wVfVI/DTB3yB9/DX
         tRB1uMceZf5pYkhCoAUt5cj5N5iLqRkt7lK/vxMgdR+z4xtXaCFpAPGoz2ps6R7tKJ3j
         xjlQk02LiRp+XB7yFEMgxZZ1j9BNb1W1Zoq9FDxAxEDE+Rb1eBOWzfjBoEOQcV81vxzx
         NZxkmLkT7AVv0usQ31A4EUFd6wZRV8a6tYC4f9wBHioz4OxGIIUt+2x1By+BcLV6pBxu
         s2Ng==
X-Gm-Message-State: ANoB5plxCKoFWb4z11GnK8PH52yZIxLSnnWMxMj6/2DHnPFTMK9RkaBN
        Mfq6lfy0T2FBdb7LbxvULS2pW0GwXIE=
X-Google-Smtp-Source: AA0mqf7BYDN6PS2zF4RjEyyDUVC8gD2DfQfW+56mw53fdSC1rZhiJWrhHauTS+Tqo3WtxTF2qi1clg==
X-Received: by 2002:a05:6402:1641:b0:46c:aa8b:da5c with SMTP id s1-20020a056402164100b0046caa8bda5cmr32788571edx.33.1671206957675;
        Fri, 16 Dec 2022 08:09:17 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id m11-20020a50ef0b000000b00472f9fd8bc6sm997839eds.62.2022.12.16.08.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:09:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p6DGp-006Q9n-2t;
        Fri, 16 Dec 2022 17:09:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 0/4] Optionally skip hashing index on write
Date:   Fri, 16 Dec 2022 16:43:41 +0100
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
 <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
Message-ID: <221216.86sfhf1gbc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 16 2022, Derrick Stolee via GitGitGadget wrote:

Thanks for the update!

> Updates since v3
> ================
>
>  * Patch 1 uses an "int" instead of "unsigned int". This was a carry-over
>    from Kevin's patch in microsoft/git, but our use of it in patch 2 is
>    different and thus is better with a signed int.
>  * Patch 2 uses a fallback to the_repository if istate->repo is NULL. This
>    allows the setting to be applied to more cases where istate->repo is not
>    set.
>  * Patch 2 also uses 'start' in more places, since it already computed the
>    beginning of the hash.
>  * Patch 4 slightly modifies its use of prepare_repo_settings() due to Patch
>    2's fallback to the_repository.

It's good that it's "int" now instead of "unsigned int", but just doing
that search-replacement I think misses the implied (which I really
should have made more explicit) question in my v3 feedback
(https://lore.kernel.org/git/221215.861qp03agm.gmgdl@evledraar.gmail.com/):
What should we do about the -1 state then?

With your 2/4 here we'll accept e.g.:

	./git -c index.skipHash=12345 status

As well as:

	./git -c index.skipHash=blahblah status

But with the migration to repo-settings.c we start refusing the latter
of those, as you inherit a stricture in repo-settings.c.

Aside: I think this series would be much more readable if it were just
squashed into one patch. 1/4 introduces code, but no way to reach it,
with 2/4 we have config, 3/4 adds a test 4/4 tweaks how to
read/parse/interpret/combine the config.

But as it is split up the individual steps should make sense. The 2/4
here should really just use "bool", not "maybe_bool" to begin with, no?

And part of this in 4/4 is inheriting a non-stricture in
repo-settings.c, but for this new config variable that we're introducing
as only a boolean from day one can't we just die() on anything that's
not a boolean?

On other implied feedback, in
https://lore.kernel.org/git/221215.865yec3b1j.gmgdl@evledraar.gmail.com/
I noted the switching between istate->repo & the_repository, and that
you could hit a BUG() (when uncommenting a line in my testing patch on
top) if we didn't have istate->repo:

There was a commit message update for that:

>  2:  00738c81a12 ! 2:  aae047cbc9f read-cache: add index.skipHash config option
>      @@ Commit message
>       
>           [1] https://github.com/microsoft/git/commit/21fed2d91410f45d85279467f21d717a2db45201
>       
>      +    We load this config from the repository config given by istate->repo,
>      +    with a fallback to the_repository if it is not set.

But I think that really sweeps a potential issue under the rug. What are
these cases where we don't get istate->repo, are those expected? Is
preferring istate->repo always known to be redundant now, and just done
for good measure, or are there subtle cases (e.g. when reading
submodules) where we pick the wrong repo's config?

In that context I'd really like to see some testing of submodules in the
added tests, i.e. does this act as we'd like it to when you set the
config as "true" in the parent, but "false" in the submodule, & the
other way around? That's a case that should stress this "the_repository"
v.s. "istate->repo".

>           While older Git versions will not recognize the null hash as a special
>           case, the file format itself is still being met in terms of its
>           structure. Using this null hash will still allow Git operations to
>      @@ read-cache.c: static int verify_hdr(const struct cache_header *hdr, unsigned lon
>        	the_hash_algo->update_fn(&c, hdr, size - the_hash_algo->rawsz);
>        	the_hash_algo->final_fn(hash, &c);
>       -	if (!hasheq(hash, (unsigned char *)hdr + size - the_hash_algo->rawsz))
>      -+	if (!hasheq(hash, end - the_hash_algo->rawsz))
>      ++	if (!hasheq(hash, start))
>        		return error(_("bad index file sha1 signature"));
>        	return 0;

Thanks, good to have this suggested simplification.

>       @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>      + 	int ieot_entries = 1;
>      + 	struct index_entry_offset_table *ieot = NULL;
>      + 	int nr, nr_threads;
>      ++	struct repository *r = istate->repo ? istate->repo : the_repository;
>        
>        	f = hashfd(tempfile->fd, tempfile->filename.buf);
>        
>      -+	git_config_get_maybe_bool("index.skiphash", (int *)&f->skip_hash);
>      ++	repo_config_get_maybe_bool(r, "index.skiphash", &f->skip_hash);
>       +
>        	for (i = removed = extended = 0; i < entries; i++) {

Re the above this looks good, but did we introduce an untested behavior
change here or not?

>        		if (cache[i]->ce_flags & CE_REMOVE)
>  3:  86370af1351 = 3:  27fbe52e748 test-lib-functions: add helper for trailing hash
>  4:  6490bd445eb ! 4:  075921514f2 features: feature.manyFiles implies fast index writes
>      @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
>        
>        	f = hashfd(tempfile->fd, tempfile->filename.buf);
>        
>      --	git_config_get_maybe_bool("index.skiphash", (int *)&f->skip_hash);
>      -+	if (istate->repo) {
>      -+		prepare_repo_settings(istate->repo);
>      -+		f->skip_hash = istate->repo->settings.index_skip_hash;
>      -+	}
>      +-	repo_config_get_maybe_bool(r, "index.skiphash", &f->skip_hash);
>      ++	prepare_repo_settings(r);
>      ++	f->skip_hash = r->settings.index_skip_hash;
>        
>        	for (i = removed = extended = 0; i < entries; i++) {
>        		if (cache[i]->ce_flags & CE_REMOVE)

I really don't care per-se where we read the config, as long as it's
doing what we expect from the UX point of view.

But in your
https://lore.kernel.org/git/9e754af8-ecd3-6aed-60e8-2fc09a6a8759@github.com/
you noted "There's no reason to load the config inside repo-settings.c
unless it's part of something like feature.manyFiles.".

I think that's true, but on the flip side of that: Is there a reason to
move the reading of such localized config (only needed in read-cache.c,
as 2/4 shows) to repo-settings.c, just because it's now relying on the
"manyfiles"?

I think the unstated reason for that is that while we read the
"manyfiles" config we didn't stick it in the "struct repo_settings",
therefore the reading of it is conveniently done in repo-settings.c,
which the 4/4 here does.

But I think it makes more sense to just stick the "manyfiles" in that
struct, not stick "skip_hash" there, and then just check the "manyfiles"
in 4/4, but read "index.skiphash" locally.

Maybe not worth the churn at this point, but I do wonder if we're going
in the wrong direction here, i.e. if all config that happens to rely on
features must be added to repo-settings.c, or whether we should reserve
that for truly "global" (or mostly global) config.


