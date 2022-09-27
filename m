Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E44C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 10:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiI0Kzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 06:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiI0Kzw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 06:55:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192CB1707F
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 03:55:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b35so12737937edf.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=HwvMZYkyMOJR1Dub7IrgmZv0Reo/e1G3mmikQQMpC8U=;
        b=IkFhLRvSGhKDwyzaBiNou3y6TtX79nOiEu+hhOS8dXaW2d6uEd6BTj6Vwlw5IyeXcc
         mwabIdcQUnSoWpgjx1lgt5wdeq+S87WiqQZmjfIWUw/y+EIsPF4/iYdkmSqLptTbHYZ9
         BuAaY160fzu/Zv+bMBxsHdc19/UikA4kBcSdDe0uj7s9yUvG/yTRi7NnMl9LP7E31jOk
         D8aohfOtFAcaKm7GTDP7fzjZF6km6mLxcrGjpeFEoJyI4TpUhvP1Tnc76daHvaF5HC0t
         mWjuiFknFwDbZ3mzw81W7tgDofUOVCezuurVbe7ZScY66InmleDoVq35a8LUWKy78PZ2
         H4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HwvMZYkyMOJR1Dub7IrgmZv0Reo/e1G3mmikQQMpC8U=;
        b=vP/lS9EbHxNIVrc2GeCaY5R/Z0TwfBxZN5xC2KK6MlApDT9o/wwunCW6WhpCBKezhP
         Jfz1qdGF6gYk9Gnz9GblyHRR9STzglCRWSlBNvmPU8F6UuG11OzdB+WHT++Clb6RjLfz
         uqI+fTxPBtjs2IG2V3u1dxMgpIw3XuTgapAFyF6oOLQ0Eu94alrjhaSXZO4Y7uPuyGuw
         DCsvRo6vZ5PkkA91wPEkNCZNVHu522j3/gCJBPuzYs9YcINdLclOMyFimy0TqjKlnkRa
         WrZyhZpSH0FGS5Ga8v4UYB8ALuqwqSWrFm4RECaBbFpreFUtUYfR7Lc/Xq/EuBs0Ac7r
         n0Iw==
X-Gm-Message-State: ACrzQf3ll2vQCAezGPT2eHTH4Er6VVijwCtnmG8Wrv//VkWK9UytlMGg
        Wf3aOwo+yBVwDuWBNZF0IcCgOYmT590=
X-Google-Smtp-Source: AMsMyM56KwdQad3cSkbJpdFQNGTULHabv58l67MwvXpZYLfxC2pq2EXkzaOSPONxN980AWDe4o1bRA==
X-Received: by 2002:a05:6402:4493:b0:451:141d:3231 with SMTP id er19-20020a056402449300b00451141d3231mr26744629edb.318.1664276147615;
        Tue, 27 Sep 2022 03:55:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ky21-20020a170907779500b0073ae9ba9ba8sm637476ejc.3.2022.09.27.03.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 03:55:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1od8Fd-000JT9-37;
        Tue, 27 Sep 2022 12:55:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
Date:   Tue, 27 Sep 2022 12:52:34 +0200
References: <20220922232947.631309-1-calvinwan@google.com>
 <20220922232947.631309-2-calvinwan@google.com>
 <220923.86sfki4ize.gmgdl@evledraar.gmail.com>
 <CAFySSZB=bPWpK25Gwtm06cOyupGeUYo6qLC4PWPwaS2pNn22hA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAFySSZB=bPWpK25Gwtm06cOyupGeUYo6qLC4PWPwaS2pNn22hA@mail.gmail.com>
Message-ID: <220927.86edvxytla.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 26 2022, Calvin Wan wrote:

>> On the implementation:
>>
>> > + * If the "pipe_output" option is specified, the output will be piped
>> > + * to task_finished_fn in the "struct strbuf *out" variable. The output
>> > + * will still be printed unless the callback resets the strbuf. The
>> > + * "pipe_output" option can be enabled by setting the global
>> > + * "run_processes_parallel_pipe_output" to "1" before invoking
>> > + * run_processes_parallel(), it will be set back to "0" as soon as the
>> > + * API reads that setting.
>>
>> ...okey, but...
>>
>> > +static int task_finished_pipe_output(int result,
>> > +                      struct strbuf *err,
>> > +                      void *pp_cb,
>> > +                      void *pp_task_cb)
>> > +{
>> > +     if (err && pipe_output) {
>> > +             fprintf(stderr, "%s", err->buf);
>> > +             strbuf_reset(err);
>>
>> ...my memory's hazy, and I haven't re-logged in any detail, but is it
>> really the API interface here that the "output" callback function is
>> responsible for resetting the strbuf that the API gives to it?
>>
>> That seems backwards to me, and e.g. a look at "start_failure" shows
>> that we strbuf_reset() the "err".
>>
>> What's the point of doing it in the API consumer? If it doesn't do it
>> we'll presumably keep accumulating output. Is there a use-case for that?
>>
>> Or perhaps it's not needed & this is really just misleading boilerplate?
>
> Ultimately it is not needed -- I added it as an example to showcase that
> the output is correctly being piped to "task_finished_pipe_output". The
> reset is necessary in this case to prevent the output from being printed
> twice. I'm not sure how exactly else I would go about testing "pipe_output".

If that's the intent then having that reset there seems to me to be
doing the exact opposite of what you want.

If the API is broken and passing the output along twice without clearing
it in-between the two calls your strbuf_reset() would be sweeping that
issue under the rug, that API brokenness would be "repaired" by your
test.

Whereas if you remove the strbuf_reset() it should behave as it does
now, and if it doesn't the API itself is broken, i.e. after calling the
callback it should be resetting the buffer.
