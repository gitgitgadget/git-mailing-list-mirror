Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D601F404
	for <e@80x24.org>; Tue, 28 Aug 2018 18:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeH1WkN (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 18:40:13 -0400
Received: from siwi.pair.com ([209.68.5.199]:38463 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeH1WkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 18:40:13 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 40E493F4089;
        Tue, 28 Aug 2018 14:47:15 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0BCC43F4090;
        Tue, 28 Aug 2018 14:47:15 -0400 (EDT)
Subject: Re: [PATCH v1 00/25] RFC: structured logging
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
 <xmqqd0u2gzma.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4bc19d36-1242-9e83-a9ed-ed58a681b499@jeffhostetler.com>
Date:   Tue, 28 Aug 2018 14:47:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0u2gzma.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/28/2018 1:38 PM, Junio C Hamano wrote:
> git@jeffhostetler.com writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> This RFC patch series adds structured logging to git.  The motivation,
>> ...
>>
>> Jeff Hostetler (25):
>>    structured-logging: design document
>>    structured-logging: add STRUCTURED_LOGGING=1 to Makefile
>>    structured-logging: add structured logging framework
>>    structured-logging: add session-id to log events
>>    structured-logging: set sub_command field for branch command
>>    structured-logging: set sub_command field for checkout command
>>    structured-logging: t0420 basic tests
>>    structured-logging: add detail-event facility
>>    structured-logging: add detail-event for lazy_init_name_hash
>>    structured-logging: add timer facility
>>    structured-logging: add timer around do_read_index
>>    structured-logging: add timer around do_write_index
>>    structured-logging: add timer around wt-status functions
>>    structured-logging: add timer around preload_index
>>    structured-logging: t0420 tests for timers
>>    structured-logging: add aux-data facility
>>    structured-logging: add aux-data for index size
>>    structured-logging: add aux-data for size of sparse-checkout file
>>    structured-logging: t0420 tests for aux-data
>>    structured-logging: add structured logging to remote-curl
>>    structured-logging: add detail-events for child processes
>>    structured-logging: add child process classification
>>    structured-logging: t0420 tests for child process detail events
>>    structured-logging: t0420 tests for interacitve child_summary
>>    structured-logging: add config data facility
> 
> 
> I noticed that Travis job has been failing with a trivially fixable
> failure, so I'll push out today's 'pu' with the attached applied on
> top.  This may become unapplicable to the code when issues raised in
> recent reviews addressed, though.
> 
>   structured-logging.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/structured-logging.c b/structured-logging.c
> index 0e3f79ee48..78abcd2e59 100644
> --- a/structured-logging.c
> +++ b/structured-logging.c
> @@ -593,8 +593,7 @@ void slog_set_command_name(const char *command_name)
>   	 * the cmd_<command>() and/or it may be too early to force a
>   	 * lazy load.
>   	 */
> -	if (my__command_name)
> -		free(my__command_name);
> +	free(my__command_name);
>   	my__command_name = xstrdup(command_name);
>   }
>   
> @@ -606,8 +605,7 @@ void slog_set_sub_command_name(const char *sub_command_name)
>   	 * the cmd_<command>() and/or it may be too early to force a
>   	 * lazy load.
>   	 */
> -	if (my__sub_command_name)
> -		free(my__sub_command_name);
> +	free(my__sub_command_name);
>   	my__sub_command_name = xstrdup(sub_command_name);
>   }
>   
> 

Sorry about that.

Let me withdraw the current series.  I'm working on a new version that
addresses the comments on the mailing list.  It combines my logging
with a variation on the nested perf logging that Duy suggested and
the consolidation that you were talking about last week.

Jeff

