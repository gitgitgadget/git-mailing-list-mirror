Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A561FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 19:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbdBJTWl (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 14:22:41 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33723 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdBJTWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 14:22:40 -0500
Received: by mail-pg0-f67.google.com with SMTP id 194so3761890pgd.0
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mcJOKVUr0ibSvgVgzvXz49OOuhbLCMBcA1xmlw4mDw4=;
        b=lIYILAr/+izyh+uTEuO7oXTI2sSHboe2xyjbx9QO5opa9LKiOLAq8idtGkN9ytvpoZ
         NKn3AADgMZ1ljyBWsAe1y9+kgHRvxYUZjz1idshyKvaQpWTtWqkVUyGbj+hOpFjOgmNv
         vrRuSJZnRanU1dZPC2Q07RVz1YmznzTKVDjqyWcsULBhZ1rvEK04y683bHQAHfwmNw1H
         YDCKpfjZF3f+RID/zLOx0F5bdZOp4Cur2Xxb45qtlB0l8g99hxn55bYZbwMZmzoFhX/d
         /lrkultmp3WDJwxVOxjyeTrnS7QkO/ixyfXuVmSKn7i7vNsXOjFJEIBDAnspansbiN6T
         pqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mcJOKVUr0ibSvgVgzvXz49OOuhbLCMBcA1xmlw4mDw4=;
        b=VsPU/LNL2QGs8glUNE9OJ2n5rXRRSo1AhlN1c14tBc2huG0RynABO9hJIh/C0xl0kH
         7AJZs4Dpy9TvOz494v1sSK7DKP9vF60L7mKcyv53wXEmKAlrSGNhS63xzXVkpbR9vO06
         nRCOOaEXX2rMsX6b7BynduQLhE2+tHpQb7sxlnuD16Y3z7S1g51MaP4v9qffhr0zTRj4
         FsKPajlrA1aZCoU8juCmhdWaDAhCySYp726wZNWeC1FjRp4xcm/J4Gv1x5P4ArWPpCsB
         io055Zjc0YxQ+QNa4gnBYwjpXH2GjVdSNbUISyt1wGcYjboK8dOyCrdpiGUfxD3K4q68
         gMcQ==
X-Gm-Message-State: AMke39ns6GgQsCBqsX/KUO8mg8YszNbC0YAQ4HJMFyNSEg++LlM/1recdaBjJ1kUyEGLEA==
X-Received: by 10.99.38.2 with SMTP id m2mr12488715pgm.169.1486754534377;
        Fri, 10 Feb 2017 11:22:14 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id h4sm7107346pfk.96.2017.02.10.11.22.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 11:22:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 9/9] read_loose_refs(): read refs using resolve_ref_recursively()
References: <cover.1486724698.git.mhagger@alum.mit.edu>
        <d8e906d969700acbca8dc717673d0a9cdc910f62.1486724698.git.mhagger@alum.mit.edu>
Date:   Fri, 10 Feb 2017 11:22:13 -0800
In-Reply-To: <d8e906d969700acbca8dc717673d0a9cdc910f62.1486724698.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Fri, 10 Feb 2017 12:16:19 +0100")
Message-ID: <xmqqbmu9lul6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> There is no need to call read_ref_full() or resolve_gitlink_ref() from
> read_loose_refs(), because we already have a ref_store object in hand.
> So we can call resolve_ref_recursively() ourselves. Happily, this
> unifies the code for the submodule vs. non-submodule cases.
>
> This requires resolve_ref_recursively() to be exposed to the refs
> subsystem, though not to non-refs code.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c               | 50 +++++++++++++++++++++++++-------------------------
>  refs/files-backend.c | 18 ++++--------------
>  refs/refs-internal.h |  5 +++++
>  3 files changed, 34 insertions(+), 39 deletions(-)

OK, but one thing puzzles me...

> @@ -1390,27 +1390,6 @@ static struct ref_store *main_ref_store;
>  static struct hashmap submodule_ref_stores;
>  
>  /*
> - * Return the ref_store instance for the specified submodule (or the
> - * main repository if submodule is NULL). If that ref_store hasn't
> - * been initialized yet, return NULL.
> - */
> -static struct ref_store *lookup_ref_store(const char *submodule)
> -{
> -	struct submodule_hash_entry *entry;
> -
> -	if (!submodule)
> -		return main_ref_store;
> -
> -	if (!submodule_ref_stores.tablesize)
> -		/* It's initialized on demand in register_ref_store(). */
> -		return NULL;
> -
> -	entry = hashmap_get_from_hash(&submodule_ref_stores,
> -				      strhash(submodule), submodule);
> -	return entry ? entry->refs : NULL;
> -}
> -
> -/*
>   * Register the specified ref_store to be the one that should be used
>   * for submodule (or the main repository if submodule is NULL). It is
>   * a fatal error to call this function twice for the same submodule.
> @@ -1451,6 +1430,27 @@ static struct ref_store *ref_store_init(const char *submodule)
>  	return refs;
>  }
>  
> +/*
> + * Return the ref_store instance for the specified submodule (or the
> + * main repository if submodule is NULL). If that ref_store hasn't
> + * been initialized yet, return NULL.
> + */
> +static struct ref_store *lookup_ref_store(const char *submodule)
> +{
> +	struct submodule_hash_entry *entry;
> +
> +	if (!submodule)
> +		return main_ref_store;
> +
> +	if (!submodule_ref_stores.tablesize)
> +		/* It's initialized on demand in register_ref_store(). */
> +		return NULL;
> +
> +	entry = hashmap_get_from_hash(&submodule_ref_stores,
> +				      strhash(submodule), submodule);
> +	return entry ? entry->refs : NULL;
> +}
> +

I somehow thought that we had an early "reorder the code" step to
avoid hunks like these?  Am I missing some subtle changes made while
moving the function down?
