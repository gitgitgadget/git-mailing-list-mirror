Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1741C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 13:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998DE64DE8
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 13:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhBWNR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 08:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhBWNRy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 08:17:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABCDC061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 05:17:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id n1so25856068edv.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 05:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DK8kr1Ez1IX9YmEJYivogEt5Wpe8M5E8DY4yRZRdNow=;
        b=IKGCEb2kVOVwJWfvr64I+dd7vGcOJxdKOo1QndXhuLomTylMHck5uTEgICDzlZFE9x
         7THfn4k796U5SxQCyOdaDTTAtskItWwcKOO2NeRfAhpxi/CCr/5D0PU0lcdRr7zKWZiu
         YotfnKVYKp+SV+FLz+19LhW2I5Yy41zTnnldeEA3LKUY+274Y0BIBeaFdP0VND8ZNsWR
         sO0CoeF35/8gYgyDtEM49GLpXrRd8N8sVDJc7vGMt7DJKT/WucZRZZnwvjRu0iPn3YQH
         3LA4IANmtYzIJAwFScrCStAI8bgnSFzolTQxeMEDjgInVSy2k5TMfxL1yGziJrxbVkUu
         jcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DK8kr1Ez1IX9YmEJYivogEt5Wpe8M5E8DY4yRZRdNow=;
        b=RuYCT2dE9IwwgrGRcwaWuWiWCXdKCSIUrFppm14eml762sJU8A3UgxnqTi2o6ZnY3M
         idr1/w5AoP6yqfyJxOZ2KnmPhO5X2Uto239fASSf+mgfiYqm86aTVO39+ZxVgseEPTHf
         zja52Anrf26xkbjGVHuGDEtLA96j9ubqq0uTACSitUpLj7Is6DDBYtBK4C/5YEZVEgiL
         R8dhmIjIJwK3yv6PatGHbjZKQEsDIBH354lBkb2TkHY6jXS3JYQuj4g56gitBXIalZ8/
         QEtCwD+atL39ktmB8FiWR4ADfQz11tfnYk7l7eEP3s1VkECmqMlGOYTJ2dIWkjjXVfwR
         F/0w==
X-Gm-Message-State: AOAM533SL+/r56+GQzCPGB8jLh1b72I8TAE05c6biTyMGFpg8cee0mUM
        w9pTgJR0yNGcmLpnr7RncML2JETQJM1v7g==
X-Google-Smtp-Source: ABdhPJx98IBulcVyiXMLfTMWUcnd+y1Pxoh3xmMUDiIVHhqXREUKbOB1jnIRwCyiWJWnCVoryIOIog==
X-Received: by 2002:aa7:cf12:: with SMTP id a18mr172804edy.111.1614086233420;
        Tue, 23 Feb 2021 05:17:13 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j24sm691106edy.3.2021.02.23.05.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 05:17:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/4] http-fetch: allow custom index-pack args
References: <20210115234300.350442-1-jonathantanmy@google.com>
 <cover.1614021092.git.jonathantanmy@google.com>
 <57220ceb841056aade08705ca0ac73ccc69f05ab.1614021093.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <57220ceb841056aade08705ca0ac73ccc69f05ab.1614021093.git.jonathantanmy@google.com>
Date:   Tue, 23 Feb 2021 14:17:12 +0100
Message-ID: <874ki29b53.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 22 2021, Jonathan Tan wrote:

> diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
> index 4deb4893f5..9fa17b60e4 100644
> --- a/Documentation/git-http-fetch.txt
> +++ b/Documentation/git-http-fetch.txt
> @@ -41,11 +41,17 @@ commit-id::
>  		<commit-id>['\t'<filename-as-in--w>]
>  
>  --packfile=<hash>::
> -	Instead of a commit id on the command line (which is not expected in
> +	For internal use only. Instead of a commit id on the command
> +	line (which is not expected in
>  	this case), 'git http-fetch' fetches the packfile directly at the given
>  	URL and uses index-pack to generate corresponding .idx and .keep files.
>  	The hash is used to determine the name of the temporary file and is
> -	arbitrary. The output of index-pack is printed to stdout.
> +	arbitrary. The output of index-pack is printed to stdout. Requires
> +	--index-pack-args.
> +
> +--index-pack-args=<args>::
> +	For internal use only. The command to run on the contents of the
> +	downloaded pack. Arguments are URL-encoded separated by spaces.
>  
>  --recover::
>  	Verify that everything reachable from target is fetched.  Used after
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 876f90c759..aeac010b0b 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1645,6 +1645,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		strvec_pushf(&cmd.args, "--packfile=%.*s",
>  			     (int) the_hash_algo->hexsz,
>  			     packfile_uris.items[i].string);
> +		strvec_push(&cmd.args, "--index-pack-arg=index-pack");
> +		strvec_push(&cmd.args, "--index-pack-arg=--stdin");
> +		strvec_push(&cmd.args, "--index-pack-arg=--keep");

The docs say --*-args, but the code checks --*arg, that seems like a
mistake that should be fixed to make the code/tests use the plural form,
no?
