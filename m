Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50CFC1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 22:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfAaWdT (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 17:33:19 -0500
Received: from siwi.pair.com ([209.68.5.199]:50859 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfAaWdT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 17:33:19 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1788E3F408C;
        Thu, 31 Jan 2019 17:33:18 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DEB2A3F4042;
        Thu, 31 Jan 2019 17:33:17 -0500 (EST)
Subject: Re: [PATCH v4 01/14] trace2: Documentation/technical/api-trace2.txt
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
 <pull.108.v4.git.gitgitgadget@gmail.com>
 <60b56d6a8fe9c0e37563f66809cc12c98c9eb21d.1548881779.git.gitgitgadget@gmail.com>
 <20190131141127.GA10587@szeder.dev>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0384b5e0-e2e2-710f-2e37-1dff96aac143@jeffhostetler.com>
Date:   Thu, 31 Jan 2019 17:33:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190131141127.GA10587@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/31/2019 9:11 AM, SZEDER Gábor wrote:
> On Wed, Jan 30, 2019 at 12:56:21PM -0800, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
>> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> 
>> +== Public API
> 
>> +=== Command Detail Messages
>> +
>> +These are concerned with describing the specific Git command
>> +after the command line, config, and environment are inspected.
>> +
>> +`void trace2_cmd_verb(const char *command_verb)`::
>> +
>> +	Emits a "cmd_verb" message with the canonical name of
>> +	(usually) builtin command, for example "status" or "checkout".
>> +
>> +`void trace2_cmd_subverb(const char *command_subverb)`::
>> +
>> +	Emits a "cmd_subverb" message with a qualifier name to further
>> +	describe the current git command.
> 
> OK, so now we know what is meant by 'verb' and 'subverb'.
> 
> Alas, this explanation also clearly shows that the word 'verb' is a
> poor fit for what it tries to convey, and 'subverb' is even worse.

How can we resolve this?

I've been using the term "command" (1) to refer to the entire lifetime
of a git command (process/instance/invocation).  Trace2 issues a series
of trace messages over that life of the process that all have a unique
id.  This allows multiple concurrent processes to write to the same
file and yet be able to associate all of the messages from a single
command instance.

I've been using the term "verb" (2) to the action -- i.e. "status" in
a "git status" command and "fetch" in a "git fetch" command.

I've been using the term "subverb" (3) to refer to the variant when
there are major differences.

What would be better choices for these 3 concepts?

Would something like "process", "command", and "mode" be better?
Or maybe "process", "command", and "command-mode"?

I'd rather not use the term "subcommand" because it already has mixed
usage.
[] See git_more_info_string[] in git.c and list_all_cmd_help()
    in help.c where both "command" and "subcommand" are used
    interchangeably.
[] And yet another completely different usage in git-submodule
    and bisect where "subcommand" is used to mean the 3rd token
    on the command line after the "command".

Suggestions?
Jeff


