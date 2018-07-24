Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071361F597
	for <e@80x24.org>; Tue, 24 Jul 2018 06:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbeGXHJW (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 03:09:22 -0400
Received: from s019.cyon.net ([149.126.4.28]:49460 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388207AbeGXHJW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 03:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=W/SggYFKmSLjQuPMgFvxCiu0PnRcDEbln5cvT6GMlHc=; b=ZVApWakhErH5QHHw+FLz6LENP/
        yfcoia3Zek9OgvnHjReMuqQwdqtPdeYRKJekvc3iwe6CKeKKh35+eS/yseDyLUcc1Mpwcx5mhOsiB
        U1g7Ebt7R3Fgf3bj8DelF6UgwG7Ou+K2yfiN70iitmywIQzP0Bi7p0htXkHsqdSVK37uBhXPb+53+
        c3TTFChfZ8s39JcyiF/ggQ7kOkYsSmNHXp10rHXnjssEWR87w4ZLcLWp157dLTS5zBSHrUn/XvOG+
        dghYbJwL5z50zwllTIrOF8thw0EFQX0yOkCetEDOcO6zz9VMDNMzPZ4BF/Wz7FTKNP/BVGb0C06rm
        QndYKKRg==;
Received: from [10.20.10.232] (port=22670 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fhqQp-005m1W-FY; Tue, 24 Jul 2018 08:04:29 +0200
Subject: Re: [PATCH v2] Makefile: add a DEVOPTS flag to get pedantic
 compilation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180721203647.2619-1-dev+git@drbeat.li>
 <xmqqva956ax8.fsf@gitster-ct.c.googlers.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <7666172f-3113-109c-29cf-f1598195b100@drbeat.li>
Date:   Tue, 24 Jul 2018 08:04:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqva956ax8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.07.18 20:53, Junio C Hamano wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> In the interest of code hygiene, make it easier to compile Git with the
>> flag -pedantic.
>>
>> Pure pedantic compilation with GCC 7.3 results in one warning per use of
>> the translation macro `N_`:
>>
>>     warning: array initialized from parenthesized string constant [-Wpedantic]
>>
>> Therefore also disable the parenthesising of i18n strings with
>> -DUSE_PARENS_AROUND_GETTEXT_N=no.
>>
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>>
>> This is the convenience knob for all developers that led to the series
>> bb/pedantic[1]. It does not depend on this series, though.
> 
> Yup, but "make DEVELOPER=Yes" build won't pass unless this patch is
> queued after those clean-up ;-)

Then there's a bug in this patch. It should only have an effect if we
"make DEVELOPER=Yes DEVOPTS=pedantic". Did you try this?

> Remind me if I forget to tweak =no back to =0 before pushing the
> result out.

No problem, I can send a v3 with this change reverted.

Beat

> 
> Thanks.
> 
>> [1] https://public-inbox.org/git/20180708144342.11922-1-dev+git@drbeat.li/T/#u
>>
>>  Makefile       | 6 ++++++
>>  config.mak.dev | 5 +++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 0cb6590f24..2bfc051652 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -484,6 +484,12 @@ all::
>>  #        The DEVELOPER mode enables -Wextra with a few exceptions. By
>>  #        setting this flag the exceptions are removed, and all of
>>  #        -Wextra is used.
>> +#
>> +#    pedantic:
>> +#
>> +#        Enable -pedantic compilation. This also disables
>> +#        USE_PARENS_AROUND_GETTEXT_N to produce only relevant warnings.
>>  
>>  GIT-VERSION-FILE: FORCE
>>  	@$(SHELL_PATH) ./GIT-VERSION-GEN
>> diff --git a/config.mak.dev b/config.mak.dev
>> index 2d244ca470..e11dd94741 100644
>> --- a/config.mak.dev
>> +++ b/config.mak.dev
>> @@ -1,6 +1,11 @@
>>  ifeq ($(filter no-error,$(DEVOPTS)),)
>>  CFLAGS += -Werror
>>  endif
>> +ifneq ($(filter pedantic,$(DEVOPTS)),)
>> +CFLAGS += -pedantic
>> +# don't warn for each N_ use
>> +CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=no
>> +endif
>>  CFLAGS += -Wdeclaration-after-statement
>>  CFLAGS += -Wno-format-zero-length
>>  CFLAGS += -Wold-style-definition

