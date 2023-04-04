Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D75C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 18:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbjDDSz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbjDDSz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 14:55:57 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1363D170F
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 11:55:56 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i6so39954249ybu.8
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680634555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPexTTIUip19Glf0OOjYkI/0+5qKpXoe/+pVuVqyS08=;
        b=J7cGJ8DeFXJRCUxWVaEFolbn0Uq/jyk2PhcCtsJNifUgPNjGE5iZt3Lq22fG4Kmptw
         v79Xxs4NKp+K69S3flqO7qsik65YteGMis3ilGexy5C8DB3uZd3H6mevaDS7v1uOySX1
         XgH/S1CsHjsaxsbqiQl2bU58pihoaZxQOXytOboe1oPFE9LW/1ISxPNQ0k88Q1huQv90
         WhszcVjxL4ilvzOZc3DLGRKIMyLW98v8tVqbo8BIFgDijyv5Xy08oYmup2utLjtrRxMr
         IuWysmygHtNGvMstGDm/ZBQbrxdgQpR7DgvaX4xdxZqdIaU21qmCcsr/xRPfEg5SkpTf
         yK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680634555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPexTTIUip19Glf0OOjYkI/0+5qKpXoe/+pVuVqyS08=;
        b=DKfUjtDK9GaO/j69pB9F7jJP4nfHj3ah5y3InJASyMv/YX1omW1NV2D7cXT39YTeUX
         P+26ajy+9UMHyx/0w9l4xOsDgJSv9y7PhAO0xso7mv3yOV82aZMoWBs7zZ4ksbZqjqU9
         u00XDB9Xva4L0OybLH/UDa2JFSaMzb9g5EecmOdAHkMBjyQGbkkB22EJVaSOESJ0q9dm
         6MKFU+zDGi7Hdgkx3JvwwqZpd824BQGTiOlU4rxkedjGbKUEJiVezCzE5Hris8BYsLxN
         wzIVWbubeankbpKFOufvDgQzaaF+c3VSaeeAK7Bm1qNHKasOaMKK5InnmEPDcAw0mmuC
         ZjoA==
X-Gm-Message-State: AAQBX9dSlt1tfc/MwLjonh1gCt48FubG+zGWiIkFJ1Msd1H35KwCFFZS
        TZS/l+c0vQMgL0KeBp2txcx5irD1806sZytc8GkBDQ==
X-Google-Smtp-Source: AKy350ZOcMrDCP/ugood1WnYUoNWpjMmSs2g8XByq0T99tT/8ztHRBAQDP0Asz2tZQy/Do3PdoDCXg==
X-Received: by 2002:a25:54d:0:b0:a5d:feb5:4ccf with SMTP id 74-20020a25054d000000b00a5dfeb54ccfmr4471114ybf.27.1680634554966;
        Tue, 04 Apr 2023 11:55:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s82-20020a257755000000b00b7767ca7471sm3522341ybc.14.2023.04.04.11.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:55:54 -0700 (PDT)
Date:   Tue, 4 Apr 2023 14:55:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <ZCxytq1esQWvjIz/@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 04, 2023 at 01:08:33PM +0200, Patrick Steinhardt wrote:
> Both issues have the same underlying root cause, which is that geometric
> repacks don't honor whether packfiles are local or not. As a result,
> they will try to include packs part of the alternate object directory
> and then at a later point fail to locate them as they do not exist in
> the object directory of the repository we're about to repack.

Interesting. This fix does make sense, but I wonder if it is doing the
right thing.

When we have an alternated repository and do 'git repack -ad' in the
"member" repository, we'll end up creating a new pack containing all
objects in that repository, including ones from the alternate.

For example, if you do something like:

    rm -fr shared member

    git init shared
    git -C shared commit --allow-empty -m "base" && git -C shared repack -d

    git clone --shared shared member
    git -C member repack -ad

    for dir in shared member
    do
      echo "==> $dir"
      find $dir/.git/objects -type f
    done

Then you'll end up with the output:

    ==> shared
    shared/.git/objects/pack/pack-a2f0c663b287c3eeb0207397f8cafb9ae49f8277.idx
    shared/.git/objects/pack/pack-a2f0c663b287c3eeb0207397f8cafb9ae49f8277.pack
    shared/.git/objects/info/packs
    ==> member
    member/.git/objects/pack/pack-a2f0c663b287c3eeb0207397f8cafb9ae49f8277.idx
    member/.git/objects/pack/pack-a2f0c663b287c3eeb0207397f8cafb9ae49f8277.pack
    member/.git/objects/info/alternates
    member/.git/objects/info/packs

In other words, we end up creating the pack necessary in the member
repository necessary to complete the repack. Since we're using `-a`
here, that means creating an identical pack as we have in the shared
repository.

If we instead did something like:

    git -C member repack -adl # <- `-l` is new here

, our output changes to instead contain the following (empty) pack
directory in the member repository:

    ==> member
    member/.git/objects/info/alternates
    member/.git/objects/info/packs

> Skip over packfiles that aren't local. This will cause geometric repacks
> to never include packfiles of its alternates.

...So I wonder if this is the right thing to do in all cases. IOW,
should we be creating packs in the "member" repository which may be
based off of packs from the shared repository when `-l` is not
specified?

