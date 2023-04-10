Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A06C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 23:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDJXtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDJXtF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 19:49:05 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AEC213D
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:49:04 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i20so10006836ybg.10
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681170544; x=1683762544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tOPONo9PTqYUoriLx85/1zJPsam6w7oNaE5lorcxfY=;
        b=b8YpPSwyjJU2kZGdLXbGiVqjzWH3+WAbW1O15uzRncKkwmip4lFzio+dsBojGm3cFL
         D4yoi60DMRt50xmoUw+p+Js/A5PH5TavCNUmTAEEN2YaeK5Qz7S/cqL+UvCOZcjXdmKP
         MAmPXguc5/McilJA/zvW3HlekchGwBK3M90siiGu0t1a8VyiCnmL6Bc22qN1f8qZNAXQ
         h4ZjKOi2p9+eHKhNZ4I3TBwWgq3Bh3xVpoZLPWN8Scw4wu/uvto2mJ3WVQzOMrYKuAXT
         Ry3v5cU0qbTqGFvoKNM4SgmFtyqJZcsYWpVNDWJiPJJ0QK7qwe6PeQbvak4ku2kbGItt
         YE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681170544; x=1683762544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tOPONo9PTqYUoriLx85/1zJPsam6w7oNaE5lorcxfY=;
        b=X8XleibREAzaG45cAq3fdEaboi+ob9QFH48Q1U9zxtJU4rPfp16b0hIEPPJ7FzCWC7
         JOeffYmALeFz84v7It0FqP24olPTS2c8qCtUC0b1/hdTmUzP8kCqc2jG4eSnxAS99gA4
         hF5ml2SVEORVklIjqq5vL6+BuRnZVBvEK6T7+6pl0j+VCohtMSNdfPWJs3ZCeT5tqsy9
         qYLJ0hcvPuH6Mxk+9wNCG+2gsbUMM+aUP8wXzCPonlnLJxGovCmjRyLH5rYLS5Tjfi8z
         fEKFw1L00ufrXQHMia15UhWOFRo9DUfmhdCY+dvixl+cOlDlz3PyfXBUjCV+czNFAPtd
         6n8w==
X-Gm-Message-State: AAQBX9ekNhLCnBKHju9BFx3DJupjEIBbL4tqISGzZggj5WP31oXMd9Wm
        xb2tq3OzIyKH0h4buQoM0N+SEA==
X-Google-Smtp-Source: AKy350bUCpNRBKZK1X4aupVw7FSIeinEsSoGNnqrP3on4UBelMnfsklrNQpaNtWYyz9nfqzCLyK3cQ==
X-Received: by 2002:a25:d09:0:b0:b8b:e8a4:5ff8 with SMTP id 9-20020a250d09000000b00b8be8a45ff8mr10236617ybn.10.1681170543633;
        Mon, 10 Apr 2023 16:49:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y72-20020a25dc4b000000b00b8ed7b61526sm1738222ybe.1.2023.04.10.16.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:49:03 -0700 (PDT)
Date:   Mon, 10 Apr 2023 19:49:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <ZDSgbYa+j/5c5t8j@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <ZCxytq1esQWvjIz/@nand.local>
 <ZC0eY8q6ushpfkrQ@ncase>
 <4c7b95e1-9d3c-e253-98ca-ac6c201babb3@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c7b95e1-9d3c-e253-98ca-ac6c201babb3@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 11:06:49AM -0400, Derrick Stolee wrote:
> Your original message includes error messages like "could not find pack"
> and "unknown preferred pack" which makes me think the _real_ problem is
> that we are not respecting the full path name of the pack-file and are
> somehow localizing packs to the local object dir.

"could not find pack" comes from pack-objects's --stdin-packs mode when
the caller specifies a pack that doesn't exist in the repository.

I'm not sure what's going on here, since read_packs_list_from_stdin()
searches over the result of calling get_all_packs(), which does include
packs in alternate object stores. And indeed, pack-objects can recognize
such packs:

--- 8< ---
#!/bin/sh

rm -fr shared member

git init shared
git -C shared commit --allow-empty -m "base" && git -C shared repack -d

git clone --shared shared member

basename "$(find shared/.git/objects/pack -type f -name '*.pack')" >input

git -C member pack-objects .git/objects/pack/pack --stdin-packs <input

for repo in shared member
do
	echo "==> $repo"
	find $repo/.git/objects/pack -type f
