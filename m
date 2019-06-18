Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05061F462
	for <e@80x24.org>; Tue, 18 Jun 2019 17:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfFRRaN (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 13:30:13 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:51626 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfFRRaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 13:30:12 -0400
Received: by mail-vk1-f201.google.com with SMTP id s145so6321571vke.18
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 10:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b0umn8G+CPm1rYozuFlsPvOyCC4fmGDH+q+zrbRkd8U=;
        b=G85KNfATM8xNNI1xWMnEI6nXI66GkMsYOETNbPZBbP5V+gue3XRBrfpVwtkTcZeUjx
         R6/lLcPnidYB3YaQAb4WesX9e72X4xm3/V7LdqFkcUrL1hQVQHQNwJBYIc8NKTEAmv4K
         qh/18DzsDg01j75kLGYSRbX7zXtaUYMz1lqywyPXdBAajeOnDQyiZi78fwBeDFZjgGlL
         /4851xbwWvV7hlqVuxcUtHuM/2Dc40V8RWyPhCb/ahbFHbcst0GkfKKGj7wkh27DcRNT
         CFGqI0pmyLYsl/8lYzfhAWt5u7oWuC0M500cj7VgFZPAedQ5xOxuyOWxoQX6ZnWxEe11
         f9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b0umn8G+CPm1rYozuFlsPvOyCC4fmGDH+q+zrbRkd8U=;
        b=nDa3+fZT2OcK/wyc6D6WSU499m8S+2QRk67zEZXHWa8y6ulRdX6VqXvxPNuJQlaNyX
         xu9KaF1qep/82RXb42AK/9hqV6gNlvOXuIkp9sFcWZt6N3kzdTAwyIfvBTmLmOZs4Nbw
         O1+J1lfiJpD2QsBfN/T8CoZ+S4EzoYP2tY9AtoftNCv8rhgVBVhZ4Z9W610fv/guGnC6
         RAGyfrUBFXnhue4rqaOLl1BRjocLE2YlTOMANd4jqsO5LM55rjQyAoTl555sHiiXjez3
         8wZdj/nTUP8E/p6alNXQUEH9kpvDo5dpm363mVCTX9AdUBQC2up7hqwEC5AqjW/h0mhU
         gFCw==
X-Gm-Message-State: APjAAAX8l76K1f1hSOCt6W93i+6dWXTydQJNbGkCxe1/F++BJKOSlyl7
        pPMenobAJtSq4dFUGmlGD6yvzdDikITiRCHE24VT
X-Google-Smtp-Source: APXvYqyRJfa+idkR3WrhqUUVU7YMweyE+mhcTbOb91WEBIt8sqbo1f2hw/LJ0LtoLG/047eet39444U/dpejMptyLXB+
X-Received: by 2002:a1f:7dc2:: with SMTP id y185mr1052545vkc.51.1560879011018;
 Tue, 18 Jun 2019 10:30:11 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:30:06 -0700
In-Reply-To: <87o92v817k.fsf@evledraar.gmail.com>
Message-Id: <20190618173006.182337-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87o92v817k.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: Re: [PATCH v4] fetch-pack: support negotiation tip whitelist
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -230,7 +246,7 @@ static int find_common(struct fetch_negotiator *negotiator,
> >  	if (args->stateless_rpc && multi_ack == 1)
> >  		die(_("--stateless-rpc requires multi_ack_detailed"));
> >
> > -	for_each_ref(rev_list_insert_ref_oid, negotiator);
> > +	mark_tips(negotiator, args->negotiation_tips);
> >  	for_each_cached_alternate(negotiator, insert_one_alternate_object);
> >
> >  	fetching = 0;
> 
> Here we blindly add objects found in an alternate repo. I found and
> debugged this with this:
> 
>     diff --git a/fetch-negotiator.h b/fetch-negotiator.h
>     index 9e3967ce66..cbe71c9c8d 100644
>     --- a/fetch-negotiator.h
>     +++ b/fetch-negotiator.h
>     @@ -33,2 +33,3 @@ struct fetch_negotiator {
>             void (*add_tip)(struct fetch_negotiator *, struct commit *);
>     +       int done_adding;
> 
>     diff --git a/fetch-pack.c b/fetch-pack.c
>     index 3f24d0c8a6..6b43b4f8f1 100644
>     --- a/fetch-pack.c
>     +++ b/fetch-pack.c
>     @@ -238,2 +238,3 @@ static void mark_tips(struct fetch_negotiator *negotiator,
>                                         &negotiation_tips->oid[i]);
>     +       negotiator->done_adding = 1;
>             return;
>     diff --git a/negotiator/default.c b/negotiator/default.c
>     index 4b78f6bf36..4e45f05f25 100644
>     --- a/negotiator/default.c
>     +++ b/negotiator/default.c
>     @@ -137,2 +137,4 @@ static void add_tip(struct fetch_negotiator *n, struct commit *c)
>      {
>     +       if (n->done_adding)
>     +               return;
>             n->known_common = NULL;
>     @@ -166,2 +168,3 @@ void default_negotiator_init(struct fetch_negotiator *negotiator)
>             negotiator->add_tip = add_tip;
>     +       negotiator->done_adding = 0;
>             negotiator->next = next;
> 
> Perhaps something like that with an assert() is a good idea for the
> negotiation backend code in general? It seems rather fragile to depend
> on there being no other codepath that calls add_tip() again after some
> other code (--negotiation-tip=*) that expects it not to be called again.

Thanks for spotting this bug.

There is already some defense from add_tip() not being called
unexpectedly - see negotiator/default.c and negotiator.skipping.c, which
sets add_tip to NULL when next() is called.

I can see that this doesn't help in this case, when we want to declare
done_adding but we haven't called next() yet, but I don't think that
this API layer is the right place to prevent that.
