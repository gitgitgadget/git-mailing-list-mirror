Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5194C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD9F6120F
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhIVRkm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 22 Sep 2021 13:40:42 -0400
Received: from elephants.elehost.com ([216.66.27.132]:60029 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbhIVRkl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 13:40:41 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 18MHd0mq011725
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 22 Sep 2021 13:39:01 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>,
        "=?UTF-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>,
        "'Jeff King'" <peff@peff.net>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "'Eric Wong'" <e@80x24.org>,
        "=?UTF-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>
References: <xmqq1r5iaj9j.fsf@gitster.g> <87lf3q9u6b.fsf@evledraar.gmail.com> <xmqqilys8u74.fsf@gitster.g> 
In-Reply-To: 
Subject: RE: cb/pedantic-build-for-developers, POSIX-but-not-C99 and -Wno-pedantic-ms-format
Date:   Wed, 22 Sep 2021 13:38:55 -0400
Message-ID: <02cd01d7afd8$bb060690$311213b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMuoglFrJd/6yJXr/PiLib+ITjx0wGcUCbiAmfySIyo4jZ40IAAFEsg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 22, 2021 1:22 PM, I wrote:
>On September 22, 2021 12:13 PM, Junio C Hamano:
>>Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>> I.e. complaining about "%m$" instead of "%" in printf formats, it's
>>> easy enough to fix in my case, it's just something I used to
>>> de-duplicate a rather complex format, this makes it C(89|99)-compliant:
>>>
>>>     -       strbuf_addf(&fmt, "%%s%%s%%s-%%0%1$lud.%%0%1$lud-%%s-%%s-%%s",
>>>     -                   (unsigned long)tmp.len);
>>>     +       strbuf_addf(&fmt, "%%s%%s%%s-%%0%lud.%%0%lud-%%s-%%s-%%s",
>>>     +                   (unsigned long)tmp.len, (unsigned long)tmp.len);
>>>
>>> But in general, do we view -pedantic as an implicit endorsement that
>>> we should be using less POSIX and more standard C than we otherwise would?
>>>
>>> I may be wrong, but I believe that construct is widely portable, we
>>> don't use it in the main source, but in the po/ files (so anything
>>> that uses git + gettext tests for this already):
>>
>>Reordering (_("%s %s"), a, b) to ("%2$s %1$s", a, b) is essential to make po/ work.
>>
>>While I do not think of a reason why it should not work, I am not sure duplicating (%1$s %1$s", a) falls into the same category.
>>
>>Any solution that makes the per-cent ridden format string is better
>
>Positional parameters do not work on all POSIX platforms. Please do not do this. NonStop will be locked out of future git releases.

I went back and checked the NonStop case history, which I should have done first. The issue was in wprintf and the fix was deployed, it just never made our development box.

Nevermind. I'm sorry.

-Randall

