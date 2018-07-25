Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE901F597
	for <e@80x24.org>; Wed, 25 Jul 2018 17:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeGYSv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 14:51:27 -0400
Received: from s019.cyon.net ([149.126.4.28]:39598 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbeGYSv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 14:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iAl1PC3a0/F571Dnx4V7filE58CVI4cqTEsiDirGc5Y=; b=wJKzxB4b3CbYV5jw/M6Oogf1+t
        NQv/wISNy9ZZ4eSCyAIBJ06Kt0XKW3IHN89NdfVYokLysKVkdwEeIOdd3V67/w7oFHkRZVp3h9gOU
        vrIlbiXymPv60/mnaZKxshH0t1yOxDhjH3XOwb3ntMIp8+a3iuLBepm4S/jsk4eIoytOj3PEjkXyL
        Nh2HDYWfFrjMMN8vKRPvuhE0nxbN5xUgr8ZW7U8vU+uGpA2AcRD0AxvUnK99tJQ5SKHV+42uvyEHS
        BoZWA74J6RUjAMPbj5XiubO3Ya6GQgpUzhA7vHw54bSLH6uzbxUYdmsOr4dziWz7Kw5kcBW/QkL/1
        aKOCznaw==;
Received: from [10.20.10.232] (port=45652 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fiNkE-00Guxo-7R; Wed, 25 Jul 2018 19:38:42 +0200
Subject: Re: [PATCH v4] Makefile: add a DEVOPTS flag to get pedantic
 compilation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <20180724171339.18983-1-dev+git@drbeat.li>
 <20180724192643.21505-1-dev+git@drbeat.li>
 <xmqqzhyfuub6.fsf@gitster-ct.c.googlers.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <504f6cfe-f869-97f6-248d-642ae1e6dfc0@drbeat.li>
Date:   Wed, 25 Jul 2018 19:38:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqzhyfuub6.fsf@gitster-ct.c.googlers.com>
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

On 25.07.18 18:57, Junio C Hamano wrote:
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
>> -DUSE_PARENS_AROUND_GETTEXT_N=0.
>>
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
> 
> Hmph, what did you change between v3 and v4?

Just the commit text. In v3, it still said =No instead of =0.

>> diff --git a/Makefile b/Makefile
>> index 0cb6590f24..2bfc051652 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -484,6 +484,12 @@ all::
> 
> The postimage of this hunk is supposed to be 11 lines long, as you
> have five additional line in the middle of 6 original context lines.
> Where did this 12 come from?  I am only interested in finding out if
> our patch generation tool(s) have some bugs with this question.
> 
> If this is only because you hand-edit your patch, then we have no
> tool breakage to worry about, but please refrain from doing so in
> the future (instead always go back to the commit, amend it, and
> re-run format-patch).
> 
> Thanks.

You got me there :-/

Won't happen again, sorry.

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
> 

