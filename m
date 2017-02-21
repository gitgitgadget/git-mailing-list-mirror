Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2642022D
	for <e@80x24.org>; Tue, 21 Feb 2017 16:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbdBUQzU (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 11:55:20 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35464 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752935AbdBUQzS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 11:55:18 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so11893613pgz.2
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 08:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eIMXm7XG5N7Y8qMUqwbFN3N+/LiarLUtxdycBgCWgtc=;
        b=avgKgDqUdlpRWsK6884TCvCafMN4bZU5gNhCvfuSO6QNDc+Sf1MdsOe8GGFhZBAbU2
         ElLDaJeKcf451YlHcRNYLP9AX+DKxzr+MtRxhSIBGXDYxyNKIqlgvzK5oQ76kq4QEhuS
         wf/7Sg4QOXf0OISFE60wrr2Erzyj8iehkYg3zzQ4cb6wUZOz91qQD6Cuztluqw13a13o
         qXJfFTSSElr+SniYFeuxl6JPsGsUonaP1O6hdfN2+RUDRVCO7gmIivd/ZGh/t0x9Ulg7
         /ODn4TejVNMrpbqadqhthHMy83SXn+bw27AYI7tCj/GjHlwV6hx3ZFKizIh14ow1L+rT
         0vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eIMXm7XG5N7Y8qMUqwbFN3N+/LiarLUtxdycBgCWgtc=;
        b=P0HBtHIYf8ioc44GOw7xdL8X5VpKEaRX3Zx8j4VdRWS2mj4ufcG0KENkelm0vsT7SY
         iiaxXvuKbaFjfrFbiyLBlQz3oE3GEMyrUJj50qi3sVkXHODHcw1l86Zy+opB3EyKvXVg
         BJ/0nqFKCFE5FZc3JTxTusBbe9+cDe8DMftBhb9WJLe+yed27eZsyX2oXKEUongeaHAD
         qnzsibWq7PvuYscRRXq+iYeuP27g1DYOdUmuqtITy6MM3yvz6BMJruQw+OMlS6hei20c
         kTddSOOwFYNo8HRl1xbnlGJDgA4nYhLbvSeDNLTuU5gWjtSjvzBUmZcwehl70fHLtUTE
         qLcg==
X-Gm-Message-State: AMke39lHEhKOYvg36o3e5t8ms8t9Q1/fdLE2nlSCFit9t2WxGjiI67ZPXwFbPFUauM7ZqA==
X-Received: by 10.98.21.196 with SMTP id 187mr28245516pfv.110.1487696117615;
        Tue, 21 Feb 2017 08:55:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id o18sm31560358pgn.36.2017.02.21.08.55.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 08:55:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        <sunny@sunbase.org>,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 4/6] stash: teach 'push' (and 'create_stash') to honor pathspec
References: <20170217224141.19183-1-t.gummerer@gmail.com>
        <20170219110313.24070-1-t.gummerer@gmail.com>
        <20170219110313.24070-5-t.gummerer@gmail.com>
Date:   Tue, 21 Feb 2017 08:55:16 -0800
In-Reply-To: <20170219110313.24070-5-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 19 Feb 2017 11:03:11 +0000")
Message-ID: <xmqqmvdfh4az.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> -		git reset --hard ${GIT_QUIET:+-q}

This hunk is probably the most important one to review in the whole
series, in the sense that these are entirely new code that didn't
exist in the original.

> +		if test $# != 0
> +		then
> +			saved_untracked=
> +			if test -n "$(git ls-files --others -- "$@")"

I notice that "ls-files -o" used in the code before this series are
almost always used with --exclude-standard but we do not set up the
standard exclude pattern here.  Is there a good reason to use (or
not to use) it here as well?

> +			then
> +				saved_untracked=$(
> +					git ls-files -z --others -- "$@" |
> +					    xargs -0 git stash create -u all --)
> +			fi

Running the same ls-files twice look somewhat wasteful.

I suspect that we avoid "xargs -0" in our code from portability
concern (isn't it a GNU invention?)

> +			git ls-files -z -- "$@" | xargs -0 git reset ${GIT_QUIET:+-q} --

Hmm, am I being naive to suspect that the above is a roundabout way
to say:

	git reset ${GIT_QUIET:+-q} -- "$@"

or is an effect quite different from that intended here?

> +			git ls-files -z --modified -- "$@" | xargs -0 git checkout ${GIT_QUIET:+-q} HEAD --

Likewise.  Wouldn't the above be equivalent to:

	git checkout ${GIT_QUIET:+-q} HEAD -- "$@"

Or is this trying to preserve paths modified in the working tree and
fully added to the index?


> +			if test -n "$(git ls-files -z --others -- "$@")"
> +			then
> +				git ls-files -z --others -- "$@" | xargs -0 git clean --force -d ${GIT_QUIET:+-q} --

Likewise.  "ls-files --others" being the major part of what "clean"
is about, I suspect the "ls-files piped to clean" is redundant.  Do
you even need a test?  IOW, doesn't "git clean" with a pathspec that
does not match anything silently succeed without doing anything
harmful?

> +			fi
> +			if test -n "$saved_untracked"
> +			then
> +				git stash pop -q $saved_untracked

I see this thing was "created", and the whole point of "create" is
to be different from "save/push" that automatically adds the result
to the stash reflog.  Should we be "pop"ing it, or did you mean to
just call apply_stash on it?

> +			fi
> +		else
> +			git reset --hard ${GIT_QUIET:+-q}
> +		fi

