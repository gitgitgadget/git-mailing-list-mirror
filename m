From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-gc: by default use safer "-A" option to repack when
 not --prune'ing
Date: Wed, 10 Oct 2007 19:26:19 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0710101918060.30020@torch.nrlssc.navy.mil>
References: <470D6509.5020607@nrlssc.navy.mil> <Pine.LNX.4.64.0710110106160.4174@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 02:26:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iflsp-0006C6-25
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 02:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbXJKA0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 20:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbXJKA0Z
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 20:26:25 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58526 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbXJKA0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 20:26:25 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l9B0QJPb005321;
	Wed, 10 Oct 2007 19:26:20 -0500
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Oct 2007 19:26:19 -0500
In-Reply-To: <Pine.LNX.4.64.0710110106160.4174@racer.site>
X-OriginalArrivalTime: 11 Oct 2007 00:26:19.0216 (UTC) FILETIME=[57E07D00:01C80B9D]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15336001
X-TM-AS-Result: : Yes--17.371900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3My03MDA4?=
	=?us-ascii?B?ODctNzAwMDc1LTEzOTAxMC03MDE3NDYtNzA4MzM5LTcwNDQzMC03?=
	=?us-ascii?B?MDMxNTctNzA0NzQ3LTcwMjExOC03MDIzNTgtNzAwNzcxLTcwMTcx?=
	=?us-ascii?B?OS03MDUxMDItNzAzNzg4LTcwNjUzOC03MDQ0MjEtNzA2MjQ5LTcw?=
	=?us-ascii?B?NzQ1MS03MTExMDktNzA4Nzk3LTcwMTQ1NS03MDI3MjYtNzA2NzE5?=
	=?us-ascii?B?LTcwMTkxNC03MDAzMjQtNzAxMjAyLTcwMTAwNS03MDA4MTAtNzAy?=
	=?us-ascii?B?MDIwLTcwNTAwNC03MDAxMDctMTQ4MDM5LTE0ODA1MC0yMDA0Mw==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60573>

On Thu, 11 Oct 2007, Johannes Schindelin wrote:

> Hi,
>
> On Wed, 10 Oct 2007, Brandon Casey wrote:

<snip>

> This is a nice cleanup, but it does not belong in this patch.

I was thinking the same thing right after I sent it off.

>
>> @@ -211,6 +205,16 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>  		prune = 0;
>>  		if (!need_to_gc())
>>  			return 0;
>> +	} else {
>> +		/*
>> +		 * Use safer (for shared repos) "-A" option to
>> +		 * repack when not pruning. Auto-gc makes its
>> +                 * own decision.
>> +		 */
>> +		if (prune)
>> +			append_option(argv_repack, "-a", MAX_ADD);
>> +		else
>> +			append_option(argv_repack, "-A", MAX_ADD);
>>  	}
>>
>>  	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
>
> To use the append_option() function, you need to make sure that the argv
> has enough space, so I suggest adding another NULL to argv_repack[].  This
> is enough, since you only ever add one option.  But you should mention it
> somewhere, probably above the definition of argv_repack[].

Shouldn't argv_repack have space for MAX_ADD (10) items?

append_option() is already used with argv_repack when --aggressive is
used.

> Other than that: I think your patch makes tons of sense; much better than
> what I tried to cobble together with the cyclic alternates detection.

Thanks.

-brandon
