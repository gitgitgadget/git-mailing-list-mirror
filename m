Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77FAC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 03:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED0B2075E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 03:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TADmxdP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgEFD5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 23:57:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57123 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgEFD5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 23:57:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CC0E40975;
        Tue,  5 May 2020 23:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RKIxoBh8zcPA
        jcEzfV5DFp4pB+U=; b=TADmxdP42stbzFSYF/E6gQttDVbD+zTbdPqthXGnY8oN
        yxsWkFYpBc+N6olR27eI/n/C3wmMlS9K443s+jJQDl1rCoYwi6nYdP9D8Pp6+Gdv
        fQQN2Vs9O0ry9p7icF/TlXr10v3vuJ7epEitNT4+B5pJwmcxG6wowsw9kMeiRJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FO1vF5
        PYd9jS/6shT2kh+KJEpQutrg3nFc8Dq3L3jyI43VLGXvFcu9COdhLal+LBwE2FNg
        HkLVV/r9QU/ncb0Ph9PWKkiccquaGCO+wRLaCUUmeZTXiXFmgdyqW9RBJYLhuTwN
        RjDkq33/9YqJtCLhzKDN3Je1UpOZp8F+D1YrU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9532640974;
        Tue,  5 May 2020 23:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2140640973;
        Tue,  5 May 2020 23:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
References: <cover.1588607262.git.congdanhqx@gmail.com>
        <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
        <20200504162311.GE12842@coredump.intra.peff.net>
        <20200504215824.GC45250@syl.local>
        <20200504233634.GB39798@coredump.intra.peff.net>
        <20200505002055.GC64230@syl.local>
        <20200505164326.GA64077@coredump.intra.peff.net>
        <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
        <20200505182418.GA66702@coredump.intra.peff.net>
        <20200505210451.GA645290@coredump.intra.peff.net>
        <20200506004612.GE927@danh.dev>
Date:   Tue, 05 May 2020 20:56:58 -0700
In-Reply-To: <20200506004612.GE927@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Wed, 6 May 2020 07:46:12 +0700")
Message-ID: <xmqqr1vx90mt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A29AA310-8F4D-11EA-B233-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
> index 8686318550..8175424929 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -82,6 +82,18 @@ Alternately, you can u
>  on Linux, macOS, and Windows) by pushing into a branch in your fork
>  or opening a GitHub's Pull Request against
>  https://github.com/git/git.git or a fork of that repository.
> +In the event that you only want to trigger GitHub Actions for specific
> +refname, you can create an executable file named `allow-ref` in
> +`refs/ci/config`. Those below steps may help you:

"These steps below" or "The follwoing steps", perhaps.

> +--------------
> +$ git checkout --orphan ci-config
> +$ cp contrib/ci-config-allow-ref allow-ref
> +$ $EDITOR allow-ref
> +$ git rm -rf .

This sounds horrible.  You just nuked the entire files in the
working tree you use for your everyday Git hacking to edit a
single file.

> +$ git commit allow-ref

If allow-ref were added to the index before this "git commit", the
previous "git rm -rf ." would have removed it.  Since the surviving
allow-ref file must have been untracked, this "git commit" would not
commit anything.  Forgot to "git add"?

> +$ git push <your-fork> HEAD:refs/ci/config
> +--------------

>  Do not forget to update the documentation to describe the updated
>  behavior and make sure that the resulting documentation set formats
> diff --git a/contrib/ci-config-allow-ref b/contrib/ci-config-allow-ref
> new file mode 100755
> index 0000000000..b53e9ddbd0
> --- /dev/null
> +++ b/contrib/ci-config-allow-ref
> @@ -0,0 +1,9 @@
> +#!/bin/sh
> +# Sample filter for GitHub Actions
> +# GitHub Actions will run if and only if this script exit with zero st=
atus

s/exit/exits/;

As the instruction above says, we should set the example and
describe the behaviour we implemented initially.  Something as basic
like ...

    # Build any branch other than those whose name begins with "no-ci"

> +
> +REFNAME=3D"$1"
> +
> +case "$REFNAME" in
> +refs/heads/no-ci*) exit 1 ;;
> +esac

