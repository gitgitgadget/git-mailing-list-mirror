Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8210120899
	for <e@80x24.org>; Mon, 14 Aug 2017 18:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbdHNSTR (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 14:19:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61562 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751031AbdHNSTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 14:19:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8151CAA6E0;
        Mon, 14 Aug 2017 14:19:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BUwVSjgjSU/5wwL3+hgdJN8fWqE=; b=aWRGLN
        Lzm8H+U/Y2BymEzQ5m7u6YC5hI4iLMTBnDQK3kgwCjj4qZnXEM8qqfgNzd1hryL6
        PI5TUbbdmYl+9FTOL3QmybQnWXSOCu5po9WRsulQoayqm9idNz4T2/RzBmw2Sj0K
        rUn1WJcItehZIk3jzkKI1DOsxfrEZw8oCM8+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SeUwAI6JhKh1T0w8FNVyc+eSZpcvRpMM
        H3zfW7yctGYblVxYMgePFWgga6ZFNDqsZPP0zZ6uskbBEg91W3Gl91jeLEnR21iO
        3700XgVuOdhI/69RyyWMk4D32mq7Qadrj5AnGtmCqOv3wcOzXKIo9XQS2qmg9Fso
        2jg2Cr9jG1o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A79DAA6DF;
        Mon, 14 Aug 2017 14:19:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4233AA6DC;
        Mon, 14 Aug 2017 14:19:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] hook: use correct logical variable
References: <20170711141111.7538-3-kaarticsivaraam91196@gmail.com>
        <20170814084646.30781-1-kaarticsivaraam91196@gmail.com>
Date:   Mon, 14 Aug 2017 11:19:06 -0700
In-Reply-To: <20170814084646.30781-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 14 Aug 2017 14:16:46 +0530")
Message-ID: <xmqqwp66ui5h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FEF388C-811D-11E7-86FC-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Sign-off added should be that of the "committer" not that of the
> "commit's author".
>
> Use the correct logical variable that identifies the committer.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  This fixes a small issue when trying to do the following with the script enabled,
>
>     $ git commit --amend -s
>
>  If the commit being amended was signed off by the commit's author
>  then the above command would *append* the sign-off of the
>  committer followed by that of the commit's author.
>  That' because the script is invoked only after the sign-off is
>  added by the '-s' option AND the default of 'trailer.ifexists'
>  for interpret-trailers currently defaults to the
>  'addIfDifferentNeighbor' thus interpret-trailer fails to identify
>  the existing sign-off of the commit's author and adds it.
>
>  Anyways, it doesn't make sense for a script to add the sign-off
>  of the commit's author. So, fixing it seemed correct to me.

I tend to agree with "Anyways" above ;-) simply because I found the
long paragraph more confusing than enlightening, leaving me wonder
"why is the user using different settings for author and committer
name" at the end, which _is_ an irrelevant point in the issue being
addressed.

The real issue is that this commented-out sample hook uses "author"
ident for the sign-off, while all the rest of Git (i.e. all callers
of append_signoff() in sequencer.c) use committer ident.

If anything to be changed to this patch, I would say its "should be"
in the log message can be clarified with "why", perhaps like:

    Sign-off added should be that of the "committer", not that of
    the "commit's author"; that is how the rest of Git adds sign-off
    using sequencer.c::append_signoff().

Thanks.

>  templates/hooks--prepare-commit-msg.sample | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
> index a84c3e5a8..12dd8fd88 100755
> --- a/templates/hooks--prepare-commit-msg.sample
> +++ b/templates/hooks--prepare-commit-msg.sample
> @@ -34,7 +34,7 @@ SHA1=$3
>  #  *) ;;
>  # esac
>  
> -# SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
> +# SOB=$(git var GIT_COMMITTER_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
>  # git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
>  # if test -z "$COMMIT_SOURCE"
>  # then
