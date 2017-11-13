Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217D91F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 11:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbdKMLI3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 06:08:29 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:14763 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdKMLI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 06:08:28 -0500
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id ECb4ezLrRmITaECbDeEyww; Mon, 13 Nov 2017 11:08:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510571306;
        bh=JbE14QbC+URMRw1DB71otrqETpur7DpnI3lHswgC9dU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GPALwj7cJXnlgMjkKClxMkATCDWcOgTlBdZy0lBLIQ8kFFSFITgNG8bG/otYfvT3B
         GYlIBpBZ08PnY91HR6MtwRXMHVvWpHc7EH989jJt4dc6Z285tS7YLnm6ILpAtn3b5U
         6L4+njCkuKQd6gQwjQKzuFdhuUwuzd5bq2ZcpEXE=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=i0qSn0j8x09g-LQUDGwA:9 a=CF1N6qyM6-JsaIPp:21 a=_K9dtJcr0A5dvI-8:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/9] commit: move empty message checks to libgit
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171110110949.328-1-phillip.wood@talktalk.net>
 <20171110110949.328-3-phillip.wood@talktalk.net>
 <dbdb4990-e539-42d5-df0a-3d5f4a993faf@ramsayjones.plus.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <9e872c1f-2d51-ef20-bae8-305b6db14a7b@talktalk.net>
Date:   Mon, 13 Nov 2017 11:08:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <dbdb4990-e539-42d5-df0a-3d5f4a993faf@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPsRHy4pnNthBnHx3dVS/UYzj0sRx4MFxWIHV+F8b31vCjl9xc9RuFUOJMEXu3BDYAWzjuqJKXe0wlOkZgr8NfEOvI1xC/XQ8Zo7hRKrhDcjVfzSac+/
 8j/DmMWwmCj2qiecEm3XQKzuHPAiLAcv/EtZoIupjZEEScNIPII4jy80uRtzVq8yB5Av8WiDnRjhEgapawbFcoqjI24B0e0KwyZjWa3y9rDSYbxFIOw4qNRT
 ENkmlNbfrxcgRwQ40c8KlCeQnos6Ri+IyVCisTH5SJgxc6eYdePHU1TpxmaV02FNYtpatUfzn/RZff5N2u7l91VMDKQZw8X2BvBx4dCOu0Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/17 18:51, Ramsay Jones wrote:
> 
> 
> On 10/11/17 11:09, Phillip Wood wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Move the functions that check for empty messages from bulitin/commit.c
>> to sequencer.c so they can be shared with other commands. The
>> functions are refactored to take an explicit cleanup mode and template
>> filename passed by the caller.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>
>> Notes:
>>     changes since v1:
>>      - prefix cleanup_mode enum and constants with commit_msg_
>>
>>  builtin/commit.c | 99 +++++++++++---------------------------------------------
>>  sequencer.c      | 61 ++++++++++++++++++++++++++++++++++
>>  sequencer.h      | 11 +++++++
>>  3 files changed, 91 insertions(+), 80 deletions(-)
>>
> 
> Just an idle thought - why are these functions moving to
> sequencer.[ch] rather than commit[.ch]?
> 
> Similar comments for other patches in the series which moves
> code from builtin/commit.c to sequencer.[ch].

I did think about putting them in commit.[ch] but I felt they where
higher level than the existing functions in those files and as they're
used by the sequencer code I just put them in there in the end.

Best Wishes

Phillip

> ATB,
> Ramsay Jones
> 
> 

