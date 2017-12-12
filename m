Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6271F407
	for <e@80x24.org>; Tue, 12 Dec 2017 10:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbdLLKcZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 05:32:25 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:14491 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdLLKcY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 05:32:24 -0500
Received: from [192.168.2.201] ([92.22.15.141])
        by smtp.talktalk.net with SMTP
        id OhrJeD1gImITaOhrJejPbU; Tue, 12 Dec 2017 10:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513074742;
        bh=yC6YqFmeoK4j82hJ/kFDQ4Z/dkPNFNSAbAils5s9ncY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JmVhnvefQs6BUbdx1dh7oapAcHWCHOmkQIJfdd06du90RBpWz3s2AT3SfbBnRMI0l
         nlMf3Cvs9YgBa40x86lLneBqKf3H7aqtWkkX3JfkidEFV4fLXhNbGjVItGgiJ7b2Ti
         usg6/h2H82SoN9DXnZHsPj6LxFhThdfyQ3zsWMBQ=
X-Originating-IP: [92.22.15.141]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=GtR6SX75q4uFXsZmIa626w==:117
 a=GtR6SX75q4uFXsZmIa626w==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=HWhUnGdlhp3S1yQuV7QA:9 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/9] sequencer: don't fork git commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171211141330.23566-1-phillip.wood@talktalk.net>
 <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <a57362a8-3e55-746f-d25a-56dd24a17278@talktalk.net>
Date:   Tue, 12 Dec 2017 10:32:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDnLlgeKmx57g+WbNQONBfj4X08LUNRIVZXgrA8tBuRNnbxEt9k33URA6M+v0SlWx3ETaexI09D4q7H64CDTvp4oVUAYmdW1nZOgr+Xo+SOVfmGn0UKj
 XlA42zyHWGFk+1v6agpza5ZnE5I58r/kEntzXSj1DQ2UKkYvNIeLX3sEYZFCd3/RXrAnlbJGrbxy2umP+K31qepHjefv2sKkJTz1cZha9u822btegsl6iWYE
 7N+g643LxXfKWyjr+DBp+yWY5Zv5pCwkkpowUnWun6v8FaCfiLkL/M/dlCaHJ2o+phT+WM/tK1Tm5UVGW069YX1kV23zi9w/1gUStomCMzYvuIFcgd18OjuX
 sVnkJgnKZYRVThZriTa4kKUPHUZ9ow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12/17 23:44, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> I've reworked the config handling since v4. It now stores the default
>> values in struct replay_opt rather than using global variables and
>> calls git_diff_basic_config(). Unfortunately I've not had time to
>> modify git_gpg_config() to indicate if it successfully handled the key
>> so git_diff_basic_config() is called unnecessarily in that case. Within
>> git_diff_basic_config() userdiff_config() also suffers from the same
>> problem of not indicating if it has handled the key.
> 
> Ouch.  I thought we agreed that we were ready to go incremental and
> the topic was merged to 'next' earlier last week.

Sorry, I thought we were waiting, not to worry.
> 
> After scanning the difference between the two rounds, it seems that
> the more important difference is the rework of the configuration,
> which looks better thought out than the previous round, and with
> associated change to use replay_opts fields instead of free variables
> to carry gpg-sign and cleanup-mode settings around, which also looks
> sensible to me.

Yes the configuration is the major change, I'm glad you think it is an
improvement

> Can you make these differences into incremental "that earlier one
> was suboptimal for this and that reasons, let's make it better by
> doing this" patches to queue them on top?

Will do, though if I don't get round to it today or tomorrow it may be
the New Year before I send them, I hope that's OK

Best Wishes

Phillip

> Thanks.
> 

