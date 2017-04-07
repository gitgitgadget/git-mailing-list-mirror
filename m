Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9DD520966
	for <e@80x24.org>; Fri,  7 Apr 2017 14:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755931AbdDGOFe (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 10:05:34 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:54096 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755430AbdDGOFd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 10:05:33 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0McFi3-1cd2Fy0sUh-00Jex4; Fri, 07 Apr 2017 16:05:29 +0200
Subject: Re: [PATCH] status: show in-progress info for short status
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20170406143342.14770-1-szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <33eebca1-b78f-1e9c-539c-120e32ecfded@grubix.eu>
Date:   Fri, 7 Apr 2017 16:05:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170406143342.14770-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:v4BhCGi0fxLtPjru/DvXi9/koUMg/UQlYZaWrehAQXw5mbGXNpS
 zFuk8Cr6e90v/HGfu1uKcV9jZUoMMPlv0TKvb8wURQeI58hC9/74pPba6RMSohHEbPnjW9W
 MiU9RIB3I8pmHymOr2NslDfeqbGNp/Ldn3OAvCYzObWmt1mi0h7y9n15ZIP7dyD+8PT/QVL
 senDu+r3TxjQAIGGP4mBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v0Kgn4OucLk=:BWlisxf6fRBoOoWk/nt82+
 CDZjgIH+A+FHJzP7jIDfBmHd5RiFaw1vFG6ZjABy9g3lJgSSq1Wt0rSf4K+eA/86/NhwP48Q/
 GsY72ZAF7h4NTyA14b1xA5/Jl/y8ZfJdVhVkgVXt83aoVJpQDTFBDlVNhAXihUmthwr+QoBkk
 PQuzQ2JYG2h6AgqvVAmfp5eNSEbERaxjzBuS3CQqRcR8F8vgndX2Kh1prA8LhpD3zFBfDIsa6
 hdLUZcWUMUKw+ijAyMp6Z4M7BfIVsKwML8MUbnMIKGSuiv2tG0RZt8qAV8jii92bW3BfcKObh
 ttkvbKO1FzStnxCBeEakRK4y4DKLsYKUuo87oeclNWlptfTfaaccWa0HL7IZJQr9T+u4/un6J
 py4jCWtxXBnC+7VctlUOSO+F//06g7vDxR+Zt5rwKMeLNOXfF2RMNEDuk+8AzyVXxOFh4xsRb
 lSQnQY/ItdD2PrqMDDIaS3AkdpQoLFmQL7ctTCYDf+H1G0hjCRQxjOXsCDDEJUAdwskzgrC8a
 7b1tySEAA/6B/k+joz9GpvYiQkdmVkwYBxo9gQ+aWv3mDisNk5+MjAEudtuMyM79yxgVV97Ip
 Vd0+lcQ9Uzksd5DAEaNcYxfAKFt6FBHr/es1jgEOaKnErtC3WIVE2bgCiihmBRkjnVrte1pmU
 31wf9j9KG2JVSfu6IA+DRiW13okxov6eiNp7TnG+Vw/c1Lifq+ByjBITlYvKv/iIAMFR1O6vd
 p0tfet3uXa29MfAB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor venit, vidit, dixit 06.04.2017 16:33:
>> @@ -1779,6 +1780,31 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>>  	}
>>  
>>  	color_fprintf(s->fp, header_color, "]");
>> +
>> + inprogress:
>> +	if (!s->show_inprogress)
>> +		goto conclude;
>> +	memset(&state, 0, sizeof(state));
>> +	wt_status_get_state(&state,
>> +			    s->branch && !strcmp(s->branch, "HEAD"));
>> +	if (state.merge_in_progress)
>> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("MERGING")));
>> +	else if (state.am_in_progress)
>> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("AM")));
>> +	else if (state.rebase_in_progress)
>> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REBASE-m")));
>> +	else if (state.rebase_interactive_in_progress)
>> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REBASE-i")));
>> +	else if (state.cherry_pick_in_progress)
>> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("CHERRY-PICKING")));
>> +	else if (state.revert_in_progress)
>> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REVERTING")));
>> +	if (state.bisect_in_progress)
> 
> else if?

No. You can do all of the above during a bisect.

> 
>> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("BISECTING")));
>> +	free(state.branch);
>> +	free(state.onto);
>> +	free(state.detached_from);
>> +
>>   conclude:
>>  	fputc(s->null_termination ? '\0' : '\n', s->fp);
>>  }
> 
> This reminded me of a patch that I have been using for almost two
> years now...
> 
> git-prompt.sh's similar long conditional chain to show the ongoing
> operation has an else-branch at the end showing "AM/REBASE".  Your
> patch doesn't add an equivalent branch.  Is this intentional or an
> oversight?

I go over all states that wt_status_get_state can give.

> I suppose it's intentional, because that "AM/REBASE" branch in the
> prompt seems to be unreachable (see below), but I never took the
> effort to actually check that (hence the "seems" and that's why I
> never submitted it).

Note that wt_status_get_state and the prompt script do things quite
differently.

I suppose that the prompt could make use of the in-progress info being
exposed by "git status" rather doing its on thing.

Michael
