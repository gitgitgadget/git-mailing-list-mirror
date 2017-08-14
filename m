Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7A0720899
	for <e@80x24.org>; Mon, 14 Aug 2017 20:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbdHNUUD (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 16:20:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54001 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751540AbdHNUT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 16:19:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A33CB955F3;
        Mon, 14 Aug 2017 16:19:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DKAsC8mOESRDkvZWf40YSKoEaFg=; b=LU57oV
        ZYdZqaX6bPdCpTnPVG42JahWnLiZmn0Nim7lMbi1kKmAtX0XDlssjX1J0aqWbtV5
        Jy5Gp7ugbT9RoKewoHfafXv8z2yX7/YvOcKfK9u90nopl9OJE93VdmFCeGsn6CBI
        avh9D8Im/NURLmfZW/b/PkVwqzp95P5urgxE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cGfr4DCSEWWbH4fQITLql0Vw/u7rDKdt
        M2n01Yqag7M856gM2BaIuqVCLPmUJw5F8RwYopElr+fBmk3Gwh+kHu+qe9N6WzOT
        MtD0GwivrCLg4eVNMPAlMXfLxFTBD0Fasa/ywDJGkL97F8JG5+7ll9yJpJNwfqdK
        OwEgb/t8N14=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B04F955F2;
        Mon, 14 Aug 2017 16:19:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F183F955F1;
        Mon, 14 Aug 2017 16:19:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com
Subject: Re: [PATCH v3 1/2 / RFC] builtin/branch: stop supporting the use of --set-upstream option
References: <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
        <20170814085442.31174-1-kaarticsivaraam91196@gmail.com>
Date:   Mon, 14 Aug 2017 13:19:55 -0700
In-Reply-To: <20170814085442.31174-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 14 Aug 2017 14:24:42 +0530")
Message-ID: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0B5BEA8-812D-11E7-BB4D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The '--set-upstream' option of branch was deprecated in,
>
>     b347d06bf branch: deprecate --set-upstream and show help if we
>     detect possible mistaken use (Thu, 30 Aug 2012 19:23:13 +0200)
>
> It was deprecated for the reasons specified in the commit message of the
> referenced commit.

I wonder if these two lines add any value here.  Those who know the
reason would not be helped, and those who don't know have to view
"git show b347d06bf" anyway.

> Make 'branch' die with an appropraite error message when the '--set-upstream'
> option is used.

OK.

> Note that there's a reason behind "dying with an error message" instead of
> "not accepting the option". 'git branch' would *accept* '--set-upstream'
> even after it's removal as a consequence of,
>
>         Unique prefix can be abbrievated in option names
>
>                           AND
>
>     '--set-upstream' is a unique prefix of '--set-upstream-to'
>        (when the '--set-upstream' option has been removed)
>
> In order to smooth the transition for users and to avoid them being affected
> by the "prefix issue" it was decided to make branch die when seeing the
> '--set-upstream' flag for a few years and let the users know that it would be
> removed some time in the future.

I somehow think the above wastes bits a bit too much.  Wouldn't it
be sufficient to say

    In order to prevent "--set-upstream" on a command line from
    being taken as an abbreviated form of "--set-upstream-to",
    explicitly catch "--set-upstream" option and die, instead of
    just removing it from the list of options.

>     $ git branch --set-upstream origin/master
>     The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
>     Branch origin/master set up to track local branch master.

> After,
>
>     $ git branch
>     * master
>
>     $ git branch --set-upstream origin/master
>     fatal: the '--set-upstream' flag is no longer supported and will be removed. Consider using '--track' or '--set-upstream-to'

Because from the end-user's point of view, it has already been
removed, I'd phrase it more like

	The --set-upstream option has been removed.  Use --track or ...

and make sure we do not list "--set-upstream" in the list of
supported options in

	git branch -h

output.

>  A query,
>
>     I see the following code in the code path a little above the die statement
>     added in this change,
>
>             if (!strcmp(argv[0], "HEAD"))
>     		    	die(_("it does not make sense to create 'HEAD' manually"));
>
>     It does seem to be doing quite a nice job of avoiding an ambiguity that could
>     have bad consequences but it's still possible to create a branch named 'HEAD'
>     using the '-b' option of 'checkout'. Should 'git checkout -b HEAD' actually
>     fail(it does not currently) for the same reason 'git branch HEAD' fails?
>
>     My guess is that people would use 'git checkout -b <new_branch_name> <starting_point>'
>     more than it's 'git branch' counterpart.    

Thanks for noticing.  I offhand see no reason not to do what you
suggest above.

> -		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
> +		OPT_SET_INT( 0, "set-upstream",  &track, N_("no longer supported"),
>  			BRANCH_TRACK_OVERRIDE),

Here we would want to use something like

	{ OPTION_SET_INT, 0, "set-upstream", &track, NULL, N_("do not use"),
	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, BRANCH_TRACK_OVERRIDE },

in order to hide the option from "git branch -h" output.

All review comments from Martin were also good ones, and I won't
repeat them here.

Thanks.


