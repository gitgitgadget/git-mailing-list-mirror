Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F04C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBA023787
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbhAUDqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:46:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54719 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436669AbhAUCHm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 21:07:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33A80973EC;
        Wed, 20 Jan 2021 21:06:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GG34st/5kksYhEaL4gPhY4mCf8I=; b=dI0Ipo
        13Qqa+S8P6JQuhiEvQKqxjmEOf6cVrsW13u0JXzBzNXetyoMG3ae3GhQUQIo+fCj
        xDmvFqujR2eob44QuMnnSJ4m3x41Febuf9Vmwt9+lqy4TylLggSkBFNV8QxUL8BN
        ke4MX3xeJyc5Vxc1hQ7WKlu5XQPdk5ZTZQU1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wzARjPtuWdF8dvgM0aONqPR2M5Souk9M
        U5AjP+YYphWamSYH/Cn06BJFS35ezFivjoY0Acc0oxSmFHPl1FjC0r7hQIPWYTcs
        tCbdZ2TC2XVrqEE+HR9atHg/D0SPZq0Tg/ewI9fQ4n94pbLqQf+Ccp97ZgNKds9V
        l7zJc3che/4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B3D8973EB;
        Wed, 20 Jan 2021 21:06:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E5FA973E9;
        Wed, 20 Jan 2021 21:06:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/2] maintenance: set log.excludeDecoration durin
 prefetch
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
        <pull.838.v2.git.1611060724.gitgitgadget@gmail.com>
        <5b2ce9049a69d4c450093433e4fa15c4e5e0c412.1611060724.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 18:06:53 -0800
In-Reply-To: <5b2ce9049a69d4c450093433e4fa15c4e5e0c412.1611060724.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 19 Jan 2021
        12:52:03 +0000")
Message-ID: <xmqqh7nbdow2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54D4F808-5B8D-11EB-BF1B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The 'prefetch' task fetches refs from all remotes and places them in the
> refs/prefetch/<remote>/ refspace. As this task is intended to run in the
> background, this allows users to keep their local data very close to the
> remote servers' data while not updating the users' understanding of the
> remote refs in refs/remotes/<remote>/.
>
> However, this can clutter 'git log' decorations with copies of the refs
> with the full name 'refs/prefetch/<remote>/<branch>'.
>
> The log.excludeDecoration config option was added in a6be5e67 (log: add
> log.excludeDecoration config option, 2020-05-16) for exactly this
> purpose.
>
> Ensure we set this only for users that would benefit from it by
> assigning it at the beginning of the prefetch task. Other alternatives
> would be during 'git maintenance register' or 'git maintenance start',
> but those might assign the config even when the prefetch task is
> disabled by existing config. Further, users could run 'git maintenance
> run --task=prefetch' using their own scripting or scheduling. This
> provides the best coverage to automatically update the config when
> valuable.

OK.  I think those users who keep distance from "git maintenance"
are different story but all others cannot be using refs/prefetch/
hierarchy for purposes other than "git maintenance" dictates, so
"git maintenance [register|start]", or even when the user first runs
"git maintenance" for that matter, would be acceptable point to add
the configuration, but at the beginning of a prefetch task, we know
the hierarchy is being used for what "git maintenance" wants to do,
so it is a good place to do so.

But playing devil's advocate, I do not think throwing refs/prefetch
into a "hardcoded list of hierarchies that would never be used for
decoration purposes" would upset any end-users in practice.  The only
reason why I do not make such a suggestion is it is more work (such
a hardcoded reject list does not exist, if I recall correctly).

> It is improbable, but possible, that users might want to run the
> prefetch task _and_ see these refs in their log decorations. This seems
> incredibly unlikely to me, but users can always opt-in on a
> command-by-command basis using --decorate-refs=refs/prefetch/.

It is not a viable workaround to add "--decorate-refs=refs/prefetch"
that is a mouthful; configuration options are to reduce such typing,
not to force more of them.  But because I agree with that
"incredibly unlikely" assessment, I do not care.

Thanks.
