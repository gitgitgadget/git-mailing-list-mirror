Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4B1C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 14:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A55F20795
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 14:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOs15nGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKKOiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 09:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgKKOiG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 09:38:06 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89E8C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 06:38:05 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so1838775qke.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wCpicEzzbpLYcaXY4ehGR4O9O/IC8lBowwzg05OSd3o=;
        b=BOs15nGtEq+2H+9pfhAEvcc/Fd9WZ9SJjKSoWGRloF60lYggBbr63pIebf2l7row2V
         qqB2NnErH2Qdjwe8VeTkTzidXNltGh9T2Vk09dmevQUgwCgfNG/kUbd3+pmoHBFpJGPR
         7ZPkjXoLfx1q4lSbiI8/HCJEPT3Es4LOULOODbM3Hi+NBGX9obi8P7TeiXSDUUrYmdsf
         +aDQb/7Njad0aYmz+fAwXXbr+YsoRAlKRWj8JiOsoUlbeOuFKwlmKMaYDwYq/6tHKInS
         kY/3VX6dHuYmkF3fIgFvSh7HpHmLNdn8JKekJmEAeoiOOLv0hMw+zxHUyPtWGWHl5DTq
         ixYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wCpicEzzbpLYcaXY4ehGR4O9O/IC8lBowwzg05OSd3o=;
        b=IW0r7LL9E1KGcq6MYQBr1GaA3j8BU009WEl1eF7kV0xKziReTcJTcFTle6QIJoVRpk
         YPAMuIU8hrycEzszFu+CPWv50X9RWWYstpR/40e9UFqTw5bNW2GYae3sVopidA+tc/LA
         uHV8M+1CZ0pEOex8tBPyOuiFqHe/LgHb/gji/1sbsFbu7I/tkK74qGV5VUSm6NYy7wVG
         vih2ZMxti8ArAC+GiT+zIo77oE9Gfni7zFCSilF0R+8Kaqb+aishoqi3EBqKEmCLvn65
         8ob4Bb3nDdA2aMPRfycOhCgGxh7CLBuFCh8odZcXYqnuq2UTKpPsM9T83Z+t2gstpWRu
         QkKg==
X-Gm-Message-State: AOAM532R00eU4l+d0HK3/O9EvqWOnZQjZB0I53jSxaRgHOlYbdpjf03s
        /rOo++GwSnfz8xEJvit9/nkqq9PR+Nfccw==
X-Google-Smtp-Source: ABdhPJwSmcoeZ2xWAA3cKwF6oPreCoQIYKJ5nN8smCPy24wn6pKgsvaD+jMqAG2Sp3FKae7Fpqrubw==
X-Received: by 2002:a37:991:: with SMTP id 139mr5308494qkj.185.1605105484381;
        Wed, 11 Nov 2020 06:38:04 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id o21sm2288402qko.9.2020.11.11.06.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 06:38:03 -0800 (PST)
Subject: Re: [PATCH v2 06/20] merge-ort: implement a very basic
 collect_merge_info()
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-7-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <42037753-c8c1-629c-3d99-d54842686b2e@gmail.com>
Date:   Wed, 11 Nov 2020 09:38:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201102204344.342633-7-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 3:43 PM, Elijah Newren wrote:
> +	/* +1 in both of the following lines to include the NUL byte */
> +	fullpath = xmalloc(len+1);
> +	make_traverse_path(fullpath, len+1, info, p->path, p->pathlen);

nit: s/len+1/len + 1/g

> +		void *buf[3] = {NULL,};

This "{NULL,}" seems odd to me. I suppose there is a reason why it
isn't "{ NULL, NULL, NULL }"?

> +		const char *original_dir_name;
> +		int i, ret;
> +
> +		ci->match_mask &= filemask;
> +		newinfo = *info;
> +		newinfo.prev = info;
> +		newinfo.name = p->path;
> +		newinfo.namelen = p->pathlen;
> +		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
> +
> +		for (i = 0; i < 3; i++, dirmask >>= 1) {

This multi-action iterator borders on "too clever". It seems like
placing "dirmask >>= 1;" or "dirmask = dirmask >> 1;" at the end
of the block would be equivalent and less jarring to a reader.

I was thinking it doesn't really matter, except that dirmask is not
in the initializer or sentinel of the for(), so having it here does
not immediately make sense.

(This has been too much writing for such an inconsequential line
of code. Sorry.)

> +			const struct object_id *oid = NULL;
> +			if (dirmask & 1)
> +				oid = &names[i].oid;
> +			buf[i] = fill_tree_descriptor(opt->repo, t + i, oid);
> +		}


>  static int collect_merge_info(struct merge_options *opt,
>  			      struct tree *merge_base,
>  			      struct tree *side1,
>  			      struct tree *side2)
>  {
> -	/* TODO: Implement this using traverse_trees() */
> -	die("Not yet implemented.");
> +	int ret;
> +	struct tree_desc t[3];
> +	struct traverse_info info;
> +	char *toplevel_dir_placeholder = "";

It seems like this should be "const char *"

> +	init_tree_desc(t+0, merge_base->buffer, merge_base->size);
> +	init_tree_desc(t+1, side1->buffer, side1->size);
> +	init_tree_desc(t+2, side2->buffer, side2->size);

More space issues: s/t+/t + /g

I'm only really able to engage in this at a surface level, it
seems, but maybe I'll have more to say as the implementation
grows.

Thanks,
-Stolee
