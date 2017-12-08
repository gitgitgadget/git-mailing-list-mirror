Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9B520C3A
	for <e@80x24.org>; Fri,  8 Dec 2017 18:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbdLHSNY (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 13:13:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60558 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752111AbdLHSNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 13:13:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 627DED244A;
        Fri,  8 Dec 2017 13:13:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qi4rOqOPWyTq
        eGYvRaGFLbSkFvA=; b=wcjvtZ6SXn+g3IsEI4LeYst5OTeiXbGTsJNzq4kH9f/b
        u0i+Q5uZkNXZEvo21G+o55o0+AloqT53U32XUXYSyB+nf1pqj+52YHc7xgQ0P8U+
        LVp1PIei181456wY498O9T3ShW3vZkxBLfss1W9Nay9yt2n7WhfYCn0ymVAag9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NGNLZX
        NoubZBB5NDJ/K07u3sNmjONcgHFGtSnCtwbPN3rCUy9svJCaP3aHmX0LARCnW1cy
        GvBETbzzRAHFHWVMMJIqDY9OBNI4Xe5rTYsmqRwbfPHyUs5X99nvLB7SRAFT8pfA
        u52xRitR7k5I8LF2LWBJCoIbhZAyYEdLkRn1g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 596A7D2449;
        Fri,  8 Dec 2017 13:13:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA200D2448;
        Fri,  8 Dec 2017 13:13:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, ashishnegi33@gmail.com
Subject: Re: [PATCH v1 1/2] t0027: Don't use git commit <empty-pathspec>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
        <20171208174633.9903-1-tboegi@web.de>
Date:   Fri, 08 Dec 2017 10:13:20 -0800
In-Reply-To: <20171208174633.9903-1-tboegi@web.de> (tboegi@web.de's message of
        "Fri, 8 Dec 2017 18:46:33 +0100")
Message-ID: <xmqqpo7p84vz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7985E846-DC43-11E7-A419-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Replace `git commit -m "comment" ""` with `git commit -m "comment"` to
> remove the empty path spec.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/t0027-auto-crlf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks a bit strange.  The intent seems to commit all changes
made in the working tree, so I'd understand it if it replaced the
empty string with a single dot.

I also thought that we deprecated use of an empty string as "match
all" pathspec recently, and expected that this to break.

    ... goes and looks ...

Indeed, 229a95aa ("t0027: do not use an empty string as a pathspec
element", 2017-06-23) does exactly that.


> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index c2c208fdcd..97154f5c79 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -370,7 +370,7 @@ test_expect_success 'setup master' '
>  	echo >.gitattributes &&
>  	git checkout -b master &&
>  	git add .gitattributes &&
> -	git commit -m "add .gitattributes" "" &&
> +	git commit -m "add .gitattributes" &&
>  	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nL=
INETWO\nLINETHREE"     >LF &&
>  	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\=
r\nLINETWO\r\nLINETHREE" >CRLF &&
>  	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\r\=
nLINETWO\nLINETHREE"   >CRLF_mix_LF &&
