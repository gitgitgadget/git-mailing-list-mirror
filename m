Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F131F403
	for <e@80x24.org>; Tue,  5 Jun 2018 23:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeFEXIZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 19:08:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45127 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeFEXIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 19:08:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id a22-v6so2118552pfo.12
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hfi9z1bE78orOh9TIUSRmilTifu6Qh5oJKOd3oxBNzs=;
        b=SjRLajJTOKQpFSYVqTIfgdjtO9i+CQGiplUvTGdLnh+PlF4GfT5D9OiZwYvLp7jQ17
         Jq4/7WOaTnv7soT/soaGut7RtM16n9uiyAZzImdUkh/TOphqCTPIxwdOr44djzpzxlwC
         OFEv02yYs/2xAnHiS5Wco7jP7dguA6+CNw+cSvygFC22eTIlKtLRunWeCssEyxmPHYrp
         rMSW6s9nu2iEjplm/6pFQA1yQr4M2TcAinvfF7BPNZFDimLMNW5Uu6+R4iObjFMgZz6y
         OmH7frKYF4C68HG6J+3nYYk+lVuamYsO/OBDxTZ3VMVggto8Q8it1Ag9H1DUj1slq/Td
         LDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hfi9z1bE78orOh9TIUSRmilTifu6Qh5oJKOd3oxBNzs=;
        b=WHLQ3SUfufbtWJmmUP8fQKfieOmJ0TE1NDmkFQF3scRZaVN+3Iv4zs0ClNIV/PA33n
         jg1cAZWG/zvg/9XAQnmBb2fuXJx4N0a93vd8qjjIIh1mXKanWjRyzDIUO3+b5ApmIRjy
         jXboiQRQ/XDU5fBnFmcwnui96kipnhqw9NH0ar5BS7b8/Em+sTQ2qAFHwLj1HkZx08/R
         GTOd31RZ0AGqNuJW+4TsnSkF7tSO233zpun24J/JD8JyKbMh5YvBcw58gDV6Jl+x0dms
         tb4x2zDrBdu4K4BujLatxW82EvNc7DQxav2HAES/IdgTYif2b+HdZT6HG+lHqi/+/gxv
         79+g==
X-Gm-Message-State: APt69E3QIAYkMTqa1BPISQyo5iMxvEsci7/fvyGQZ9If6hBVgVVTJhPI
        UfGHIox4genIob29NNm+KvC3q5LS
X-Google-Smtp-Source: ADUXVKLHPstVZjBKTbjEqctt86ulxywNsIPXfT2F1uoLe8pGTZyoTeFl1VAftyKIe5nIq6oS7J2LGA==
X-Received: by 2002:a63:82c7:: with SMTP id w190-v6mr479243pgd.172.1528240104307;
        Tue, 05 Jun 2018 16:08:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 68-v6sm87342463pff.35.2018.06.05.16.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 16:08:23 -0700 (PDT)
Date:   Tue, 5 Jun 2018 16:08:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Subject: Re: [PATCH 1/6] fetch-pack: clear marks before everything_local()
Message-ID: <20180605230821.GC9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <b9d6d8fef370fae316f78c851833dbd706ff6f7c.1527894919.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d6d8fef370fae316f78c851833dbd706ff6f7c.1527894919.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> If tag following is required when using a transport that does not
> support tag following, fetch_pack() will be invoked twice in the same
> process, necessitating a clearing of the object flags used by
> fetch_pack() sometime during the second invocation. This is currently
> done in find_common(), which means that the work done by
> everything_local() in marking complete remote refs as COMMON_REF is
> wasted.
>
> To avoid this wastage, move this clearing from find_common() to its
> parent function do_fetch_pack(), right before it calls
> everything_local().

I had to read this a few times and didn't end up understanding it.

Is the idea that this will speed something up?  Can you provide e.g.
"perf stat" output (or even a new perf test in t/perf) demonstrating
the improvement?  Or is it a cleanup?

[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -336,9 +336,6 @@ static int find_common(struct fetch_pack_args *args,
>  
>  	if (args->stateless_rpc && multi_ack == 1)
>  		die(_("--stateless-rpc requires multi_ack_detailed"));
> -	if (marked)
> -		for_each_ref(clear_marks, NULL);
> -	marked = 1;
>  
>  	for_each_ref(rev_list_insert_ref_oid, NULL);
>  	for_each_cached_alternate(insert_one_alternate_object);
> @@ -1053,6 +1050,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  	if (!server_supports("deepen-relative") && args->deepen_relative)
>  		die(_("Server does not support --deepen"));
>  
> +	if (marked)
> +		for_each_ref(clear_marks, NULL);
> +	marked = 1;
>  	if (everything_local(args, &ref, sought, nr_sought)) {

As an experiment, I tried applying the '-' part of the change without
the '+' part to get confidence that tests cover this well.  To my
chagrin, all tests still passed. :/

In the preimage, we call clear_marks in find_common.  This is right
before we start setting up the revision walk, e.g. by inserting
revisions for each ref.  In the postimage, we call clear_marks in
do_fetch_pack.  This is right before we call everything_local.

I end up feeling that I don't understand the code well, neither before
nor after the patch.  Ideas for making it clearer?

Thanks,
Jonathan
