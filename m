Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44407C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 15:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbiAZPSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242654AbiAZPSU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 10:18:20 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76592C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:18:20 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m4so39851802ejb.9
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=f/Q50mLE1odIho6yAHQmghXmi6pCPIZyNtuXKTEOBuI=;
        b=Tqeb5Qvb6rrH8EJEEdkGhynrC17/hHjVXNP8DQf6i9K5hqOprm7aQpygbD1A5OnhpO
         bQ/MJ3s5Bwb12wfP93pLbRpYhwzylM09LgGPHyzaWfsxv+XWKrYCiQEgeG+uQ8c+9h2y
         SdE+KpSWaDivL6EY2K+gts0cTKwuDXbI3ZCzaf7mA7I/z7VeNZbDZtebA/l1dCpXnmvK
         l7UhGyPhr9lFqou/fuC2zPxB607xJytVbjqsIFuhXvYYrSXkuJnPPnzapFJivTuh2iGy
         /aKBtw6//fnWnKD0pkAW3kE/xynXdxm89L1zRcBJKyq5wTMGuoX5rr3bmPhdWbt6TxK/
         Zh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=f/Q50mLE1odIho6yAHQmghXmi6pCPIZyNtuXKTEOBuI=;
        b=pCYBS6aXl0fPyixwGR8MaG5Zm5GGiluoKabnO2W2FrsJqnpwdIkI8KDZWsteCeY6JJ
         NfZmX9f75vDjRCMZZhgQs+DPrEx/Bm9madT44E/mPODNhjEpGrFQ2yrNHXigLSWcb1+b
         UmJlUm4dNc5Ra8TtFHlTEHLOrOYc5rramjhIhqrziB/C3ggeRvOnqw82+SR7P7pAvkGU
         NSxqih7Z8jLbz/2TgQ9apWx/4tCrusLPq5IJZHqw27uhgglrj7ocxA9Phj15yvyRvHO7
         FZymfmew8eURvh8IS+7gjhEbHpe0yhQCLlSz/IFi+SyCEDjupmVyKLi0K5Nqsc10zqOV
         HTRA==
X-Gm-Message-State: AOAM531rGxNmPbyUKmbJ4jNClPqxWBqzcgZH/bPgmoQCNV2BEEyDogr4
        lL3YbzlqfpGOYKyJism8DkA=
X-Google-Smtp-Source: ABdhPJyuos8lIRt3vqrv1xGOMskrvSZMBPPMFED4FHbgniWXYYraeVm5OwoKSt8NkgXAGd6i4A0a8Q==
X-Received: by 2002:a17:907:6d9d:: with SMTP id sb29mr18505746ejc.455.1643210298920;
        Wed, 26 Jan 2022 07:18:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h1sm9788498edz.64.2022.01.26.07.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:18:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCk3t-003Aa6-Si;
        Wed, 26 Jan 2022 16:18:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 8/9] midx: read `RIDX` chunk when present
Date:   Wed, 26 Jan 2022 16:10:08 +0100
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
 <94563cf038722852d801bd0a8e744a569799f354.1643150456.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <94563cf038722852d801bd0a8e744a569799f354.1643150456.git.me@ttaylorr.com>
Message-ID: <220126.86lez2edae.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 25 2022, Taylor Blau wrote:

> @@ -298,9 +298,26 @@ int load_midx_revindex(struct multi_pack_index *m)
>  {
>  	struct strbuf revindex_name = STRBUF_INIT;
>  	int ret;
> +

nit: good addition for style in general, but a stay whitespace change in
an otherwise narrowly focused patch.

>  	if (m->revindex_data)
>  		return 0;
>  
> +	if (m->chunk_revindex) {
> +		/*
> +		 * If the MIDX `m` has a `RIDX` chunk, then use its contents for
> +		 * the reverse index instead of trying to load a separate `.rev`
> +		 * file.
> +		 *
> +		 * Note that we do *not* set `m->revindex_map` here, since we do
> +		 * not want to accidentally call munmap() in the middle of the
> +		 * MIDX.
> +		 */
> +		trace2_data_string("load_midx_revindex", the_repository,
> +				   "source", "midx");
> +		m->revindex_data = (const uint32_t *)m->chunk_revindex;
> +		return 0;
> +	}
> +
>  	trace2_data_string("load_midx_revindex", the_repository,
>  			   "source", "rev");

This trace2_data_string() is repeated with just "midx" v.s. "rev"
parameters.

I was going to suggest that maybe we should add a "goto" here, since
you're trying to juggle the early return and logging this.

But wouldn't this be both simpler and give you better logging if it was
the usual region start/end pattern, with just the "data string"
in-between?

Then you'd get both performance data on the index loading, and the
source.

Or maybe it's overkill in this case, I don't know...

