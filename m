Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D9AC43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 12:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiFDMZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 08:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiFDMZH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 08:25:07 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F2A1CB13
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654345472;
        bh=7RdO+hDis5+pdKARTbucxjcETUcquVvO7rzURjcqxqA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZutmWEm43/d3d5CqeqaVtnd2VWC4PSNX3d2motC0tHqPvyUqmEyaxzGYPA8aMs9GU
         DZ6PJ7dT8/RqZpF/NXafio3GXZhNLWFrS54paj0BfvIL7TQDhvunWCrUJKCaBxn+cz
         2B0nFIPP3mV8XhuyfZA2wOvelmmyLmRusj5YVWEw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McIgY-1nNI8S2Gku-00ct4U; Sat, 04
 Jun 2022 14:24:32 +0200
Message-ID: <1de74bf7-0e75-8ae3-6ea7-62939b540061@web.de>
Date:   Sat, 4 Jun 2022 14:24:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 03/15] reftable: don't memset() a NULL from failed
 malloc()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-03.15-0b570d112fc-20220603T183608Z-avarab@gmail.com>
 <693ed3c3-535e-9eae-9fd7-ca612ebf6943@web.de>
 <220604.86pmjpw8h0.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220604.86pmjpw8h0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NCXjWMU3qW95OmIG+5WFI4CY5DjANCL/cw00FMINcHBEQDXDbq1
 Pxj8k7LWTIF8uIJwQjMB0xlG7I2TQrRS2w7usbldgLPzZKNWl0KciDx3VZtlBWHyAo4Yr+f
 sfhddk32KVjkr02BsWDZq7claKdedf/88AYH/IX7PhIPkvHPf3ocQGuiMzvTSeTDA2mGEgK
 6WJmfjLc01zl4OOIUk9zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lxWsNZ/Y0VE=:n76HCICn9oBW8rgYqQ18bm
 0DGj9wtXJMxWGgSPe8JlDiaTECFXoP3pGmoth75O+dCEIirVanJzSvu/1lrjbYpUZJ/PeOKwk
 VntWC6sWS+jAHHb2VGwaA467Tj0/SD41jfUeL76v9WJUUHHlnzYiQqVdjHSLeBq98MRqDnQCW
 o+irRoEosbHeYd1aBiS3FVTUpANFnxHXeWKiCdVJhdJSqKw0XbtQ9U21RErAYQHnqFsjmbTaP
 MjkeVy2egkqmnyCWsq5+e1uiT6iCssvgPt+/LrweL9QoQfd/+v7K8fXEkoFJM/tfxRJLnRIxX
 d1Dl9kzlo/wN+lM2Ia1rtR0W/Jk23FdFfbBtChBEGBegDeAXOsJQXhvbBqtLP26IFWNL3YYzp
 BDGKyo2ljvjuEnwUPAgFwOsQizWV/O+4rWJ6Tm5Dry5gxXpTCtFgfCQOdhAYkln1f+SpKtnm0
 LErvkOfGiFo0ng8Pcp7A9+re/t6dQsCgM9knX/V3WjulXPwSgijsgsd4UWdTAbqF1qRfJzo9w
 UP2HE1zlto51UGwt0+ESieHYJxRdHDj7EF+eXZV6zbQquQ1hjt6m2cF4O/qaH4dUhlXPHtpYL
 OStO3v+1R9vKXqhBbAYniQlORM6Gy5sJP05OfecMEp38EVPjFXDevdsLQ95lc+7eAM+v8AQxo
 FkY256YDG4x1helerAq5oP8s+IvQ9zcrhdA7vyP6PyCLGU9v8GL6uGaSJUgk9sfce7g365EMO
 MRORJowOBn4VPpMd14qjYNYkW+AGRh1Bzp9Uy6fCYxVcJdrOE673JiyBzIsc8ViBMJabGBOnK
 xWD2MzsOfG98pH8e9EFSLy9R6zIxTla7krtixDeCS/8vTmfCtO1GQbNAbiuBPOAMH5pdb5dvh
 rUueIBRTJ9ou8S6Ri6BKehIWOYahMoZarlJxYHvuwhBvX0L80hrKlps9dWqqYn5b6K6kbjefK
 mAMOLXRFTvRkNo5QMD1MnUn0lCYihUuDxyt08YfsFxeMpolte/vF1PHesyiIIX7WVkBKGXhkI
 hvH/TgEyR7QeMx3yIkp9kD0iZNJ97zUlLWxjNgl1lrLGCBgbJo3vToVU0n85b9eu2blznpa3v
 M0bSuoiGrELkFna+4ATawNU0OY4kpJ/jZJ1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.06.22 um 02:54 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> To your comment here & some others (e.g. FREE_AND_NULL()): I was really
> trying to focus on narrowly addressing these -fanalyzer issues without
> digressing into the larger topics "what is this code *really* doing, and
> does it make sense?". It was pretty unavoidable in 13/15 though.
>
> Which isn't to say that I shouldn't fix some of it, e.g. your
> s/return/BUG()/ suggestion, but I think it's best to view these patches
> with an eye towards us already having these issues, and in most cases
> making -fanalyzer happy is a small cost.
>
> And by doing so and getting a "clean build" we'll be able to turn it on
> in CI, and thus notice when we run into new -fanalyzer issues.

Future analyzer reports are likely of the same quality as the current
ones.  If the goal is to shush them then we should just not use the
analyzer.  If reports contain a helpful signal, e.g. pointing to a real
bug or to overly complicated code, then we better address these issues.

We can think about automating the analyzer once we have a certain number
of commits with improvements that would not have been made without it.

Ren=C3=A9
