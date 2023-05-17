Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54A9C77B7D
	for <git@archiver.kernel.org>; Wed, 17 May 2023 18:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjEQSGj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 17 May 2023 14:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQSGi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 14:06:38 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1392C83
        for <git@vger.kernel.org>; Wed, 17 May 2023 11:06:36 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34HI5Feo2770884
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 18:05:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Christian Hesse'" <list@eworm.de>, <git@vger.kernel.org>,
        "'Christian Hesse'" <mail@eworm.de>
References: <20230517070632.71884-1-list@eworm.de> <xmqqwn17q7ou.fsf@gitster.g> <ZGT6fEZFumAsZnxu@nand.local> <ZGT/eK6+IKlCM6Sg@nand.local> <xmqqcz2yrjbe.fsf@gitster.g> <xmqq8rdmrixc.fsf@gitster.g> <ZGUVvjG+xou3w8YW@nand.local>
In-Reply-To: <ZGUVvjG+xou3w8YW@nand.local>
Subject: RE: [PATCH 1/1] imap-send: include strbuf.h
Date:   Wed, 17 May 2023 14:06:24 -0400
Organization: Nexbridge Inc.
Message-ID: <016701d988ea$4e4ffcd0$eaeff670$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNCvfHGg6mwyi4A2rl62H/zgjrb8AFjxtXPAggd4roCWVvaKAEHH+70Aq+7NJYBrkdDuawzBLXA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, May 17, 2023 1:58 PM, Taylor Blau wrote:
>On Wed, May 17, 2023 at 10:01:35AM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> >>         if ! gcc -I $(pwd) -E $f | grep -q 'struct strbuf {'
>> > ...
>> > What does the above prove, more than what your regular compilation
>> > that does not fail, tells us?
>>
>> It is actually worse than that, isn't it?  This does not even use the
>> definition in the config.mak.uname, so it is not even matching your
>> build environment.
>>
>> I am uncomfortable to use this as an explanation of what due diligence
>> we did to convince ourselves that this fix should cover all similar
>> issues.  Perhaps I am grossly misunderstanding what your investigation
>> did?
>
>Oof, yes, you are right:
>
>    diff -u \
>      <(gcc -I . -E imap-send.c) \
>      <(gcc -DNO_CURL=1 -I . -E imap-send.c)
>
>How *should* we test this?

I hope not by using gcc, which is not currently a dependency. Using the C preprocessor directly might help in a more general sense, but you probably will need a knob for some compilers to work.

