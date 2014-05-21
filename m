From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why is --graph --max-count=n so much slower than --graph HEAD~n..?
Date: Tue, 20 May 2014 17:24:19 -0700
Message-ID: <CAPc5daWBKa2kTe6jEcNk2=Xqh+R-mMFqL2tTpHERtPjPkAAvGg@mail.gmail.com>
References: <vnkwd2f8ayea.fsf@mitchelh-linux.qualcomm.com> <xmqq61l0rrng.fsf@gitster.dls.corp.google.com>
 <vnkw4n0kat01.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, jonas@bernoul.li
To: Mitchel Humpherys <mitch.special@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 02:24:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmuKr-0004bT-36
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 02:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbaEUAYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 20:24:41 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:46813 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbaEUAYk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 20:24:40 -0400
Received: by mail-lb0-f177.google.com with SMTP id s7so991989lbd.36
        for <git@vger.kernel.org>; Tue, 20 May 2014 17:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nEMoORXSdfeoKsKkj69feeXV+5t6wpXovIAqaclGdBQ=;
        b=ElWdGda37zlc4KI5I8Mr9r929LRQIrZo4QXn/hKiqBVyowUiFm4Z7/RKv2FGVA9+KT
         WcI+9wP/Ik33tYp4GjP670LzIvwrpm66ewpH2HWtseJ/xBx70qoho7OuyXztYW50Yw1C
         68zcMKwKbZ5r4/GfhxdhWhaHNiOaH2Nb0rR8XOQCoYVnSeObx4VQsbo7fvxdVf4TkB2k
         QjvS/yWg8mlJcPD45VuyySUl6ZUlX6Mx0RH374gffMmiGOhQjbiDCZd5iMZBTY3MbFK6
         1MFI3SCSn49ENNakRPnyuuH7KoPNOeonYwPkLpOU+pvlbjJB+VpbFPtaJeFvlgMy2LQH
         QceQ==
X-Received: by 10.112.148.165 with SMTP id tt5mr4671356lbb.61.1400631879286;
 Tue, 20 May 2014 17:24:39 -0700 (PDT)
Received: by 10.112.17.98 with HTTP; Tue, 20 May 2014 17:24:19 -0700 (PDT)
In-Reply-To: <vnkw4n0kat01.fsf@mitchelh-linux.qualcomm.com>
X-Google-Sender-Auth: tiMl2TQsEdQrM5d2AA2uWGDZadI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249763>

Surely. I am on a bus with terrible WiFi that does not let me use the
usual terminal,
but you would find a code in revision.c that sets revs->topo_order = 1
when it parses
"--graph" option. If you disable it, that would stop "--graph" from
wanting to compute
the whole history before starting to emit stuff (and then stop at nth
one with --max-count).

I do not know what other side effects such a change would have, though.

On Tue, May 20, 2014 at 5:13 PM, Mitchel Humpherys
<mitch.special@gmail.com> wrote:
> On Tue, May 20 2014 at 03:50:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Mitchel Humpherys <mitch.special@gmail.com> writes:
>>
>>> I've noticed that --max-count doesn't seem to speed up `git log --graph'
>>> computation time.
>>
>> AFAIK, --graph wants to compute the whole history and the max-count
>> only affects the output phase after --graph does its computation.
>>
>> Besides, "log --max-count=n" and "log HEAD~n.." compute completely
>> different things, so the comparison is apples and oranges.
>
> Yes, apples and oranges in a black box :). I provided the
> HEAD~n.. measurements just to show that we can get (almost) the exact
> same output another way and it's much faster. It just "seems like"
> --max-count=n should speed things up as n decreases...
>
>
> --
> Mitch
