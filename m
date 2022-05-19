Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6EDC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 11:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiESLdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 07:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiESLdN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 07:33:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCF2B042F
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:33:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y13so8613349eje.2
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KzXuSHNKnQ6uyuvvULq7TKhqaypnu0EgXwFPU6aSP6Q=;
        b=Im9DMnw8A1p/X2KDx2xf8PMHYLJSRTUW4aMjyVra0mrk04FmTY+jn4Aegl0Rd6tDN1
         EpmO82TPJEWZrRTsazNFce4SiHvchHuFml4R9XtKLgpwzO1yIr1TY2VlqLQK+VJ4Roy7
         qfMfb/rfLgWtML1uQwvGvBVZyslW0G3i7qXhph5srB87L0fM0/J4PWK6ymhsr4TdLqxY
         fNx9mZc/iLLUE1wrVGBCOgIL41Wkmw8qTb0inmMrD7i3N7RVdQu9zP17I66F8so3q7pX
         FNOf1HDeaDJKK7PgUhCpZRwDyLbpTWflGlYeV18VITAs0JQhjNSEYihMhySwd3D9bSfc
         VdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KzXuSHNKnQ6uyuvvULq7TKhqaypnu0EgXwFPU6aSP6Q=;
        b=VE5EbR6kqJ5FjNJjgD8q1+HPjpHGWI5s6dbMl8SjYQjKKvOVIMrHUTgm/qvPMZU0LL
         Myj31aR79PpFvm4whTKwqQGN00Z571rCosUZL3LIyg8P6Ub2nGIwM8WCjSeQ4hvyGQhs
         8pOgbw1nWmFIZjO3ZWvb0dEryG9OvyXUgEdm08IlhqYDAXm1L5am4de/a5uuuB0sH80I
         ZGz3mrVRlKPFGQY4LMOYfPqta1rd7cKNsUF+4RKXL2stfIq0qiRjoFtIYY/V0Y1IABo0
         23fWuIVccXp2PLIpegR3v6pAIRkBhSYtcUEawFOrHKUFl5GTZNjJKPqPd2n5z69pfctA
         Ae/g==
X-Gm-Message-State: AOAM533mFM53PnLVDnLTj8X8UCS8zKWA4SmuNiwlZZltjTH3dNvJiBkK
        ZpfXjJNFTjWDh+tIlcmkGeg=
X-Google-Smtp-Source: ABdhPJyyNztjggiZwHjK6LZEP0mqAChJ+D+KH2e1V2s3wRUp+5tE/jQ/2vVgntL5ZPafFAbC0dY2Dg==
X-Received: by 2002:a17:906:3ed5:b0:6f5:108c:a45 with SMTP id d21-20020a1709063ed500b006f5108c0a45mr3819192ejj.623.1652959990902;
        Thu, 19 May 2022 04:33:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id eo8-20020a1709069b0800b006fe78f1123fsm1965383ejc.197.2022.05.19.04.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 04:33:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nreOz-0025k4-Cy;
        Thu, 19 May 2022 13:33:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 15/17] builtin/repack.c: add cruft packs to MIDX
 during geometric repack
Date:   Thu, 19 May 2022 13:32:26 +0200
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
 <0743e373baaaaee2bc5f8664b1e64038e6dbf4c2.1652915424.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <0743e373baaaaee2bc5f8664b1e64038e6dbf4c2.1652915424.git.me@ttaylorr.com>
Message-ID: <220519.86r14p4v0q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 18 2022, Taylor Blau wrote:

> When using cruft packs, the following race can occur when a geometric
> repack that writes a MIDX bitmap takes place afterwords:
>
>   - First, create an unreachable object and do an all-into-one cruft
>     repack which stores that object in the repository's cruft pack.
>   - Then make that object reachable.
>   - Finally, do a geometric repack and write a MIDX bitmap.
>
> Assuming that we are sufficiently unlucky as to select a commit from the
> MIDX which reaches that object for bitmapping, then the `git
> multi-pack-index` process will complain that that object is missing.
>
> The reason is because we don't include cruft packs in the MIDX when
> doing a geometric repack. Since the "make that object reachable" doesn't
> necessarily mean that we'll create a new copy of that object in one of
> the packs that will get rolled up as part of a geometric repack, it's
> possible that the MIDX won't see any copies of that now-reachable
> object.
>
> Of course, it's desirable to avoid including cruft packs in the MIDX
> because it causes the MIDX to store a bunch of objects which are likely
> to get thrown away. But excluding that pack does open us up to the above
> race.
>
> This patch demonstrates the bug, and resolves it by including cruft
> packs in the MIDX even when doing a geometric repack.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/repack.c              | 19 +++++++++++++++++--
>  t/t5329-pack-objects-cruft.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 36d1f03671..e9e3a2b4e3 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -23,6 +23,7 @@
>  #define PACK_CRUFT 4
>  
>  #define DELETE_PACK 1
> +#define CRUFT_PACK 2
>  
>  static int pack_everything;
>  static int delta_base_offset = 1;
> @@ -161,8 +162,11 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
>  		if ((extra_keep->nr > 0 && i < extra_keep->nr) ||
>  		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
>  			string_list_append_nodup(fname_kept_list, fname);
> -		else
> -			string_list_append_nodup(fname_nonkept_list, fname);
> +		else {
> +			struct string_list_item *item = string_list_append_nodup(fname_nonkept_list, fname);

Nit: very long line, and we end up with {} just on the else, not the if.
