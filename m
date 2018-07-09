Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91AA1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933523AbeGIVhV (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:37:21 -0400
Received: from s019.cyon.net ([149.126.4.28]:46622 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933353AbeGIVhT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dvWLfTPxi7sDPbrUjrzkdhSqjghbMDBTZjn9qnWkFd0=; b=Us1Ghyh5a9KS8reDM05dOgjvSU
        QyO6vvEW3QAcF7bkFaXfPwCRhPLEyeQbcDV7TrklPvAC0o5NZHcSRkW7jxgjBcSZJnVuijTnKnjSg
        zdU8DymqL4hKFExden39d9DYFLpchRnjqnc53o7PWOwo9PTI3KelR4PIdHF2Fs1ZHQPiRPMKCqr10
        bXw/xsjihTYNA0F2Vpfak/zYrFcvHuP2y/CHh4lTY2aZ9ZvGFygBMkq5pnCvNK/RfVUDKFy+pRL0W
        uxJ2VQ7HF8DF6jlfcZnDkDos7mnR38vyfz0NlZexBHGWDY1IfzdOyBuKP8y2K64klVoXyKQVeuNz7
        Z49gyRkw==;
Received: from [10.20.10.233] (port=57052 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fcdqO-00DL5M-8D; Mon, 09 Jul 2018 23:37:17 +0200
Subject: Re: [RFC PATCH 4/6] sequencer.c: avoid empty statements at top level
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20180708144342.11922-1-dev+git@drbeat.li>
 <20180708144342.11922-5-dev+git@drbeat.li>
 <xmqqo9fgayb6.fsf@gitster-ct.c.googlers.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <82fa7e95-5e27-bb8a-2fbf-4895bdfea05c@drbeat.li>
Date:   Mon, 9 Jul 2018 23:37:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9fgayb6.fsf@gitster-ct.c.googlers.com>
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

On 09.07.18 23:34, Junio C Hamano wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> The marco GIT_PATH_FUNC expands to a complete statement including the
>> semicolon. Remove two extra trailing semicolons.
> 
> Wait a bit.  The observation in the log message and the
> implementation of GIT_PATH_FUNC() do not match.
> 
>         #define GIT_PATH_FUNC(func, filename) \
>                 const char *func(void) \
>                 { \
>                         static char *ret; \
>                         if (!ret) \
>                                 ret = git_pathdup(filename); \
>                         return ret; \
>                 }
> 
> The code generated does "include semicolon" but that is not why the
> caller should place semicolon after the closing parens.  Perhaps
> replace "including the semicolon." with something else, like ", and
> adding a semicolon after it not only is unnecessary but is wrong."
> or soemthing like that?

This message is fixed in the non-RFC series that I sent at 19:25 UTC. I
noticed the error after the message from Philip Oakley.

Beat