done
--- >8 ---

^^ the above results in generating the identical pack in the "member"
repository as expected:

==> shared
shared/.git/objects/pack/pack-d51c724345703411d57134d018e9643924900d39.idx
shared/.git/objects/pack/pack-d51c724345703411d57134d018e9643924900d39.pack
==> member
member/.git/objects/pack/pack-d51c724345703411d57134d018e9643924900d39.idx
member/.git/objects/pack/pack-d51c724345703411d57134d018e9643924900d39.pack

> The basic reason is that write_midx_included_packs() takes all of the
> pack-files from the geometry, but does not strip out the pack-files
> that are not in the same object directory.

I agree here; the pack-geometry code should be stripping out non-local
packs when writing a MIDX regardless of whether the caller passed
--local or not.

> Perhaps this method could include a step to create a new, "local"
> geometry containing only the packs within the local object dir. We can
> then skip the --preferred-pack option and bitmap if this is different
> than the original geometry (perhaps with a warning message to help
> users who did this accidentally).

It would be nice to not have to juggle multiple pack geometry structs,
since the logic of what gets repacked, what gets thrown away, and what
gets kept is already fairly complicated (at least to me) and pretty
fragile.

I think if I were sketching this out, I'd start out by doing something
like:

--- 8< ---
diff --git a/builtin/repack.c b/builtin/repack.c
index df4d8e0f0b..eab5f58444 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -558,6 +558,10 @@ static void midx_included_packs(struct string_list *include,
 		for (i = geometry->split; i < geometry->pack_nr; i++) {
 			struct packed_git *p = geometry->pack[i];

+			/* MIDXs cannot refer to non-local packs */
+			if (!p->pack_local)
+				continue;
+
 			strbuf_addstr(&buf, pack_basename(p));
 			strbuf_strip_suffix(&buf, ".pack");
 			strbuf_addstr(&buf, ".idx");
--- >8 ---

...and I actually think that might do it, since:

	- existing_nonkept_packs is populated by calling readdir() on the local
		repository's $GIT_DIR/objects/pack directory, so it will never contain
		any non-local packs.

	- existing_kept_packs is also OK for the same reason

	- names (which tracks the packs that we just wrote) will never contain a
		non-local pack, since we never write packs outside of our local pack
		directory

So that would cause you to write a MIDX containing only local packs (as
desired) regardless of whether or not the caller passed --[no]-local or
not.

> > I'd personally be fine to start honoring the `po_args.local` flag so
> > that we skip over any non-local packfiles there while ignoring the
> > larger problem of non-local geometric repacks breaking in certain
> > scenarios. It would at least improve the status quo as users now have a
> > way out in case they ever happen to hit that error. And it allows us to
> > use geometric repacks in alternated repositories. But are we okay with
> > punting on the larger issue for the time being?
>
> I think the real bug is isolated in write_midx_included_packs() in how
> it may specify packs that the multi-pack-index cannot track. It should
> be worth the time exploring if there is an easy fix there, and then the
> po_args.local version can be used as a backup/performance tweak on top
> of that.

Yeah, seeing "unknown preferred pack" makes me suspicious that we tried
to write a MIDX that contains a pack outside of our repository. I tried
to reproduce that case with the following script but couldn't do it (the
pack that the MIDX does track is the local one, as expected):

--- 8< ---
#!/bin/sh

rm -fr shared member

git init shared
git -C shared commit --allow-empty -m "base" && git -C shared repack -d

git clone --shared shared member

git -C member commit --allow-empty -m "base" && git -C member repack -d

{
	basename "$(find shared/.git/objects/pack -type f -name '*.idx')"
	basename "$(find member/.git/objects/pack -type f -name '*.idx')"
} |
git.compile -C member multi-pack-index write --stdin-packs

for repo in shared member
do
	echo "==> $repo"
	find $repo/.git/objects/pack -type f
done

( cd member && ~/src/git/t/helper/test-tool read-midx --show-objects .git/objects )
--- >8 ---

But the MIDX code that is responsible for collecting the packs specified
over --stdin-packs enumerates the possible packs by calling
`for_each_file_in_pack_dir()` with our local `object_dir`, so I don't
think it's possible to have a MIDX that contains a non-local pack.

IOW, I agree with you that the bug is in write_midx_included_packs(),
and I think the fix that I outlined would do the trick.

Thanks,
Taylor
