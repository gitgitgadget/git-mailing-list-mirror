Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F9F207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 21:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbdFWVzM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 17:55:12 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36173 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbdFWVzL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 17:55:11 -0400
Received: by mail-pf0-f195.google.com with SMTP id z6so385420pfk.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=riKSvGWsYLymU48/8wdhFao1aEf1L7Ox7jdTaQmq1Nw=;
        b=jB//hQaoQv/xgS2M7XxjcCP1IsCZEZS3FlyBzk6AnICIbEPVXMkeHpdRGR+rj6S85i
         ueWfqM8l0SbG0R2iM+9wvVcz61QmljeeVt0z136nvkA1PQcbumii0CtKBXIBlRelWSLa
         PbDAh/zWP37rwM2rpgbTNj/2rd3hbUJ4SrJeBV5g98AxN/BX9/3We9lF3IADeHh9JjAL
         Makw8B+mZQOZJQ/d583QJ+LotC1go4DNye3cZepQLs1BeMVjW53BLemILDsF/ZvbV9gQ
         eZ09RPQC9Fm/iqfOsVMd2BhlUARhr1upfHLrsjz62LTHk8lR3OyS+uDNfgoZuNP5PDTp
         NZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=riKSvGWsYLymU48/8wdhFao1aEf1L7Ox7jdTaQmq1Nw=;
        b=Qpuxhwg4A2LEtQf1fV9ibNTuvHcTnqp28YH7ShyB+oj9MUPe+VjGPs8qoZ6DsEbsww
         NIJUhYJZaI2CH3EVE22tdwseRHVrSoQd7zntXjTSIyp9IRXYDDYQ4U2LrVv33akPjkxk
         dGUkiTdJOFrnDV6kigA+oJ+5aHRlgibZ+dpCfZTWE8Mn26E5KsUu91qnqFQv5lXvam9V
         CNykkpcfFsYoKjWqq0kRb5+ITas4MwnLQNf/zgx9JQzZshNquCyFPMPE2SK9fEnKC9k2
         wgzy4xxPlIZNOUgWaxuAtIVMR9AlawUBgzUqNHZ+QJXhzEELgIl1nFe5x6HnMp/7a9zb
         0TTw==
X-Gm-Message-State: AKS2vOzfYgmz9TL78LbPQqCsByPQBtCLnc9+TxGdNFTet/i6XHW0Y9EB
        1m1UBoOGBmZLO7ov1J/4fg==
X-Received: by 10.98.8.81 with SMTP id c78mr10176910pfd.213.1498254910523;
        Fri, 23 Jun 2017 14:55:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id p5sm4477183pgf.50.2017.06.23.14.55.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 14:55:09 -0700 (PDT)
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
Date:   Fri, 23 Jun 2017 14:55:08 -0700
In-Reply-To: <20170623151640.24082-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 23 Jun 2017 17:16:38 +0200")
Message-ID: <xmqqa84ycqtf.fsf@gitster.mtv.corp.google.com>
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

Shouldn't we be using the API function get_tempfile_path() for this
instead of reaching into its implementation detail?

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
