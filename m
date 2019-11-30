Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE2EC432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 10:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9E720732
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 10:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlobO629"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfK3KsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 05:48:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35535 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfK3KsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 05:48:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so13987275plp.2
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 02:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HWImUPSeaOkDxbBGO1nVfd2LW8+Tj8v5eIx6N5HYCS0=;
        b=tlobO629EdHQvTbMZdmXDBT53kfUJaCTzjPhWuAWhigaXZ6jqz2toTGs3CguGtxt+M
         ldd2fU+VKKXhY8Pyku31Rna94NCEGPMhKWlWJ2QvXbSlIwmOy1xMuYkJI2aPgopMj3rp
         2Xtm80L56pon4AJslCMU8Kpd7gVtV2FHvo+hZy+vv3NMbPyuXtHOfUQg9mNGvJjQgMTL
         66cukFj8RQzX2/0mW1Nyvop0zFkWvUgDv1hIJ0D1oEREihCRAW6T99UJmGt7DqbUf8nP
         lNTBf4gZdc9PCF6NsJqMgyrvc2++BdIMgPqCqs3H/yPAKOqXc5yOpbRu9v57AqNbCXqc
         M7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HWImUPSeaOkDxbBGO1nVfd2LW8+Tj8v5eIx6N5HYCS0=;
        b=BNx+o9SOT3ZZXEmw0BhrJ29ooWRiSuuqXdvN6YagAYp2HRWxQi9W+yAVypSacTdRDN
         SHz74opGSzTAQWzgEbbHKTzPQXr0WbbLZABjiZDwPhJxXTo+4P2rfXen2VKGt8GkhB2g
         r3HBGMc48ABIhRQpZwJbi4VTQftwkhR7t8liuRDaj8hfUDRtjS4TeTrPzqgOHtcLxXTu
         OwSqW8uulpR/LaLkvK6XXuRSGvLVBZAZhS0Knvk4gEXc/6CqlaItqFsI28qX3pvpYxTe
         GyoAcS1yT+B21ghEFY4DFgIB6A3srkjUKb+0s9ov/684AYv4TbeK/D4mXbej3gSYkfSq
         qXvQ==
X-Gm-Message-State: APjAAAX8hQfKxx7uUlAB7u5f358+26OhFe1xPA3ewglQbikHNdfdUahb
        UuKCJPI/rLAcwOcsYoDvvdQ=
X-Google-Smtp-Source: APXvYqzrBq2Mee/rTkCe7IzShKPUdijqCeoX/h4Q5nz8+JrfpqiVWWcc8dOKQe9fMfI3uititPhB6A==
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr6408234pjs.26.1575110895767;
        Sat, 30 Nov 2019 02:48:15 -0800 (PST)
Received: from localhost ([27.68.90.110])
        by smtp.gmail.com with ESMTPSA id 203sm27765853pfy.185.2019.11.30.02.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 02:48:15 -0800 (PST)
Date:   Sat, 30 Nov 2019 17:48:12 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 26/26] t7700: stop losing return codes of git commands
Message-ID: <20191130104812.GA18401@danh.dev>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
 <1f6d9a80ad45fd9f51c8cffe9ce3721fce9b80c0.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f6d9a80ad45fd9f51c8cffe9ce3721fce9b80c0.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Denton,

On 2019-11-27 11:54:04-0800, Denton Liu <liu.denton@gmail.com> wrote:
> -	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
> -		grep "^$coid " | sort | uniq | wc -l) &&
> +	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
> +	! grep "^$coid " packlist &&

I think we want to use test_must_fail instead of !

>  	echo >.git/objects/info/alternates &&
>  	test_must_fail git show $coid
>  '
> @@ -151,8 +150,8 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
>  	    --unpack-unreachable </dev/null pack &&
>  	rm -f .git/objects/pack/* &&
>  	mv pack-* .git/objects/pack/ &&
> -	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
> -		grep "^$coid " | sort | uniq | wc -l) &&
> +	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
> +	! grep "^$coid " &&

ditto

-- 
Danh
