Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B3B202DD
	for <e@80x24.org>; Mon, 23 Oct 2017 01:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932180AbdJWBTm (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 21:19:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56813 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932171AbdJWBTl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 21:19:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A04B9ABE10;
        Sun, 22 Oct 2017 21:19:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iakUPK3rk7fj4QK+zyXjL4j5WI0=; b=gXsig/
        cssxGc8XBTfnnq/xVxKCJ1KZk1GC+LFCXjN5KR648scxLGVZKVheDmEjbY95Mnpl
        UiDwTlPHzzrembEBA4vdLYpA+exi3giPxo0F6OpG5EeJ/FqtUoC+DRO8UvxRWi4j
        SYI/ZQM63B0LwWl5ouhjh3IXMk7ACMuZqJ42Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dFuIEzeVPaPx8pdKGn4sMDOUHfAgSEgk
        GnZe9gzGX+bt21Lh/nmhuVtC87lghFANQ2C8jcCmfeTW5n80talaCpYv/xZ/6Dez
        0UbWwG5daGI+y7L7g/rjygS9wpq/gC58dZldqWbadCkWhrMaHlrqIWjB3J5iV0Q9
        cHRQqmHhFoI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97405ABE0F;
        Sun, 22 Oct 2017 21:19:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 155BFABE0E;
        Sun, 22 Oct 2017 21:19:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH v3 0/3] deprecate git stash save
References: <20171019183304.26748-2-t.gummerer@gmail.com>
        <20171022170409.8565-1-t.gummerer@gmail.com>
Date:   Mon, 23 Oct 2017 10:19:38 +0900
In-Reply-To: <20171022170409.8565-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 22 Oct 2017 18:04:06 +0100")
Message-ID: <xmqqwp3md5jp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DF96730-B790-11E7-97F7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Interdiff below:

Thanks.  Looks much more polished.

>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 89b6a0e672..8be661007d 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -86,7 +86,9 @@ The `--patch` option implies `--keep-index`.  You can use
>  
>  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
>  
> -	This option is deprecated in favour of 'git stash push'.
> +	This option is deprecated in favour of 'git stash push'.  It
> +	differs from "stash push" in that it cannot take pathspecs,
> +	and any non-option arguments form the message.

Every time I saw this line, I misread s/form/from/ and got
confused.

I know the below is what the above wants the readers to eventually
[*1*] know:

        'git stash save' cannot take pathspecs (nor it can be
        enhanced with new options in the future) because any
        non-option argument to it is treated as the message and has
        been deprecated.  'git stash push' supersedes 'git stash
        save'; it corrects the command line syntax by requiring '-m'
        before the message.

but I feel that the text in your patch still does not read clearly
enough.  But it may only be me.

Thanks.


[Footnote]

*1* By "eventually" what I mean is that it may not be necessarily a
good idea to lay it out all to the reader here at this point in the
document---they may not care why a subcommand is being deprecated,
but for those who want to know, we need to write it down somewhere.
