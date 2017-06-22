Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFFED1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753623AbdFVTv5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:51:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34714 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdFVTv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:51:56 -0400
Received: by mail-pf0-f193.google.com with SMTP id d5so4415941pfe.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=N64dKzcFZ5m8NlQhAR4pga4BUTv2VNElatri4YIjn00=;
        b=P/DVgNiFzP43p1HngAGqr/8s7oZnILONd7dlSUlm3cLXw2juzDe351fIdGSKAf2Tep
         QAc15sXQ4fjlMNUG4T2j8dgC3+THxPOWatj2fErxSXQgB/ZJVIE4jo9mGNrrPAGVfGO2
         KG/LR61AdQYRsoHnRrmTc43J/rnmHsNY7o4QlLbP/zhuQ7lNYHxkbR41ucyM59t1mGba
         O9F5I13d+Sf7JbOCwoaGTtC+c7awxbm8fMmFWSPzk18JKzb7D224cw8KepZmIla+B3uG
         fCq9Nr7mvtKn/uKi9HEI4ifIV0Vd+NtkOTP2tAp8/Vc6PLJj+fnDsr3NZplf6eOdQD8e
         9OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=N64dKzcFZ5m8NlQhAR4pga4BUTv2VNElatri4YIjn00=;
        b=VNlKO02f5DR8+LnS0hRwAXg0KeOOn7nc2qPFmnuqK58eFTrB9l0IFzIBI11VS7I5M/
         RqUZ/gfrOtb0x3rhu+InWplpX8CezelHrvGZwpbRzQawj12oDk4cwt1bikvwNmGhXDa4
         NvpcyCHLIWTlsonF9WGL4PUtvnkrqQl2k+1DVFkahFCPRjI8vaCCYRNm1ro0C9qUYl4R
         UiL6yMFYQEBIkwHkmiaP3fxgRbfQkh/pBKJJd5Vf+jXYD/BNYGB0QLf6z1Ud4a8lkgnX
         GbIZYDmyoFKzLmx/xL2aH7B6PAdHFLfg+rJxCXuIUmr4lri+sSR0FzcuZaAym5Kk0dL6
         mEpQ==
X-Gm-Message-State: AKS2vOxfVqWInuFM/0sHAyu5D1xc9PPi6vrMtte5YNhkLfiZBWOl5xfn
        AAZwmRhYBQLpnw==
X-Received: by 10.99.3.202 with SMTP id 193mr4207445pgd.222.1498161115770;
        Thu, 22 Jun 2017 12:51:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id g13sm5252045pgu.54.2017.06.22.12.51.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 12:51:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] read-cache: use shared perms when writing shared index
References: <20170622190158.13265-1-chriscool@tuxfamily.org>
Date:   Thu, 22 Jun 2017 12:51:54 -0700
In-Reply-To: <20170622190158.13265-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 22 Jun 2017 21:01:56 +0200")
Message-ID: <xmqq8tkjkdgl.fsf@gitster.mtv.corp.google.com>
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
> This means that on repositories created with `git init --shared=all`
> and using the split index feature one gets an error like:
>
> fatal: .git/sharedindex.a52f910b489bc462f187ab572ba0086f7b5157de: index file open failed: Permission denied
>
> when another user performs any operation that reads the shared index.

Assuming that a "shared" repository setting should allow uses by
different users, the above analysis makes sense to me.

But the conclusion does not.

> Let's fix that by using create_tempfile() instead of mks_tempfile()
> to create the shared index file.
>
> ...
> -	fd = mks_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));
> +	fd = create_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));

So we used to create a temporary file that made sure its name is
unique but now we create sharedindex_XXXXXX with 6 X's literally 
at the end?

Doesn't mks_tempfile() family include a variant where you can give
custom mode?  Better yet, perhaps you can call adjust_shared_perm()
on the path _after_ seeing that mks_tempfile() succeeds (you can ask
get_tempfile_path() which path to adjust, I presume)?

>  	if (fd < 0) {
>  		hashclr(si->base_sha1);
>  		return do_write_locked_index(istate, lock, flags);
