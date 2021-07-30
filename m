Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B79DC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 20:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E5960F48
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 20:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhG3U15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 16:27:57 -0400
Received: from mout.web.de ([212.227.15.3]:40345 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhG3U14 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 16:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1627676870;
        bh=kkj7/7eEOQJm5+wsSzeWbl8JReQ5GAOVz0NYZRPei68=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fWiEVHyrpHuPrNoUO67eUPBNHDpvtAQm7MClwGmHA5n4ZcBsfABAdbV4PKqbc17uQ
         21mpt8gh/82VheYrCDoczIkvBNWgXS76t+w39qoBCUogVf9QZgragT93Vnnv/SfCLo
         kw1VFGaS2ZckLL3ewLAMhZ4lhNkIbn+ZiPoc0INc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.106]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LfAro-1myJ3n2DIu-00opIO; Fri, 30 Jul 2021 22:22:39 +0200
Subject: Re: [PATCH] use fspathhash() everywhere
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
References: <b85ed04f-ef9c-f460-e21b-bd1f8dfba9e2@web.de>
 <xmqq35rv1u2a.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <14653a9b-8999-78bc-03f7-b9f21954b873@web.de>
Date:   Fri, 30 Jul 2021 22:22:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq35rv1u2a.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1a+z/63lLMJKZBrgZjmk23pDFES+d8nqUvyJlpuEq9JuFUhrxqb
 fT4i94XS8z5atPuhPtxfh7gewy1/b76mqy4BtX+AMPGfJ7KgUufNb4LfWHc7Dj82a7Kb1X3
 ZuvAj1UqRA1YogszSCDm6fj+kJXDgPmgkVxdIBhuVv3KzK9eJleYqfCZs1stnjQaWI4sKOD
 RzE4Uk3XEl0wlFm8yQi0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BcScI02q9rs=:8CaYymxvgqPpvUTtRxZ/zk
 xHxjHorzAJD1heEolEbZQrCitS86fzBHeiX6JaVaC0d+iJt0AIlfn42FMPVjeGczQBqXqUsY3
 9zz8cxg6UvmL2xWugsA9LNoJ3maIPjmJ0QPePjneDC1YOKBpiu2kFjnDmxrqctJL778nNf1X/
 cnlPsPZP/td5rT373JATrAlsOmtaV+Q3q8FRW84zrjYcYHOSQc7y7OxNSk+OpR/1RGGYHabJq
 RTS7axsAl+j5Fh04YcOE9dUwVowAhzc/nkeLzLmWzGoxFJe3RdloLffx7cNoAgzMy5O8iHY9p
 olnxSl8TCfM9gasuSIq/ji5FosBKf06qLivqDKAn9ZYQEa4wWW8yMsElLat47yzLbmENeTQlc
 CHDxcQIaKiITBO+8swSIjNZTX7k3SfImXujaaqL2n47t/9W74oc4h5RZE2cgoiU9BiYinUKrG
 NbOL//eOxrdE7XSsTaug+DlPEcR50rzg4E8W9jVXCUrXTgs9dzodbwYy0ShG0viVwznEDiFt9
 SfTkm8KvM9YQx+06NQ/aZ8OlNvyuKyEydPkIJLkCjuYVDQAPPTMoZAuzOFJ8q5wKzMrgdoImO
 uUVxl+n734VuMY4ZKNFAtvdoNOKzVmuQGW4uiY1FHvGjtPA7KR8dBWSusppzEp5EDi4+vh7v1
 dJZSuyElNH/jjiRNKNAr5Pqn83uRm4wz4owMdjUtoLmaOHGmmHBLuXhRmG8RPv4m7hto/ydRX
 aUC82BS9knP7YYm75SjUx2TYjqeZ5NIsI+Bg/vanfLqv79oOaKRMpHFwwaZdB3NIIqyZzrs7i
 NUK0MwYAmSZ2sZ9oYhIX1P/VHxzi5sTQp8FaCCOe2giFafszNysjFPGyRlnj5eqa9vFFpJshY
 Xe8ZGEBgIuSPLQgTrO+1Tam2/CSgOfXWxgUkF3cfamZxz5jWQWo3L0fabxYv6lSQBZ50Qo+fj
 UeuN9bikI7xC5rf8kbF0Y0qKtiMSQB2d39FTtHoQbFkwjPIQvdZQkjV4QeaVg+U2lpB5DsUA6
 tyPO2kE0ILH8LDBNOoPo7Vhb4d3BKPWAwOs/1549duUpgKnHtiyFM96mT0VcopFnqsj4dahRy
 JQLsrNnK5pdb7CsWhCTs8ReYKyV3sp8dQHB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.07.21 um 21:27 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
>> introduced the function fspathhash() for calculating path hashes while
>> respecting the configuration option core.ignorecase.  Call it instead o=
f
>> open-coding it; the resulting code is shorter and less repetitive.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/sparse-checkout.c | 10 ++--------
>>  dir.c                     | 13 +++----------
>>  merge-recursive.c         | 11 +++--------
>>  3 files changed, 8 insertions(+), 26 deletions(-)
>
> I love this kind of "now we have this thing available, let's use it
> at more places" clean-up patch.
>
> Was coccinelle involved in finding these places?

Just git grep this time; there were not enough hits for me to consider
writing a semantic patch.

Ren=C3=A9
