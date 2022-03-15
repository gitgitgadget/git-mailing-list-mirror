Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E848DC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 19:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243217AbiCOTkI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 15 Mar 2022 15:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbiCOTkF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 15:40:05 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C65237C1
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:38:53 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22FJcp9Y065628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Mar 2022 15:38:52 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Carlo Arenas'" <carenas@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>        <20220315105723.19398-1-phillip.wood123@gmail.com>        <20220315105723.19398-3-phillip.wood123@gmail.com>        <xmqqzglrdsd8.fsf@gitster.g>        <02fd01d83896$c0261240$407236c0$@nexbridge.com> <xmqqilsfdok0.fsf@gitster.g>
In-Reply-To: <xmqqilsfdok0.fsf@gitster.g>
Subject: RE: [PATCH v3 2/4] terminal: don't assume stdin is /dev/tty
Date:   Tue, 15 Mar 2022 15:38:46 -0400
Organization: Nexbridge Inc.
Message-ID: <031801d838a4$4d3c7770$e7b56650$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGKt2ggdcH8T8D+I2vfsOMG9Pml6gGNcxSxAhyA+dkC9+EoRgIz6A3UAdBFZcmtBqlykA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 15, 2022 3:05 PM, Junio C Hamano wrote:
>To: rsbecker@nexbridge.com
>Cc: 'Phillip Wood' <phillip.wood123@gmail.com>; 'Git Mailing List'
><git@vger.kernel.org>; 'Phillip Wood' <phillip.wood@dunelm.org.uk>; 'Ævar
>Arnfjörð Bjarmason' <avarab@gmail.com>; 'Carlo Arenas' <carenas@gmail.com>;
>'Johannes Schindelin' <Johannes.Schindelin@gmx.de>; 'Ramsay Jones'
><ramsay@ramsayjones.plus.com>
>Subject: Re: [PATCH v3 2/4] terminal: don't assume stdin is /dev/tty
>
><rsbecker@nexbridge.com> writes:
>
>>>The check before closing it is wrong.  It should be
>>>
>>>	if (0 <= term_fd)
>>
>> Should this expression succeed if term_fd == stdin? I might be missing the point
>here.
>
>We could use "if (0 < term_fd)" to make this guard both about avoiding to call
>close() on an uninitialized FD and also about avoiding to close standard input.  I'd
>prefer to see them handled separately as these live at different conceptual levels
>(i.e. closing -1 is a no-no no matter what, closing 0 is bad if it is what we did not
>open but what the caller supplied us via the SAVE_TERM_STDIN bit, but it may be
>warranted if it was what we obtained from an earlier call to open("/dev/tty") we
>did ourselves).

Thanks. This is one of those situations where explaining magic numbers is important. I appreciate the insight.

Regards,
Randall

