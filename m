Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90692C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 12:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5B1610EA
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 12:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhDOMcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:32:20 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:38269 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOMcT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 08:32:19 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4FLdy224qLz1qwy6;
        Thu, 15 Apr 2021 14:31:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4FLdy21N49z1sP6X;
        Thu, 15 Apr 2021 14:31:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id lhvAqUMuvngA; Thu, 15 Apr 2021 14:31:53 +0200 (CEST)
X-Auth-Info: tUMJlmjqA/aT6evzCWpHgJR0vehvAvQKPQuFV05zN8hcU1kbKDBaYol/yCZHsKC0
Received: from igel.home (ppp-46-244-183-189.dynamic.mnet-online.de [46.244.183.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 15 Apr 2021 14:31:53 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 8C2DD2C30BB; Thu, 15 Apr 2021 14:31:52 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 15/16] Revert and amend "test-lib-functions: assert
 correct parameter count"
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-15.16-0cd511206c4-20210412T110456Z-avarab@gmail.com>
        <xmqqa6q3cn0s.fsf@gitster.g> <87blafvl49.fsf@evledraar.gmail.com>
X-Yow:  What GOOD is a CARDBOARD suitcase ANYWAY?
Date:   Thu, 15 Apr 2021 14:31:52 +0200
In-Reply-To: <87blafvl49.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 15 Apr 2021 13:32:38 +0200")
Message-ID: <87y2djrao7.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 15 2021, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Apr 12 2021, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>>  test_path_is_file () {
>>> -	test "$#" -ne 1 && BUG "1 param"
>>> -	if ! test -f "$1"
>>> +	if ! test -f "$@"
>>>  	then
>>> -		echo "File $1 doesn't exist"
>>> +		echo "File $@ doesn't exist"
>>>  		return 1
>>
>> What does it even mean to call
>>
>> 	test_path_is_file Documentation/ Makefile
>>
>> with this patch applied?
>>
>> If there were three files "COPYING Makefile", "COPYING", and
>> "Makefile", what would happen when you did
>>
>> 	test_path_is_file COPYING Makefile
>>
>> (without dq around them)?
>>
>> I think this particular medicine is far worse than the symptom it
>> tries to cure.
>
> We'll error with:
>
>     test: foo: unexpected operator

If you want a single argument you should use "$*", not "$@".

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
