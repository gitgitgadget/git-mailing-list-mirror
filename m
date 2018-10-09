Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4181F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 09:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJIQ0w (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 12:26:52 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36247 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeJIQ0w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 12:26:52 -0400
Received: by mail-wm1-f52.google.com with SMTP id a8-v6so1096898wmf.1
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iffYRPqbMLjKP4z1g5Tvwk31Zjk55DDRJybRpP9HEnc=;
        b=cFSHNcWJ4TPVu5bRJb7NTxJKYChAhybulzKLcIn+Te+2TjUgS/9JZE2Ye7MO9GvEkK
         4khc/qOxKcZfxAOwMEaejLIyzP1+93pfM6TuSk+21HLvSyvEXRJw3Qg1SCau0tuQsc3+
         ua/zVnPxRMByVwDWczqKu95oNj8d22q/Sc4HVLmOt1bNPEJVwbbAjnaPWbJynZ6PeSA6
         JOOuLoR7InH4WJCs1+jkZ/sd6KDp3wWgi75ku50BsX5LMmhmP0p6OgVTr1NfFi9F65Hj
         NJk8hwnFPpY5jsH9g4oSzYzXzlClUjypGZlBxkfTiz6h/vTLzHbzetZWba0pReuoQTB4
         NFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iffYRPqbMLjKP4z1g5Tvwk31Zjk55DDRJybRpP9HEnc=;
        b=Y2QdErBGqr7XJ68yDRTNDzNgBgzRyO0uPFJugXv4tRv1qJbDyy570YRmZhPW8t2ea7
         MbNgpOh07ZWcTks7PPi1f3/xSt1W1ZWFO57ubb7Xx2Ur4LfBcrn95W5sJpFUjrJQ5U+E
         4BvT8oUj9zdU0fzu/5FC+rR3xsNLLIG7uS0SLJfZCuRDsFF0+wkFhwiNlG6nHdUDY2xM
         1pMHTbrm5JEX7WNDVUk9sa6oUhaN5KMCs7yFjAXkzlwp/ZyT85IavBG9gJITf5vgY328
         UetfKx6Rr5a+rRsYC6xeSb+2z5ixkcSAJazKBzUHY/pD+XPUoBx+QJ/rsAf/wMoE74Zb
         lu/Q==
X-Gm-Message-State: ABuFfohXkojNvhOiDpgVtMX2sMxojnJx2su3plUZEFWMQ7/0LZ8+fEKu
        LjSvvowJzC1Mnq7CzWj9c94=
X-Google-Smtp-Source: ACcGV62CEhcLz6ngAYOe0o95x6pf62tuq6khKhnmw3PapLEiCOuqQR4DZReIqBNm47NQZHUbDfsAtw==
X-Received: by 2002:a1c:1dcc:: with SMTP id d195-v6mr1220641wmd.119.1539076255805;
        Tue, 09 Oct 2018 02:10:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r131-v6sm9896406wmb.32.2018.10.09.02.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:10:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] midx: close multi-pack-index on repack
References: <pull.27.git.gitgitgadget@gmail.com>
        <725ebadc92a91469eed089eb501b705c2dd2c627.1539011820.git.gitgitgadget@gmail.com>
Date:   Tue, 09 Oct 2018 18:10:53 +0900
In-Reply-To: <725ebadc92a91469eed089eb501b705c2dd2c627.1539011820.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 08 Oct 2018
        08:17:05 -0700 (PDT)")
Message-ID: <xmqq4ldvqyci.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/repack.c b/builtin/repack.c
> index c6a7943d5c..7925bb976e 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -432,6 +432,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  
>  			if (!midx_cleared) {
>  				/* if we move a packfile, it will invalidated the midx */
> +				if (the_repository->objects) {
> +					close_midx(the_repository->objects->multi_pack_index);
> +					the_repository->objects->multi_pack_index = NULL;
> +				}
>  				clear_midx_file(get_object_directory());
>  				midx_cleared = 1;

It somehow looks like a bit of layering violation, doesn't it?  When
we are clearing a midx file, don't we always want to do this as well?
