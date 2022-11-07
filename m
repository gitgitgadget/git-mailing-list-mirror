Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65CAC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 15:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiKGPgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 10:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiKGPgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 10:36:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A99CD3
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 07:36:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s12so8566408edd.5
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 07:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gY5GkwTCQYpATImAvULsch55Dyx0kDSNtPpbRPr2Ksg=;
        b=mwM4HxE9i8PNFvHzjmHeX4DNY7neGSnFCzrsuMgXwCVMbyEoMyhoUy7uPNe55Jm/T0
         tsM9KGyrm660fv7xswd3+qm2mb+HHbu1246HnAYrF4uLKbXVLeRUqjb+bilhIG2B4UK7
         4ObAoCJSKQ9ccuonG585aBJfNxdZYHFGWuCVSh+1PRA3cLABfPYLJuHMkKC0ii7EyxnX
         vV5de97Zv/ymVdEgUbQi5IFw5HNNyBKema0XiEUN+rGNJBFfTDDZvc0RLoOiWiUG15ZS
         5+d7VVpvFr0gbah3REaLZcxuvQ9kNBZ+DCDP/a+7675QBIvPPtyvItaR9YBa2rfEVJB8
         zoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gY5GkwTCQYpATImAvULsch55Dyx0kDSNtPpbRPr2Ksg=;
        b=x7IearjgKV2LGzrU+PspvpwkupTuYkMUQUA24zzdkFoLj0d2paKbH9ggFt0YWTu6wN
         6wnkGcErSqP4nQ5ObZEac/40d8/fonTRtjhaqkpkOjKwb+KEiomT7+IT6QdNPjqQh6ks
         XxK4hanote26/51weu+vB+2PuH5pRqKlcWdRjlzZU8QNo15/Oj3pVpCZZrxiGXuwbIbA
         vHKKTy/2LHmuwA5WxiQtcnHxnXF0L9lpCVZzh1nhjSr5nqKmRM6JJSsiN/2ZUkRwwd3P
         yNtNgusmwhYjD7lboCmsn/rdRWXXA5tVzrtcNOpzIgbwuB2Lb+7dwYavn7JTwSkoeu+9
         Xd6A==
X-Gm-Message-State: ACrzQf2HDIgueMYHTNy/KqS335AhuCYu9o0lOjroby2pINofWmcdvMi6
        /dtbQ/aiDg0W+AA46EhGjsc=
X-Google-Smtp-Source: AMsMyM6807UIxlaC/pUPjHBNxj+oo9pW7Rqw+3x8pWBqGPc3Y47gK5beB4KFHcsXvCcenPYxMGo+gA==
X-Received: by 2002:a05:6402:294a:b0:461:b661:d903 with SMTP id ed10-20020a056402294a00b00461b661d903mr50645000edb.407.1667835366923;
        Mon, 07 Nov 2022 07:36:06 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090631c500b007a03313a78esm3559092ejf.20.2022.11.07.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:36:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os4AQ-0009e1-08;
        Mon, 07 Nov 2022 16:36:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        man dog <dogman888888@gmail.com>
Subject: Re: [PATCH 1/3] line-log: free diff queue when processing non-merge
 commits
Date:   Mon, 07 Nov 2022 16:29:39 +0100
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
 <20221102220142.574890-2-szeder.dev@gmail.com>
 <Y2MJRRfwG7rSp6Ra@nand.local> <20221107151115.GA1951@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221107151115.GA1951@szeder.dev>
Message-ID: <221107.86r0yevkt5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, SZEDER G=C3=A1bor wrote:

> On Wed, Nov 02, 2022 at 08:20:21PM -0400, Taylor Blau wrote:
>> > +void diff_free_queue(struct diff_queue_struct *q)
>> > +{
>> > +	for (int i =3D 0; i < q->nr; i++)
>> > +		diff_free_filepair(q->queue[i]);
>> > +	free(q->queue);
>> > +}
>>=20
>> Though I wonder, should diff_free_queue() be a noop when q is NULL? The
>> caller in process_ranges_ordinary_commit() doesn't care, of course,
>> since q is always non-NULL there.
>>=20
>> But if we're making it part of the diff API, we should probably err on
>> the side of flexibility.
>
> On one hand, strbuf_reset(), string_list_clear(), or strvec_clear()
> would all segfault on a NULL strbuf, string_list, or strvec pointer.

But the reason we do that is because those APIs will always ensure that
the struct is never in an inconsistent state, as opposed to the
destructor you're adding here.

I.e. if you were to work with the queue after this diff_free_queue()
call in process_ranges_ordinary_commit() you'd segfault, not so with
those other APIs.

> On the other hand, given the usage patterns of the diff API, and that
> it mostly only works on the dreaded global 'diff_queued_diff'
> instance, I don't think there is any flexibility to be gained with
> this; indeed it is already more flexible than many diff API functions
> as it works on the diff queue given as parameter instead of that
> global instance.

I pointed how this could be nicer if you made it work like those other
APIs in
https://lore.kernel.org/git/221103.864jvg2yit.gmgdl@evledraar.gmail.com/;
I.e. we could do away with DIFF_QUEUE_CLEAR() after calling this
"free()".

But in lieu of such a larger change, just adding a call to
"DIFF_QUEUE_CLEAR()" in this new free() function seems like it could
make thing safer at very little cost.

We're also far from consistent about this, but I wish it worked like
that and were called:

	diff_queue_struct_{release,clear}()

I.e. the usual naming is:

	<struct name>_{release,clear}()

In cases where we don't free() the pointer itself, but assume that we're
working on a struct on the stack, whereas *_free() functions will free
the malloc'd pointer itself, as well as anything it contains.

