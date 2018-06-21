Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8DA71F516
	for <e@80x24.org>; Thu, 21 Jun 2018 15:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933269AbeFUPyV (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 11:54:21 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45418 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933218AbeFUPyV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 11:54:21 -0400
Received: by mail-wr0-f193.google.com with SMTP id o12-v6so3715043wrm.12
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1A7r8qSRxDgK94ozNXcbt6ruD2GPJilo05pbWOCFDYg=;
        b=gZMT1XiWn6PewNKfdRSMSp41b5Of2o0aZuP4uVF/pyeqGbUyK/ho6DGfmRcZUkjdzn
         8sFy7ZO0H4CQtTWHNXWrfJ+Yn2KwbQa3TyMXn5617jf6YSLWk+LpN64PfzI2Vb7tNziO
         3GADDdpj8oGUgrJt52SidroIgbrM8vv/hQgqTwbnaqbbadZuRWVDgJvUpB3IS1bYEsAC
         lBtVORd0glS0xIvRRb0YVskB+bTcokqBgQZ3Jwi70Ez+TNkz+IUoLP602frV4kko5dIT
         BEguTPeM3GikA+b66bjs+vQdB99TYothcjif51Fg38BJ+UFRkjY0LernRgRmMQaVCheP
         EhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1A7r8qSRxDgK94ozNXcbt6ruD2GPJilo05pbWOCFDYg=;
        b=pZe8Z5JeMvo2iXNAXtgl9Gc6eBb3DxY2fxDBXObJsMmxQlM8nBvtL7V0r0wonzuLNj
         x7ZSj+1VLp94Oi4NGqh6mKsGgmmngPw5knmsYuVTFw0YjW04fIbX5LlIv5lCnCZCjpAC
         61yzmh/XotIdidEliIU+Odogs+bA0tHw3izII64eIxdyOhYBWwQj0dWRjPrDPUhvKCpJ
         Ei1ZplNljt8VSnnBS2GXusVS/YS2bmYuf6/7zQmkqpcf0r1J0sUNoT+V4WoBo4BvRBS3
         VLVqJE0iWfYxeXOoMbuEpMFGigq88jOJen5D3Ylpuz3x6UuRpyfeXKKUaW8s2TqnrfBv
         giIw==
X-Gm-Message-State: APt69E3mUjzsYodxSoGHNjC+XSCieRtApM0MaZ3Ba+DLSf7K5XoiA4Gg
        tzoAOEjDt7BkyKvmeelp9ZU=
X-Google-Smtp-Source: ADUXVKJYWACpmdKvpePbee5k+Cu98uBfOcuK3bWdQPdjZz+1zNqqyjjrkXP38uS3ysW2iiZTxCddZg==
X-Received: by 2002:adf:ff09:: with SMTP id k9-v6mr24210387wrr.15.1529596459466;
        Thu, 21 Jun 2018 08:54:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b124-v6sm8558419wmf.11.2018.06.21.08.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 08:54:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is specified
References: <87efh0pdln.fsf@javad.com>
Date:   Thu, 21 Jun 2018 08:54:17 -0700
In-Reply-To: <87efh0pdln.fsf@javad.com> (Sergey Organov's message of "Fri, 25
        May 2018 15:42:03 +0300")
Message-ID: <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
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

Allowing "-m1" even when picking a single parent commit, because
the 1-st parent is defined for such a commit, makes sense, espeially
when running a cherry-pick on a range, exactly for the above reason.
It is slightly less so when cherry-picking a single commit, but not
by a large margin.

I think the original reasoning for requiring "-m $n" not present,
especially because cherry-pick was originally for replaying only a
single commit, was because it would lead somebody to propose that
the command should behave as if -m1 is always given (and when trying
to cherry-pick a merge relative to its second parent, give -m2 to
override it), which in turn encourage the 'first-parent is special'
world-view from the tool-side.  IOW, "The worldview to treat the
first-parent chain specially is correct, because Git has many
features to work with that worldview conveniently" was something we
wanted to avoid; rather "Such and such workflows benefit from
treating the first-parent chain specially, so let's add features to
do so" was we wanted to do, and of course, back then cherry-pick
that allows mixture of merges and single-parent commits to be
picked, which would have made the need to do something like this
patch does felt greater, did not exist.

Now, it appears, at least to me, that the world pretty much accepted
that the first-parent worldview is often very convenient and worth
supporting by the tool, so the next logical step might be to set
opts->mainline to 1 by default (and allow an explicit "-m $n" from
the command line to override it).  But that should happen after this
patch lands---it is logically a separate step, I would think.

> This patch allows '-m 1' for non-merge commits. Besides, as mainline is
> always the only parent for a non-merge commit, it made little sense to
> disable it in the first place.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  sequencer.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

>
> diff --git a/sequencer.c b/sequencer.c
> index 1ce6326..2393bdf 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1543,9 +1543,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  			return error(_("commit %s does not have parent %d"),
>  				oid_to_hex(&commit->object.oid), opts->mainline);
>  		parent = p->item;
> -	} else if (0 < opts->mainline)
> -		return error(_("mainline was specified but commit %s is not a merge."),
> -			oid_to_hex(&commit->object.oid));
> +	} else if (1 < opts->mainline)
> +		/* Non-first parent explicitly specified as mainline for
> +		 * non-merge commit */

Style.

	/*
	 * Our multi-line comments are to be
	 * formatted like this.
	 */

> +		return error(_("commit %s does not have parent %d"),
> +			     oid_to_hex(&commit->object.oid), opts->mainline);
>  	else
>  		parent = commit->parents->item;
