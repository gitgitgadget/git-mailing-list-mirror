Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF7C7EE24
	for <git@archiver.kernel.org>; Mon, 15 May 2023 20:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244299AbjEOUGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 16:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjEOUGq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 16:06:46 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 13:06:44 PDT
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37A8E707
        for <git@vger.kernel.org>; Mon, 15 May 2023 13:06:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 417BE1869CF;
        Mon, 15 May 2023 16:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wma6o70s1rdraJmVQzLxx7eT7GMQtat52Bw+Ay
        Y2oqA=; b=BkmPuXnnLOl75bxykVwHMLx7FRfjPxT9RcuaErC3wd4/jcfwyACj7k
        R1uoncY20tJxwQ6ZPt1n1gzussdUPRs/poRxDwvP8ML7sW540Yafq/utZ1uAr+4D
        /wflWuyQJTQfR5ieIOnA3tK85jP7FQrEYFgmWK2tjptIe0UVQajQA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3929C1869CE;
        Mon, 15 May 2023 16:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D7CD1869CD;
        Mon, 15 May 2023 16:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>
Subject: Re: [PATCH v3 6/6] ls-remote doc: document the output format
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
        <de57b8aa563f20b45e18dbe45abaa14a2971da13.1684152793.git.gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 13:01:39 -0700
In-Reply-To: <de57b8aa563f20b45e18dbe45abaa14a2971da13.1684152793.git.gitgitgadget@gmail.com>
        (Sean Allred via GitGitGadget's message of "Mon, 15 May 2023 12:13:13
        +0000")
Message-ID: <xmqqfs7x8iu4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EB7FFDE-F35B-11ED-9D25-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Allred via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sean Allred <allred.sean@gmail.com>
>
> While well-established, the output format of ls-remote was not actually
> documented. This patch adds an OUTPUT section to the documentation
> following the format of git-show-ref.txt (which has similar semantics).
>
> Add a basic example immediately after this to solidify the 'normal'
> output format.
>
> Signed-off-by: Sean Allred <allred.sean@gmail.com>
> ---
>  Documentation/git-ls-remote.txt | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index c0b2facef48..15313f2b10d 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -96,9 +96,33 @@ OPTIONS
>  	separator (so `bar` matches `refs/heads/bar` but not
>  	`refs/heads/foobar`).
>  
> +OUTPUT
> +------
> +
> +The output is in the format:
> +
> +------------
> +<oid> TAB <ref> LF
> +------------
> +
> +When `<ref>` is a tag, it may be followed by `^{}` to show its peeled
> +representation.

While I can guess what the above wants to say, the above does not
quite "click" for me for some reason.  Here is my attempt.

    When showing an annotated tag, unless `--refs` is given, two
    such lines are shown, one with the refname for the tag itself as
    <ref>, and another with <ref> followed by `^{}`.  The `<oid>` on
    the latter line shows the name of the object the tag points at.

The verb `peel` is used in the explanation for the `--refs` option,
but there is no formal definition of what it means in the glossary.

We may want to do something about it, but we probably would want to
leave it outside the scope of this series.

Other than that, looking great.

Thanks.
