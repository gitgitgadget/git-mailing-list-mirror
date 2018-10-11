Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E201F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 11:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeJKSlV (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 14:41:21 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:32503 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeJKSlV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 14:41:21 -0400
Received: from [192.168.2.240] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id AYvHgylIMVlGZAYvIgSZpA; Thu, 11 Oct 2018 12:14:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539256472;
        bh=K+ZDzMfn4PbinNTjvZrbpTqKJytvFZNf1jCPvg0/E/8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Jimbe6vgXwOsx1d82HNxxO8F87ldJDXWhwpCTc2OhU+73lloRj7XqnO80Ozhl4y2r
         NlUkrAb94s0JJsD/YaRdrXLT1wvM4KITTIVocQyKa5Aa71NM65q47c72SCxpjAa78e
         36R7qEmN+vCCYWGi2FcIoPMO9FHMH7GMJYMMp9WE=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=wLTIuke6hT3HaiiqlOQA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revert & cherry-pick: run git gc --auto
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20181010193557.19052-1-avarab@gmail.com>
 <20f33df8-7ba8-af26-e0c8-16152345c85b@talktalk.net>
 <87ftxceqxc.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <65275c82-1fc0-8f89-8c13-562b73f3ffcf@talktalk.net>
Date:   Thu, 11 Oct 2018 12:14:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87ftxceqxc.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIRz3T0WCj3UW+NIHoZt3PLRgqicaHcNB2qq9E4VdezApN8lHfn0WAvwZrqIiG0N/xJbaeCox7UDxeJPIc/Hf3iTSeSQCMIQFUHiCzrplUFBUZ/FqDcj
 NGUtvE/L2L05LP99jSDefKnonHegOSYnbCfBjJTLfDyL86ZPX+pF7vlpCFGBz7PkeHSNYhmypORlazQpnLR6iD+fGYLqTed9sUvKQRZjan9huK7hJlbQlrQ2
 Ek2dI+EbBx3Z05tWMBlQeJWnmk/ntIMeNY2yUPXajJAiBZiWAxT2wWYDcPjmag46ghgEpqNSu48n0RapikmsRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar
On 11/10/2018 11:08, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 11 2018, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 10/10/2018 20:35, Ævar Arnfjörð Bjarmason wrote:
>>> Expand on the work started in 095c741edd ("commit: run git gc --auto
>>> just before the post-commit hook", 2018-02-28) to run "gc --auto" in
>>> more commands where new objects can be created.
>>>
>>> The notably missing commands are now "rebase" and "stash". Both are
>>> being rewritten in C, so any use of "gc --auto" there can wait for
>>> that.
>>
>> If cherry-pick, revert or 'rebase -i' edit the commit message then they
>> fork 'git commit' so gc --auto will be run there anyway.
> 
> Yeah it seems I totally screwed up the testing for this patch, first it
> doesn't even compile because I'm not including run-command.h, I *did*
> fix that, but while wrangling a few things didn't commit that *sigh*.
> 
> And yeah, there's some invocations where we now run gc --auto twice,
> i.e. if you do revert, but not revert --no-edit, and not on cherry-pick,
> but on cherry-pick --edit.
> 
> So yeah, this really needs to be re-thought.
> 
>> I wonder if it would be better to call 'gc --auto' from sequencer.c at
>> the end of a string of successful picks, that would cover cherry-pick,
>> 'rebase -iu' and revert. With 'rebase -i' it might be nice to avoid
>> calling 'gc --auto' until the very end, rather than every time we stop
>> for an edit but that is probably more trouble than it is worth.
> 
> That seems a lot better indeed. I.e. running it from the sequencer. I do
> wonder if there should be some smarts about running it in the middle of
> a sequence, i.e. think of a case where we're rebasing 10k commits, which
> is a gc need similar to what happens in the middle of "git svn
> clone". So maybe something where we gc --auto in the sequencer for every
> Nth commit, and at the end.

That sounds like a good idea. It would be nice if need_to_gc() was in 
libgit, then we could avoid the cost of forking unless we actually need 
to gc. Looking at builtin/gc.c there seem to be quite a few global 
variables so transforming it to library code may not be that straight 
forward.

Best Wishes

Phillip

>>
>>>
>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> ---
>>>
>>> After reading the "Users are encouraged to run this task..." paragraph
>>> in the git-gc manpage I was wondering if due to gc --auto all over the
>>> place now (including recently in git-commit with a patch of mine) if
>>> we shouldn't change that advice.
>>>
>>> I'm meaning to send some doc changes to git-gc.txt, but in the
>>> meantime let's address this low-hanging fruit of running gc --auto
>>> when we revert or cherry-pick commits, which can like git-commit
>>> create a significant amount of loose objects.
>>>
>>>   builtin/revert.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/builtin/revert.c b/builtin/revert.c
>>> index 9a66720cfc..1b20902910 100644
>>> --- a/builtin/revert.c
>>> +++ b/builtin/revert.c
>>> @@ -209,6 +209,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>>>   {
>>>   	struct replay_opts opts = REPLAY_OPTS_INIT;
>>>   	int res;
>>> +	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
>>>
>>>   	if (isatty(0))
>>>   		opts.edit = 1;
>>> @@ -217,6 +218,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>>>   	res = run_sequencer(argc, argv, &opts);
>>>   	if (res < 0)
>>>   		die(_("revert failed"));
>>> +	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>>>   	return res;
>>>   }
>>>
>>> @@ -224,11 +226,13 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>>>   {
>>>   	struct replay_opts opts = REPLAY_OPTS_INIT;
>>>   	int res;
>>> +	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
>>>
>>>   	opts.action = REPLAY_PICK;
>>>   	sequencer_init_config(&opts);
>>>   	res = run_sequencer(argc, argv, &opts);
>>>   	if (res < 0)
>>>   		die(_("cherry-pick failed"));
>>> +	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
>>>   	return res;
>>>   }
>>>