I think this gets tricky. For one, the geometric repack code creates at
most one new pack. So if some of the packs that were above the split
line (IOW, the ones that don't need to be squashed together) were in the
shared repository, I'm not sure how you'd write a MIDX that covers both
without using the MIDX-over-alternates feature. I have no idea how that
works with MIDX bitmaps (IIUC, the MIDX/alternates feature is very
niche).

I think we reasonably could do something like ignoring non-local packs
in `init_pack_geometry()` only when `-l` is given. That still runs into
problems when trying to write a MIDX or MIDX bitmaps, so we should
likely declare the combination "-l --write-midx --write-bitmap-index" as
unsupported. For backwards compatibility, I think it would make sense to
have "--no-local" be the default when `--geometric` is given (which is
already the case, since po_args is zero-initialized).

I suspect in practice that nobody cares about what happens when you run
"git repack --geometric=<d> --local", but in case they do, I think the
above is probably the most reasonable behavior that I can quickly come
up with.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/repack.c            |  6 ++++
>  t/t7703-repack-geometric.sh | 59 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 87f73c8923..c6d12fa4bd 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -333,6 +333,12 @@ static void init_pack_geometry(struct pack_geometry **geometry_p,
>  	geometry = *geometry_p;
>
>  	for (p = get_all_packs(the_repository); p; p = p->next) {
> +		/*
> +		 * We don't want to repack packfiles which are not part of the
> +		 * primary object database.
> +		 */
> +		if (!p->pack_local)
> +			continue;

So this would change to something like `if (po_args.local &&
!p->pack_local)`.

> diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
> index 8821fbd2dd..9f8bc663e4 100755
> --- a/t/t7703-repack-geometric.sh
> +++ b/t/t7703-repack-geometric.sh
> @@ -281,4 +281,63 @@ test_expect_success '--geometric with pack.packSizeLimit' '
>  	)
>  '
>
> +packed_objects() {
> +	git verify-pack -v "$@" >tmp-object-list &&
> +	sed -n -e "s/^\([0-9a-f][0-9a-f]*\).*\(commit\|tree\|blob\|tag\).*/\1/p" <tmp-object-list &&
> +	rm -f tmp-object-list
> +}

Just a nitpick, but I've found the output from index-pack to be a little
easier to work with here. I think that you could replace this function
with the following and have it work:

--- 8< ---
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 9f8bc663e4..e3ac5001bd 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -282,9 +282,8 @@ test_expect_success '--geometric with pack.packSizeLimit' '
 '

 packed_objects() {
-	git verify-pack -v "$@" >tmp-object-list &&
-	sed -n -e "s/^\([0-9a-f][0-9a-f]*\).*\(commit\|tree\|blob\|tag\).*/\1/p" <tmp-object-list &&
-	rm -f tmp-object-list
+	git show-index <"$1" >tmp-object-list &&
+	cut -d' ' -f2 tmp-object-list
 }

 test_expect_success '--geometric with no local objects creates no pack' '
--- >8 ---

I removed the "&& rm -f tmp-object-list", since we overwrite it anyway
whenever we call packed_objects().

> +test_expect_success '--geometric with no local objects creates no pack' '
> +	git init shared &&
> +	test_when_finished "rm -fr shared" &&
> +	test_commit -C shared "shared" &&
> +	git -C shared repack -Ad &&
> +
> +	# Set up the member repository so that it does not have
> +	# any objects on its own.
> +	git clone --shared shared member &&
> +	test_when_finished "rm -fr member" &&
> +
> +	git -C member repack --geometric 2 --write-midx &&
> +	find member/.git/objects/pack -type f >actual &&
> +	test_must_be_empty actual

Another small nitpick, but I think these last two lines could be
replaced with

    test_dir_is_empty member/.git/objects/pack

or even

    test_dir_is_empty member/$packdir

> +test_expect_success '--geometric does not include shared packfiles' '
> +	git init shared &&
> +	test_when_finished "rm -fr shared" &&
> +	test_commit -C shared "shared" &&
> +	git -C shared repack -Ad &&
> +
> +	git clone --shared shared member &&
> +	test_when_finished "rm -fr member" &&
> +	git -C member commit --allow-empty --message "not-shared" &&

Any reason to make this commit empty? Could we replace this with

    test_commit -C member not-shared

?

> +test_expect_success '--geometric with same packfile in shared repository' '
> +	git init shared &&
> +	test_when_finished "rm -fr shared" &&
> +	test_commit -C shared "shared" &&
> +	git -C shared repack -Ad &&
> +
> +	# Prepare the member repository so that it got the exact same packfile
> +	# as the shared repository and set up gitalternates.
> +	cp -r shared member &&
> +	test_when_finished "rm -fr member" &&
> +	test-tool path-utils real_path shared/.git/objects >member/.git/objects/info/alternates &&
> +	find shared/.git/objects -type f >expect &&

This works, though it may be easier to write something like:

    git clone -s shared member &&
    test_when_finished "rm -fr member" &&
    # ensure that "shared" and "member" have an identical set of packs
    git -C member repack -a &&
    find shared/.git/objects -type f >expect &&

> +	# After repacking, contents of the member repository should not have
> +	# changed.
> +	git -C member repack --geometric 2 --write-midx 2>error &&

I think that "2>error" is a stray change left over from debugging, and
could probably be removed.

> +	find shared/.git/objects -type f >actual &&

This and above could be replaced with shared/$packdir. Whenever I'm
asserting the contents of a directory are unchanged, I typically like to
call the two files under comparison "before" and "after", but "expect"
and "actual" are fine here, too.

Thanks,
Taylor
