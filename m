Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9737B2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 16:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbcIOQ01 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 12:26:27 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38404 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754154AbcIOQ0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 12:26:24 -0400
Received: by mail-it0-f50.google.com with SMTP id n143so84257108ita.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3StqG6a7yp70Q7qBlxgoQybfMwN1F0S+AnlA9dW4sys=;
        b=MRV8AB4bJBbWT2J8cc/tNK7uqAu2fohAkQTj1emdHCVk4MGSAbUFabhBmFF2b7l5Vo
         SxM6uCprMPrzCcprhPIfV76NDok7wX/LeXzmv+4jmoYRC3krYXmH3pR51UbuUzQPRg3u
         pvJc/sanwoLwSh2PHMDzp4TwHVhwB1YUjbZ+JOrzsR4eIvMK47SrpWAtCjmP3pz8TFbZ
         Wry8HagZGx/NkAbkB+WSIlPqdnslK6gnGSHE9lKbe7w006XY4owkjoiLKsKyTS36St9p
         SPEQzfWmKhq/S4TXxfAFzBluOHPSlKCiSCiYee+AddFxmLl3aoLxIZypZNPqK2i5Hr/N
         oGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3StqG6a7yp70Q7qBlxgoQybfMwN1F0S+AnlA9dW4sys=;
        b=mDWk/mhZSsDKy5/t1ZSqQ3M4w2kvxPLD+SasQzVVV+uuxzTUdCMAFD6vFWHVF16I5k
         QzbmETXDhvSIsAHDDip9zdfk/FschOxv8JqNjBlvLyzyF37IHkBnhwfLJprMCJjQ8Asg
         3V5FWI+j4XTVkkYyrm/mplzOZCgdeoUWhl+RCkv3VuixMTo2qqVYekg9FiRGEAJ+iE+h
         OXXdx60PqwG4/OI04f9xQSEw/nICWy0cQWBW0Wph/5+ZDgbIIymQ1vmk3ozcXDdTRe7R
         J+vMQnPqhQ1vOq/pKsjpVBXJM+CVu92Zv1w79dV0CMuNBgcbp0n2Co0oo7JxBNOFWrBQ
         5TFw==
X-Gm-Message-State: AE9vXwMZs/LdVTCaFHZ0zpOVqV9PtnzzH09mHeqQPH3xO/GRpNCcDVN5gtYOzagClAF/ISc56oSF//sBPmuS1R4/
X-Received: by 10.36.98.199 with SMTP id d190mr417133itc.39.1473956783111;
 Thu, 15 Sep 2016 09:26:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 15 Sep 2016 09:26:22 -0700 (PDT)
In-Reply-To: <20160915064701.c4ishixuynbzpgwx@sigill.intra.peff.net>
References: <20160915020141.32000-1-sbeller@google.com> <20160915064701.c4ishixuynbzpgwx@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Sep 2016 09:26:22 -0700
Message-ID: <CAGZ79kZ-rLVijKj31uYgYrLkSCCOaLKWrr8u=6LXnd=gmma+xQ@mail.gmail.com>
Subject: Re: [PATCH] object: measure time needed for resolving hash collisions
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 11:47 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 14, 2016 at 07:01:41PM -0700, Stefan Beller wrote:
>
>>  According to Jeff, sending patches that don't get accepted is the new hype!
>
> It is what all the cool kids are doing. Unfortunately, it does not save
> you from nitpicky reviews...;)
>
>>       first = i = hash_obj(sha1, obj_hash_size);
>> +     clock_gettime(CLOCK_MONOTONIC, &time1);
>>       while ((obj = obj_hash[i]) != NULL) {
>>               if (!hashcmp(sha1, obj->oid.hash))
>>                       break;
>> @@ -98,6 +131,9 @@ struct object *lookup_object(const unsigned char *sha1)
>>               if (i == obj_hash_size)
>>                       i = 0;
>>       }
>> +     clock_gettime(CLOCK_MONOTONIC, &time2);
>> +     diff(&time1, &time2, &t_diff);
>> +     add_time_to(&caching, &t_diff);
>>       if (obj && i != first) {
>
> I don't think this is actually measuring the time spent on collisions.
> It's measuring the time we spend in hashcmp(), but that includes the
> non-collision case where we find it in the first hashcmp.

Right. I measured all lookup times, i.e. this function accounts for
1/3 of the run
time.

>
> Measuring _just_ the collisions is more like the patch below. In my
> measurements it's more like 30ms, compared to 10s for all of the
> hashcmps.

So off by a few orders of magnitude, i.e. we don't have to worry about
the time spent in resolving collisions.

>
> So we really aren't dealing with collisions, but rather just verifying
> that our hash landed at the right spot. And _any_ data structure is
> going to have to do that. If you want to make it faster, I'd try
> optimizing hashcmp (and you can see why the critbit tree was slower; if
> we spend so much time just on hashcmp() to make sure we're at the right
> key, then making that slower with a bunch of branching is not going to
> help).
>
> I notice we still open-code hashcmp. I get a slight speedup by switching
> it to memcmp(). About 2.5%, which is similar to what I showed in
>
>   http://public-inbox.org/git/20130318073229.GA5551@sigill.intra.peff.net/
>
> a few years ago (though it's more pronounced as a portion of the whole
> now, because we've optimized some of the other bits).
>
> The main driver there was memcmp() improvements that went into glibc
> 2.13 several years ago. It might be time to start assuming that memcmp()
> beats our open-coded loop.

http://stackoverflow.com/questions/21106801/why-is-memcmp-so-much-faster-than-a-for-loop-check

seems to agree with you; so I'd think I'll agree with switching over.

>
> It may also be possible to really micro-optimize it on some platforms,
> because we know the size in advance (I'd kind of expect the compiler to
> do that, but if we're ending up in glibc memcmp then it sounds like it
> is not the case).

That stackoverflow link suggests that glibc already has microoptimisations
for a variety of platforms.

>
> -Peff
