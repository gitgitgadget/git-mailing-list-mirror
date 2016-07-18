Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF73F2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 21:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbcGRVF0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 17:05:26 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37529 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbcGRVFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 17:05:25 -0400
Received: by mail-wm0-f42.google.com with SMTP id i5so2719227wmg.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 14:05:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s1KcPPJEYft19kEXCoRf4GQkPThN8tg22QVNMmeqfQI=;
        b=nEOvTlQ761CAHpmvjCkGmYalYRLS6Nxvr8Egeg4BxfRyBzXki62hjjh2hxNsdegcqi
         qVu62JQUIzu9wnOc7zoNUbGM1GvahIHNP1wYc+KfP+oxezhwH9CvKfZAqARyfLLH1Oke
         5+CAtAr5/d1b1V1DGhRqhQBTGBK+IOMozlMyHKldzu621HxORyvlcdtfLzkbvwYJyciX
         DAFPKCIWDLO/HJ37y40dXGq3t6OTlSksphdpJ2kepyM3cN61750OSmNwA16xJZcApeJy
         EjH2fx5zz8zDbC5e35KOylYuuO0t96uSqyR7lmExQwg04cIaODkgllhkiEGAv3+S4qB/
         SK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s1KcPPJEYft19kEXCoRf4GQkPThN8tg22QVNMmeqfQI=;
        b=ZS+bH9s/k1qYuK68eniyJ8wPO5tltdku33FYVdmn+Whi9tgVoTTzKnEYGySL88Aw3U
         OuMLgb+QTVyp1i/HVwJo7WCesMnrn6vveP1M+Zd1BG5F41Gi3e/fpVcDkRQXVOfGoyOv
         65yZyKD+cpRy4ApOOBtGOPBpmiUxM4ywsKFA/M883OV5sCwXCIB4kavM4YO/HFcEvHrk
         oarTUv3UAql9vPOIuLPEhY7pztxWUWN7BqYhZdArbDpPssjLGkUAxw4fJpScIUxdwuXR
         xE5xgwAPvqQdKoMtxIFgDIoJD5r4BzLfs4GLUWz6uv6Fc/mOmznGk40fEYOaJCIlQ9I3
         8fUQ==
X-Gm-Message-State: ALyK8tKVFOfcetO/B1WS7Flnf+YjhX1g/q1eGbK1S1EJlYcxEycLIE76c05nRh8F9Leu6zq6xNaTAZoAiul/V01h
X-Received: by 10.28.4.77 with SMTP id 74mr320014wme.84.1468875923530; Mon, 18
 Jul 2016 14:05:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.167.87 with HTTP; Mon, 18 Jul 2016 14:05:22 -0700 (PDT)
In-Reply-To: <xmqqoa5uiumu.fsf@gitster.mtv.corp.google.com>
References: <1468867019-13086-1-git-send-email-jonathantanmy@google.com>
 <20160718185527.GB29326@google.com> <xmqq37n6kbib.fsf@gitster.mtv.corp.google.com>
 <CAGf8dgJVkkVwJ5aJCQBcYKw7F9g7u3pMsuJHedSGLG6PQk2Keg@mail.gmail.com>
 <20160718193147.GC29326@google.com> <xmqqoa5uiumu.fsf@gitster.mtv.corp.google.com>
From:	Jonathan Tan <jonathantanmy@google.com>
Date:	Mon, 18 Jul 2016 14:05:22 -0700
Message-ID: <CAGf8dgJWMBbU1rbU1hTOjX9d-b-ocmYs-td9kpQ=skQFM7XcSA@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack: grow stateless RPC windows exponentially
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> You have full control of the growth function.  So how about aggressive
>> growth until 1024*10?
>>
>> That is:
>>
>> Current git:
>>   n < 1024: aggressive exponential
>>       16, 32, 64, 128, 256, 512, 1024
>>   1024 <= n: linear
>>       2048, 3072, 4096, 5120, ...
>>
>> Initial proposal:
>>   n < 1024: aggressive exponential
>>       16, 32, 64, 128, 256, 512, 1024
>>   1024 <= n < 10240: linear
>>       2048, 307, 4096, 5120, ...
>>   10240 <= n: conservative exponential
>>       11264, 12390, ...
>>
>> New proposal:
>>   n < 10240: aggressive exponential
>>       16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384
>>   10240 <= n: conservative exponential
>>       18022, 19824, ...
>>
>> That way, on one hand it would still never use a smaller window than
>> today and on the other hand the heuristic would be easier to
>> understand (only decelarating, instead of decelarating and then
>> accelerating again).
>
> That sounds more explainable (I do not know if that is a growth
> curve that gives us better results, though).
>
> So, the result would look something like this, perhaps?
>
>  fetch-pack.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 3c5dfc4..97fe5f7 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -264,12 +264,17 @@ static void insert_one_alternate_ref(const struct ref *ref, void *unused)
>
>  static int next_flush(struct fetch_pack_args *args, int count)
>  {
> -       int flush_limit = args->stateless_rpc ? LARGE_FLUSH : PIPESAFE_FLUSH;
> -
> -       if (count < flush_limit)
> -               count <<= 1;
> -       else
> -               count += flush_limit;
> +       if (args->stateless_rpc) {
> +               if (count < LARGE_FLUSH * 10)
> +                       count <<= 1;
> +               else
> +                       count = count * 11 / 10;
> +       } else {
> +               if (count < PIPESAFE_FLUSH)
> +                       count <<= 1;
> +               else
> +                       count += PIPESAFE_FLUSH;
> +       }
>         return count;
>  }
>

Using aggressive growth until 1024*10 seems like a good idea to me,
and it would look like that patch. (I would probably redefine
LARGE_FLUSH to be 10 times its current value instead of multiplying it
by 10, since it is not used anywhere else.)
