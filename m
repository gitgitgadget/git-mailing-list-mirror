Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A34C678D4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 11:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCGLu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 06:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCGLti (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 06:49:38 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB40B76F78
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 03:48:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u9so51176114edd.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 03:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678189712;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXPc0KB/WkumFrWYIE43HA2psbS54QDsQF3syP+8aek=;
        b=PrjVna4gjQX9RBhyIsmRBjTzrsiT9SAHTzduJx5NGWaBgBRSMkYV1x3Ar7/fsyjrt5
         UmNaFEIvzK6cqSDiELJQ/eKWh+cGGqs3pa9dc0C5qVuocrXRJR1bRpWs+wg7lVogmCkE
         8uksOGiDg6eO1VunKA+sckWOItNtS5SbIoZQ+0DT17J0GDerP1eiACmMay77IODUGhhb
         y3LMm9HNO8DGnIweBTWXm3U9ZtUoSBFTtH/33cZzDMTXsWSPhRlnKBTVHuOswwPAw0ie
         VQvDP0pG2Vw044y6Jmn+n8lavrAUGNgqHNY2ObsagAVK2icWDc72Yi74LEEprVCKCh+P
         DFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678189712;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXPc0KB/WkumFrWYIE43HA2psbS54QDsQF3syP+8aek=;
        b=FQvC7IkzBw3b6Y2ZJUuuyQdB44Rf0/EU9JBidKoNvJIQ2tzXDQmZck6yqEr7eW4DTz
         LSC8lXGtfMwF9Zy5DvKpLxUnPVzGkuT8MyjbTaZh13+jcQVOXpUHU+XSTjEvs6U6Y6mQ
         8kWn5QwQmo/Ir92ZutrRgBs+d+FbCvlVcqUyY4/iIZ/ZTCHF+DNrsIrPNZlagJK1Y2+B
         jUHACd1H6q1oqzDfb+4JB7xNoJRBYYU+3cPTsCnvtTnyt1P4oPsiHgE3xXx41dYnbJRV
         Gs9lOAKR1I8Vmx6i4P8C6gzvl8zuziCGQjHsvO3llqJhI4mqHiur9HP3IbU5wCXcZ4oT
         xUhw==
X-Gm-Message-State: AO0yUKUlrAMhqTct7b+ew7hK3vnCKRA9RyGQjEWikqg+PDBwWDhXDQx7
        JYTHcXydRHYGm+HW06f8pJc=
X-Google-Smtp-Source: AK7set/WhW1lTbD+BCX9r/4oIAMCNKIS5/0MClVdpfiCKCSs7m1PFnfzlyyC0aqGvv6yieaTV027bA==
X-Received: by 2002:a05:6402:1810:b0:4ab:ec2:3cd1 with SMTP id g16-20020a056402181000b004ab0ec23cd1mr13134263edy.25.1678189712025;
        Tue, 07 Mar 2023 03:48:32 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004bdcc480c41sm6589419edj.96.2023.03.07.03.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 03:48:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZVny-000gmD-1a;
        Tue, 07 Mar 2023 12:48:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] object-file: reprepare alternates when necessary
Date:   Tue, 07 Mar 2023 12:28:44 +0100
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
Message-ID: <230307.861qm0235d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 06 2023, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When an object is not found in a repository's object store, we sometimes
> call reprepare_packed_git() to see if the object was temporarily moved
> into a new pack-file (and its old pack-file or loose object was
> deleted). This process does a scan of each pack directory within each
> odb, but does not reevaluate if the odb list needs updating.
>
> Create a new reprepare_alt_odb() method that is a similar wrapper around
> prepare_alt_odb(). Call it from reprepare_packed_git() under the object
> read lock to avoid readers from interacting with a potentially
> incomplete odb being added to the odb list.
>
> prepare_alt_odb() already avoids adding duplicate odbs to the list
> during its progress, so it is safe to call it again from
> reprepare_alt_odb() without worrying about duplicate odbs.
>
> This change is specifically for concurrent changes to the repository, so
> it is difficult to create a test that guarantees this behavior is
> correct. I manually verified by introducing a reprepare_packed_git() call
> into get_revision() and stepped into that call in a debugger with a
> parent 'git log' process. Multiple runs of reprepare_alt_odb() kept
> the_repository->objects->odb as a single-item chain until I added a
> .git/objects/info/alternates file in a different process. The next run
> added the new odb to the chain and subsequent runs did not add to the
> chain.

