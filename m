Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFFD207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 22:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbdFWWCx (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 18:02:53 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33910 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbdFWWCw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 18:02:52 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so7620136pge.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 15:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EZFA5e/GelNJp58dZo4FcWGsbhNOkEGB4YM+dTKfEq8=;
        b=uYq22W+g0etY/YLdU7uGJIWeCoFmUc7jLZkqBlhr4VNVHqHYUrHT6LTDBXE8KXcNiU
         mpTZzDGMPqAe1mRvcgMBQvFM+RE/F0diZjql92E8H+OCUK4inC4VqWrhPPF3HUMBsny5
         UqjIS3o9FXT4IhvDRW6aQ5y3MA6+ZGMV/QdYzTAzfyaEEkYP9Exfd5LtTG/9IJpMB3b+
         uF1T6kcCQakOmOeWx6QoNhffXSMogmdS31dG1LfTe9143dLGkUUXvHXC9I9r95fZhilG
         +R39xWk0FcE3W2nFWUF9hGp7Dri2DhzKwW/dRkRCw+AhwJClaY54ML3Zi3TnW/MpWger
         22ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EZFA5e/GelNJp58dZo4FcWGsbhNOkEGB4YM+dTKfEq8=;
        b=WE+K/gVP3x9mhfOFZhL/j07pLyplEH3F92YLf6OPnVge1PFvgd5WnMvpMuRjpbXTg2
         BGp7E+3/ypFi2twNi1P71HRShhymgEksmbJRl2k5so71BL71b7e9xvMKpPxBKHkNlmol
         hS/8Z6r3D4J8pXfsVFGal+u8e+JiGKxb6AUQqApcUwle8PmMfr5qy/2nXI6HRoQ1QrE2
         S5Pg2JlD3k+VVFcL03qP3kYaT0AN9uqoukbnYmGWMStheTCBGdgXseE1FIxjJd5iaN7b
         pqmVYsuyMCEJbf4gJfsctTOTQ2LPnJrgWsgRw6vk7L1ARazXEyaFPMNU3o+fV6GRWGnV
         hKnQ==
X-Gm-Message-State: AKS2vOxiFOka3f7Yrg4pMy9V3grEa+U4mFUHjvGL7RX+Kp9kVRYC4ZMA
        7e8rPz6GPw2AVw==
X-Received: by 10.84.233.204 with SMTP id m12mr11254882pln.292.1498255371356;
        Fri, 23 Jun 2017 15:02:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id v62sm10487453pfb.124.2017.06.23.15.02.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 15:02:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/3] read-cache: use shared perms when writing shared index
References: <20170623151640.24082-1-chriscool@tuxfamily.org>
Date:   Fri, 23 Jun 2017 15:02:49 -0700
In-Reply-To: <20170623151640.24082-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 23 Jun 2017 17:16:38 +0200")
Message-ID: <xmqq60fmcqgm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Since f6ecc62dbf (write_shared_index(): use tempfile module, 2015-08-10)
> write_shared_index() has been using mks_tempfile() to create the
> temporary file that will become the shared index.
>
> But even before that, it looks like the functions used to create this
> file didn't call adjust_shared_perm(), which means that the shared
> index file has always been created with 600 permissions regardless
> of the shared permission settings.
>
> Because of that, on repositories created with `git init --shared=all`
> and using the split index feature, one gets an error like:
>
> fatal: .git/sharedindex.a52f910b489bc462f187ab572ba0086f7b5157de: index file open failed: Permission denied
>
> when another user performs any operation that reads the shared index.
>
> We could use create_tempfile() that calls adjust_shared_perm(), but
> unfortunately create_tempfile() doesn't replace the XXXXXX at the end
> of the path it is passed. So let's just call adjust_shared_perm() by
> ourselves.

Because create_tempfile() is not even a viable alternative, the
above sounds just as silly as saying "We could use X, but
unfortunately that X doesn't create a temporary file and return its
file descriptor" with X replaced with any one of about a dozen
functions that happen to call adjust_shared_perm().

	Call adjust_shared_perm() on the temporary file created by
	mks_tempfile() ourselves to adjust the permission bits.

should be sufficient.

Thanks.

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  read-cache.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index bc156a133e..66f85f8d58 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2425,6 +2425,14 @@ static int write_shared_index(struct index_state *istate,
>  		delete_tempfile(&temporary_sharedindex);
>  		return ret;
>  	}
> +	ret = adjust_shared_perm(temporary_sharedindex.filename.buf);
> +	if (ret) {
> +		int save_errno = errno;
> +		error("cannot fix permission bits on %s", temporary_sharedindex.filename.buf);
> +		delete_tempfile(&temporary_sharedindex);
> +		errno = save_errno;
> +		return ret;
> +	}
>  	ret = rename_tempfile(&temporary_sharedindex,
>  			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
>  	if (!ret) {
