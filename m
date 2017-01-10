Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E0D20756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967041AbdAJUOl (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:14:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55494 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1763535AbdAJUOi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:14:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5C605F6E2;
        Tue, 10 Jan 2017 15:14:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=myw1ykzwnaUEAom4+w5cFdW98iE=; b=ITl5hb
        7zEB5qU8jB2/xyMvJ13sT2lrXS8DeM8jE7KtR87jLoAytUvFcjjATuiz9fUAZBRK
        rehsQ80DsvvtvYlv14swv9srH5jjFcxkgaV3mVd1dm0TNFSa4BJ6WJBCrRDygJ6Z
        cBORAmOQsEPdY7wrly1hFN+G4z1N4NZAkiyd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WiRdO9Fuamza7Qu2ZenbYRoCWhST0RF+
        Fxcm1wO7wHn7xLganvdv5mpgtfdjNsoifELTD7ZPWilUoDdXu+R4FqFOGBYQNnPm
        njMZj7eizBqyATB7B/5ZsJSYSh7uA8ZJrCnPdClUCguPMw2XfrQ/vi+ZwWVeP/Np
        MzYUeKYelNc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE1F05F6E1;
        Tue, 10 Jan 2017 15:14:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20DED5F6E0;
        Tue, 10 Jan 2017 15:14:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff: document the pattern format for diff.orderFile
References: <20170110004031.57985-1-hansenr@google.com>
        <20170110004031.57985-3-hansenr@google.com>
Date:   Tue, 10 Jan 2017 12:14:34 -0800
In-Reply-To: <20170110004031.57985-3-hansenr@google.com> (Richard Hansen's
        message of "Mon, 9 Jan 2017 19:40:31 -0500")
Message-ID: <xmqq8tqismdx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 683CFAAC-D771-11E6-9D25-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Hansen <hansenr@google.com> writes:

> Document the format of the patterns used for the diff.orderFile
> setting and diff's '-O' option by referring the reader to the
> gitignore[5] page.
>
> Signed-off-by: Richard Hansen <hansenr@google.com>
> ---
>  Documentation/diff-config.txt  | 3 ++-
>  Documentation/diff-options.txt | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 875212045..a35ecdd6b 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -100,7 +100,8 @@ diff.noprefix::
>  
>  diff.orderFile::
>  	File indicating how to order files within a diff, using
> -	one shell glob pattern per line.
> +	one glob pattern per line.
> +	See linkgit:gitignore[5] for the pattern format.


I do not think it is wise to suggest referring to gitignore, as the
logic of matching is quite different, other than the fact that they
both use wildmatch() internally.  Also, unlike gitignore, orderfile
does not allow any negative matching i.e. "!<pattern>".

>  	If `diff.orderFile` is a relative pathname, it is treated as
>  	relative to the top of the work tree.
>  	Can be overridden by the '-O' option to linkgit:git-diff[1].
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index e6215c372..dc6b1af71 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -467,7 +467,8 @@ endif::git-format-patch[]
>  
>  -O<orderfile>::
>  	Output the patch in the order specified in the
> -	<orderfile>, which has one shell glob pattern per line.
> +	<orderfile>, which has one glob pattern per line.
> +	See linkgit:gitignore[5] for the pattern format.
>  	This overrides the `diff.orderFile` configuration variable
>  	(see linkgit:git-config[1]).  To cancel `diff.orderFile`,
>  	use `-O/dev/null`.
