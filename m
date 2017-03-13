Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC3E20373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbdCMVwK (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:52:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59028 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750961AbdCMVwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:52:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D011385B8D;
        Mon, 13 Mar 2017 17:52:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jn9ALoJrv892icUYi2GWaZR87Vk=; b=vIvx1J
        FAUiz6T3Y4FTFIRgK5YbaUH5sbayKSq9jLXSgqRXi/jKfzP9oDe3agKu3EqYW8el
        aSl5qOYQdqwy6m8fHZ8zr6DpWCYlo3viqgXFhGqpCogjVHhvgk+/ahHMYj2YOfvk
        pA1JlAGoCd9S4nOggGgUNNdmwWMIVk8G0U+P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w7npe0QPR838zYP2q3PDjw+zj/cgD5n/
        DMY2flE6IpZrp83uzQcbp6EMG5AdXA4a7WHV7oyT9BRmJp0JwmQy4vXeLuLY+UzK
        3Bt4Jz6YHBBUTJrAYRbWAbz9wRQI05nlJW/zNR69zwIqsUouLIMj7gC9JsA99AiC
        RrgIravCGwY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9B6285B8C;
        Mon, 13 Mar 2017 17:52:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4897185B8B;
        Mon, 13 Mar 2017 17:52:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v2 2/2] credential-cache: use XDG_CACHE_HOME for socket
References: <20170313172232.96678-4-lehmacdj@gmail.com>
        <20170313204355.56559-1-lehmacdj@gmail.com>
        <20170313204355.56559-2-lehmacdj@gmail.com>
Date:   Mon, 13 Mar 2017 14:52:06 -0700
In-Reply-To: <20170313204355.56559-2-lehmacdj@gmail.com> (Devin Lehmacher's
        message of "Mon, 13 Mar 2017 16:43:55 -0400")
Message-ID: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D697F2E-0837-11E7-A02E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <lehmacdj@gmail.com> writes:

> git-credential-cache will now use a socket following the XDG base path
> specification by default. This increases consistency with other
> applications and helps keep clutter out of users' home directories.

We tend to write our log messages in imperative mood, as if you are
giving an order to the codebase to "be like so" (alternatively, you
can read them as if you are giving an order to the maintainer of the
code to "make these changes").

	We have been using ~/.git-credential-cache/socket as the
	location to store the UNIX socket to communicate with the
	credential daemon process.  In order to make it more
	consistent with other applications and reduce clutter in the
	home directory, move it to $XDG_CACHE_HOME/git/credential/socket,
	which matches what XDG base path specification suggests.

Similarly for the other two paragraphs.  Instead of "We still
check the old location ...", just "Check the old location ...", etc.

> If there is not a socket at that location we create a new one at
> $XDG_CACHE_HOME/git/credential/socket. This complies with the XDG
> standard and good for the reasons previously mentioned. 

And the second sentence can go; you already said why you think
XDG_CACHE_HOME is a good idea.

> We use the
> subdirectory credential/ in case we later want to store other files
> under $XDG_CACHE_HOME/git/ and to make the purpose of the socket clear.

And this probably can disappear (or rolled into the first paragraph,
if we really want; personally I think it is obvious why we want the
extra "credential" directory under "git" there).

> I also change to documentation to reflect the new default socket
> location.

This probably does not have to be said, as it is obvious from the
diffstat.

Missing sign-off.

> ---
>  Documentation/git-credential-cache.txt |  3 ++-
>  credential-cache.c                     | 16 +++++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
> index 96208f822..4b9db3856 100644
> --- a/Documentation/git-credential-cache.txt
> +++ b/Documentation/git-credential-cache.txt
> @@ -34,7 +34,8 @@ OPTIONS
>  
>  	Use `<path>` to contact a running cache daemon (or start a new
>  	cache daemon if one is not started). Defaults to
> -	`~/.git-credential-cache/socket`. If your home directory is on a
> +	`~/.git-credential-cache/socket` if it exists and otherwise
> +    `$XDG_CACHE_HOME/git/credential/socket`. If your home directory is on a

There is a funny indentation here.

>  	network-mounted filesystem, you may need to change this to a
>  	local filesystem. You must specify an absolute path.
>  
> diff --git a/credential-cache.c b/credential-cache.c
> index cc8a6ee19..db1343b46 100644
> --- a/credential-cache.c
> +++ b/credential-cache.c
> @@ -83,6 +83,20 @@ static void do_cache(const char *socket, const char *action, int timeout,
>  	strbuf_release(&buf);
>  }
>  
> +static char *get_socket_path(void) {
> +	char *home_socket;
> +
> +	home_socket = expand_user_path("~/.git-credential-cache/socket");
> +	if (home_socket) {
> +		if (file_exists(home_socket))

Don't we want to make sure that this path _is_ a socket?  In general
I think file_exists() is a poor choice to use here (the existing use
are all about having a regular file there, and its definition may be
later tightened from "does lstat() succeed?" to something a bit more
sensible, and FIFO may start failing the updated test.

Thanks.
