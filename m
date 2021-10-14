Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3F8C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 16:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A8E6109E
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 16:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhJNQxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:53:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51036 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhJNQxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 12:53:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAE0BE0939;
        Thu, 14 Oct 2021 12:51:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MuRN8o9ev0KxkQiJ1CNkLTmVmIQP8HJ5/4Nauw
        cXY84=; b=SKTDrejggIirzmwywNqJoXN59K1ICL2OV5TBGYzzWi3eDntKsrGTXT
        HOzYX9kxOHMGJOyUNBZWSM0ih7GF5DBMj3G4ywfJx9y+I8XMoSyyVG1n0nRwIa3y
        vRnwQQ44pTr5Y2rWkljkDeg/tjVT+Eei1t2Q5T9VF4cUDvqKINOcs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0EB8E0938;
        Thu, 14 Oct 2021 12:51:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 084EEE0937;
        Thu, 14 Oct 2021 12:51:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, vagabon.xyz@gmail.com,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH RESEND] archive: rewrite description for compression
 level option
References: <20211014120233.7834-1-bagasdotme@gmail.com>
Date:   Thu, 14 Oct 2021 09:51:28 -0700
In-Reply-To: <20211014120233.7834-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Thu, 14 Oct 2021 19:02:34 +0700")
Message-ID: <xmqqh7djczxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA1BB394-2D0E-11EC-9158-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Currently, the description of compression level option (`-<number>` or
> `-#`) only specifies two level (`-0` and `-9`), giving the impression
> that only both levels are accepted, although other level number can be
> specified. Rewrite the description.

While I find that the updated description is more detailed [*], I am
not sure if the change to the heading is an improvement for readers,
as I do not think of a case where users would choose to use anything
other than to use (1) no compression level option, (2) '-0' for
speed, or (3) '-9' for size, and explicitly singling out `-0` and
`-9` like the current text does would help those who wonder what the
option, used in a script written by somebody else that they are
given to maintain, mean, better than the updated text that does not
even allow /-9 in their pager to look for the description, if you
only had `-<number>` or `-#`.

Also, unless we take `-47`, I do not think it is a good idea to
spell it as `-<number>`.  Perhaps `-<digit>` is OK, but it shares
exactly the same issue as `-<number>` I mentioned above.

Thanks.


[Footnote]

 * Not that the original does not carry the same information; when
   "-9" is described as "highest and slowest", accompanied by "any
   number from 1 to 9 to adjust", the readers can easily read that
   "Higher number indicates ..." tradeoff without getting told.

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/git-archive.txt | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index 9f8172828d..097b999bbd 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -93,12 +93,11 @@ BACKEND EXTRA OPTIONS
>  
>  zip
>  ~~~
> --0::
> -	Store the files instead of deflating them.
> --9::
> -	Highest and slowest compression level.  You can specify any
> -	number from 1 to 9 to adjust compression speed and ratio.
> -
> +-<number>::
> +	Select the compression level. Higher number indicates better
> +	compression at the expense of longer time to compress. Valid
> +	values are from 0 to 9. If 0 is selected, the files will be
> +	stored without compressing.
>  
>  CONFIGURATION
>  -------------
>
> base-commit: 2bd2f258f4195ac54293a3f45b86457c0bd5fc11
