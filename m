Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04E0D1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbeGWTHY (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:07:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35993 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387995AbeGWTHX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:07:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so38634wmc.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lHxJVFE9rimtw+Ldm8Q5jEvbTz51eQudsi2EEb8qRJU=;
        b=GxZBH3SbmPG9KOoF1NLaeuTf+INXPPU2SGvF4eOveiLm9/dLS0t/VvXDrqPTSXcdmP
         MdfwOZvaie9Dgz/qz+c4hT+5QkKGqCPBgkgbY+Keol7h4Vnb24HpKiWMCoU/KTHJ5gSd
         tq7pRRv/w64Kza1njNgtXdqD5LU6Tu3EFyvNFEeRbwohbCnf4z5Vx00IslYdR7qaRhyG
         4fWVYa1L/z98GNPgH8Di/dtQFeDi5VN5QlFdY91d9mM+t1V566oqdsrtzbtYYX2r2/76
         2jzGTWqA6djA9QzvCfrOaG45E162qOjbDnWLafHV0/0pYJ3gOGi/2WjkXnp7HwAexw5X
         /gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lHxJVFE9rimtw+Ldm8Q5jEvbTz51eQudsi2EEb8qRJU=;
        b=aeT160euAUGhD5Wn98xCZVAnYWQupd+7jeESptYHHKC09yiV8q/Z06xZtMp2Ak6e3F
         d1wDnUMqbP0oY2NeWrZITEfaaBkdUcVHkPVn8GO0tn+DuFasitB0j/2+VmJyzlv7zZXB
         fqvPpC9IzNE76KvV6EAQLEEzQBTZUMRzxZVJLu2MF/XFziBg9AOOr+NKHsO4BtshlP5b
         FTPz1DAuHfber0QXd12hQZR3zDPBzT53Fc5kagtPmer9LOhLz5cU14+UmWBWyOCwRBY9
         CmEk+j8RRsyueU+WO/nCm/WfKcRC1hqNLxqZOqJIwbndzya/evfiU8MQlxuv88kkgtI6
         thbw==
X-Gm-Message-State: AOUpUlE/d6tAtlN2x8k+nAuz/HW4d0KF6wehCon3lFwvNOYH1Dfl9lfs
        RT3KjpjaeZPLxdrZ3QGyJYs=
X-Google-Smtp-Source: AAOMgpc6Su5dsUU2DW1aqdQGRlT22+5JmW4nrLECzulvctPjN0lJQBnWULz7XLvSlhi4KGIGO3XbCw==
X-Received: by 2002:a1c:93d2:: with SMTP id v201-v6mr20964wmd.77.1532369097893;
        Mon, 23 Jul 2018 11:04:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j131-v6sm10203178wmb.25.2018.07.23.11.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 11:04:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] pack-objects: fix performance issues on packing large deltas
References: <20180720153943.575-1-pclouds@gmail.com>
        <20180722080421.12887-1-pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 11:04:56 -0700
In-Reply-To: <20180722080421.12887-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 22 Jul 2018 10:04:21 +0200")
Message-ID: <xmqq8t617rqv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Access to e->delta_size_ (and by extension
> pack->delta_size[e - pack->objects]) is unprotected as before, the
> thread scheduler in pack-objects must make sure "e" is never updated
> by two different threads.

OK.  Do we need to worry about "e" (e.g. "e->delta_size_valid")
being accessed while/before it is set by another thread?

oe_delta_size() makes unprotected accesses to .delta_size_ and
pack->delta_size[e - pack->objects], so we apparently do not, and
oe_set_delta_size() only protects the allocation call and does not
prevent a reader in oe_delta_size() from first reading the _valid
field, noticing that it is 0 as initialized, and goes on to read the
pack->delta_size[] slot for the entry, while the writer is setting
the size to .delta_size_ field and flipping _valid bit, without ever
storing the size in the pack->delta_size[] array.

> @@ -130,6 +131,7 @@ struct packing_data {
>  	uint32_t index_size;
>  
>  	unsigned int *in_pack_pos;
> +	unsigned long *delta_size;
>  
>  	/*
>  	 * Only one of these can be non-NULL and they have different
> @@ -140,10 +142,29 @@ struct packing_data {
>  	struct packed_git **in_pack_by_idx;
>  	struct packed_git **in_pack;
>  
> +#ifndef NO_PTHREADS
> +	pthread_mutex_t lock;

I am wondering if we want the variable to say what data it is
protecting from simultaneous accesses, or leave it as generic so
that any new caller that wants to lock any (new) thing that is
associated with a packing_data structure can grab it for other
purposes.  The design of this patch clearly is the latter, which is
OK for now, I think.

> @@ -332,18 +353,34 @@ static inline unsigned long oe_delta_size(struct packing_data *pack,
>  {
>  	if (e->delta_size_valid)
>  		return e->delta_size_;
> -	return oe_size(pack, e);
> +
> +	/*
> +	 * pack->detla_size[] can't be NULL because oe_set_delta_size()
> +	 * must have been called when a new delta is saved with
> +	 * oe_set_delta().
> +	 * If oe_delta() returns NULL (i.e. default state, which means
> +	 * delta_size_valid is also false), then the caller must never
> +	 * call oe_delta_size().
> +	 */
> +	return pack->delta_size[e - pack->objects];
>  }
>  
>  static inline void oe_set_delta_size(struct packing_data *pack,
>  				     struct object_entry *e,
>  				     unsigned long size)
>  {
> -	e->delta_size_ = size;
> -	e->delta_size_valid = e->delta_size_ == size;
> -	if (!e->delta_size_valid && size != oe_size(pack, e))
> -		BUG("this can only happen in check_object() "
> -		    "where delta size is the same as entry size");
> +	if (size < pack->oe_delta_size_limit) {
> +		e->delta_size_ = size;
> +		e->delta_size_valid = 1;
> +	} else {
> +		packing_data_lock(pack);
> +		if (!pack->delta_size)
> +			ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
> +		packing_data_unlock(pack);
> +
> +		pack->delta_size[e - pack->objects] = size;
> +		e->delta_size_valid = 0;
> +	}
>  }
