Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD67E1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 20:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755939AbcIUUkF (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 16:40:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50868 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755511AbcIUUkE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 16:40:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8920F403AC;
        Wed, 21 Sep 2016 16:40:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=70zUKf8rDig+6dGEY7pAHRRG6kw=; b=A5+cns
        A78PXFVy/SwISIVilneydG9EciObfTZ36u322yR0Hz0+dUIyCYvgSEljLmPrQ9x4
        u3lm8ATYyme+yz6+R2KHi6VuVYBLmkvhVCKM2jdsFKOshmzPJogUKbptWmNPNHgu
        Xr2QGykyoi2Xd6NIdHj0ou9uAEU25bsFzOaeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FKAxIWMbbNJS07wfUHACaY+DyuEig6jr
        /P6qG69vVb95QcOQAtaQYPZpI4BFfOyCcqrVkkhKDlmSrYi9ljH3/E5uhAdx/Zdi
        1uRgLjNPxhHXB1UKJ5xsAD7DyeiL7htkNc7Ia1ICcaWwALIG1BNli935uDHJORVq
        svG0+K/iQOI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44147403AA;
        Wed, 21 Sep 2016 16:40:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BD5E403A7;
        Wed, 21 Sep 2016 16:40:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     git@vger.kernel.org
Subject: Re: v2.10.0: ls-tree exit status is always 0, this differs from ls(1)
References: <20160921132655.h49HMsHbp%steffen@sdaoden.eu>
        <xmqqr38d9ova.fsf@gitster.mtv.corp.google.com>
        <20160921194004.QOizfyGm8%steffen@sdaoden.eu>
Date:   Wed, 21 Sep 2016 13:39:59 -0700
In-Reply-To: <20160921194004.QOizfyGm8%steffen@sdaoden.eu> (Steffen Nurpmeso's
        message of "Wed, 21 Sep 2016 21:40:04 +0200")
Message-ID: <xmqqeg4d6l7k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91766CEC-803B-11E6-9ACF-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steffen Nurpmeso <steffen@sdaoden.eu> writes:

> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> index dbc91f9..8ebeced 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -33,6 +33,10 @@ in the current working directory.  Note that:
>     However, the current working directory can be ignored by passing
>     --full-tree option.
>  
> + - the behaviour is different to that of "/bin/ls" in sofar as non-existing
> +   '<path>' arguments are silently ignored and not reflected in the exit
> +   status code.
> +
>  OPTIONS
>  -------
>  <tree-ish>::

Sorry, but I did not notice that there was an attached patch when I
was reading your response for the first time.  Risk of using an
attachment to e-mail ;-)

I think this issue does not need a separate bullet point.  The
existing text says:

    Note that:

     - the behaviour is slightly different from that of "/bin/ls" in that the
       '<path>' denotes just a list of patterns to match, e.g. so specifying
       directory name (without `-r`) will behave differently, and order of the
       arguments does not matter.

     - the behaviour is similar to that of "/bin/ls" in that the '<path>' is
       taken as relative to the current working directory.  E.g. when you are
       in a directory 'sub' that has a directory 'dir', you can run 'git
       ls-tree -r HEAD dir' to list the contents of the tree (that is
       'sub/dir' in `HEAD`).  You don't want to give a tree that is not at the
       root level (e.g. `git ls-tree -r HEAD:sub dir`) in this case, as that
       would result in asking for 'sub/sub/dir' in the `HEAD` commit.
       However, the current working directory can be ignored by passing
       --full-tree option.

and what caused your surprise is already covered by the first bullet
point, if the reader knows what "patterns to match" means in Git's
command line tools; it just needs to be extended to be more
meaningful to those who don't, I think.

How about rewriting the first bullet point like so instead:

  - the behaviour is different from that of "/bin/ls" in that the
    '<path>' are actually patterns to match, e.g. so specifying
    directory name (without `-r`) will behave differently, the order
    of the arguments does not matter, and a '<path>' argument that
    does not match any path is not an error (i.e. if there is no
    path that matches any pattern, nothing is shown in the output).
