Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65960C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C3160EE9
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhI0V6K convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 27 Sep 2021 17:58:10 -0400
Received: from elephants.elehost.com ([216.66.27.132]:54503 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbhI0V6H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 17:58:07 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 18RLuGrC019794
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Sep 2021 17:56:16 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "'The Grey Wolf'" <greywolf@starwolf.com>
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net> <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com> <YU49+Y+nRhl1mgof@coredump.intra.peff.net> <xmqqa6k1slxe.fsf@gitster.g> <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net> <xmqqo88eq8um.fsf@gitster.g> <YVImeFHxY7hmb3wY@coredump.intra.peff.net> <00ee01d7b3e1$ceb06840$6c1138c0$@nexbridge.com> <YVI5rYamHBkGQ/jy@coredump.intra.peff.net>
In-Reply-To: <YVI5rYamHBkGQ/jy@coredump.intra.peff.net>
Subject: RE: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Date:   Mon, 27 Sep 2021 17:56:10 -0400
Message-ID: <00f701d7b3ea$7eb59eb0$7c20dc10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHNlhe/H9xUBWexP8Y5jg2L0M3l4gJZS/JsALVatmcCOYbmaACH6NfUAkwXmUIDEF/NxwGzAHMKAhd8yqqrVPATcA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 27, 2021 5:38 PM, Jeff King wrote:
>Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
>
>On Mon, Sep 27, 2021 at 04:53:59PM -0400, Randall S. Becker wrote:
>
>> What about something like:
>>
>> 	[includeIf "env:PATH ~= '^(.*😊)/usr/bin(:.*)*$' "]
>>
>> Using single quotes and a full regex pattern instead of trying to
>> provide a syntax to extract a pattern and then match. One call to
>> regexec() would be easier. Then escaping is regcomp's problem
>> (mostly). Potentially, you could even remove the outer ", but that
>> would be wonky. You could omit the ^ and $ by default assuming a full
>> match.
>
>I almost suggested that, but then...how do you put single-quotes in your pattern? You can backslash-escape them, but:
>
>  - do you need to escape the backslash to get it through the config
>    parser intact?
>
>  - it seems extra funny to me because single quotes usually imply a
>    lack of interpolation

Exactly so. I think it would be more clear to have a regular expression be provided literally without interpretation other than by regcomp - other than the emergency ' escape, of course.

