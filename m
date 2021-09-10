Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57945C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 18:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EC2611CE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 18:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhIJSaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 14:30:52 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:42530 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJSas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 14:30:48 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Sep 2021 14:30:48 EDT
Received: from [192.168.1.37] ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id Ol9PmEUhzxbmZOl9PmBFaX; Fri, 10 Sep 2021 19:21:24 +0100
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=S6SnP7kP c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=pGLkceISAAAA:8
 a=P9UpGL_Bcdxdkj3MHDsA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH v2 2/5] help: correct usage & behavior of "git help
 --guides"
From:   Philip Oakley <philipoakley@iee.email>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
 <patch-v2-2.5-039639a0dd3-20210910T112545Z-avarab@gmail.com>
 <2493437c-01c5-ddcc-6a61-666f87e70f20@iee.email>
Message-ID: <8c72d383-4ae2-b96c-6886-7c36153d8991@iee.email>
Date:   Fri, 10 Sep 2021 19:21:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2493437c-01c5-ddcc-6a61-666f87e70f20@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfG0XpCovVfXC1vAdlAfhPh/XpRJQkW4suQ5Xh6T4nr1HYZwVB567FZUbHUN2Fm4sdJpdWQm4779aFZqJ5Cl2WKZGLK3Ik8jioaCDklPKS4qys4dAv93b
 lQroXmgJI0gevX5fbyV7Yl+bYJFh9cbVYWeOrcx7qFF1puYGckcTuwqSAk604ExasTXQ1TnDRmKCLws/HjkoIgSCZQXYfe6rNt3k9kwN7oA66sqTHb6J+lTw
 GbkfWhng3QtJ64BZt+qyj05BPHd0TvrlaUxXo6IqOKx/pWWVfjN7Opw3ZwdU9IbPENGiPRbSeMbf8DLK2dv/LV2oDRz5YYLd429RHeo53tE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2021 19:15, Philip Oakley wrote:
> On 10/09/2021 12:28, Ævar Arnfjörð Bjarmason wrote:
>> As noted in 65f98358c0c (builtin/help.c: add --guide option,
>> 2013-04-02) and a133737b809 (doc: include --guide option description
>> for "git help", 2013-04-02) which introduced the --guide option it
>> cannot be combined with e.g. <command>.
>>
>> Change both the usage string to reflect that, and test and assert for
>> this behavior in the command itself. Now that we assert this in code
>> we don't need to exhaustively describe the previous confusing behavior
>> in the documentation either, instead of silently ignoring the provided
>> argument we'll now error out.
>>
>> The comment being removed was added in 15f7d494380 (builtin/help.c:
>> split "-a" processing into two, 2013-04-02). The "Ignore any remaining
>> args" part of it is now no longer applicable as explained above, let's
>> just remove it entirely, it's rather obvious that if we're returning
>> we're done.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  Documentation/git-help.txt |  6 +++---
>>  builtin/help.c             | 11 +++++++----
>>  t/t0012-help.sh            |  4 ++++
>>  3 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
>> index 568a0b606f3..cb8e3d4da9e 100644
>> --- a/Documentation/git-help.txt
>> +++ b/Documentation/git-help.txt
>> @@ -8,8 +8,9 @@ git-help - Display help information about Git
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git help' [-a|--all [--[no-]verbose]] [-g|--guides]
>> +'git help' [-a|--all [--[no-]verbose]]
>>  	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
>> +'git help' [-g|--guides]
> Shouldn't we also include the [-c|--config] options here in the synopsis,
> and the help_usage below?

I see this is fixed in 4/5
>
> Further, shouldn't we mention this (git help -c) on the git config man
> page, e.g. "A list all available configuration variables can be
> generated by `git help -c`." 

Still feel this one would be useful (but may be out of scope of this series)
>
> I hadn't realised the facility was even available.

Philip
>>  
>>  DESCRIPTION
>>  -----------
>> @@ -58,8 +59,7 @@ OPTIONS
>>  
>>  -g::
>>  --guides::
>> -	Prints a list of the Git concept guides on the standard output. This
>> -	option overrides any given command or guide name.
>> +	Prints a list of the Git concept guides on the standard output.
>>  
>>  -i::
>>  --info::
>> diff --git a/builtin/help.c b/builtin/help.c
>> index 44ea2798cda..51b18c291d8 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -59,8 +59,9 @@ static struct option builtin_help_options[] = {
>>  };
>>  
>>  static const char * const builtin_help_usage[] = {
>> -	N_("git help [-a|--all] [-g|--guides] [--[no-]verbose]]\n"
>> +	N_("git help [-a|--all] [--[no-]verbose]]\n"
>>  	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
>> +	N_("git help [-g|--guides]"),
>>  	NULL
>>  };
>>  
>> @@ -552,6 +553,11 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>>  			builtin_help_usage, 0);
>>  	parsed_help_format = help_format;
>>  
>> +	/* Options that take no further arguments */
>> +	if (argc && show_guides)
>> +		usage_msg_opt(_("--guides cannot be combined with other options"),
>> +			      builtin_help_usage, builtin_help_options);
>> +
>>  	if (show_all) {
>>  		git_config(git_help_config, NULL);
>>  		if (verbose) {
>> @@ -582,9 +588,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>>  
>>  	if (show_all || show_guides) {
>>  		printf("%s\n", _(git_more_info_string));
>> -		/*
>> -		* We're done. Ignore any remaining args
>> -		*/
>>  		return 0;
>>  	}
>>  
>> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
>> index 5679e29c624..c3aa016fd30 100755
>> --- a/t/t0012-help.sh
>> +++ b/t/t0012-help.sh
>> @@ -34,6 +34,10 @@ test_expect_success 'basic help commands' '
>>  	git help -a >/dev/null
>>  '
>>  
>> +test_expect_success 'invalid usage' '
>> +	test_expect_code 129 git help -g git-add
>> +'
>> +
>>  test_expect_success "works for commands and guides by default" '
>>  	configure_help &&
>>  	git help status &&

