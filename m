Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7971320A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 04:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeLMEUf (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 23:20:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56316 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMEUe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 23:20:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so890488wmc.5
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 20:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SAt5Kx0QBaS8RH0sopqmPvc2WZ7u4ZSs2TOdigeN0ps=;
        b=bIlgUKjDSlNWplXFE6wVr+zzUxniJAiNd8sz5fkuPLQNDoMXE5dmIdYjIC3gunUvXL
         pc5eh2mnxxT54L465FK6aeNKOlDSw8hl/nbdn08m2F7TV7JB0vJWEaOVyA3Z66H+g2Nf
         ox+NwA9xhtWWpCS1s/gNdoojVP79Z14JYDpkHFr6pOynjBYpsR25ySB3SgSecoBjcOY2
         sOclZi1aBIf2W9Njl1DdV827HCFTlwereDKMiCC25k+N5lrTpmJn4JopBtXyt1IB6Myv
         xndx+UvpMCquKJJGzKxF/JL611hpw8+R0ngKN8rC8KebjuWXkezDaROEEYpNVdurTfIR
         oUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SAt5Kx0QBaS8RH0sopqmPvc2WZ7u4ZSs2TOdigeN0ps=;
        b=WiYYVou1DHntra/gPPdNJiCKqQIwuATokx3EhwgEq/MR3V/mR+ip/ow/xu4Nh15htA
         EqMKziVU4o835rCNvKI5XrAXqTvfi3m9byAXvz7pPzb+rst1RbP7/y4jaiyy4pcy9MLV
         zG06BtaUXDnBV5p8lxnL3Jua0+BdnpzkdEu7JABhoB67QWW2HMbw9KZluHJAGbJGo7j1
         un5IgNAFs9UnyGXncxKL5hi+03WlMVlY5KjNbM3xPLF83cUUNTy2dYZE2aYUmfa9aNcH
         e9iiZZJN9bYDOdfW08yKFYhosy9WoMdrAENaLrZtaRNS20IpirzMwQf/2Xlf/knJCotA
         mBuw==
X-Gm-Message-State: AA+aEWavl9AzPaS80zpBT7Bfw58bPtHGBWm4g/INODVR2pzg2qF4rLD/
        hc6QBmALVp2Fbn5Q0tWNH+4=
X-Google-Smtp-Source: AFSGD/UeOtdbbc7aX2CgUIe2Gz61GHYJiZkA99BS6eQ2xRf8h+yMYbc4h2yV+esdj6/yEWwC3Y9xPw==
X-Received: by 2002:a1c:f8f:: with SMTP id 137mr8419927wmp.96.1544674832572;
        Wed, 12 Dec 2018 20:20:32 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j14sm452449wrv.96.2018.12.12.20.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 20:20:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is specified
References: <87efh0pdln.fsf@javad.com>
        <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
        <871s6n5mtd.fsf@javad.com>
Date:   Thu, 13 Dec 2018 13:20:29 +0900
In-Reply-To: <871s6n5mtd.fsf@javad.com> (Sergey Organov's message of "Wed, 12
        Dec 2018 08:35:58 +0300")
Message-ID: <xmqqo99qf46q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> When cherry-picking multiple commits, it's impossible to have both
> merge- and non-merge commits on the same command-line. Not specifying
> '-m 1' results in cherry-pick refusing to handle merge commits, while
> specifying '-m 1' fails on non-merge commits.
>
> This patch allows '-m 1' for non-merge commits. Besides, as mainline is
> always the only parent for a non-merge commit, it made little sense to
> disable it in the first place.


The feature to give a range to cherry-pick came much much later in
7e2bfd3f ("revert: allow cherry-picking more than one commit",
2010-06-02) that first appeared in v1.7.2.  The feature to allow
picking a merge commit came in 7791ecbc ("revert/cherry-pick: work
on merge commits as well", 2007-10-23), first appeared in v1.5.4.

In the original context to pick a single commit, it made perfect
sense to avoid mistakes by blindly passing '-m 1' to non-merge
commit.  It may be fair to say that we failed to reconsider what to
do with '-m 1' when we did 7e2bfd3f, but it is utterly an unfair 
history revisionism to say that it made little sense to disable it
in the first place.

The change to the code itself looks sane, but applying this patch
alone will break existing tests whose expectations must be updated,
and this new behaviour must be protected by a new test (or two) so
that we won't accidentally stop accepting "-m 1" for a single-parent
commit.

Thanks.

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  sequencer.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index e1a4dd1..d0fd61b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1766,9 +1766,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  			return error(_("commit %s does not have parent %d"),
>  				oid_to_hex(&commit->object.oid), opts->mainline);
>  		parent = p->item;
> -	} else if (0 < opts->mainline)
> -		return error(_("mainline was specified but commit %s is not a merge."),
> -			oid_to_hex(&commit->object.oid));
> +	} else if (1 < opts->mainline)
> +		/*
> +		 *  Non-first parent explicitly specified as mainline for
> +		 *  non-merge commit
> +		 */
> +		return error(_("commit %s does not have parent %d"),
> +			     oid_to_hex(&commit->object.oid), opts->mainline);
>  	else
>  		parent = commit->parents->item;
