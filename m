Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904202035F
	for <e@80x24.org>; Fri, 11 Nov 2016 17:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934616AbcKKRG1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 12:06:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52919 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934465AbcKKRGX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 12:06:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE6664CE0F;
        Fri, 11 Nov 2016 12:06:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=chON1+x4OTB8zSZ6CRpqTOkllqY=; b=wrBwfn
        ulkwxxMdTS86MTaIL3yrrD9NupYxuXWz1GbW8o3ot8KX7GXcx4MIM5zNGMjwpwB2
        VjcB/LkPylGUX6E53GgoBrXBk57//ebBHIsg0H0+AvGS27gf7YwKt0ax3mCb0PX5
        AbkLzXzZMJJNWiyT50qplnG49J74nj48c3kII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FgFAqJBc5Ud+/KH4A2G/ffR50KcYSKLZ
        OlzQ9W4V5hSi8NXLgsdTvWWUsrIr4alXo53aTtj3TOH4ik9d6oxqyoIbHdOojllW
        EEmuLyQ9eY85u4LIAPD9t+5XkzWjlo4Si5iai1bzy+5G59yBSHw+WiFhCyTC3dXM
        FiVplBF0gDs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6A324CE0E;
        Fri, 11 Nov 2016 12:06:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33F954CE0B;
        Fri, 11 Nov 2016 12:06:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] mingw: hot-fix t5615
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
Date:   Fri, 11 Nov 2016 09:06:11 -0800
In-Reply-To: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 11 Nov 2016 17:29:33 +0100
        (CET)")
Message-ID: <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26640CC0-A831-11E6-A99E-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> That test made the incorrect assumption that the path separator character
> is always a colon. On Windows, it is a semicolon instead.

Documentation/git.txt says that GIT_ALTERNATE_OBJECT_DIRECTORIES is
separated with ";" on Windows fairly clearly, and we should have
caught that.  

For the upcoming release there is no need for any further tweak on
your fix I am responding to, but in the longer term we would want to
turn this to path_sep=";" (or ":") and define it in the global
t/test-lib.sh, as it is plausible that we may want to prepend or
append to $PATH in the tests and that also needs ";" on Windows, no?

Are there other variables that is a list of paths that we care in
our tests?  I notice GIT_CEILING_DIRECTORIES does not have the
corresponding ": separated (on windows ; separated) list" in its
description in Documentation/git.txt but the documentation may need
to be fixed there as well?

Thanks for a quick fix.  Will apply on jk/alt-odb-cleanup and merge
down.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/t5615-path-separator-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git t5615-path-separator-v1
>
> 	This is required, but not sufficient, to fix `master` on Windows.
>
>  t/t5615-alternate-env.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
> index 22d9d81..3aeffb6 100755
> --- a/t/t5615-alternate-env.sh
> +++ b/t/t5615-alternate-env.sh
> @@ -37,8 +37,10 @@ test_expect_success 'access alternate via absolute path' '
>  	EOF
>  '
>  
> +sep=:
> +test_have_prereq !MINGW || sep=\;
>  test_expect_success 'access multiple alternates' '
> -	check_obj "$(pwd)/one.git/objects:$(pwd)/two.git/objects" <<-EOF
> +	check_obj "$(pwd)/one.git/objects$sep$(pwd)/two.git/objects" <<-EOF
>  	$one blob
>  	$two blob
>  	EOF
>
> base-commit: 0538b84027a8aba7e8b805e3ec8fceb3990023e5
