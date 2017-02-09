Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57EFD1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbdBIWY1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:24:27 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36383 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753875AbdBIWYX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:24:23 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so1351264pgf.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 14:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3DB3zHaEoyhRh65Wg0dzNICsLqOtTHB6lHJuAdkumc8=;
        b=BvrQSK2Be3d7BTA23j02peYdCwqCc8Q98idog69+rGnqAwMbPwvKiODf231YZwqnAX
         kfLvyMGGpLKjWdVDhoG6Ky5gKuR6I6wsnj6q1zrGotlQQe+S0KsisKpB2BPUUz0pKG7c
         nQoTobwmdMR7NGSWnaezE+TSG6w+ke8D4j60QDbTjBaRKZkjaYLvoHz1PEp3u9OR/zAY
         HB8LLdMjqS3eZUAe/+p8nGFw7rwwJu8DTBxSwwQC7NWeG5d+R7IEKgnsnM5YxTfOqkDV
         AZlc3PcHB2k914tShk2XJB8jU6Rs0sdoTa7XeIX33GU3f1S78YVZ/ropaNbtSw0H1J40
         U8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3DB3zHaEoyhRh65Wg0dzNICsLqOtTHB6lHJuAdkumc8=;
        b=Upc+AaVQdqZeZ3gSQxFW/JBHMrdbGdmlmatop0sD8HKZjUqeCRzn+JzYHEy2+1pdIj
         vNBeREE5MHLQhuTa+Mk5QNFBB2JXzPzvoXayGM3a3FLtrZQpkm6WtLniHvxUa7BYcUpf
         DC/g95pSffc1LuAgclwTjSHV77N34aQJbziu2EXbPX0wBKTsJz94P0IrZ3tYq9bJBNDz
         35ZEkSIep7zooTizLUQAmqdPscSJgjqtHj7OCVriU190+NXbhlzjlvygKae79zaCi91N
         8rfNEbvDlTDyvid8mNT2rG3nNuYTk+KRtvPpS6fozr4qZ22JCDiD1RzWbPQLAMSthJ6d
         yOsg==
X-Gm-Message-State: AMke39mNdaiNumtNvqjfTy6E5f5tQBghalyuINREjKAgolB+O5+7paBZjTAWUOuzKWvdIw==
X-Received: by 10.99.132.200 with SMTP id k191mr6071091pgd.10.1486672446452;
        Thu, 09 Feb 2017 12:34:06 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id l188sm31115844pfl.28.2017.02.09.12.34.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 12:34:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] refs: store submodule ref stores in a hashmap
References: <cover.1486629195.git.mhagger@alum.mit.edu>
        <a944446c4c374125082f5ad8b79e731704b66196.1486629195.git.mhagger@alum.mit.edu>
Date:   Thu, 09 Feb 2017 12:34:04 -0800
In-Reply-To: <a944446c4c374125082f5ad8b79e731704b66196.1486629195.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Thu, 9 Feb 2017 14:26:58 +0100")
Message-ID: <xmqqh943p0hv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Aside from scaling better, this means that the submodule name needn't be
> stored in the ref_store instance anymore (which will be changed in a
> moment).

Nice.  I like the latter reason very much (this is not a suggestion
to change the description).

> +struct submodule_hash_entry
> +{
> +	struct hashmap_entry ent; /* must be the first member! */
> +
> +	struct ref_store *refs;
> +
> +	/* NUL-terminated name of submodule: */
> +	char submodule[FLEX_ARRAY];
> +};
> +
> +static int submodule_hash_cmp(const void *entry, const void *entry_or_key,
> +			      const void *keydata)
> +{
> +	const struct submodule_hash_entry *e1 = entry, *e2 = entry_or_key;
> +	const char *submodule = keydata;
> +
> +	return strcmp(e1->submodule, submodule ? submodule : e2->submodule);

I would have found it more readable if it were like so:

	const char *submodule = keydata ? keydata : e2->submodule;

	return strcmp(e1->submodule, submodule);

but I suspect the difference is not that huge.

> +}
> +
> +static struct submodule_hash_entry *alloc_submodule_hash_entry(
> +		const char *submodule, struct ref_store *refs)
> +{
> +	size_t len = strlen(submodule);
> +	struct submodule_hash_entry *entry = malloc(sizeof(*entry) + len + 1);

I think this (and the later memcpy) is what FLEX_ALLOC_MEM() was
invented for.

> +	hashmap_entry_init(entry, strhash(submodule));
> +	entry->refs = refs;
> +	memcpy(entry->submodule, submodule, len + 1);
> +	return entry;
> +}
> ...
> @@ -1373,16 +1405,17 @@ void base_ref_store_init(struct ref_store *refs,
>  			die("BUG: main_ref_store initialized twice");
>  
>  		refs->submodule = "";
> -		refs->next = NULL;
>  		main_ref_store = refs;
>  	} else {
> -		if (lookup_ref_store(submodule))
> +		refs->submodule = xstrdup(submodule);
> +
> +		if (!submodule_ref_stores.tablesize)
> +			hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 20);

Makes me wonder what "20" stands for.  Perhaps the caller should be
allowed to say "I do not quite care what initial size is" by passing
0 or some equally but more clealy meaningless value (which of course
would be outside the scope of this series).