I found this a bit hard to read, as one migh think from just this
explanation that you're adding ODB locking as a new concept here, adding
"existing" in front of "read lock" above might help.

But in fact we've been doing the locking since 6c307626f1e (grep:
protect packed_git [re-]initialization, 2020-01-15). So the only thing
that really needs justification here is that putting the alternates
re-reading under the same lock

There is a really interesting potential caveat here which you're not
discussing, which is...

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>     object-file: reprepare alternates when necessary
>     
>     This subtlety was notice by Michael Haggerty due to how alternates are
>     used server-side at $DAYJOB. Moving pack-files from a repository to the
>     alternate occasionally causes failures because processes that start
>     before the alternate exists don't know how to find that alternate at
>     run-time.
>     
>     Thanks,
>     
>      * Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1490%2Fderrickstolee%2Fstolee%2Freprepare-alternates-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1490/derrickstolee/stolee/reprepare-alternates-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1490
>
>  object-file.c  | 6 ++++++
>  object-store.h | 1 +
>  packfile.c     | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/object-file.c b/object-file.c
> index 939865c1ae0..22acc7fd8e9 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -944,6 +944,12 @@ void prepare_alt_odb(struct repository *r)
>  	r->objects->loaded_alternates = 1;
>  }
>  
> +void reprepare_alt_odb(struct repository *r)
> +{
> +	r->objects->loaded_alternates = 0;
> +	prepare_alt_odb(r);
> +}
> +
>  /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
>  static int freshen_file(const char *fn)
>  {
> diff --git a/object-store.h b/object-store.h
> index 1a713d89d7c..750c29daa54 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -56,6 +56,7 @@ KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
>  	struct object_directory *, 1, fspathhash, fspatheq)
>  
>  void prepare_alt_odb(struct repository *r);
> +void reprepare_alt_odb(struct repository *r);
>  char *compute_alternate_path(const char *path, struct strbuf *err);
>  struct object_directory *find_odb(struct repository *r, const char *obj_dir);
>  typedef int alt_odb_fn(struct object_directory *, void *);
> diff --git a/packfile.c b/packfile.c
> index 79e21ab18e7..2b28918a05e 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1008,6 +1008,7 @@ void reprepare_packed_git(struct repository *r)
>  	struct object_directory *odb;
>  
>  	obj_read_lock();
> +	reprepare_alt_odb(r);
>  	for (odb = r->objects->odb; odb; odb = odb->next)
>  		odb_clear_loose_cache(odb);
>  
>
> base-commit: d15644fe0226af7ffc874572d968598564a230dd

This seems reasonable, but wouldn't this do the same without introducing
an API function just for this one use-case?

That's of course a nit, and you seem to have been adding this for
consistency with reprepare_packed_git(), but it already "owns" the
"approximate_object_count_valid" and "packed_git_initialized" flags in
"struct raw_object_store".

So as we'll only need this from reprepare_packed_git() isn't it better
to declare that "loaded_alternates" is another such flag?

Perhaps not, but as the resulting patch is much shorter it seems worth
considering.

...but to continue the above, the *really* important thing here (and
correct me if I'm wrong) is that we really need to *first* prepare the
alternates, and *then* do the rest, as our new alternates might point to
new loose objects and packs.

So with both of the above (the same could be done with your new helper)
something like this would IMO make that much clearer:

	diff --git a/packfile.c b/packfile.c
	index 79e21ab18e7..50cb46ca4b7 100644
	--- a/packfile.c
	+++ b/packfile.c
	@@ -1008,6 +1008,13 @@ void reprepare_packed_git(struct repository *r)
	 	struct object_directory *odb;
	 
	 	obj_read_lock();
	+	/*
	+	 * New alternates might point to new loose & pack dirs, so we
	+	 * must first read those.
	+	 */
	+	r->objects->loaded_alternates = 0;
	+	prepare_alt_odb(r);
	+
	 	for (odb = r->objects->odb; odb; odb = odb->next)
	 		odb_clear_loose_cache(odb);

And, I think this is an exsiting edge case, but we're only locking the
ODB of the "parent" repository in this case, so if we have alternates in
play aren't we going to racily compute the rest here, the loose objects
and packs of the alternates we're about to consult aren't under the same
lock?


