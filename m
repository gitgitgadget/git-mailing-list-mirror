Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CDDC43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 13:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37D920809
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 13:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWJbcBjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgITMy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 08:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgITMy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 08:54:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D135EC061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 05:54:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d20so12123797qka.5
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JaC3RMxQL7CTeVNn5wG5Dz+3X02ydnY9tEXU2btuwE4=;
        b=cWJbcBjOh9wHQQ2LUvy0vdU5PkuJMzaJCtAAt+xloW0NdSG1tLeM5SDYa9thmJtVK6
         5to052EWS5wQVFDE6m0cg/4q6fC/eHvzVxoLXLyT7/Gj7P21GcHogFZZQk5jAQIGvk7O
         V35YfzQWqok/kJPz7xgfJHQAofMPZltUMmSNgbcm3ebVifvjMstOidu0f5o3FsdwIvic
         SY9raSKSQ6Rt55OAeZO/CSzLxkmHliyle/WSXtpnbZXJBC+8OywlG2W1puntBoKDUOcF
         jXFS6VT+TJi288tuJoIW3XL0D1ooM8CBB7MMjDY5Bo9eeUHQROfReCaJueVWTCcCJeD0
         sC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JaC3RMxQL7CTeVNn5wG5Dz+3X02ydnY9tEXU2btuwE4=;
        b=fc4+fGNas7ipAGwUlY6OnGLtNbZYsFT0IXiovz21gF5Zyr2+zZUrgokF/NwYGON+7i
         +WT2sEgssaMnaJOapE/bWDTJUI9TuXG5fwTI+3VdT56ZPQqMroOFrw6LkPn+f2LWxxD1
         kX2CAii7SJhGzquTwEotaMLgzQS/t/LPqz7DPmdIOzHcEYN3LDgzhf9Z9N/uWgPpavHo
         EBZOiwdk68ISyR0kEC0jBhj7R3l+MUkDcPMn8A6gZn0H1/OgClnNHAwsSd5Vv5Uk6Mtl
         XQ/BoglZ5d5T45Lfk+i6SEl0wsxjpzctrpXY32LfZ28FRhNlGCbHD9ci0/DNWr6vUSAp
         LedQ==
X-Gm-Message-State: AOAM532A+9p2+is+rO5eiVkny4JwoAY/1Lr0JWR82LxEO2FGof9j/DFm
        6daQU5HTHJgS5KVGP1kh/tc=
X-Google-Smtp-Source: ABdhPJxJmaZrweK8Buc2xUGViQda54gHY2qDm97UWuy2o3JTRtJ+HIt08FiaQxWKPLMaooyEd6sc5A==
X-Received: by 2002:a05:620a:1297:: with SMTP id w23mr38817598qki.345.1600606495612;
        Sun, 20 Sep 2020 05:54:55 -0700 (PDT)
Received: from [192.168.67.200] (dsl-216-221-52-235.mtl.contact.net. [216.221.52.235])
        by smtp.gmail.com with ESMTPSA id f13sm6165423qko.122.2020.09.20.05.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 05:54:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff
 --no-index
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-3-tguyot@gmail.com>
 <20200918143647.GB1606445@nand.local>
 <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
 <20200918171950.GA183026@coredump.intra.peff.net>
 <xmqqbli3m0w6.fsf@gitster.c.googlers.com>
 <20200918180239.GA186717@coredump.intra.peff.net>
From:   Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f338b63f-fd89-095c-b036-8d548fd2470c@gmail.com>
Date:   Sun, 20 Sep 2020 08:54:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918180239.GA186717@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-18 14:02, Jeff King wrote:
> On Fri, Sep 18, 2020 at 10:48:41AM -0700, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> Getting back to the overall feature, this is definitely something that
>>> has come up before. The last I know of is:
>>>
>>>   https://lore.kernel.org/git/20181220002610.43832-1-sandals@crustytoothpaste.net/
>>>
>>> which everybody seemed to like the direction of; I suspect the original
>>> author (cc'd) just never got around to it again. Compared to this
>>> approach, it uses a command-line option to avoid dereferencing symlinks.
>>> That puts an extra burden on the caller to pass the option, but it's way
>>> less magical; you could drop all of the "does this look like a symlink
>>> to a pipe" heuristics. It would also be much easier to test. ;)
>>
>> Yes, I do remember liking the approach very much and wanted to take
>> it once the "do not dereference symlinks everywhere---just limit it
>> to what was given from the command line" was done.
>>
>> To be quite honest, I think "git diff --no-index A B" should
>> unconditionally dereference A and/or B if they are symlinks, whether
>> they are symlinks to pipes, regular files or directories, and
>> otherwise treat symlinks in A and B the same way as "git diff" if A
>> and B are directories.  But that is a design guideline that becomes
>> needed only after we start resurrecting Brian's effort, not with
>> these patches that started this thread.
> 
> Yeah, I think I'd be fine with that approach, too. It makes "git diff
> --no-index" more like other tools out of the box. And if we took brian's
> patch first, then we'd just be flipping its default, and the option it
> adds would give an easy escape hatch for somebody who really wants to
> diff two maybe-symlinks.

Considering the issue with MacOS I'm starting to think the best solution
is to not use any heuristic and read passed-in files directly. That
said, I don't think it makes much change either way (if I resurrect
Brian's patch is will probably end up being a hybrid between the two as
both read the pipe at the same place and my approach was simpler further
down).

I'm not sure which way I prefer to start first - will you accept a patch
that reads passed in files as-is if I I start with this one?

In the mean time I will submit the first patch fixed) as a standalone one.

Regards,

Thomas

