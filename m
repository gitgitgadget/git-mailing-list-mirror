Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82CB202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 18:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760101AbdKQSPM (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 13:15:12 -0500
Received: from cp-27.webhostbox.net ([208.91.198.76]:48716 "EHLO
        cp-27.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbdKQSPK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 13:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unimetic.com; s=default; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
        From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dyPnw+6QHcnJbPL8qTfRKWycqW0BCwUxYDHvGSahypc=; b=HVJHMVEtUreh5SU+8eM+rxP2ZG
        k/YgcGF8yFS96bbBT0BmNQzweBlYW9+5UmOEnLH+ifaGt7vExjQXcoP6P/JzaUKF7gL8W1JHS2TLc
        /c1s13K4VZ64vXWk91Ez3dFgX4V6Futx7xa1lULFIbP0+P9S8hFBabGbbTd19WUYlPbT9CcL/k0lU
        mUBH0S8fHa6eh3l3TQ4C96ZktpwiytglyU5d2LAcTFo3GiWW+U6rAUqCxNSBgW61aMU1s/Ze/Zs7H
        1CmOnNef9Bc2FNJqJlU7Zl6Gc/lfvXkl/d5hCfu/N8CoNpIDQWtqsqR6JQfVKoUywZCsP8Lm35vEY
        Kw8Zx/mA==;
Received: from [127.0.0.1] (port=41021 helo=208.91.198.76)
        by cp-27.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <hsed@unimetic.com>)
        id 1eFlAT-0036Xj-Kc; Fri, 17 Nov 2017 18:15:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 Nov 2017 18:15:09 +0000
From:   hsed@unimetic.com
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: [PATCH V3] config: add --expiry-date
In-Reply-To: <xmqqlgj7xcuf.fsf@gitster.mtv.corp.google.com>
References: <xmqqshdh2wln.fsf@gitster.mtv.corp.google.com>
 <20171116000547.3246-1-hsed@unimetic.com>
 <xmqqlgj7xcuf.fsf@gitster.mtv.corp.google.com>
Message-ID: <aaff8c91c03bbbc797183f26440496b6@unimetic.com>
X-Sender: hsed@unimetic.com
User-Agent: Roundcube Webmail/1.2.3
X-Authenticated_sender: hsed@unimetic.com
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp-27.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unimetic.com
X-Get-Message-Sender-Via: cp-27.webhostbox.net: authenticated_id: hsed@unimetic.com
X-Authenticated-Sender: cp-27.webhostbox.net: hsed@unimetic.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-16 00:54, Junio C Hamano wrote:
> 
>> -	if (parse_expiry_date(value, expire))
>> -		return error(_("'%s' for '%s' is not a valid timestamp"),
>> -			     value, var);
>> ...
>> +	if (parse_expiry_date(value, timestamp))
>> +		die(_("failed to parse date_string in: '%s'"), value);
> 
> This is an unintended change in behaviour (or at least undocumented
> in the log message) for the "git reflog" command, no?
> 
> Not just the error message is different, but the original gave the
> calling code a chance to react to the failure by returning -1 from
> the function, but this makes the command fail outright here.
> 
> Would it break anything if you did "return error()" just like the
> original used to?  Are your callers of this new function not
> prepared to see an error return?

I did notice the slight change in the error handling but the new one
was copied from one of the other functions in builtin/config.c. I
will revert it to the old method and if the new (and other) tests still
pass, I will provide an updated patch.

Kind Regards,
Haaris
