Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E35C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE0E60F36
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhHBVH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhHBVH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 17:07:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A59C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 14:07:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so848867pjr.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gwB2uQmJ1s8E8LD0BSbSlNy8F8fdPiUtuNFqb0KY7q4=;
        b=nK4bxnyBodOqCBmN0lheQAf341Xtu3j623SoJv8nJQU8yFdq3W7ps120udZnN9KDYP
         c8YdIi4GAocmMY9XSbyERr9sjFQcgapWe9XcTyphUh3bmMKNioI6I15Smq6Bisc+To5t
         OcYd9NArfR9KBYUvQGK5o1SMsep3LRxXxoNZiwu8aaSCOd+OQBfLOizOuZ5G83IMMW6E
         7dH98IcKcXHcY3sPGTAu6sKVgQJ0u2VQCTWo1qYC3T5oRcQvDTqmMQLMlGZybBWoK6bA
         TJ4mO68ghqFepfmOiLYA4+p7m7uW3GXHbfQ0ZYYHBFgwOkHAsxOcgWKYTOvecvl5ea7H
         1mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=gwB2uQmJ1s8E8LD0BSbSlNy8F8fdPiUtuNFqb0KY7q4=;
        b=uOUd0llk94jBTzF/9nXQnRZZjCEhj9C8Uzfd4rAmTV5/Tz6IzUj0P3jH57Z9GtdgWV
         tfWY4P4OLb0BZLozyzIWQz3IqnanWhkTppj8xsoliO3QnurZQsgYJhB+ZlEIEGy2Hl35
         tMERV/xgpG/7fWp6PYJJoC90R53pTDWUwtuUNA2SNH1HlEeOVkMKS2QNKtCM+ha4orUV
         xL4T/De9RS/192z3aGrLuEo4BOGx7fLauv3N/2fp4EUk3vZD+rxYlLRp79lsGvcKu4Og
         b8exm0CeeDjnVfIMOtSnDlTDhBPbX6AEuxbVHkwfbaTk7RdUGqvPCJ/oFTe3lIsKCtSa
         6wgA==
X-Gm-Message-State: AOAM530ocOd3iDtqoCgEOkw/5eKD1QiBQB4Jl0/bq9ke2vYVbzfXh8HH
        TDTReeo1bit2VYSvJukLhncp+g==
X-Google-Smtp-Source: ABdhPJysNHfw9AAs3W7hWOivYteB9/fOqxxYfAT1dlgvyamBuDMylRNJ+6fc5PnMP1ckKI2MF813sA==
X-Received: by 2002:a65:6118:: with SMTP id z24mr274209pgu.325.1627938468296;
        Mon, 02 Aug 2021 14:07:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:48c6:d78b:4975:a449])
        by smtp.gmail.com with ESMTPSA id y4sm331189pjg.9.2021.08.02.14.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:07:46 -0700 (PDT)
Date:   Mon, 2 Aug 2021 14:07:40 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 00/12] serve.[ch]: general API cleanup
Message-ID: <YQhenAYAOvdCAXge@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
 <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.07.22 01:40, Ævar Arnfjörð Bjarmason wrote:
> For v2, see:
> https://lore.kernel.org/git/cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com/
> 
> Junio: Sorry about the late update, re:
> http://lore.kernel.org/git/xmqqsg07cz4g.fsf@gitster.g
> 
> I think most people were on the fence about the need for this
> "startup_config" callback in v2. I think we could still do without it,
> but as the new 08/12 shows a big part of the API complexity was due to
> serve() supporting the --advertise-refs mode directly. 08-10/12 is a
> new late-series cleanup of that, which makes serve.[ch] a lot simpler.
> 
> Ævar Arnfjörð Bjarmason (12):
>   serve: mark has_capability() as static
>   transport: rename "fetch" in transport_vtable to "fetch_refs"
>   transport: use designated initializers
>   serve: use designated initializers
>   serve.c: add call_{advertise,command}() indirection
>   serve: add support for a "startup" git_config() callback
>   serve.c: move version line to advertise_capabilities()
>   serve.[ch]: remove "serve_options", split up --advertise-refs code
>   {upload,receive}-pack tests: add --advertise-refs tests
>   upload-pack: document and rename --advertise-refs
>   upload-pack.c: convert to new serve.c "startup" config cb
>   serve.[ch]: don't pass "struct strvec *keys" to commands

Sorry for the delayed response on this series; I've been away from work
for the past several weeks.

I'm in favor of the cleanups in patches 1-4. I'm afraid I am not
familiar enough with the server code to have useful feedback on the rest
of the patches, at least not at first glance.
