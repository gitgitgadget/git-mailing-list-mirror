Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB56C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1118C20760
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VCJYpBCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390619AbgHQS02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:26:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63150 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390893AbgHQS0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:26:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA807DABE2;
        Mon, 17 Aug 2020 14:26:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XLDCeAIvc/90qm++//kG0h7bU/0=; b=VCJYpB
        CBsBlxjleO5MPpKx2XNNFhIbulyRtQZ9mMkjzLBofHrlmbSIv42JDLkIWZcTWidT
        EAl5x0ixsBnZiLV4nmbGrmwM+LOCBoEIPtnVMyy1wWUKvmeGFHnJ8Hkf1lE0Q75h
        7F5OAwUK6fVEGxdrmTr86GRyz5a8HxEsiwCr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sH/zuXQNbqE7iQmXVn9BWsFqFmFwHUsL
        w1SKdmlxSZlp5S29ssFn7kq0VrVTLDDC9Z0dForhFvyqP6GV6vkFpV1j5qzvEoWT
        w1F09wwgNIvr1XCN8aCwrJH3Ro+9HjfpLXEYjYFvunVGrYeuyu3gZcgUQ4WthKgT
        FObNp8W8sps=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2FB8DABE0;
        Mon, 17 Aug 2020 14:26:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 02704DABDF;
        Mon, 17 Aug 2020 14:26:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] ci: stop linking built-ins to the dashed versions
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <1269d7ace84b5d0e9a009044b49251cdf1dfbd23.1597655273.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 11:26:11 -0700
In-Reply-To: <1269d7ace84b5d0e9a009044b49251cdf1dfbd23.1597655273.git.gitgitgadget@gmail.com>
        (Johannes Schindelin's message of "Mon, 17 Aug 2020 09:07:53 +0000")
Message-ID: <xmqq364l2kos.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21487268-E0B7-11EA-8D73-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <gitgitgadget@gmail.com> writes:

> Originally, all of Git's subcommands were implemented in their own
> executable/script, using the naming scheme `git-<command-name>`. When
> more and more functionality was turned into built-in commands (i.e. the
> `git` executable could run them without spawning a separate process),
> for backwards-compatibility, we hard-link the `git` executable to
> `git-<built-in>` for every built-in.
>
> This backwards-compatibility was needed to support scripts that called
> the dashed form, even if we deprecated that a _long_ time ago.

The other day, I found this amusing (yes, I am a fan of Emacs).

https://medium.com/@steve.yegge/dear-google-cloud-your-deprecation-policy-is-killing-you-ee7525dc05dc

> In preparation for eventually dropping those hard-links, teach the CI
> (and PR) builds to skip generating those hard-links.

You do not have to set the policy of "eventuall dropping" here.
The presence of the choice of not installing added in step [2/3]
alone is a very good justification to include this patch in the
series.  Otherwise, we won't know if our test suite and remaining
scripted Porcelain rely on the age old promise we made and have kept
to the end users, as [2/3] requires all our users accept the
breakage of the promise.

It may be a good idea to test both configurations, with or without
SKIP_DASHED, at least for now, though.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/run-build-and-tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 17e25aade9..b074db5c4b 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
>  *) ln -s "$cache_dir/.prove" t/.prove;;
>  esac
>  
> -make
> +make SKIP_DASHED_BUILT_INS=YesPlease
>  case "$jobname" in
>  linux-gcc)
>  	make test
