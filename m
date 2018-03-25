Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAD11F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeCYQTH (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:19:07 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33294 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753435AbeCYQTG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:19:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id z73so16544391wrb.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Cis0bDrPVN7yXTcxGu4syK3kzW346ze9rLrOF50R284=;
        b=XqgGQGy85oH1G768xcG+/xMVm/x/RxCxoN65s3EiwXZqLC9lG1TtXm8YWZN/WYM2sL
         AZhRXS+JL/QpnZ/sCjAx86xW/92iBUJcLSQN6/DqYuaWmPI8r6BUAVpn6k5uHLuC8VKi
         bljI2bAfgp04IEK1i8rZt1RHdkEV1CiTmQ04qlSm8W76/K1T01IZ0JxGDnzvwcaUnk5x
         8Mfb+l57c22B7FI03M1wqEZzzpNOCaEqamry2MDBk0yMDr/NgsJYeCy+7tksD5MhRfaA
         zeYUKWtlF07HE9RjCcpwWRi7thyqSX4S/PcbOa0xmVM+vcyD6eNlUY6uFpuBPKR54xwY
         yxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Cis0bDrPVN7yXTcxGu4syK3kzW346ze9rLrOF50R284=;
        b=cHU657RV3snHs1aohvmGxqyJkD1bl49rg7O1aYfp+wl9Bd7E8yHhwURA5QTqN1zex0
         BVXGIPDiT472JJ0vqJuZEBsksovs4N1zBcgIfdwFAcMmH4ngmldTweM/oxzuYVAKxwjr
         E9q/dusg5lnxBT+/y6SHg13EJ3NpcRKwh7xBOnHcHMa/5uLKY/FSlzInh3ZguEdhRagd
         DuOnNLxhOGKqO7ZLGsIz+qgF0ypdB7XwWqbiMNQzrc/u8JrolgdzzEHpX1k1K4Z4f9pP
         3mANlQcDnOOYF+XG4tDrEVqfB0itk/LHowhJIjgaj7+hxdTYOnwCb9hIM2jfQXmMaZAK
         Eafw==
X-Gm-Message-State: AElRT7EON2m64ugke+ECPW2FNKrgeK46wnS3gFEP9TecvtVm+m1Aw3Lh
        4mnWAsnYLxWru3WG+MimTHI=
X-Google-Smtp-Source: AG47ELtOlSouUD6ux2hrdusM0mGMPNj4k5hkCz/M8saJrs67tYWI6zcZOaTd3L5lG1LIUaSR1w76sQ==
X-Received: by 10.223.188.1 with SMTP id s1mr30189783wrg.243.1521994744915;
        Sun, 25 Mar 2018 09:19:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n62sm12414222wmf.13.2018.03.25.09.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 09:19:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        stolee@gmail.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 4/3] sha1_name: use bsearch_pack() in unique_in_pack()
References: <20180321224226.GA74743@genre.crustytoothpaste.net>
        <20180322174010.120117-1-dstolee@microsoft.com>
        <71b5cef0-abad-001f-6a23-3f2d874b9709@web.de>
Date:   Sun, 25 Mar 2018 09:19:02 -0700
In-Reply-To: <71b5cef0-abad-001f-6a23-3f2d874b9709@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 24 Mar 2018 17:41:08 +0100")
Message-ID: <xmqqvadkf7rd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Replace the custom binary search in unique_in_pack() with a call to
> bsearch_pack().  This reduces code duplication and makes use of the
> fan-out table of packs.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> This is basically the same replacement as done by patch 3.  Speed is
> less of a concern here -- at least I don't know a commonly used
> command that needs to resolve lots of short hashes.

Looks correct.  Did you find this by eyeballing, or do you have some
interesting tool you use?

>
>  sha1_name.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 24894b3dbe..0185c6081a 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -150,31 +150,14 @@ static int match_sha(unsigned len, const unsigned char *a, const unsigned char *
>  static void unique_in_pack(struct packed_git *p,
>  			   struct disambiguate_state *ds)
>  {
> -	uint32_t num, last, i, first = 0;
> +	uint32_t num, i, first = 0;
>  	const struct object_id *current = NULL;
>  
>  	if (open_pack_index(p) || !p->num_objects)
>  		return;
>  
>  	num = p->num_objects;
> -	last = num;
> -	while (first < last) {
> -		uint32_t mid = first + (last - first) / 2;
> -		const unsigned char *current;
> -		int cmp;
> -
> -		current = nth_packed_object_sha1(p, mid);
> -		cmp = hashcmp(ds->bin_pfx.hash, current);
> -		if (!cmp) {
> -			first = mid;
> -			break;
> -		}
> -		if (cmp > 0) {
> -			first = mid+1;
> -			continue;
> -		}
> -		last = mid;
> -	}
> +	bsearch_pack(&ds->bin_pfx, p, &first);
>  
>  	/*
>  	 * At this point, "first" is the location of the lowest object
