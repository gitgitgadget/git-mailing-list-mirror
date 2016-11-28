Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA65B1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 17:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754687AbcK1RRp (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 12:17:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52443 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754300AbcK1RRo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 12:17:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FC94519DD;
        Mon, 28 Nov 2016 12:17:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w2uqfEBe/eOyAkJHndqu/3085C4=; b=p2cpnT
        4voOujv9CKUbTL8z5lxSzIiVnbMmRanIQSJmDIvENQfqnqUHsnP5vtnD1e0MTSrs
        eu34ID++Y78/GuuAyoig5Wk+pFQGLocnSkHxY0Vi0YL+hiuAYmJvvkShTvqHc5R5
        Wy4T2e4MlyQzRTdb6VD6s8OktqsJt7fH8MnJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H0RFKuWPdl5ECDO1R2KtFT72TQ1FDAdf
        8/C9m+aiGAvrcgavP8lE98mp+EjqtVCb6aXdsZBgK6fg1A9Df3U0NVRceQL3yHNq
        5ocYLwS3ZhIX6ZJ2Rec5g60TjWD0v8TigSORrxQNFS/5jUvYluGjjtvewdeXDx9n
        3kwQ/17/gBo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37224519DB;
        Mon, 28 Nov 2016 12:17:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A82F8519D9;
        Mon, 28 Nov 2016 12:17:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Jeff King <peff@peff.net>, Dun Peal <dunpealer@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: trustExitCode doesn't apply to vimdiff mergetool
References: <CAD03jn5PAZcFeesaq2osjo7cYd1frWZeN0odNqTh+AMxSEmLgQ@mail.gmail.com>
        <20161127050818.rmjpvha64y4wosq2@sigill.intra.peff.net>
        <CAD03jn7gU9g7NyDk_3wYTKsYQUtRGg6msvumZqUDs44hMOVX7w@mail.gmail.com>
        <20161127165559.j5okxyztwescheug@sigill.intra.peff.net>
        <20161128014538.GA18691@gmail.com> <20161128021554.GA30863@gmail.com>
Date:   Mon, 28 Nov 2016 09:17:41 -0800
In-Reply-To: <20161128021554.GA30863@gmail.com> (David Aguilar's message of
        "Sun, 27 Nov 2016 18:15:54 -0800")
Message-ID: <xmqq4m2rle16.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 925E932C-B58E-11E6-91B6-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> deltawalker, diffmerge, emerge, kdiff3, kompare, and tkdiff originally
> provided behavior that matched trustExitCode=true.
>
> The default for all tools is trustExitCode=false, which conflicts with
> these tools' defaults.  Allow tools to advertise their own default value
> for trustExitCode so that users do not need to opt-in to the original
> behavior.
>
> While this makes the default inconsistent between tools, it can still be
> overridden, and it makes it consistent with the current Git behavior.

I think this is sensible, because the way I look at this issue is
that in an ideal world, we would want all tool backends consistently
give us usable exit codes, but some tools are known to give unusable
exit codes, so we ignore their exit codes by default.

As to the implementation, I think you can reduce the duplication by
having each tool backend 

 - export a new function that echos "true" or "false"; or
 - export a new function that returns true or false; or
 - set a variable whose value is either "true" or "false"

and use that from the trust_exit_code() in git-mergetool--lib.sh.
Something like this (for the second alternative).

    trust_exit_code () {
        if git config --bool "mergtool.$.trustExitCode"
	then
		:; # OK
	elif mergetool_exitcode_trustable
	then
		echo true
	else
		echo false
        fi
    }
