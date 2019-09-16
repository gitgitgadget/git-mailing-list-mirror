Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1FF81F463
	for <e@80x24.org>; Mon, 16 Sep 2019 02:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfIPCfp (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 22:35:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41743 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfIPCfo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 22:35:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id x4so9745251qtq.8
        for <git@vger.kernel.org>; Sun, 15 Sep 2019 19:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JI3xT7q9vhBVaxi7khnQjL1trABcjmnUD6Ukmri+W4I=;
        b=MIiAHdXlCHONQ8mDTf3G0NJXaWa0qGIr2rPwe2LYOoF76ogQEyxoRJYK8PFaZXyNRs
         a/iW+z0AIqs6/qVrBwIxvcYyE6Tp5gyTfB3GBDCcsqAuMAXa3hO+Zm7x7jOsAvQN8pvl
         L5Nnvemr8CNIYG3Jc0i/O6b9ZaZTAUxP03NxyxDaRt8+En/PBGyMGKLvoPg9gx5ikpxL
         TUxmd1mU+yh2f+E/gEybLo08YJgH5GjAxkSExA0W7m2ivOcRs3r27fGYOKP8qOUFhPOy
         Yv3RsYxW6xL86jVEIncSw3dl3sLS7zsMaYyCKk6rO+YXHJkUcAea7XFEHlPEiY1newN4
         VROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JI3xT7q9vhBVaxi7khnQjL1trABcjmnUD6Ukmri+W4I=;
        b=kWDkHoh9hz7bthimEVnI3yUGRoJ8Wqh168rQR1VPaBu1f1L3p9Y710F7GmueFqcCj2
         ntdbVZgBe5k25bd7CjtMt4HgbGcggphtwa6OIth7KYCWLF8etuu/3hnsNQzBMFRvOheX
         YkrCKtD6yrMeLy6WBIj2AZIpXDPDdBQxfi9TYDCxH/VSvcxt9FrZfaWeA8WPkN6heSTp
         qzhJFoHVmcQl0SQrQjOPDCbZlNzJuFWeoe8wboqWWHd86jww3HgYDJ+bZIUCH2NiU8kI
         aSu9k3A8Xcs8r2Amm9G0itpzeRnbZGH3B62d2qn1flGfO5bn1WxjWzCWiMuoMywp31hE
         iFdg==
X-Gm-Message-State: APjAAAVLHGzlfiRL7DqK4P4lVbEoPRH0e0HBqZCEn1zYSVLh6BH8KtwM
        kVt6XlW0VgBqUtOHMAiPfMo3xp0abo4=
X-Google-Smtp-Source: APXvYqx5QFnWLO1rVrR0GLh+XWa6OEnWDBRLv1p99n4wWGtjRdL+I4QITjQBvNFROQnsfHCTtaB7TA==
X-Received: by 2002:aed:216a:: with SMTP id 97mr15346503qtc.114.1568601343309;
        Sun, 15 Sep 2019 19:35:43 -0700 (PDT)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id b16sm22153850qtk.65.2019.09.15.19.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 19:35:42 -0700 (PDT)
Subject: Re: [PATCH 1/1] fetch: Cache the want OIDs for faster lookup
To:     Masaya Suzuki <masayasuzuki@google.com>, git@vger.kernel.org
References: <20190915211802.207715-1-masayasuzuki@google.com>
 <20190915211802.207715-2-masayasuzuki@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bbc3ef83-7ff9-deeb-2b7d-734112fc2418@gmail.com>
Date:   Sun, 15 Sep 2019 22:35:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190915211802.207715-2-masayasuzuki@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/15/2019 5:18 PM, Masaya Suzuki wrote:
> During git-fetch, the client checks if the advertised tags' OIDs are
> already in the fetch request's want OID set. This check is done in a
> linear scan. For a repository that has a lot of refs, repeating this
> scan takes 15+ minutes. In order to speed this up, create a oid_set for
> other refs' OIDs.

Good catch! Quadratic performance is never good.

The patch below looks like it works, but could you also share your
performance timings for the 15+ minute case after your patch is
applied?

Thanks,
-Stolee

> 
> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> ---
>  builtin/fetch.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 54d6b01892..51a276dfaa 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -7,6 +7,7 @@
>  #include "refs.h"
>  #include "refspec.h"
>  #include "object-store.h"
> +#include "oidset.h"
>  #include "commit.h"
>  #include "builtin.h"
>  #include "string-list.h"
> @@ -243,15 +244,13 @@ static void add_merge_config(struct ref **head,
>  	}
>  }
>  
> -static int will_fetch(struct ref **head, const unsigned char *sha1)
> +static void create_fetch_oidset(struct ref **head, struct oidset *out)
>  {
>  	struct ref *rm = *head;
>  	while (rm) {
> -		if (hasheq(rm->old_oid.hash, sha1))
> -			return 1;
> +		oidset_insert(out, &rm->old_oid);
>  		rm = rm->next;
>  	}
> -	return 0;
>  }
>  
>  struct refname_hash_entry {
> @@ -317,6 +316,7 @@ static void find_non_local_tags(const struct ref *refs,
>  {
>  	struct hashmap existing_refs;
>  	struct hashmap remote_refs;
> +	struct oidset fetch_oids = OIDSET_INIT;
>  	struct string_list remote_refs_list = STRING_LIST_INIT_NODUP;
>  	struct string_list_item *remote_ref_item;
>  	const struct ref *ref;
> @@ -324,6 +324,7 @@ static void find_non_local_tags(const struct ref *refs,
>  
>  	refname_hash_init(&existing_refs);
>  	refname_hash_init(&remote_refs);
> +	create_fetch_oidset(head, &fetch_oids);
>  
>  	for_each_ref(add_one_refname, &existing_refs);
>  	for (ref = refs; ref; ref = ref->next) {
> @@ -340,9 +341,9 @@ static void find_non_local_tags(const struct ref *refs,
>  			if (item &&
>  			    !has_object_file_with_flags(&ref->old_oid,
>  							OBJECT_INFO_QUICK) &&
> -			    !will_fetch(head, ref->old_oid.hash) &&
> +			    !oidset_contains(&fetch_oids, &ref->old_oid) &&
>  			    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
> -			    !will_fetch(head, item->oid.hash))
> +			    !oidset_contains(&fetch_oids, &item->oid))
>  				clear_item(item);
>  			item = NULL;
>  			continue;
> @@ -356,7 +357,7 @@ static void find_non_local_tags(const struct ref *refs,
>  		 */
>  		if (item &&
>  		    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
> -		    !will_fetch(head, item->oid.hash))
> +		    !oidset_contains(&fetch_oids, &item->oid))
>  			clear_item(item);
>  
>  		item = NULL;
> @@ -377,7 +378,7 @@ static void find_non_local_tags(const struct ref *refs,
>  	 */
>  	if (item &&
>  	    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
> -	    !will_fetch(head, item->oid.hash))
> +	    !oidset_contains(&fetch_oids, &item->oid))
>  		clear_item(item);
>  
>  	/*
> @@ -404,6 +405,7 @@ static void find_non_local_tags(const struct ref *refs,
>  	}
>  	hashmap_free(&remote_refs, 1);
>  	string_list_clear(&remote_refs_list, 0);
> +	oidset_clear(&fetch_oids);
>  }
>  
>  static struct ref *get_ref_map(struct remote *remote,
> 

