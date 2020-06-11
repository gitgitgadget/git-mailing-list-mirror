Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D0C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775D7206A4
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I291EXCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgFKAS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:18:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62148 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgFKAS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 20:18:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D664FDEB88;
        Wed, 10 Jun 2020 20:18:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TkUVw/U2N3FphdzgpeNSxbzz/K0=; b=I291EX
        Cb4UeFs/jDpkzVN9TrzX1t/qe0qEbzb/O3Gk4I5rObuvj8ZhCBWIywInbigiafxw
        s3uhSkBJ52jIl3RRRCsijSZ799HoFjJttJhAgKuhXkkdIIE6VgzKP2HBj9CtsR7V
        rxvzDL7oCso4VNG/DbxQc1EyWjpILkxUduKCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lvC6VtH13d+rJa7NnJX4HjOySLzB+5kc
        tHNCyTDl6ld9OradF3M9RFYxlBfcxy6gCWxekd5/javJ1p+N0SmByijlBRAnl7a9
        0INtax8G3xnk62u3GfDHgdZywfQE78vgtSkTNsej1mSrM9W/+WzalMN8bZPsgz+E
        GMe5kEBYROk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF174DEB87;
        Wed, 10 Jun 2020 20:18:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F4FBDEB86;
        Wed, 10 Jun 2020 20:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 9/9] Document how the default branch name can be overridden
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <f680e66dd6ddfc5294d04ddd11d4b2bd4ec1520c.1591823971.git.gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 17:18:49 -0700
In-Reply-To: <f680e66dd6ddfc5294d04ddd11d4b2bd4ec1520c.1591823971.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 10 Jun 2020
        21:19:30 +0000")
Message-ID: <xmqq3672e9p2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 206A465A-AB79-11EA-9AC5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 74619a9c03b..a11e1abdf59 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -626,3 +626,7 @@ core.abbrev::
>  	in your repository, which hopefully is enough for
>  	abbreviated object names to stay unique for some time.
>  	The minimum length is 4.
> +
> +core.defaultBranchName::
> +	Allows overriding the default branch name e.g. when initializing
> +	a new repository or when cloning an empty repository.

As we saw in [PATCH 7/9], it also affects for which branch an
auto-generated merge message omits "into $branch" at the end.

The behaviour change of "merge" might matter more than we think here
in a hand-wavy way, and it certainly does affect more than 'init'
and 'clone' (both of which are one time operation per repository),
because setting this in ~/.gitconfig would affect all the
repositories, whose merges into their 'master' suddenly starts
saying "into master" at the end, unlike existing merges.  So it
probably is worth highlighting it here.

> diff --git a/t/README b/t/README
> index cf863837ab9..b32f520a27f 100644
> --- a/t/README
> +++ b/t/README
> @@ -421,6 +421,10 @@ GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
>  the default when running tests), errors out when an abbreviated option
>  is used.
>  
> +GIT_TEST_DEFAULT_BRANCH_NAME allows overriding the default branch name
> +that is used for example when initializing new repositories, or when
> +cloning a repository that has no branches yet.
> +
>  Naming Tests
>  ------------
