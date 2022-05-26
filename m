Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19A6C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 12:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiEZMBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 08:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiEZMBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 08:01:09 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A81C8BEB
        for <git@vger.kernel.org>; Thu, 26 May 2022 05:01:07 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nuCAr-000866-3G;
        Thu, 26 May 2022 13:01:05 +0100
Message-ID: <1e7dd39e-0491-e561-be1f-7666fcf62bc6@iee.email>
Date:   Thu, 26 May 2022 13:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] rebase: note `preserve` merges may be a pull config
 option
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <ece3eecdc4de44cdec1b6efa9079930721db85ad.1653556865.git.gitgitgadget@gmail.com>
 <220526.8635gw7has.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <220526.8635gw7has.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi,
On 26/05/2022 10:50, Ævar Arnfjörð Bjarmason wrote:
> On Thu, May 26 2022, Philip Oakley via GitGitGadget wrote:
>
>> From: Philip Oakley <philipoakley@iee.email>
>>
>> The `--preserve-merges` option was removed by v2.35.0. However
>> users may not be aware that it is also a Pull option, and it is
>> still offered by major IDE vendors such as Visual Studio.
>>
>> Extend the `--preserve-merges` die message to also direct users to
>> the use of the `preserve` option in the `pull` config.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>  builtin/rebase.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index aada25a8870..6fc0aaebbb8 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -1205,7 +1205,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>  			     builtin_rebase_usage, 0);
>>  
>>  	if (preserve_merges_selected)
>> -		die(_("--preserve-merges was replaced by --rebase-merges"));
>> +		die(_("--preserve-merges was replaced by --rebase-merges\n"
>> +			"Your `pull` configuration, may also invoke this option."));
>>  
>>  	if (action != ACTION_NONE && total_argc != 2) {
>>  		usage_with_options(builtin_rebase_usage,
> Ditto 2/3 about maybe die_message() + advise(). 
I'm not that enamoured about hiding die message details behind an advice
option. In this case it not meant to be a regular reminder type thing,
rather a one-off fix-it-forever sort of `advice'. At least that my
reasoning.

> In this case that has
> the slight advantace of allowing us to keep the existing translated
> string as-is.
>
> But also, is *our* pull configuration causing us to end up here?
Yes, but. The extra message is about fixing all places that the user may
have setup a config for using preserve-merges, not just here. The fact
that IDEs offer a menu for adding that setting makes it easy for users
to get into this.
I'd agree that pull already has detection for this, but I was looking to
avoid the 'fool me once, fool me twice' scenarios.

It could be dropped if thought over zealous.
>  I
> vaguely recall that being discussed (probably in answer to a question of
> mine) in the earlier round, or is this the IDE picking it up & invoking
> us like this?
>

