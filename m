Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDCB21F453
	for <e@80x24.org>; Sat, 29 Sep 2018 18:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeI3BAi (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:00:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53372 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeI3BAi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:00:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so5055607wme.3
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q6Fmwh24mTjfwjKn/3P5a0UWxKYF0KrJRKxcHtQ5ZVQ=;
        b=KLfQL+3ueiF1liCvSeddURUiATWReWXRRjQ6ZbPoDo9DzbkApjT9DAUDzB+w3LjTFb
         MZqUsxZmd49fpd+k24hWv0SN579fPRYg4yb4ib1l+FM9n+Ce4+gMmFrYTU3szwsm2sXE
         Jgjn67GES+q9arKcEPwX/l5MT0agypydRSLKfChRcrONm+RIUufCCjz/v2PdPrtb46ZL
         B+4aOhISOon9S3Fm5ypGE/uZ+GXuGJhg+LnNTVG75sVAra8YjIGspvJ8uyK+XJ9z+LjE
         cgwTD0qa+p5t2rEP0WJIJJUoVZNxTtT3UM22bi4LSp7I2KXXtnG8z4DUt10tV/pViyi/
         u2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q6Fmwh24mTjfwjKn/3P5a0UWxKYF0KrJRKxcHtQ5ZVQ=;
        b=GGWWF++8HO2ofhjUz4jFexV9ckNRubLPN3DWSME6D/ss1CLeg9wtzKyKWXbRgt8U7V
         1wslJbmDmN8ekomfAmZmYFRJ1Yjls0H1CSZi4AW/uuBhFPOXQdaN1y4NKF/GbeNK2+UM
         b/T2heljOrjE/QIGN/PncosdVLGX9AnlGB05tZZeP4GboTLBukScqzZG3YBuI0R5T6LF
         kkm2ORhxNbDM/dt9rpiKukgxAlo/lt8SQVzo7w/O+f6ka3ORFngckeumVbunftkVLItZ
         EcRpMDstCoCtwsDso/U/IRrz29bZYiNUacER9HbhyML9m4atuVY9I5qEwgu7e4tQLx9v
         hz9g==
X-Gm-Message-State: ABuFfoiXqormedlkiYgyffsIxjcHFYaXUwp2Le2SfrqliFmTvRH6+M81
        uW92T6FEZ7wQDzdbD/bZXTE=
X-Google-Smtp-Source: ACcGV61s0kvjW7Q+tEhXDvjlDMy1VRu8nGDSu4bngEud9mN928p+Spd9sq9ybjlKlnJJn0Tfgbml7A==
X-Received: by 2002:a1c:385:: with SMTP id 127-v6mr5126445wmd.92.1538245869486;
        Sat, 29 Sep 2018 11:31:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q200-v6sm6392192wmd.2.2018.09.29.11.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 11:31:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch: replace string-list used as a look-up table with a hashmap
References: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kamkLV7yHtCu_qSqNzj7bJm0=Uw1CKxss+zTKJWsYz3qw@mail.gmail.com>
        <20180927055415.GC14178@sigill.intra.peff.net>
Date:   Sat, 29 Sep 2018 11:31:08 -0700
In-Reply-To: <20180927055415.GC14178@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 27 Sep 2018 01:54:15 -0400")
Message-ID: <xmqqva6o88b7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 26, 2018 at 03:59:08PM -0700, Stefan Beller wrote:
>
>> > +struct refname_hash_entry {
>> > +       struct hashmap_entry ent; /* must be the first member */
>> 
>> $ git grep "struct hashmap_entry" reveals that we have another
>> convention that we follow but not document, which is to stress
>> the importance of putting the hashmap_entry first. ;-)
>
> One thing I've liked about the list.h implementation is that you can
> store the list pointer anywhere in the struct, or even have the same
> struct in multiple lists.
>
> The only funny thing is that you have to "dereference" the iterator like
> this:
>
>   struct list_head *pos;
>   struct actual_thing *item;
>   ...
>   item = list_entry(pos, struct actual_thing, list_member);
>
> which is a minor pain, but it's reasonably hard to get it wrong.
>
> I wonder if we could do the same here. The hashmap would only ever see
> the "struct hashmap_entry", and then the caller would convert that back
> to the actual type.

Hmph, how would hashmap_cmp_fn look like with that scheme?  It would
get one entry, another entry (or just the skeleton of it) and
optionally a separate keydata (if the second one is skeleton), and
the first two points at the embedded hashmap struct, not the
surrounding one.  The callback function is now responsible for
calling a hashmap_entry() macro that adjusts for the negative offset
like list_entry() does?

> I think we could even get away with not converting
> existing callers; if the hashmap _is_ at the front, then that
> list_entry() really just devolves to a cast.

Yes.

> So as long as the struct
> definition and the users of the struct agree, it would just work.

Yes, too.

Was it ever a consideration, when allowing struct list-head anywhere
in the enclosing struct, that it would allow an element to be on
more than one list?  Would it benefit us to be able to place an
element in multiple hashmaps because we do not have to have the
embedded hashmap_entry always at the beginning if we did this
change?
