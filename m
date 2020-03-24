Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4305C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 21:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6C22074D
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 21:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B1EA9cm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCXVE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:04:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53374 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgCXVE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 17:04:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A4285ABEC;
        Tue, 24 Mar 2020 17:04:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UcFpqc7rLH3RL6QWJeo0saOLF6w=; b=B1EA9c
        m+u1A65DmrqJvBEC+BJqZTpkACc/JnzOPzXAjZLO8uqMie0dsDOiVYXIyRPUx9Hm
        sqEm54Yc33+n2ZURrem/j+2Y5o+CXwEq40EVB964uhFSCvVH/4+wDPt/a4CezfS+
        ikuW+j+bNO8qsgspNuM5yD1Y6KnDYetnDuPZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yGVD2Qu7uYMwkPqN8Ge3vYvKCAs0zbkY
        SyKDjGwoqzb9JXJY/WaWg3Y1uGX71g25Ary0HKtKS3S0JHNVIkWBQUr7sqprmLZ4
        MAucMiKadebvgZulkFvPSkCfB8EyTsRxdY8DItRXHtwdV4pITrZMh+PGbC6vwP+z
        CW8mWhr7caA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0180F5ABEB;
        Tue, 24 Mar 2020 17:04:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 762E85ABEA;
        Tue, 24 Mar 2020 17:04:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] import-tars: ignore the global PAX header
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
        <pull.577.v2.git.1585078545448.gitgitgadget@gmail.com>
Date:   Tue, 24 Mar 2020 14:04:24 -0700
In-Reply-To: <pull.577.v2.git.1585078545448.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 24 Mar 2020 19:35:45
        +0000")
Message-ID: <xmqqd0911n3b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A553620-6E13-11EA-8197-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>      +    Note: this global header might contain useful information. For example,
>      +    in the output of `git archive`, it lists the original commit, which _is_
>      +    useful information. A future improvement to the `import-tars.perl`
>      +    script might be to include that information in the commit message, or do
>      +    other things with the information (e.g. use `mtime` information
>      +    contained in the global header as date of the commit). This patch does
>      +    not prevent any future patch from making that happen, it only prevents
>      +    the header from being treated as if it was a regular file.
>       
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>       
>
>
>  contrib/fast-import/import-tars.perl | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
> index e800d9f5c9c..d50ce26d5d9 100755
> --- a/contrib/fast-import/import-tars.perl
> +++ b/contrib/fast-import/import-tars.perl
> @@ -139,6 +139,8 @@
>  			print FI "\n";
>  		}
>  
> +		next if ($typeflag eq 'g'); # ignore global header
> +

Yeah, it is more like "don't create a phony file out of global
header" which is exactly the point of this fix, rather than "ignore
global header", and if the contents of the header is used for any
other purpose (e.g. metadata that will be added to the log message
or mode bits that is forced on all files), that can be handled
before this line.  And the current code structure is already
prepared for it: all that remains in the block after this point is
to create a file at $path and store its contents.

So, this makes sense.  I suspect that with an update to the comment
in the direction, there probably is no need for the huge "Note" in
the log message.

Thanks.

>  		my $path;
>  		if ($prefix) {
>  			$path = "$prefix/$name";
>
> base-commit: b4374e96c84ed9394fed363973eb540da308ed4f
