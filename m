Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43976C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 18:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E583F64DA1
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 18:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhBCSmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 13:42:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52826 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhBCSl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 13:41:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E8F49E961;
        Wed,  3 Feb 2021 13:41:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D2F7IhYi/J2bkErKxRpYFhs2swI=; b=sgKMGW
        F4uLYPzrztCh/jQF4r1wAGqDtuqWphAQZh2cwNIKMRM7vaXN6eVHZxi1AlVgxDfj
        yfmZFkphlJLvZyngs3MCyj4fsTQMXxKBRRpJPiQITHHOn+qJZWwTlMEEQ1qHCufi
        B//4nH3lSPxdCnu8UVVC4oereLqTjXbMOqTZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=auAzqhl/8ZCUybov0J8jRTlMd1imE1HQ
        ZopHiw93l0KJlGaDAxvUIrYy67kHMrC+IfPmiHJ3AvryrUV9/mIqViEX19SW44Q+
        t9pGVzOZyFKD4jXbzwptkKx8hgmQIz8+ztOjFy4PtcFfPjmoSyY6qJjjiyDxZFXE
        Z8ETqTYsZZA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01F939E960;
        Wed,  3 Feb 2021 13:41:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B35759E95D;
        Wed,  3 Feb 2021 13:41:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
        <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
        <YBn3fxFe978Up5Ly@google.com>
        <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
        <YBoBBie2t1EhcLAN@google.com>
        <6dc1520f-8130-75e1-6617-67b54cb03933@gmail.com>
        <YBrCli7AR/XrB3Pr@nand.local>
Date:   Wed, 03 Feb 2021 10:41:08 -0800
In-Reply-To: <YBrCli7AR/XrB3Pr@nand.local> (Taylor Blau's message of "Wed, 3
        Feb 2021 10:34:46 -0500")
Message-ID: <xmqqk0rpc7uj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6299AE44-664F-11EB-AA40-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Thinking aloud, I'm not totally sure that we should be exposing "git
> commit-graph clear" to users. The only time that you'd want to run this
> is if you were trying to remove a corrupted commit-graph, so I'd rather
> see guidance on how to do that safely show up in
> Documentation/git-commit-graph.txt.
>
> On the other hand, now I'm encouraging running "rm -fr
> $GIT_DIR/objects/info/commit-graph*", which feels dangerous.

True.

As this is, like pack .idx file, supposed to be "precomputed cached
data that can be fully recreated using primary information" [*], I
am perfectly fine to say "commit-graph may have unexplored corners,
and when you hit a BUG(), you can safely use 'commit-graph clear'
and recreate it from scratch, or operate without it if you feel you
do not yet want to trust your data to it for now."  Giving safer and
easier way to opt out for those who need to get today's release
done, with enough performance incentive to re-enable it when the
crunch is over, would be an honest thing to do, I would think.

	Side note: the index file also used to be considered to hold
	such cached data, that can be recreated from the working
	tree data and the tip commit.  We no longer treat it that
	way, though.

> Somewhere in the middle would be something like:
>
>   git -c core.commitGraph=false commit-graph write --reachable

I am a bit worried about the thinking along this line, because it
gives the users an impression that there is no escaping from
trusting commit-graph---the one that was created from scratch is
bug-free and they only need to be cautious about incrementals.

But (1) we do not know that, and (2) it is an unconvincing message
to somebody who just got hit by a BUG().

> which would disable reading existing commit-graph files. Since
> 85102ac71b (commit-graph: don't write commit-graph when disabled,
> 2020-10-09), that causes us to exit immediately.

Meaning the three command sequence

	git commit-graph clear
	git commit-graph write --reachable
        git config core.commitGraph false

to force a clean build of a graph and forbid further updates until
the bug is squashed???  But should't core.commitGraph forbid reading
and using the data in the existing files, too?  In which case, shouldn't
it be equivalent to "git commit-graph clear"?

> I think that reverting that patch and advertising setting
> 'core.commitGraph=false' in the documentation makes the most sense.

