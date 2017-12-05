Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E486F20C11
	for <e@80x24.org>; Tue,  5 Dec 2017 11:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbdLELVJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 06:21:09 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:44113 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbdLELVI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 06:21:08 -0500
Received: from [192.168.2.201] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id MBHdeuiwXmITaMBHeecVkK; Tue, 05 Dec 2017 11:21:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1512472866;
        bh=j2AC0D3Yu3Mj819rsqGFW2SB7GLfV9n81Q0C0Qugo0w=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Jmyp7bjCfyeVPpyWC1dfNp48b70yLNmPP9IEnldL2cyTCs+A+Gu5zADqFxkxCFvti
         EWsAQVO7FSTKb4PcPJXQv41or8DFW0NTokrZCRspQpGo+krQOrbZJv7M5BweYSiyLq
         YkURoEJGIE75qlo8/xXCjWp4GdN5Z8gdiWva8os8=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=xkdnT2lu7eryPL9L3CcA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 7/9] sequencer: load commit related config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171124110758.9406-1-phillip.wood@talktalk.net>
 <20171124110758.9406-8-phillip.wood@talktalk.net>
 <xmqqd13umjl7.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <632c35d3-46ca-e0bc-5b14-244647df9b19@talktalk.net>
Date:   Tue, 5 Dec 2017 11:21:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqd13umjl7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNdU7sb11Pq7v33CXuyq9J3wL3TeyWGEJK0Cu1sJJnVYolSEYwlIGmCux5gqkqtUGfXm23ono8zw0fWQpt/h58CZhwoTNY+gguYvQuGRNUBcCyuGf5z4
 AUjkHF0NMObdqXeKrfRzjoQAtO40j+MXZLagcYnqZ3Z06Trxt1+kx4Xi8+O8c36P7VWw5W25fTy/eMDH/vS0L77TukWff5ylWDgMtnKRVS4nUcxADTuWoBIz
 041cmoKix8B1YEEHn1fOwZjsHAydwz2TDJbtlt7oUHypYv7S/c2Z+cCP7utwaRl89W/wJGbcYxGcjFFRLgosACk5ENP+Yhu8qLcoAevyM5pGcwr1vU3LD9oS
 4ivP0HLn2mmzLruRLxSBmLM0BM3QXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/12/17 18:30, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> --- a/builtin/rebase--helper.c
>> +++ b/builtin/rebase--helper.c
>> @@ -9,6 +9,17 @@ static const char * const builtin_rebase_helper_usage[] = {
>>  	NULL
>>  };
>>  
>> +static int git_rebase_helper_config(const char *k, const char *v, void *cb)
>> +{
>> +	int status;
>> +
>> +	status = git_sequencer_config(k, v, NULL);
>> +	if (status)
>> +		return status;
>> +
>> +	return git_default_config(k, v, NULL);
>> +}
>> +
> 
> Sorry for spotting the problem this late, but this code is
> unfortunate and we will need to revisit it later; we may want to do
> so sooner rather than later.

If it needs fixing then doing it before it hits next makes sense.

> When k,v is a valid configuration that is handled by
> sequencer_config() successfully, this code still needs to call into
> default_config() with the same k,v, only to get it ignored.

I'm a bit confused by this sentence. Do you mean that when k,v is a
valid configuration that is successfully handled by sequencer_config()
this code unnecessarily calls default_config() as there is no need to
call default_config() if k,v have already been handled?

> The problem lies in the (mis)design of git_sequencer_config().  The
> function should either allow the caller to notice that (k,v) has
> already been handled, or be the last one in the callback by making a
> call to default_config() itself.

The problem is that git_gpg_config() provides no indication if it has
handled k,v so there's no way to avoid the call to default_config() in
that case. builtin/am.c and builtin/commit.c both do something like

static int git_am_config(const char *k, const char *v, void *cb)
{
	int status;

	status = git_gpg_config(k, v, NULL);
	if (status)
		return status;

	return git_default_config(k, v, NULL);
}


Looking more generally at sequencer_config() I wonder if we should be
providing a warning or an error if the config contains an invalid
cleanup mode. Also should it be calling git_diff_ui_config() to set
things up for print_commit_summary()? (I'm not sure if anything in that
function is affected by diff config settings)

Let me know what you think. I should have time to update this patch set
later in the week.

Best Wishes

Phillip

> For the former, because this helper does not have to be called
> directly as a git_config() callback, but instead it is always meant
> to be called indirectly from another git_config() callback (like
> git_rebase_helper_config() here, and common_config() in
> builtin/revert.c like we see below), it does *not* have to be
> constrained by the function signature required for it to be a config
> callback.  It could take a pointer to an int that stores if 'k' was
> handled inside the function,
> 
>     int git_sequencer_config_helper(char *k, char *v, int *handled);
> 
> for example.
> 

