Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4567C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 12:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63713610CA
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 12:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhFTMzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 08:55:23 -0400
Received: from mout.web.de ([212.227.15.3]:48399 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhFTMzW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 08:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624193586;
        bh=Bj7Bv3bVUSofb7/WCSYst2M0L355RT9pi5GEI0SVX40=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GFXGehOAsz1rK3pPjymtZQyicLUiYAxrw9CeMGC4BzCFS6yQKNgzmJ6/Pn4Brpbbf
         waZgKfzogTTavokyo1d/fJcuj9ZHhfAprtkmTIQYR9uODb1pz9c9Erf+0PFwKCixMY
         qea4SlcCmvtVlmgYsJsr1pi2daR7H0UxBoiGIPJQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MPaII-1lhFZr3VGE-00Ma0u; Sun, 20 Jun 2021 14:53:05 +0200
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
 <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
 <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
 <87k0n54qb6.fsf@evledraar.gmail.com>
 <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
 <8735tt4fhx.fsf@evledraar.gmail.com> <xmqqczsxtf8g.fsf@gitster.g>
 <87wnr4394y.fsf@evledraar.gmail.com>
 <74183ce6-e17f-1b11-1ceb-7a8d873bc1c7@web.de>
 <87lf7k2bem.fsf@evledraar.gmail.com>
 <f5e181fc-af94-bccf-051f-a58a04fe1ffc@web.de>
 <87zgvszo8i.fsf@evledraar.gmail.com>
 <4f251a35-8b5e-30f0-c742-960cb7c30b57@web.de>
 <87o8c8z105.fsf@evledraar.gmail.com>
 <34d5febf-508c-52b8-a04b-98298d75bd8d@web.de>
 <877divystm.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0a30d7f3-1718-f2c5-39ab-75acfd754d9a@web.de>
Date:   Sun, 20 Jun 2021 14:53:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <877divystm.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gf//yE/hiYrRoeaMT28Np2hkTdRzmH5HC3E9xwTG4SQe2brDTUZ
 46y4VEVe65S9jC/kowz3vjAYcShhGC0MYXkN4GIB+fTECgt8tiyoeuEcH757RBohw1TOl8U
 q4lpTSgyw7BaIO9CNoG70TsKR3o/tZBW4VanO6AD7JGssiNWlgueTjNpeBbSEsLKDxb077R
 zRu/uHO8dQS0Iz6xjIk8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:buoEBFDb4i0=:M4YCxt9QmaYsFc6qx0qW3m
 F35M7JcE3fkEXbfAodxn7NbGnG5Fx3F8Xe8BoBW9fpBP+arNgl6SA/EV+Ed/k0nOtlthvArUM
 xTAYNOrEl/beqjuJEqsmUwpYrEqjG4TnrQEajX//llORcP0LS5N3jeN2vpGG6nCKSH/wyVjiG
 P8t2wDyuSyoCL7ok+Cp1XCdL7KAlIfEIRZZatfWagZutFgqKi6L6j+j27JFDDpzvt7vI9xEU1
 MRP/p/8/N0v0jM0dC18LaojwuHULpHMcB7LlGnL7D976Pgo/1blu4nKFnofS0Rha9poUl4DvX
 QebKzAkKmEDx73f70Bx3eRtIYWqYxF6MKshrqAitPEIP2YJ60zl7X8QdMLK+8nN3KiymqeoE0
 B7G32sM2W7K89s37oC5qiQT/RY0T3K8QOMAQotuRvu4TP2kiXtvuBO+l0xtOnF1tszQM88MWw
 BqPwS2z7YTuVMrThT6MV7aCqOpx8A6E2YriVDT2ChiNCEHyDqfoNx2fm4Y0gUbPFllKE+/7Z9
 iQXDhgHrNI28651H0Lj8WSFIV6RSk+YTw7G6kx2YVStB1rJ/f1DspW2nRt3Zm+fNfJ1YlkR2F
 D04v03GlU21Qgdgwi8c4mATDaIU3rCFZ5P0vPJjQ5ED0LDK9UQWI15+12xzyyAGFKHbuvAgQA
 nRVL5YFalMiT/w7GaW+DsELd/yQA61yFnLDTBc00/I5Qv/CSXnWUudaDjr5p2QLHuuRrO38ly
 sPbw2ZcDFELZ8l9qYs0dJrPYtRSNSEMI1tdmdJ+5ELgemg+IeR2tXS16vY5TRYU3ZtY+5FxBn
 vkestCXXB2PQzBy7cl++nGktW7Na/ZWtGifzJLo2RWSInvPtO7STLMDpZY+kaj3OOJPCLHvAo
 SRYEA1y/7VFTLNB1YMADGy3h+xlig5NryPuWHhDCVNaMRC0PPHRkaNePeqPlnAFsw794zic1G
 KDkhlPp+h81jIbtUFQdZq4OyEHhmCg3vOTl4W9pEz2ZDq3fOdODosMJE1uWCPmRCnVts2rGjm
 ybc7lsKRGGJ7GUq2gCSMIyQA0CAEfDbaFjUtH4oZQxVb6+GTcKWNGd9uKxSUr/3rNHmVQKWti
 Ld9rFVgvi2mo00GnnJ0/W0ZEPTqX52xwyyF
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.21 um 18:46 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> We disagree, and I for one think I understand what you mean, perhaps you
> don't understand what I mean, but let's try to move on.

Perhaps.  You seem to think of progress as being represented by a real
number.  We show integers, though, and you want to round up.

The progress display's function is to inform the user that work is being
done and how much there is still to do.  It allows them to decide
whether to keep the program running.

A progress of "100%" being shown for an extended duration would lead me
to the conclusion that the program hangs and I'd cancel it.  Rounding
down (truncating) prevents that.

Showing an estimated time of completion as well would be even nicer,
but is only practical if the time taken for each work item is roughly
the same.

But let's move on indeed.  The part of your patch that moves the
display_progress() call to the top of the loop to avoid stalling is a
good idea and worth splitting out into its own patch (keeping the "i").

In general it seems that changes described with "Let's also ..." or
"While at it ..." almost always deserve their own patch.  I need to
follow that insight more myself..

> I think it would be better if you replied specifically to the comments I
> had later about throughput progress bars, i.e.:
>
>     How does the idea that we show "has been done" make sense when you
>     combine the progress.c API with the display_throughput(). I.e. outpu=
t
>     like[...]

Junio already replied to that, but since you ask, here are my thoughts:

Progress and throughput are separate metrics.  Adding one doesn't change
the other.  The throughput value is not specific to the currently
processed item.

Say we download a number of files of different sizes and want to show
our progress.  Then from time to time we display the number of processed
files and how many bytes we got since the last update, divided by the
time passed since then.  The reported bytes could belong to multiple
files.  Or we could process lots of zero-sized files, which would keep
throughput low.

> Anyway, in this case I understood you to mean that you thought the
> off-by-one wasn't a big deal in practice most of the time, I don't think
> so either for e.g. counting objects in pack files.

Not exactly.  While I think a difference of one isn't a big deal most
of the time, also think there is a correct way, i.e. to show the number
of completed items.  You have found ways to use an off-by-one error, and
my point was that this usage is not reliable.  Perhaps that's a weak
and convoluted argument.

> I do think it's useful to be consistent though, and for e.g. cases of
> downloading 5 files it makes sense to show 1/5 if we are currently in
> the process of downloading files 1 out of 5, not 0/5 or whatever.

I agree that we should be consistent.  If we have downloaded 70% of the
first of five files then we have 0.7 files, which is not yet 1 file, so
we have to say 0/5.

But let's move on, for real.

Ren=C3=A9
