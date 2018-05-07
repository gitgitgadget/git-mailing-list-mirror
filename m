Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D42E3200B9
	for <e@80x24.org>; Mon,  7 May 2018 18:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeEGScy (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 14:32:54 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:37011 "EHLO
        homiemail-a20.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752652AbeEGScx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 May 2018 14:32:53 -0400
Received: from homiemail-a20.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a20.g.dreamhost.com (Postfix) with ESMTP id C4A657EC06F;
        Mon,  7 May 2018 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=date
        :in-reply-to:references:mime-version:content-type
        :content-transfer-encoding:subject:to:cc:from:message-id; s=
        novalis.org; bh=vPdK8yN2k8RG45DEj/KDEBJCF4U=; b=lGBWv0lqPktbqLDF
        mItNdyeHEcSIoyoqrwSCu2N7WxYvQlb+5jWlcso5YUktV3xgDuY774OX9EHSyhMs
        vSkZHVz3A8Uq7xaSvQiB4CT8eUtoWw6bTJkWsZGcP8e7qL0qAv57XGV+vOzXy3MX
        kwHx+Nuo3tkH9pzamBwk6vJsZK0=
Received: from [10.41.131.218] (unknown [107.77.244.96])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a20.g.dreamhost.com (Postfix) with ESMTPSA id C037B7EC060;
        Mon,  7 May 2018 11:32:51 -0700 (PDT)
Date:   Mon, 07 May 2018 05:12:27 -0600
User-Agent: K-9 Mail for Android
In-Reply-To: <CAN0heSpfu+070fxhjjccXQpfFnr13O4tvSaj44YWkFWVJL_4mA@mail.gmail.com>
References: <20180506141031.30204-3-martin.agren@gmail.com> <1525621731.16035.11.camel@novalis.org> <CAN0heSpfu+070fxhjjccXQpfFnr13O4tvSaj44YWkFWVJL_4mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] refs.c: do not die if locking fails in `write_pseudoref()`
To:     =?ISO-8859-1?Q?Martin_=C5gren?= <martin.agren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
From:   David Turner <novalis@novalis.org>
Message-ID: <01AF002E-C9E2-48FB-97AB-D9D903866310@novalis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On May 6, 2018 9:56:31 AM MDT, "Martin =C3=85gren" <martin=2Eagren@gmail=
=2Ecom> wrote:
>On 6 May 2018 at 17:48, David Turner <novalis@novalis=2Eorg> wrote:
>> On Sun, 2018-05-06 at 16:10 +0200, Martin =C3=85gren wrote:
>>> While at it, make the lock non-static=2E
>
>> Re making the lock static, I wonder about the following case:
>>
>>       if (read_ref(pseudoref, &actual_old_oid))
>>
>> die("could not read ref '%s'", pseudoref);
>>
>> I think this calls exit(), and then atexit tries to clean up the lock
>> files=2E  But since lock is no longer static, the stack may have been
>> destroyed (I don't actually know whether this is true, so maybe
>someone
>> else does)=2E
>
>Right=2E After commit 076aa2cbda (tempfile: auto-allocate tempfiles on
>heap, 2017-09-05) this is safe though=2E Quite a few locks have already
>been moved to the stack, e=2Eg=2E, in 14bca6c63c (sequencer: make lockfil=
es
>non-static, 2018-02-27) and 02ae242fdd (checkout-index: simplify
>locking
>logic, 2017-10-05)=2E  I could add a note to the commit message to make
>this clear, like "After 076aa2cbda, locks no longer need to be static=2E"

I am going to reply now to keep the thread moving, but I am on my phone wi=
th bad connectivity (few cell towers in Bears Ears), so I can't really chec=
k the code=2E Feel free to disregard if I am still wrong=2E

I saw that patch, but I thought the new logic required that cleanup funtio=
ns be called before the lock goes out of scope=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
