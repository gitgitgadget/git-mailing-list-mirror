Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44344C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 16:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1600960FD9
	for <git@archiver.kernel.org>; Wed,  5 May 2021 16:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhEEQUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 12:20:19 -0400
Received: from mout.web.de ([212.227.17.11]:44767 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233902AbhEEQUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 12:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1620231547;
        bh=z8thELXMQCunAwQtVVlVkK5/XK60A7KHwtKVtR7E390=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QTzUS2fC+CprjGXX1CXl+7RhsoISM6ks0gQDWDwpMIBzE3pSwulw23UuvZu1chAU8
         GNXGa9BehvR4R1n5siY3fLIbx9jbS3iULyMxPW+fn9AcyPsrE7B7WQqHyMdexvfpNO
         nvb0/FxRyeF/OB2xBde4TQp9w9mJYZY4bN3+NPaA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M8T7K-1lZwWB08KO-004VHC; Wed, 05 May 2021 18:19:07 +0200
Subject: Re: [PATCH 3/5] pack-objects: clamp negative window size to 0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org, Yiyuan guo <yguoaz@gmail.com>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
 <YI1fubjvQQlrPz9D@coredump.intra.peff.net>
 <3d77d70b-2cc5-4ca9-8753-fa9af5111842@gmail.com>
 <YJAOzTIXkO2lhxSs@coredump.intra.peff.net>
 <02a66bfb-aac0-c05e-dab3-366bc312d900@web.de>
 <874kfhwfwz.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <aa21321a-08d8-5a3a-0ccd-4f4ea4bf7a9c@web.de>
Date:   Wed, 5 May 2021 18:19:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <874kfhwfwz.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0xLHgQWJ0Esq+pt67zBah2TnjihPIKzYSVzoRWAjp8jlBNwvZor
 n1XRBVHvu73vQERtA0OXGXF43VGbXrb6Sd0KoYVSv1nS4OhclCb5WdRMp0mnUu9uIalrcWk
 3cued5Uzu8ISH3SJAelG8wwrmqgIuq1p9Mch2kKs9GSlLWJZsaIoFpvOsoK4SHV0v2woexL
 GhdWe+02oQcbCvTxlstJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aDCZ6ZttPT8=:D4OOLqLvqlAaRG+z73grum
 XoHva/xE8JfINYNzdj1d/V7d+bq2iUvjVJOMwOSOm/RHocL+pWIVanE5Kk0LTPe4auro25dIc
 t7buEgkPSZDc8q07HjmZt1iL0z9DhXQ0uj9rdSAsmmcQZoZOrIpKAuK1TiBTsQhtbZJbUShoT
 CcagY2G94DpFnfoH1Nw6WWBeY5nHuPNJopGR5YZU+Ef370RxYihwfZRR1Jjs/WzrklpQO9eeW
 hOaEaGmNqoGWHOBTHhhKTkXiR/E+GEINZZzWiUVaqtDpAlh/HCl7f9/uVCrMAXzbPV+nUg4iV
 Jb8/VQNxrLNmn9ZTUcCNF43jJNBu0KP7UU+wlTxNvmXt9QuiNe1YFJh1bHIwJIFmgbPmdOL4C
 oFFzNqjRSa/+eVhreybnU6mNVgAAgCIFIYjOAuN8H7qb4rA65Uc7gpyHqrunwv9kgkhBOtymg
 0OasZ4nI8l8frJ/NuoDDWh9Fzev51jaqygmImNWHmYQLF/Z7bFYv4Eig1+kO0AC1n85q3bI5i
 8kh65PT7U1GhRfuMcqt3sKkri/gMjdmSZqUVdi//Ed7IP7Li3Ofuio+ZiG0XDwprPof5+n6PY
 sIDViw1QxMH0UePcYViM5aVvY0H6jfdt1ztjB44rQhre4VLILcscHDxlezX4MFopptX6PBwUy
 qY5A5FNdtaQh+yFmkOemv2kBBUIVATWFKt2uEjmvYdwVoXzuvPB1h5OKdVetpVhIWDyXMYvMe
 yPXZL+2HgFmrvAafF+CqEzrHcqlRJ5favBEwwcSKEiIsvqZMWVVmsh1nAlfOYV9neErQ19m+6
 0tYxgnmf2lLXUpC0QtX0YoDpfp7z5xB3L+AVM3cR4c7hghVPE9XBbs6nh5pfjpW8J+lmcabLg
 cZlxfpo4zvC817GalxyIzLwOsKPWsQsgH/y070yzr3prh1GpZpRMoLFPzahfH9gXN/jGwWaY5
 C/0IDhsdiWGqaj6AnGUT2z9gh3lACfhklzHoh6ppMuTbhx/jBvM9HFxQCY1usdYLNmhohHk3h
 2gbNT4dcLc9nIFxmrQrfRDuba5KGkWmDysIrQGg9FGlNrkAysHevlStzi5dt8cgEFkc+IbYhN
 4x4v6ZBOx6Tu9zz6xNW2ICs4mWgDFOH9J76UFzNVHem/UGAL8lJuPsEfXj67q/h3VztC5aI5j
 1uXXqmIRgZy+vxKYYcuATe01BSnvk4VAaZYtN6sV2grvos48uVqTi8Sbblavj94GaUcgw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.05.21 um 13:53 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, May 04 2021, Ren=C3=A9 Scharfe wrote:
>
>> There's another option: Mapping -1 or all negative values to the
>> maximum:

> That seems sensible to expose, but I think should really be
> --window=3Dmax, not --window=3D-1. The latter feels way too much like
> assuming that a user might know about C's "set all bits" semantics.

Nitpicking: Setting all bits for -1 is done by two's complement, which
is just one of the signed number representations supported by C.

But yeah: A non-numeric value would probably be better in general.  As
Peff explained it's not a particularly good idea to specify the maximum
values of --depth and --window, though, so no need to make it easier.

> The one example of such a variable I could think of is core.abbrev=3Dno,
> which could arguably benefit from a core.abbrev=3Dmax synonym.

core.abbrev=3Dno turns off abbreviation, i.e. you get the full hash
size (false and off work as well).

Following that logic, core.abbrev=3Dmax would ask for a maximum of
abbreviation, i.e. for the shortest unambiguous hash.  That would have
a length of at least 4.  This value is stored in a constant called
minimum_abbrev -- which seems backwards.  The implied negation of abbrev
(the more you abbreviate, the shorter the length) is a bit confusing.

> Another one is *.threads, e.g. grep.threads, index.threads. We currently
> say that "auto" is like "max, but I can see how we'd eventually benefit
> from splitting those up. I sometimes run git on machines where that
> "auto" is 48 or whatever (I haven't benchmarked, but that's surely
> counter-productive). Having max !=3D auto in that case (but still having=
 a
> "max") would be nice.

Good thinking.  What is the maximum number of threads?  Certainly higher
than the number of CPUs.  Would that be useful?  Maybe -- on a
single-core VM with an SSD queue length of 32 we can probably benefit
from running more than one thread.

Are our threads CPU-bound or I/O-bound?  I guess the answer is "yes". :)
How do we even find out the disk queue length in a portable way?  And
how would we calculate the optimal number of threads?  Are these even
the right questions to ask?

An "auto" option might help with that.  I imagine it starting out with
some default value and then experimentally decreasing and and increasing
the number of threads to find out which one works best.  Downside: It
would need to have comparable workloads for that.  And these benchmarks
need an otherwise quiet system.  Similar battery level if running on a
laptop.  Same system temperature.  Impractical during normal use.

Perhaps a "git benchmark" command that runs some synthetic speed tests
to tune grep.threads etc. would be possible?

Ren=C3=A9
