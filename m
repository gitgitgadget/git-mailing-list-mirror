Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EB6C433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 23:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9054B60F21
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 23:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347952AbhIBXYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 19:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhIBXYD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 19:24:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D2EC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 16:23:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i6so5360940edu.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 16:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SE+rA12ie5ucxol6d8MjxvjyLOg/H81Om6p1XFbLTzE=;
        b=QosqfXb6/6ENCZ/wgkdgdzwpQirm3Su60wp5SquTUbS0lq6ZtJcU9U4dUxjF8L83p9
         oZ1x6yhYKk7p6v5AkWFViCVfYbJEf2RTHw71q1vbuLKt863LpMbUWs4oHcNHIDhp4Fqj
         r+xig0CD/61oukQAn7B4qTMtT5MrTffHRlwsc4Qrv7ugq9Zsh/lCyB1ewhuiYbhpsOlY
         Qb9h6pqyGvcQwFSXBs0/WzQlKju19fOCwjUxZQV+HVyXWeHN8c7xyszN2o5nfpEJTY5Q
         bTDUy28vZfZQyuHXwMpGw3OWfWAQQ8q9AHsnJlfmeE1NM6GiMpJkD00vVb29kpbR/eKu
         6BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SE+rA12ie5ucxol6d8MjxvjyLOg/H81Om6p1XFbLTzE=;
        b=hifYNo6ssNM/Is7e+e4BLf1BKvbr7pdORW5uvBt/LN12fZVw++GZoCpwiFqLtQcoVz
         fofamqEoqVzKfgDiHQUW1uGCMhppuC9qltb75YWwIZmn+AglrT/KY9fxcL1TESXHiZeo
         yiyjzkXBk08Ym7xIZJTTxD47PCMDay6JEfm11anHJ3/s+Q0zowLAUAQplgzSXE6K3hHH
         2PsuJhvDx5W29i4p23YBNttZGT64YECzIKMSNjhNsxzPAcN6wFsJ5twPFL8n/NxREnWd
         RresK0Mf8aD278cPjAH9j7OcN0VoQGYI3WFdJe42+nDzgKqiQvnzrp/qU54dVmERlQFL
         2XVg==
X-Gm-Message-State: AOAM532WAPZS9IF74r6q4+cvm8R/uM2zUt/xOxiInIVAVuGVhp7iEUgM
        fNL5ewKw4gFFJAisO7pSFmLTcFQpmOwlsA==
X-Google-Smtp-Source: ABdhPJxi73+hBytX+WfVh+Tj5VFIwZbZa323Mssf9c3OMrWwv9hCacLUIQM6V80GD+O4evj8QZpWnA==
X-Received: by 2002:a05:6402:14d6:: with SMTP id f22mr822545edx.274.1630624983174;
        Thu, 02 Sep 2021 16:23:03 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o21sm1858996eji.29.2021.09.02.16.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 16:23:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/5] strvec: add a strvec_pushvec()
Date:   Fri, 03 Sep 2021 01:19:33 +0200
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
 <patch-v3-2.5-321b8ba3f0e-20210826T140414Z-avarab@gmail.com>
 <xmqq8s0m9xbl.fsf@gitster.g> <xmqq4kba9x1h.fsf@gitster.g>
 <YSm3ofxlRB1ViBf5@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YSm3ofxlRB1ViBf5@coredump.intra.peff.net>
Message-ID: <87v93i8svd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 28 2021, Jeff King wrote:

> On Fri, Aug 27, 2021 at 06:29:30PM -0700, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>=20
>> >> +void strvec_pushvec(struct strvec *array, const struct strvec *items)
>> >> +{
>> >> +	int i;
>> >> +
>> >> +	for (i =3D 0; i < items->nr; i++)
>> >> +		strvec_push(array, items->v[i]);
>> >> +}
>> >
>> > This implementation is not wrong per-se, but is somewhat
>> > disappointing.  When items->nr is large, especially relative to the
>> > original array->alloc, it would incur unnecessary reallocations that
>> > we can easily avoid by pre-sizing the array before pushing the
>> > elements of items from it.
>> >
>> > In the original code that became the first user of this helper, it
>> > may not have made much difference, but now it is becoming a more
>> > generally reusable API function, we should care.
>>=20
>> And if we do not care, you can rewrite the code that became the
>> first user of this helper to instead call strvec_pushv() on the
>> items->v array that is guaranteed to be NULL terminated, without
>> inventing this new helper.
>
> I came here to say that. ;)
>
> I do not mind using pushv() directly, or a pushvec() that is a
> convenience wrapper for pushv(). Even better if that wrapper is smart
> enough to pre-allocate based on items->nr, as you mentioned, but that
> can also come later.
>
> One thing that did surprise me: the use of "int" here for iterating,
> rather than size_t. But it seems that strvec is already storing ints,
> which is an accident!

Is it really? If you temporarily try to say convert that to "size_t *nr"
to have the compiler catch all the cases where we use "nr", and then
s/size_t/int/g those all, you'll find that e.g. setup_revisions() and
the like expect to take either "int argc" or the strvec equivalent.

We can sensibly convert some of those to size_t, but not all, and the
int v.s. size_t inconsistency as a result feels weird.

Since the main point of this API is to be a wrapper for what a C main()
would take, shouldn't its prototype mirror its prototype? I.e. we should
stick to "int" here?

> I think we'd want the patch below. It can be applied independently
> (though if we do take the index-iterating version of =C3=86var's patch, I
> think it should switch to size_t).
>
> -- >8 --
> Subject: [PATCH] strvec: use size_t to store nr and alloc
>
> We converted argv_array (which later became strvec) to use size_t in
> 819f0e76b1 (argv-array: use size_t for count and alloc, 2020-07-28) in
> order to avoid the possibility of integer overflow. But later, commit
> d70a9eb611 (strvec: rename struct fields, 2020-07-28) accidentally
> converted these back to ints!
>
> Those two commits were part of the same patch series. I'm pretty sure
> what happened is that they were originally written in the opposite order
> and then cleaned up and re-ordered during an interactive rebase. And
> when resolving the inevitable conflict, I mistakenly took the "rename"
> patch completely, accidentally dropping the type change.
>
> We can correct it now; better late than never.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  strvec.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/strvec.h b/strvec.h
> index fdcad75b45..6b3cbd6758 100644
> --- a/strvec.h
> +++ b/strvec.h
> @@ -29,8 +29,8 @@ extern const char *empty_strvec[];
>   */
>  struct strvec {
>  	const char **v;
> -	int nr;
> -	int alloc;
> +	size_t nr;
> +	size_t alloc;
>  };
>=20=20
>  #define STRVEC_INIT { empty_strvec, 0, 0 }

