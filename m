Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783362047A
	for <e@80x24.org>; Fri, 11 Nov 2016 18:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935258AbcKKSzs (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 13:55:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63493 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935122AbcKKSzq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 13:55:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C7004C144;
        Fri, 11 Nov 2016 13:55:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cAZFuuRk59Z9ArcRL0Csuv2hN9I=; b=FxU2PK
        +u7QVk0WxFdToM4ERF0RC9pMSM64qdDq7D05Z7wQrbav8DczmyF1M9otZYYk2oJd
        +DJ6MKQlrj2VzG1iG2B324efN/nY5dylk/SmLz13RyE7gAM9nMJcfO7v6ZyUZuzI
        PT8eDPDs8NRFPqlGUEi04jRWBQZu46PXFF5U0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MiV27jZBbNOq5L+W9GeEDzjoZT6bIvFm
        qkqtTEXQz6B8bBVd4Xed+Nx426W9ghWH3bjwg0pQGzifYa1Du4rvcTJbDo4bR7/h
        4woJrXrOkAETRBpxlzOaTDCw6i1swwKRL/A9geVTskhbW4KnYuvREWuOU603JHax
        P8QVWSZfXFs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 786974C143;
        Fri, 11 Nov 2016 13:55:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C618A4C142;
        Fri, 11 Nov 2016 13:55:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like shell variables
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
        <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
        <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org>
        <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
Date:   Fri, 11 Nov 2016 10:55:42 -0800
In-Reply-To: <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org> (Johannes Sixt's
        message of "Fri, 11 Nov 2016 18:31:48 +0100")
Message-ID: <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72C5183E-A840-11E6-B401-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> We have to use $PWD instead of $(pwd) because on Windows the latter
> would add a C: style path to bash's Unix-style $PATH variable, which
> becomes confused by the colon after the drive letter. ($PWD is a
> Unix-style path.)
>
> In the case of GIT_ALTERNATE_OBJECT_DIRECTORIES, bash on Windows
> assembles a Unix-style path list with the colon as separators. It
> converts the value to a Windows-style path list with the semicolon as
> path separator when it forwards the variable to git.exe. The same
> confusion happens when bash's original value is contaminated with
> Windows style paths.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Am 11.11.2016 um 18:11 schrieb Johannes Sixt:
>> Am 11.11.2016 um 18:06 schrieb Junio C Hamano:
>>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>> ...
>
> When the MSYS program such as bash invokes a non-MSYS program, it
> translates the Unix-style paths in arguments and environment variables
> to Windows stlye. We only have to ensure that we inject only Unix-style
> paths in these places so as not to confuse the conversion algorithm.
> Most of the time, we do not have to worry.
>
> On the other hand, when we write a path to a file that git.exe consumes
> or receive a path from git.exe, i.e., when the path travels through
> stdout and stdin, no automatic translation happens (which is quite
> understandable), and we have do the translation explicitly. An example
> for such a case is when we write a .git/info/alternates file via the
> shell.
>
>> A simpler fix is to use $PWD instead of $(pwd). I'll submit a patch in a
>> moment.
>
> Here it is. I had proposed the t0021 part earlier, but it fell through
> the cracks during the temporary maintainer change.

Thanks.  Dscho, does this fix both of these issues to you?

>  t/t0021-conversion.sh    | 2 +-
>  t/t5615-alternate-env.sh | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 9ff502773d..b93cd44546 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -4,7 +4,7 @@ test_description='blob conversion via gitattributes'
>  
>  . ./test-lib.sh
>  
> -TEST_ROOT="$(pwd)"
> +TEST_ROOT="$PWD"
>  PATH=$TEST_ROOT:$PATH
>  
>  write_script <<\EOF "$TEST_ROOT/rot13.sh"
> diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
> index 22d9d8178b..eec4137ca5 100755
> --- a/t/t5615-alternate-env.sh
> +++ b/t/t5615-alternate-env.sh
> @@ -31,14 +31,14 @@ test_expect_success 'objects inaccessible without alternates' '
>  '
>  
>  test_expect_success 'access alternate via absolute path' '
> -	check_obj "$(pwd)/one.git/objects" <<-EOF
> +	check_obj "$PWD/one.git/objects" <<-EOF
>  	$one blob
>  	$two missing
>  	EOF
>  '
>  
>  test_expect_success 'access multiple alternates' '
> -	check_obj "$(pwd)/one.git/objects:$(pwd)/two.git/objects" <<-EOF
> +	check_obj "$PWD/one.git/objects:$PWD/two.git/objects" <<-EOF
>  	$one blob
>  	$two blob
>  	EOF
