Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878CB20323
	for <e@80x24.org>; Fri, 17 Mar 2017 05:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbdCQFiv (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 01:38:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53776 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750898AbdCQFiu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 01:38:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8BDE6D9EE;
        Fri, 17 Mar 2017 01:38:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kge6rONfifW2d9Trio/IrSC+A0Y=; b=pZTt/q
        jjqF2UcDXFIw2Jm6XmswyLsVWXuJANPHooKXAZ5E/CI3+LqrSH5WGz0QN9e8VKJ1
        ferw77jRyoGXi94U6NBSGh/HR54YrKYTCZIiG1hirD47MaTMbpa81l+Id5RtX5/S
        4ab4O3WXL/r7zk+1utuBd0yi+J5TmfkQEbkok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vNr6qZn/Y2W6UobDevWTJDLub9w/Mu4I
        OYgfgSZfEXgxnzUwCShEq+wTPjyoGJ/QR0C9j/91oc6/3kDG9TI4UzeuLyuXPo7v
        Mw4YjNNilPahKWYB7q+XuDmxB8jVGQ9LQvQwXn6sSK7ex2hHF6EOuWGK5zm1NKib
        G1IBGKEx/9k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1EA16D9ED;
        Fri, 17 Mar 2017 01:38:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 515B06D9EC;
        Fri, 17 Mar 2017 01:38:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [GSoC][PATCH v5 3/3] credential-cache: add tests for XDG functionality
References: <20170316051827.97198-5-lehmacdj@gmail.com>
        <20170317025315.84548-1-lehmacdj@gmail.com>
        <20170317025315.84548-3-lehmacdj@gmail.com>
Date:   Thu, 16 Mar 2017 22:38:47 -0700
In-Reply-To: <20170317025315.84548-3-lehmacdj@gmail.com> (Devin Lehmacher's
        message of "Thu, 16 Mar 2017 22:53:15 -0400")
Message-ID: <xmqq37eca2e0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE920A98-0AD3-11E7-A5DA-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <lehmacdj@gmail.com> writes:

> +# test that the daemon works with no special setup
>  helper_test cache
> +
> +test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
> +	test_when_finished "
> +		git credential-cache exit &&
> +		rmdir -p .cache/git/credential/
> +	" &&
> +	test_path_is_missing "$HOME/.git-credential-cache" &&
> +	test -S "$HOME/.cache/git/credential/socket"
> +'

OK, the clean-up looks quite sensible.

> +test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exists" '
> +...
> +	password=store-pass
> +	EOF
> +	find . &&

A leftover from a debugging session?  If so remove the "find" line.

> +	test -S "$HOME/.cache/git/credential/socket" &&
> +	XDG_CACHE_HOME="$HOME/xdg" &&
> ...
> +'

> +test_expect_success 'use user socket if user directory is a symlink to a directory' '

I think anybody without NO_UNIX_SOCKETS is practically capable of
doing a symbolic link, but still it is a good idea to protect this
one behind the SYMLINKS prerequisite, i.e.

	test_expect_success SYMLINKS 'use ~/.git-credential-cache that is a symlink' '
		...

> +	test_when_finished "
> +...
> +'
> +
>  helper_test_timeout cache --timeout=1
>  
>  # we can't rely on our "trap" above working after test_done,

Thanks.
