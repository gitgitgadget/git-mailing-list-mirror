Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03CF120248
	for <e@80x24.org>; Mon,  8 Apr 2019 07:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfDHH7b (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 03:59:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50595 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHH7b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 03:59:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so13211945wmi.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VPDiAFP2CDMLlh2GzaStsFHLe6Sg7Pi62w3MOUHlE38=;
        b=O2HagX/en/lH4PAI266vbxCSAbSeSPaqNWuxshgNPfCOpDl9a7aMgQ4tkq86OPabJd
         YPcx36+b3byZLjHxDr/523pev/gIGik4Ak2kJnCIAecXY9qlku90r6cuRZz/S3ZY3Xtm
         ioVK1sbA1XKD/5VaZgwUGyR8iVChj7Keg4EUOQ58aa7iK6Y1isRJ6CyyKArexRHnEHFe
         q9cPXyjuCxBSzFBeea0TSLLAXGW5oSYQHTMNbydcuxgB3zD+XetNmJAddletFbfHSqPV
         Z1LhkqVcQ46RoFIqHQnGyATPFD1uP1SeoOjnI3GGBD+sJ+jzFZpazZ28NsXzCmwccu+L
         9gMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VPDiAFP2CDMLlh2GzaStsFHLe6Sg7Pi62w3MOUHlE38=;
        b=fgFdFObeBRCAcjJVbL4LuTNd9KKvwV8ZtPNWHXhIqd1hKKq+hJkuSVoS+yhC7j4BTv
         KIQk43UXT2kMpHIEwvvqH7y4CQRwu3bzERq5Kq5xhcy7VO7iobkyV3QQ4A5fXVUt+Qvc
         4A8DdNT/3/hfsTVR4WIDpMUQsnJEUiOiwbu+Lor4QYVQin4f3A9Hjn7/5uLcPVSMOBzs
         qEPo7TcVvHe3FPLYO0So20ro/q/EUmu/bEnhzRpg6NutbU8Uduqs/QX1h0v51Cxsj49g
         R3DFxK8dZS4qwqBy87svMe3UVS5IJkdO995b2QzWhX0xBmN7kxr59Ci6z6FAJXbfo6CJ
         eLvQ==
X-Gm-Message-State: APjAAAV8F8CYt3Jwd1eNuhfxn7GKj9rgiR+ovUo1h5cBiD503AjIV6tx
        XAtF2NdCvP2iAOrLf0RH51exFs75JLw=
X-Google-Smtp-Source: APXvYqyHV27nvpOHTu9DD2tMWzGJhYyXXQBdbwtAvqpRF3xbVrRcJOtT4FE3PaJoIxUPdwR0kYRGQg==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr16061455wmk.9.1554710369598;
        Mon, 08 Apr 2019 00:59:29 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a10sm31123164wrs.19.2019.04.08.00.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 00:59:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
References: <20190326220906.111879-1-jonathantanmy@google.com>
        <cover.1553895166.git.jonathantanmy@google.com>
        <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
        <20190404024710.GO32732@szeder.dev>
        <nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet>
        <CAP8UFD1qK61MtJ-XeMuwY4W2V0CdHeZQC9rQap1M+nEeaLmBJQ@mail.gmail.com>
        <xmqqy34lb4vb.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD0gmaZzfK7taS=1hj=sCEpLFt_Az60TxYeUqp2A7r25JQ@mail.gmail.com>
Date:   Mon, 08 Apr 2019 16:59:28 +0900
In-Reply-To: <CAP8UFD0gmaZzfK7taS=1hj=sCEpLFt_Az60TxYeUqp2A7r25JQ@mail.gmail.com>
        (Christian Couder's message of "Mon, 8 Apr 2019 08:40:23 +0200")
Message-ID: <xmqqbm1h7wrj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Patch 3f82acbca2 (Use promisor_remote_get_direct() and
> has_promisor_remote(), 2019-04-01) in cc/multi-promisor starts with:
>
>     Use promisor_remote_get_direct() and has_promisor_remote()
>
>     Instead of using the repository_format_partial_clone global
>     and fetch_objects() directly, let's use has_promisor_remote()
>     and promisor_remote_get_direct().
>
>     This way all the configured promisor remotes will be taken
>     into account, not only the one specified by
>     extensions.partialClone.
>
> I will at least add something telling that in most cases
> "repository_format_partial_clone" and fetch_objects() shouldn't be
> used directly anymore.

Yes, that would be necessary not in the log, but in-code comments
next to now "by-exception-only" API functions and variables.

>> > @@ -6506,8 +6507,7 @@ void diffcore_std(struct diff_options *options)
>> >              /*
>> >               * NEEDSWORK: Consider deduplicating the OIDs sent.
>> >               */
>> > -            fetch_objects(repository_format_partial_clone,
>> > -                      to_fetch.oid, to_fetch.nr);
>> > +            promisor_remote_get_direct(to_fetch.oid, to_fetch.nr);
>>
>> Likewise between fetch_objects() and promisor_remote_get_direct().
>> Shouldn't the underlying fetch_objects be hidden from general
>> callers?
>
> I will see if I can do that, though it has to be used in promisor-remote.c.

Does fetch-objects.[ch] even need to exist after multi-promisor
world as an external interface?  

Wouldn't it become an implementation detail of promisor-remote.[ch]
API?
