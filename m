Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DDBB20248
	for <e@80x24.org>; Tue, 19 Mar 2019 14:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfCSOGv (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 10:06:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41812 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfCSOGu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 10:06:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id a25so9495948edc.8
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bmA/8wAiqE37ByeiEAnjtIVKqZfSTSqL4oitZoCVx2M=;
        b=DATTB8+gh+Lnh2ujWdydPr1P8K7RieIYeKMCBQHTZEeTVdOFnhvS/7Xr9otMkOJ25L
         yexp+rPE0YW2iUYAFvLGNGIKaiI89ckiNUw+m9novdhsClKrp9YkIlVvSFYKbwHar79c
         cr6P7c+nNGD5YJK/x+sMk5QmvJ/WfnIsLMo9/m4q9N1Yo6RzTP4Ou3uIFo8XO1plnDeN
         Un/llMSrpqiY5kslEYlOvz0ECa7sSCJCBEmy5uYzh3QDUJkIaXhe6VU8nUFcSBYlxhsL
         EFT2ta5eQceWa3D9weA8H9N7BtkZ8SSawtCOinHOOqpeI/McNL+c8RCoOx4mASZrwL2z
         iyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=bmA/8wAiqE37ByeiEAnjtIVKqZfSTSqL4oitZoCVx2M=;
        b=dbd63aI7zJ90G6MzptA1ncUqMXgZ8G9Mkn8e+NsELkC/edIqlDNTZuAJUY8sAxeVRy
         jAOYQmdZoqFgPVnE433c1Q+wfiyVjim3+fV6puqiN0KIBroPLKrABnpwndORmw88ySsP
         NzaFKHSpm/o+xTF9dWGz1RDdvVTAqOpmShUdTeqdqyeKbDtWGBfV5StZdWJXaCEOKD5/
         18ECxR5M26ngPNM4PxtHFdrGcCeTYWclWJq9X3MOittPovycOtZ9drCg9Wv3E1RnC2pv
         t+F2su2wCDmUA2slfT1dJbfxyfSMH0QUesTmMFFDXiZ10MUz3GCA0nHjxteYkNflX5Wr
         ZoUQ==
X-Gm-Message-State: APjAAAWMKUrRCnpslIMxZYbuJNsTbg8C2949lr8C9dAME+GDMYtGmCYK
        L21tVjootnhtlCP2Pno4H0g=
X-Google-Smtp-Source: APXvYqxICAMLpwSugb9PShBR05CFwZ8LkteDKG5GY/kU9R3CHjvOit61veyOWrxMxMXV4D6301cd1Q==
X-Received: by 2002:a50:cac9:: with SMTP id f9mr16656562edi.225.1553004408231;
        Tue, 19 Mar 2019 07:06:48 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id x4sm4023645eds.63.2019.03.19.07.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 07:06:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/3] midx: verify: group objects by packfile to speed up object verification
References: <pull.166.git.gitgitgadget@gmail.com> <86f6b0325821a9e1742a28895f9c9b712a1fdec4.1552919394.git.gitgitgadget@gmail.com> <87pnqodvr9.fsf@evledraar.gmail.com> <9c4da72d-6066-8d05-f181-a93c3926705f@jeffhostetler.com> <87lg1bet9d.fsf@evledraar.gmail.com> <d3f119b1-22f6-e34a-a68f-883aca3d8013@jeffhostetler.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <d3f119b1-22f6-e34a-a68f-883aca3d8013@jeffhostetler.com>
Date:   Tue, 19 Mar 2019 15:06:45 +0100
Message-ID: <877ecvdklm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 19 2019, Jeff Hostetler wrote:

> On 3/18/2019 6:02 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Mon, Mar 18 2019, Jeff Hostetler wrote:
>>
>>> On 3/18/2019 11:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>
>>>> On Mon, Mar 18 2019, Jeff Hostetler via GitGitGadget wrote:
>>>>
> [...]
>>>>> +	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
>>>>> +
>>>>> +	for (k =3D 0; k < m->num_objects; k++) {
>>>>> [...]
>>>>
>>>> I have not tested this (or midx in general), but isn't this new QSORT()
>>>> introducing the same sort of progress stalling that I fixed for
>>>> commit-graph in 890226ccb57 ("commit-graph write: add itermediate
>>>> progress", 2019-01-19)? I.e. something you can work around with a
>>>> "display_progress(progress, 0)" before the QSORT().
>>>>
>>>
>>> I wasn't tracking your commit-graph changes, but yes, I think it is.
>>>
> [...]
>>>
>>> There is the dead time while the sort() itself is running, but at least
>>> there is isn't a 5+ second frozen at 0% message on screen.
>>
>> Yeah, the same with the commit-graph with my hack. I.e. it'll sit there,
>> but at least it sits like this:
>>
>>      What I was doing before 100% (X/Y)
>>      What I'm about to start doing 0% (0/Z) [hanging]
>>
>> Instead of:
>>
>>      What I was doing before 100% (X/Y)
>>      [hanging]
>>
>> So that's an improvement, i.e. you know it's started that next phase at
>> least instead of just having a non-descriptive hang.
>>
>> Ideally there would be some way to reach into the QSORT() and display
>> progress there, but that's all sorts of nasty, so as the TODO comment in
>> commit-graph.c notes I punted it.
>
> Perhaps I'm confused or this is a Windows issue, but when I do:
>
> 	progress =3D start_delayed_progress("sorting", n);
> 	display_progress(progress, 0);
> 	QSORT(...);
> 	stop_progress(&progress);
>
> I never see the 0% message.  It always does the hang with the cursor in
> column 0 on a blank line.  If I make this a regular start_progress(),
> I do see the 0% message for the duration of the qsort hang.
>
> I did some similar testing around your QSORT() in commit-graph.c
> and got the same result.  It looks like start_delayed_processing()
> wants to wait at least 2 seconds before displaying anything and has
> an interval timer to notify it that another message should be printed,
> but the display_progress(0) prior to the QSORT() arrives before the 2
> seconds are up and so nothing is printed.  It's not until we get into
> the loop below the QSORT that one of the display_progress(i+1) calls
> could cause a message to appear.

Correct, it'll still hang the N seconds that start_delayed_progress()
imposes.

In the commit-graph code this would sometimes take longer than that, so
I'd see the 0% earlier.

But maybe in this case even on humongous repositories it's faster than
that.
