Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4482018E
	for <e@80x24.org>; Fri,  5 Aug 2016 18:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936030AbcHESNZ (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 14:13:25 -0400
Received: from siwi.pair.com ([209.68.5.199]:35112 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936010AbcHESNY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 14:13:24 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 25A99845E9;
	Fri,  5 Aug 2016 14:13:22 -0400 (EDT)
Subject: Re: [PATCH v4 6/8] status: print branch info with --porcelain=v2
 --branch
To:	Junio C Hamano <gitster@pobox.com>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
 <1470147137-17498-7-git-send-email-git@jeffhostetler.com>
 <xmqqd1lnxi99.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57A4D6C4.3010501@jeffhostetler.com>
Date:	Fri, 5 Aug 2016 14:11:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqd1lnxi99.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 08/05/2016 01:01 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
>
>>   /*
>> + * Print branch information for porcelain v2 output.  These lines
>> + * are printed when the '--branch' parameter is given.
>> + *
>> + *    # branch.oid <commit><eol>
>> + *    # branch.head <head><eol>
>
> Just bikeshedding, but ...
>
>> +	if (!s->branch)
>> +		fprintf(s->fp, "# branch.head %s%c", "(unknown)", eol);
>> +	else {
>> +		if (!strcmp(s->branch, "HEAD")) {
>> +			fprintf(s->fp, "# branch.head %s%c", "(detached)", eol);
>> +
>> +			if (state.rebase_in_progress || state.rebase_interactive_in_progress)
>> +				branch_name = state.onto;
>> +			else if (state.detached_from)
>> +				branch_name = state.detached_from;
>> +			else
>> +				branch_name = "";
>> +		} else {
>> +			branch_name = NULL;
>> +			skip_prefix(s->branch, "refs/heads/", &branch_name);
>> +
>> +			fprintf(s->fp, "# branch.head %s%c", branch_name, eol);
>
> ... given that we are showing branch name, perhaps "branch.name"
> instead of "branch.head" is more appropriate?

Either way is fine with me.  I just saw your comments on
commit v4-7/8. And leaving it as is is fine.

>
> I wondered if "# " prefix before these lines is useful, by the way,
> and initially thought that the fact that these lines begin with
> "branch." and not with the "1/2/u $key" sufficient clue for whoever
> reads them, but the reader can tell which kind of record it is by
> reading the first two characters of each line (i.e. if "# " that is
> not the usual "change info for a single file"), so it is actually a
> good idea.

Yes, I used the "#" prefix to indicate a header line so that
parsers can always look at the first character and decide.

I set it up so the "--branch" argument creates "# branch.*" headers.

In my first patch series, I included worktree state information
(such as in-a-rebase and the rebase step counts), but it was thought
that that should be an independent effort. So, using this model,
if we later do add a "--state" argument, it would create "# state.*"
headers.  And we would not have to change the --porcelain=v2 version
number.


Jeff
