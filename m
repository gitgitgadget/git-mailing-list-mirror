Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24ADE1F51C
	for <e@80x24.org>; Sun, 27 May 2018 11:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755198AbeE0Lxj (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 07:53:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38822 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755142AbeE0Lxi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 07:53:38 -0400
Received: by mail-wr0-f195.google.com with SMTP id 94-v6so15976695wrf.5
        for <git@vger.kernel.org>; Sun, 27 May 2018 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P+EyAPtKj08XT2HJM7hUF0Af+SxktcJpSflpZxzy2ls=;
        b=r9EO+UEQWK5Apobw8gACRYFSLT68XId2+GihxQcUS1xws7NyJDxUcMRcaGjYg8QU/S
         xw0b7X+kTLGmykGvQ5XyVh5jxegmsAd+SZyMdy/2BdLcMPiSvZJ8Cv7m2laYh7/F2S7o
         WV/FmPpmZXldQu0yVX9sAsHSRJuQkDNEI3t+T8M1IFgodPm26Wg5TrEjCY2FFTcX2IHr
         8buJcKOiWxyumD5PrhLOBOoc4DJlT7KFPrJ1POc4b2xCe0xYHOEfXF4Ju2akOfg2K8ps
         XD92DqRmxI9MzTZ/wtxSEL8KsBU0101QoNkLO9l+zVzr5iemdRJBBtWFNn2w+SzOvCnB
         vrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P+EyAPtKj08XT2HJM7hUF0Af+SxktcJpSflpZxzy2ls=;
        b=IIZbsfkCghKwDkNYqkhzeCi38+HaxyPIJOr0/b5pNpyBhBPS+fkS1h3q3+dEX7Nw/g
         Iw7vPWZ4Dxw3FkLuhxp5XEko6O7ADsW9+qmeWsWClnMZCvf95SiiqtWL74WQyFq1cfVn
         QHKUC9504j4TGn2e6IpukKaNiyvVVrEewfz+yZzNo7L5CAo0n2TpCTaKaAAJ4snMujG3
         2TkJWV6i+ACPEimBHzgRrE5chfLDBmxXJHm45K8UQj+xzB6C8xLcHZBmdlZdLWuG7G29
         DljM0wsF2RbwuCpBPHz/koYZsMYdwmoJUmfB8NGnUx3OJJppe/FyjPWIOtCnkfYZEVqd
         xKJg==
X-Gm-Message-State: ALKqPwfQgalDcX5uzcWOXAl2SOR4/aLLpmOTXDJJBar4bi5zkRXF3t1i
        GEBsgaeL6gkHKwkvLChoWxp1rpA3
X-Google-Smtp-Source: AB8JxZq3rnAA7pChekyqJ0uMVEGULj01gXCz3igZ+saqsK5OAN+JP1Md5Ldh3hgoJyBcl1yjWdA5/A==
X-Received: by 2002:adf:c08a:: with SMTP id d10-v6mr6739523wrf.268.1527422016989;
        Sun, 27 May 2018 04:53:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g78-v6sm14233209wmc.27.2018.05.27.04.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 04:53:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeremy Linton <lintonrjeremy@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] packfile: Correct zlib buffer handling
References: <20180525225601.22575-1-lintonrjeremy@gmail.com>
        <CACsJy8C4zNZAe6Vw-mz8r8HueYdQKs4ZhMOQYX0v7ypfHdmShg@mail.gmail.com>
        <xmqq8t86m0m3.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CNmDkxzhkdfwjVHjGF4JeUzzPHGnp1x647NxU-GxkxvA@mail.gmail.com>
Date:   Sun, 27 May 2018 20:53:35 +0900
In-Reply-To: <CACsJy8CNmDkxzhkdfwjVHjGF4JeUzzPHGnp1x647NxU-GxkxvA@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 27 May 2018 07:02:05 +0200")
Message-ID: <xmqqsh6dl3gg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, May 27, 2018 at 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Sat, May 26, 2018 at 12:56 AM, Jeremy Linton <lintonrjeremy@gmail.com> wrote:
>>>> @@ -1416,7 +1416,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
>>>>                 return NULL;
>>>>         memset(&stream, 0, sizeof(stream));
>>>>         stream.next_out = buffer;
>>>> -       stream.avail_out = size + 1;
>>>> +       stream.avail_out = size;
>>>
>>> You may want to include in your commit message a reference to
>>> 39eea7bdd9 (Fix incorrect error check while reading deflated pack data
>>> - 2009-10-21) which adds this plus one with a fascinating story
>>> behind.
>>
>> A bit puzzled---are you saying that this recent patch breaks the old
>> fix and must be done in some other way?
>
> No. I actually wanted to answer that question when I tried to track
> down the commit that adds " + 1" but I did not spend enough time to
> understand the old problem. I guess your puzzle means you didn't think
> it would break anything, which is good.

No it merely means I am puzzled how the posted patch that goes
directly opposite to what an earlier "fix" did is a correct solution
to anything X-<.
