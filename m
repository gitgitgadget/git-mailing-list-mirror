Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D554C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 15:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbiAZPEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiAZPEX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 10:04:23 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB429C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:04:22 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p15so39651385ejc.7
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=OCYhnosqNwMdThAduX2uXGcPNFSinPzP3+x7opv7azY=;
        b=NqSmV5PfRFlM9LsEjvjFL/tAcdn2RGbG+bbhb+Tp5xD9tzMEYo43juZY4CvQrMwKuF
         Dxr5htBjUWNSUsv4KZmonfBr7btwrqkZ/nnVD4NKYFxtzgJE8rU/QOvnN4PLOXxCbHuv
         P2pkK5ImMS4jBDb63+ivkQQEy+vgCfPUDhiWbLk5VSh/nBXIK0QM3Ew4eogKLuptlAyh
         o1CJYR45o0I6KWyOxT1+FRJKihYgA8kyPL9LLYn+W0PBEqlB3UZoepVc1rR4FX6wjDPu
         Bu2E4QmU4CX0S67lpPSUXmP/wMUvQzHMtHGldDzmoUQmDJwdatvX+0cjHsKhogJ/ScfM
         jOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=OCYhnosqNwMdThAduX2uXGcPNFSinPzP3+x7opv7azY=;
        b=rt1fu6r2TldbSH+Q8xIL99Adj0mnQp7wWVuIvMrqOvoGMziQR0oFYiaEbASjh5jYvh
         k1rjvsOy4EvZSfeAk/azBI0nm4wbBZL8HhTtzhwJB8tVxLNzieXFjy3dcbCLjC1ttxl0
         XFpe1IKXxaiLPJ6Bciwe3R0uq5/1ApBacMCPfflttBJD5HaVvzgg7gA0iNwrRTQ9uiVm
         zSA60HM3XD0P4znvlfjikPUtGYJhEssw/d+jvDKeD4jD7Kifo3uJMl2jkisQR5dRZIKR
         KH0R1lT+AGEzj4XZcTyTEnpI8IClnzK0WLfdYniIg9pkqmbYkF/rjXR9TQkESfkA+D3B
         gB3g==
X-Gm-Message-State: AOAM530PxVynSBMyVm3WZETqctw4aEIf+LBj4aw/TVkbRnLJeLbXbr3u
        Sjy9BsnbOOwYS8xqDAivHpI=
X-Google-Smtp-Source: ABdhPJwGDzRSMKQKFQHxuM5f/E7mgCY8b1kq38ZfBojVSxiQlDf4Z+glXaJC4N4iE+MubDiwYRrICQ==
X-Received: by 2002:a17:907:8687:: with SMTP id qa7mr5187290ejc.328.1643209461324;
        Wed, 26 Jan 2022 07:04:21 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s12sm7484641ejx.184.2022.01.26.07.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:04:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCjqO-003ADs-6z;
        Wed, 26 Jan 2022 16:04:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 3/9] pack-revindex.c: instrument loading on-disk
 reverse index
Date:   Wed, 26 Jan 2022 16:03:50 +0100
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
 <abc18613e04a3bb8571926cb653296fe6b49cc60.1643150456.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <abc18613e04a3bb8571926cb653296fe6b49cc60.1643150456.git.me@ttaylorr.com>
Message-ID: <220126.86y232edxn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 25 2022, Taylor Blau wrote:

> In a subsequent commit, we'll use the MIDX's new 'RIDX' chunk as a
> source for the reverse index's data. But it will be useful for tests to
> be able to determine whether the reverse index was loaded from the
> separate .rev file, or from a chunk within the MIDX.
>
> To instrument this, add a trace2 event which the tests can look for in
> order to determine the reverse index's source.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-revindex.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/pack-revindex.c b/pack-revindex.c
> index 70d0fbafcb..bd15ebad03 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -301,6 +301,9 @@ int load_midx_revindex(struct multi_pack_index *m)
>  	if (m->revindex_data)
>  		return 0;
>  
> +	trace2_data_string("load_midx_revindex", the_repository,
> +			   "source", "rev");
> +
>  	get_midx_rev_filename(&revindex_name, m);
>  
>  	ret = load_revindex_from_disk(revindex_name.buf,

IMO easier to read/reason about if squashed into 5/9, where it's first
used, or at least re-arrange it so that 4/9 isn't between the two...
