Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35CA120A30
	for <e@80x24.org>; Tue,  7 Nov 2017 10:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbdKGKut (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 05:50:49 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:30268 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753460AbdKGKur (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 05:50:47 -0500
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id C1Suel1eJAp17C1SueOQsU; Tue, 07 Nov 2017 10:50:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510051845;
        bh=+kOpEzvN7cuuGEU++Kt//EFEkN1SjyAjtl1n2tZyPV4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ao6+qRBVPuqTyxiRsto8dHcD+9W4A9jeY6e80dYER0X115FcC5PnI/Z0ibapqB0+7
         BPiCKzPBGNrpqtrrys34nRNX0Ymriar1hj4RYpCbZcM2wsx8jXI34ORXhS1OkQwnvI
         qgDf4JsF6jHcF4EvniAJ7YaG4Z8oMNzW0hM/ZwoE=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=xGw9uJ0HFP6cn7TEgzIA:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 7/8] sequencer: load commit related config
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
 <20171106112709.2121-8-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1711070202040.6482@virtualbox>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <7529b1ab-a336-3410-b827-f783d6cb5c5e@talktalk.net>
Date:   Tue, 7 Nov 2017 10:50:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1711070202040.6482@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEuGNaHRa/CdLcoccbfhJzMyozLpDPaiM4dHHXSCvJeyNo18IZNNYoHlJ4UIyLrbg90/PWfIXhD3zgHDKJus4pDNrfijTUg1hyOIePIE+1ZNqR8gb6YZ
 v9CffjUvu1XZPGXl7axamSyod5Qva7LuRrWXRWJmcJguIt70AQZcTPaQ/PO12qICByQ8qc+SgN3PAMAPRWM4GXA36aZMHAHt6Jr2j2Wtcb58NNkGTaOUMrHg
 OgseN7LLaIup6pGR8aZ8jCI7mB2wX4Mhvw87cwgJDAHvjK2w8kw+EPiuCjoNJlC+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for looking at these patches

On 07/11/17 01:02, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Mon, 6 Nov 2017, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Load default values for message cleanup and gpg signing of commits in
>> preparation for committing without forking 'git commit'.
> 
> Nicely explained.
> 
>> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
>> index f8519363a393862b6857acab037e74367c7f2134..68194d3aed950f327a8bc624fa1991478dfea01e 100644
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
> 
> It's more a matter of taste than anything else, but this one would be a
> little bit shorter:
> 
> 	return git_sequencer_config(k, v, NULL) ||
> 		git_default_config(k, v, NULL);

I'd do that in python or perl but in C it changes the return value which
may not matter but if the git convention is to return -1 for errors then
this deviates from that.

> A more important question would be whether this `git_default_config()`
> call could be folded into `git_sequencer_config()` right away, so that the
> same pattern does not have to be repeated in rebase--helper as well as in
> revert/cherry-pick.

I kept it separate to be more flexible, imagining that in the future
there maybe other commands that want to call git_sequencer_config()
followed by some_othor_config() before git_default_config(). I don't
have a strong opinion either way.

>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index b9d927eb09c9ed87c84681df1396f4e6d9b13c97..b700dc7f7fd8657ed8cd2450a8537fe98371783f 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -31,6 +31,17 @@ static const char * const cherry_pick_usage[] = {
>>  	NULL
>>  };
>>  
>> +static int git_revert_config(const char *k, const char *v, void *cb)
> 
> Seeing as it is used also by `cmd_cherry_pick()`, and that it is
> file-local anyway, maybe `common_config()` is a better name?

Yes that would be better, the old name came from the file it was in.

> 
> This point is moot if we can call `git_default_config()` in
> `git_sequencer_config()` directly, though.
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index 3e4c3bbb265db58df22cfcb5a321fb74d822327e..b8cf679751449591d6f97102904e060ebee9d7a1 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -688,6 +688,39 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>>  	return run_command(&cmd);
>>  }
>>  
>> +static enum cleanup_mode default_msg_cleanup = CLEANUP_NONE;
>> +static char *default_gpg_sign;
> 
> I was ready to shout about global state not meshing well with libified
> code, but as long as we're sure that these values are set only while Git
> executes single-threaded, still, it is the correct way to do it: these
> settings reflect the config, and therefore *are* kinda global (at least
> until the day when the submodule fans try to call `git commit` in a
> submodule using the `struct repository` data structure).
> 
> In short: this code is good (and I was just describing a little bit of my
> thinking, to demonstrate that I tried to be a diligent reviewer :-)).
> 
> Thanks,
> Dscho
> 

