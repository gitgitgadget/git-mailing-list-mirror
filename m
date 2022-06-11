Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7B7C433EF
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 14:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiFKODd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jun 2022 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiFKODc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jun 2022 10:03:32 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6B6443C6
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 07:03:28 -0700 (PDT)
Received: from host-78-147-178-211.as13285.net ([78.147.178.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1o01i2-0002Ms-BR;
        Sat, 11 Jun 2022 15:03:26 +0100
Message-ID: <4cac8a13-a075-544e-8c10-e58bbf0dd73d@iee.email>
Date:   Sat, 11 Jun 2022 15:03:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/4] rebase: note `preserve` merges may be a pull
 config option
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
 <fe000f062078e544361c87c319830cd36aabbc91.1654341469.git.gitgitgadget@gmail.com>
 <xmqq1qw18yk2.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq1qw18yk2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for delay, I had other family priorities to attend to.

On 06/06/2022 18:57, Junio C Hamano wrote:
> "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Philip Oakley <philipoakley@iee.email>
>>
>> The `--preserve-merges` option was removed by v2.34.0. However
>> users may not be aware that it is also a Pull configuration option,
>> which is still offered by major IDE vendors such as Visual Studio.
>>
>> Extend the `--preserve-merges` die message to also direct users to
>> the possible use of the `preserve` option in the `pull.rebase` config.
>> This is an additional 'belt and braces' information statement.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>  builtin/rebase.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 17cc776b4b1..5f8921551e1 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1205,7 +1205,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>  			     builtin_rebase_usage, 0);
>>  
>>  	if (preserve_merges_selected)
>> -		die(_("--preserve-merges was replaced by --rebase-merges"));
>> +		die(_("--preserve-merges was replaced by --rebase-merges\n"
>> +			"Note: Your `pull.rebase` configuration may also be  set to 'preserve',\n"
>> +			"which is no longer supported; use 'merges' instead"));
> "be  set" -> "be set".
Noted. I see that the series is now in `next` [Thank you], so not worth
the churn of a patch, unless folks start noticing..

>
> I am not sure how this helps anybody, though.  

It's the Catch 22 problem for deleted capabilities, which we rarely see
because we normally have backward compatibility.
 
>
> When pull.rebase is parsed, rebase.c::rebase_parse_value() is called
> from builtin/pull.c::parse_config_rebase() and would trigger an
> error, whether it comes from the pull.rebase or the branch.*.rebase
> configuration variable.  An error() message already said that
> 'preserve' was removed and 'merges' would be a replacement when it
> happened.
>
> If the user has *not* reached this die() due to a configuration
> variable, then there is not much point giving this new message,
> either.

From my perspective, users should then be purging _all_ their `preserve`
configurations once they hit such errors. As the v2.34.0 change
propagates through the Git ecosystem, hopefully it'll be a sufficient
prompt for those who haven't realised that the option can be 'hidden' in
their configuration options.

Time will tell.

Thanks

Philip
