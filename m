Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B24C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 10:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiAXKAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 05:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbiAXKAH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 05:00:07 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6C3C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 02:00:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id p15so19812348ejc.7
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 02:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KNUtgt3rhouKVIdn8/g+Ifi4P2C9Tg8SmOUv9dIGOSY=;
        b=TNBSy9+v3Hk/GBv1Ok8h5sGU+u/W6UWZy077/GYxBTabQFH29lB7H//tRfcJ8LVUYc
         VKLxL5g3RyoVShbvl6ywX5NJ+vO5Sv8XMDDZKphkSw+tDuxOfcM0lFdZA+AXZtjhSpCE
         pOojOfy/qfoCWXebnRhkoKtt285WGtjwy2Zz7QzT/usqY6kPZJkc7KMpAGVUqpMEkXWG
         ky+qepYHH46A6AUjip9lmBwx8FKfaFX07XtZRHQW2QKHGuZPYv5ONsTplr33qv3TepSR
         N8L44DGM4+bri2NCTQ+1Q4HXrPcXolgLARzcTZmQ5ZGDAW/hkhRAMjVYvIzsJiRdcItV
         +txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KNUtgt3rhouKVIdn8/g+Ifi4P2C9Tg8SmOUv9dIGOSY=;
        b=dhuYXqfsuRxuxt3tY114se5YY/WAFWETsWwza8T4UlMh9TLBIKVxxhFrD6feTaKIPz
         MfRfYkdQY5rVeQhrYpkofjzZ6kGlmMtFnEcXZgur6JUnKtdWseIkyU5V1ER5dBsd0QpA
         dmo/HfdB5EG8V+bS511XAZd7ZV3WZ44yoCIuOfT9d2a0Eq27oz0qAezV4h8XApWg4lCT
         lios4k9NAFPX0vOSwZwwLzgOUvtbUTlsYNu4Nhx2pZuR/IjRVlvuwVfTmSGWI/PUmlhR
         eXq723izkr4fQngAEwQVNYgoc6dfRRpgqAJ+xtlP6jxCL9p2+w449fsDYNozggz3/bcq
         85Ng==
X-Gm-Message-State: AOAM5318vR4XIvnYcoJA02CJySbJnNc1I44i84bRyNwrxKRbwM+PX6Ti
        pM4n9QIQyd59tt+58+frQcCPdfML86Q=
X-Google-Smtp-Source: ABdhPJwHv5phdYj7eYQbQb5wYXt8r18L2/JZX/7IOlOPBycLOgiKQciv5WphSk5i6V8PKS+ePkuC4Q==
X-Received: by 2002:a17:907:7286:: with SMTP id dt6mr11945689ejc.562.1643018404216;
        Mon, 24 Jan 2022 02:00:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u19sm4745316ejy.171.2022.01.24.02.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 02:00:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nBw8n-002QL9-Bt;
        Mon, 24 Jan 2022 11:00:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/12] merge-ort: split out a separate
 display_update_messages() function
Date:   Mon, 24 Jan 2022 10:56:39 +0100
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <095aa266c2bfdda47ed722fbc5a0d9c94132fbf1.1642888562.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <095aa266c2bfdda47ed722fbc5a0d9c94132fbf1.1642888562.git.gitgitgadget@gmail.com>
Message-ID: <220124.86czkhihcu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 22 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> [...]
> +	/* Hack to pre-allocate olist to the desired size */
> +	ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
> +		   olist.alloc);

Perhaps just add a string_list_grow()? But I wonder if this is really
needed v.s. just using the default growing pattern here.

> +
> +	/* Put every entry from output into olist, then sort */
> +	strmap_for_each_entry(&opti->output, &iter, e) {
> +		string_list_append(&olist, e->key)->util = e->value;
> +	}
> +	string_list_sort(&olist);
> +
> +	/* Iterate over the items, printing them */
> +	for (i = 0; i < olist.nr; ++i) {
> +		struct strbuf *sb = olist.items[i].util;
> +
> +		printf("%s", sb->buf);
> +	}

Shorter/nicer:
	
	for_each_string_list_item(item, &olist) {
		struct strbuf *sb = item->util;
	        puts(sb->buf);
	}
	
> -	if (display_update_msgs) {
> -		struct merge_options_internal *opti = result->priv;
> -		struct hashmap_iter iter;
> -		struct strmap_entry *e;
> -		struct string_list olist = STRING_LIST_INIT_NODUP;
> -		int i;
> -
> -		if (opt->record_conflict_msgs_as_headers)
> -			BUG("Either display conflict messages or record them as headers, not both");
> -
> -		trace2_region_enter("merge", "display messages", opt->repo);
> -
> -		/* Hack to pre-allocate olist to the desired size */
> -		ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
> -			   olist.alloc);
> -
> -		/* Put every entry from output into olist, then sort */
> -		strmap_for_each_entry(&opti->output, &iter, e) {
> -			string_list_append(&olist, e->key)->util = e->value;
> -		}
> -		string_list_sort(&olist);
> -
> -		/* Iterate over the items, printing them */
> -		for (i = 0; i < olist.nr; ++i) {
> -			struct strbuf *sb = olist.items[i].util;
> -
> -			printf("%s", sb->buf);
> -		}
> -		string_list_clear(&olist, 0);

Ah, at this point I see you're just moving code around :) Sending this
anyway in case it's useful :)
