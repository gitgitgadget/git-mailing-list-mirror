Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3348DC433F5
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 00:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiAWAaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 19:30:24 -0500
Received: from mail-gateway-shared15.cyon.net ([194.126.200.68]:60790 "EHLO
        mail-gateway-shared15.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230488AbiAWAaY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Jan 2022 19:30:24 -0500
X-Greylist: delayed 671 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jan 2022 19:30:23 EST
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1nBQb8-0002qX-Lc
        for git@vger.kernel.org; Sun, 23 Jan 2022 01:19:11 +0100
Received: from [10.20.10.230] (port=49022 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.94.2)
        (envelope-from <dev+git@drbeat.li>)
        id 1nBQb7-009wwO-EJ; Sun, 23 Jan 2022 01:19:09 +0100
Message-ID: <74d35354-20a6-9cc1-3452-573460c694bd@drbeat.li>
Date:   Sun, 23 Jan 2022 01:19:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v3] cache.h: auto-detect if zlib has uncompress2()
Content-Language: de-CH
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
 <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
 <xmqqr190ekrh.fsf@gitster.g>
From:   Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <xmqqr190ekrh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.01.22 00:23, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
>> As noted in the updated commit message this approach of having an
>> object just for this fallback function comes at the cost of some
>> complexity, but now the compat object lives neatly in its own object.
> 
> I do not see any change in this patch adding costly complexity, but
> I notice lack of one possible trick that might become problem with
> some compilers and linkers when their zlib has uncompress2()
> function.  Let's have this graduate very early in the next cycle, to
> see if anybody on a rarer system sees a complaint due to having to
> deal with a totally empty object file.

OpenSSL has a macro in include/openssl/macros.h to counteract exactly this:

     /*
      * Sometimes OPENSSL_NO_xxx ends up with an empty file and some 
compilers
      * don't like that.  This will hopefully silence them.
      */
     #define NON_EMPTY_TRANSLATION_UNIT static void *dummy = &dummy;

They insert it in the otherwise empty "#else" branch of conditionally 
complied code.


Cheers, Beat
