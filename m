Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A80F211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 22:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeLEWEQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 17:04:16 -0500
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:35376 "EHLO
        resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbeLEWEQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Dec 2018 17:04:16 -0500
Received: from resomta-po-17v.sys.comcast.net ([96.114.154.241])
        by resqmta-po-02v.sys.comcast.net with ESMTP
        id UeBeghA14kRy4UfHDgeSlB; Wed, 05 Dec 2018 22:04:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1544047455;
        bh=Uq83D6oUvU/vV2ZMah8zHob2XVA/cHLqoIFYGVM5cDI=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=WFAdjO7PQO+jEYwYXY84iK2kPiOu8jfEJg+93Io9ZTeu4XHfcT94qdi3u93PEJOSR
         4qMbVuy+P3e7Od76FBT1R+1syLvZOyQdcm1wwgN40DEXOTcJTzNZif9FlcmT1keGEj
         eIUaHHi+4WKCT3SdlkUSxwxGSStbiXT1lHW39IFOeGz6izddG3h7P6nRiNz6e3JTaO
         8/LP36d/gtEU3isNpMESI7+t3Pxk0qkrelSyIzHDfc5IWySRdEydNQi7gZln7U69iQ
         8B+y6Nilcip8ftugoKvDJcs7adwIoO24DMaTwzi6zkfz6ktzsnONrhfZKYu9mk8Pls
         R9ohENp26ceTQ==
Received: from maqtu.svl.corp.google.com ([IPv6:2620:0:100e:913:aa8d:64ee:3bb6:179])
        by resomta-po-17v.sys.comcast.net with ESMTPSA
        id UfH0gjl5zyJIlUfH5gx1hq; Wed, 05 Dec 2018 22:04:13 +0000
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@comcast.net>
Message-ID: <93b57fe5-1cd4-9213-7183-47f695876615@comcast.net>
Date:   Wed, 5 Dec 2018 14:04:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCOrDD0Lmbqb/yw5/Yuqk4cPdDi0TuMq/xrIKOQLtrHZt2b5StRtosxjLF5Qs5ZJcdtKlnjvmWn/lbZf1M76CjIIf5Q3i5UxNQPhKymb2AfsZntGTv0t
 i+h4iGWY9wFTrA6ZYaDtjwHJzY/shjOwvRG2UTIcBSaEaVrqTGza8iIHMCjbaL5idIKXzfOqCxLBv37nWdaPU9KOu2b454SGhKp544o6dZFQMJBfiZcc2V9J
 SAa6JBSJKtz/nsHdM157HZcBy8Ce2pUieAlDXln5icU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/21/2018 01:00 AM, Junio C Hamano wrote:
> * md/list-lazy-objects-fix (2018-10-29) 1 commit
>   - list-objects.c: don't segfault for missing cmdline objects
> 
>   "git rev-list --exclude-promissor-objects" had to take an object
>   that does not exist locally (and is lazily available) from the
>   command line without barfing, but the code dereferenced NULL.
> 
>   That sympotom may be worth addressing, but I think the "fix" is
>   overly broad and is wrong.  Giving a missing object should be
>   diagnosed as an error, not swept under the rug silently.

Thank you for taking a look. I just sent v3 of the patch: 
https://public-inbox.org/git/20181205214346.106217-1-matvore@google.com/T/#u

which is different from v2 in that it honors the presence or absence of 
--ignore-missing. It will only sweep things under the rug if that flag 
is passed.
