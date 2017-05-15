Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593BF201A7
	for <e@80x24.org>; Mon, 15 May 2017 22:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdEOWIR (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 18:08:17 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34718 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdEOWIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 18:08:16 -0400
Received: by mail-pf0-f169.google.com with SMTP id 9so29802604pfj.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1nTzemwUBEPogWXKU27vD6YDydeDhKmqQ7pn/QIEoCg=;
        b=nh+GdaFOYy8rogT/4fMZqp/cvmlCpgXe25qt0RehY3mWhQ6SnAXKBZ5P447W4t4VVJ
         Wa49w7iMzFrjBCY6eYDfxi0eU1qM5E7Qvvw1mWqABRWVXqgdtUF/oLA+zgdPlkprKU5S
         oqQ+h8GS3oggyFG9v3ZpK/C2MgXqcQjn925sJo4q2ebBtspbgHNcUwVLnL2n/evXgTF/
         M5XWTiBhPBoSWFM4oYCygFTF+65Zc6N1W7vyAr519yyCj33EIR7rEMPYF/6QHG60VQ06
         abTco/JbZlkcv0weMlqgaADeH4x3y9F4gNpB/Yw+TTouY/dnWHPaUnN8hJUpK9hC5sT9
         +IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1nTzemwUBEPogWXKU27vD6YDydeDhKmqQ7pn/QIEoCg=;
        b=IgvVPYRM3eBeOyIpevuJJq2MD86MF2AGHnqd7d8Si2EecnZWjSeuRxRwvBw7S06GaS
         LsDIBb1/0C+sJqIt2HCG6HUopz8CZK8Hb0VrUfHSNEGBGlcOJGBzFuBhdJQIY8wAL3Ul
         OUpQ0GLy7Jh60i1ac2SOssSA9mvfS6nEmDlUNCN4d422ElhZJ/W8NjuTva6oiUrQZbN6
         PbGD+m6JygICSLidzUsqUK1om8wTaCUetKtOYtXnWCk1q7mWXnxI2AVbOswTcFEPPObM
         549LOZoOPGCHwU0Wtq+4UYsu8iJrB+C38RGh05WQCQhIZKh3cg5KRXRXNiRW4w3y9GNP
         IkIA==
X-Gm-Message-State: AODbwcC9dzeLEJWZ8uKVq3inmiqbz4ibUYnZym47uuw8qERRj8GSBHXg
        SYrnQfX8g9IFUS6Y7HWbC//qFuI5wMLh
X-Received: by 10.98.205.65 with SMTP id o62mr8528432pfg.105.1494886095184;
 Mon, 15 May 2017 15:08:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 15 May 2017 15:08:14 -0700 (PDT)
In-Reply-To: <1b85a773-fb44-9a88-63d3-36c642d07c22@google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-16-sbeller@google.com>
 <1b85a773-fb44-9a88-63d3-36c642d07c22@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 15 May 2017 15:08:14 -0700
Message-ID: <CAGZ79kaWAMjzJUkqWOOmUrQcQZzT1RxqYE9tTr4ouy9Ax33t9g@mail.gmail.com>
Subject: Re: [PATCH 15/19] diff.c: convert diff_flush to use emit_line_*
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 1:21 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On 05/13/2017 09:01 PM, Stefan Beller wrote:
>>
>> In a later patch, I want to propose an option to detect&color
>> moved lines in a diff, which cannot be done in a one-pass over
>> the diff. Instead we need to go over the whole diff twice,
>> because we cannot detect the first line of the two corresponding
>> lines (+ and -) that got moved.
>>
>> So to prepare the diff machinery for two pass algorithms
>> (i.e. buffer it all up and then operate on the result),
>> move all emissions to places, such that the only emitting
>> function is emit_line_0.
>>
>> This covers diff_flush.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  diff.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 07041a35ad..386b28cf47 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4873,7 +4873,9 @@ void diff_flush(struct diff_options *options)
>>                                   term, 1);
>>                         if (options->stat_sep) {
>>                                 /* attach patch instead of inline */
>> -                               fputs(options->stat_sep, options->file);
>> +                               emit_line(options, NULL, NULL,
>> +                                         options->stat_sep,
>> +                                         strlen(options->stat_sep));
>
>
> Same comment as patch 10 - is it OK that we now output a prefix too?

In this case, I would think it is ok. The stat_sep is only used in
"format-patch --attach" for example, which makes NO sense to
use in combination with --line-prefix.

(That is already broken; at least the line-prefix part, as we
do *not* prefix all the lines with the given prefix. That is because
stat_sep is a multiline string emitted, starting with '\n'.)

Thanks,
Stefan
