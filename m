Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BA601FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 07:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbdDQHGW (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 03:06:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56867 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932719AbdDQHGU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 03:06:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38DB68D266;
        Mon, 17 Apr 2017 03:06:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NrxUPOCc6NzeMd4vNaNIew+tLWw=; b=iWk9IP
        cmmXppAv7Oa0YlOHxwOLt2nOmbr8BfPpzkezeRLloBM986OoxQYlPAdx2gnHJF2U
        QW5hNdfo43+iqQKqxmxktfA3+8QEMdGhtQuOONdi+GA4VFwZiTU5xBwhGQsx0iP0
        AjEXVHMlJxZ/GLke6K8dY/xn9stasB8pBb0S8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JhL/PP67hK0c4kosEJEN6J3ZWgFK3nMd
        GTKJroEebE6Z6RZ24UYfx3jLp2n2SOLCOevva42PjMcnf4I/23uyxi8CYtcX4JJ/
        WyTnm/U1Z7WLVEa5XjTY0jx8RnHwQPhGGy15NjlUfOx/xV1pfGlgpIwk2/bqsoKl
        0res7nVm+fk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30C6E8D265;
        Mon, 17 Apr 2017 03:06:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92BCF8D264;
        Mon, 17 Apr 2017 03:06:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] status: show in-progress info for short status
References: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
Date:   Mon, 17 Apr 2017 00:06:17 -0700
In-Reply-To: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
        (Michael J. Gruber's message of "Fri, 31 Mar 2017 15:59:17 +0200")
Message-ID: <xmqqwpajikd2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AC82D4E-233C-11E7-BA9C-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Ordinary (long) status shows information about bisect, revert, am,
> rebase, cherry-pick in progress, and so does git-prompt.sh. status
> --short currently shows none of this information.
>
> Introduce an `--inprogress` argument to git status so that, when used with
> `--short --branch`, in-progress information is shown next to the branch
> information. Just like `--branch`, this comes with a config option.
>
> The wording for the in-progress information is taken over from
> git-prompt.sh.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
> When used with --porcelain, this gives an easy way to amend the powerline-gitstatus
> prompt for example (in use locally here), and certainly others.
>
> I don't touch --porcelain=v2 - that one reads in-progress state but does not seem
> to display it. I don't know which parts are supposed to be stable for v2. 
>
>  Documentation/config.txt     |  4 +++
>  Documentation/git-status.txt |  5 ++++
>  builtin/commit.c             | 13 ++++++++++
>  t/t7512-status-help.sh       | 58 ++++++++++++++++++++++++++++++++++++++++----
>  wt-status.c                  | 32 +++++++++++++++++++++---
>  wt-status.h                  |  1 +
>  6 files changed, 105 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d51..3adc65f9d3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2957,6 +2957,10 @@ status.branch::
>  	Set to true to enable --branch by default in linkgit:git-status[1].
>  	The option --no-branch takes precedence over this variable.
>  
> +status.inprogress::
> +	Set to true to enable --inprogress by default in linkgit:git-status[1].
> +	The option --no-inprogress takes precedence over this variable.
> +

Has the name of the option been discussed already and the list
reached a consensus?  "in progress" is a two-word phrase, and I am
wondering if this should be status.inProgress (and the option name
should be "--in-progress").

> +-p::
> +--inprogress::
> +	When showing branch and tracking info in short-format,
> +	show in-progress information (BISECTING, MERGING etc.), too.
> +

I do not think we want to give short-and-sweet "-p" to this option.
"git log -p" gives a patch output, "git status -p" sounds like it
does so, too (i.e. "git show" plus various status).  Besides, for
those who are lazy, you already have a configuration variable.

