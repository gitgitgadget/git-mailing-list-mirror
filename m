Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CCDC20954
	for <e@80x24.org>; Mon, 27 Nov 2017 06:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbdK0GpK (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 01:45:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56042 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751045AbdK0GpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 01:45:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FC6DB31DA;
        Mon, 27 Nov 2017 01:45:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EdmsYoRuZIMmNIf6ZvNlvKJAuAY=; b=FLp4x6
        SQm6vEAWaST8pByO0TYtDehfGdR0dPIRNL30x6GZvc1enrtqR+68R0EF1Z02AzPd
        ZNaPG7kYMOVk9DnZ4iRMzVAN0UCQHOWK5BiPfApF0y6+wcLM+cw/VPoSfmcXdnAo
        8E5WHsQeWW1bt6kyCEoiDWSPDPBlsHx2NA4TE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MKlIpk3Q4oVGOXCjJss3n45Sa7+xpWMh
        jgFIi78kX2f9p9rrO9ThLO4poK1+cGKnBWmiDcIGWylmhgrs0foN7hCvUCdY+yu1
        nohTtIoaEOlnLyiih+rG+Mzf8yuGnbObH54ipgTBojp2VxU3J9Z7Qp+8qnieHIAf
        TuGMzR7F48k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87C14B31D9;
        Mon, 27 Nov 2017 01:45:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFD64B31D8;
        Mon, 27 Nov 2017 01:45:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH v5 6/6] add worktree.guessRemote config option
References: <20171122223020.2780-1-t.gummerer@gmail.com>
        <20171126194356.16187-1-t.gummerer@gmail.com>
        <20171126194356.16187-7-t.gummerer@gmail.com>
Date:   Mon, 27 Nov 2017 15:45:06 +0900
In-Reply-To: <20171126194356.16187-7-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 26 Nov 2017 19:43:56 +0000")
Message-ID: <xmqq8tescj9p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8200FA50-D33E-11E7-AFE2-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +worktree.guessRemote::
> +	With `add`, if no branch argument, and neither of `-b` nor
> +	`-B` nor `--detach` are given, the command defaults to
> +	creating a new branch from HEAD.  If `worktree.guessRemote` is
> +	set to true, `worktree add` tries to find a remote-tracking
> +	branch whose name uniquely matches the new branch name.  If
> +	such a branch exists, it is checked out and set as "upstream"
> +	for the new branch.  If no such match can be found, it falls
> +	back to creating a new branch from the current HEAD.

Unlike the part I commented on in the previous step, this one is
clear that the feature only kicks in for 'add <path>' without
anything else, which is good.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 15cb1600ee..426aea8761 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -33,8 +33,19 @@ struct add_opts {
>  
>  static int show_only;
>  static int verbose;
> +static int guess_remote;
>  static timestamp_t expire;
>  
> +static int git_worktree_config(const char *var, const char *value, void *cb)
> +{
> +	if (!strcmp(var, "worktree.guessremote")) {
> +		guess_remote = git_config_bool(var, value);
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +

It is a lot more consistent with the established practice if this
function had

	return git_default_config(var, value, cb);

instead of "return 0" at the end, and then have the call to

	git_config(git_default_config, NULL);

we have in cmd_worktree() replaced with

	git_config(git_worktree_config, NULL);

That would avoid having to scan the entire set of config keys once
in cmd_worktree() and then again in add(), the latter one only
looking for a single variable.
