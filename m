Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E0C1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbdLLTsB (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:48:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62795 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752273AbdLLTsA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:48:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D7FDC7FB9;
        Tue, 12 Dec 2017 14:48:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GgU5kQ+LGPWf57BDHs6BNlk1/Ek=; b=FReDbB
        aE6wm778rR+aIWZDAQuzzB1j8hK35X9wKKA3ut0YBDYz96lEHEuxWzpzBs6oq/aB
        OA979F9B71CNAmGwmB7uzQlWPhx+kdGsoT6xZHygiKhwpZx8xaELXXJFy1uiV+4A
        wVaegfKR5nL1owmFaBMyhTiuA6xGn7hX94q3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BUedU/pBceP+QNb6LBhOpW5KeiK3NMwR
        vVEiU5wSB4koCLZCBREEQoa+6LpUHsfLxoz6ArgdZaBholzMjceRUGDmbuGvcrim
        6P8O0Ab1BNGBCVEvFGKA4BHfDX6DytvvzVJeO3RXv6beUSQ6bUm8ujGSjWQxwZIw
        rkJCxe0If+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34664C7FB8;
        Tue, 12 Dec 2017 14:48:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A82A1C7FB6;
        Tue, 12 Dec 2017 14:47:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: [PATCH] doc: clarify usage of XDG_CONFIG_HOME config file
References: <1513077862-165-1-git-send-email-jacob.keller@gmail.com>
Date:   Tue, 12 Dec 2017 11:47:58 -0800
In-Reply-To: <1513077862-165-1-git-send-email-jacob.keller@gmail.com> (Jacob
        Keller's message of "Tue, 12 Dec 2017 03:24:22 -0800")
Message-ID: <xmqqo9n320ep.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B7AB2DE-DF75-11E7-B045-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>  --global::
> +	For writing options: write to global user configuration file
> +	rather than the repository `.git/config`.
>  +
> +For reading options: read only from global user configuration file
> +rather than from all available files.
>  +
>  See also <<FILES>>.

OK.

> @@ -237,26 +235,30 @@ See also <<FILES>>.
>  FILES
>  -----
>  
> +If not set explicitly with `--file`, there are three locations where
>  'git config' will search for configuration options:
>  
> +System-wide configuration::
> +	Located at `$(prefix)/etc/gitconfig`.
>  
> +User-specific configuration::
> +	One and only one of the following files will be read

We said "will search for" upfront, but this talks about "will be
read", leaving the reader puzzled as to what should happen when
writing.  Perhaps "s/read/used/"?

> ++
> +- `~/.gitconfig`
> +- `$XDG_CONFIG_HOME/git/config`
> +- `$HOME/.config/git/config`
> ++
> +If `~/.gitconfig` exists, it will be used, and the other files will not be
> +read. Otherwise, if `$XDG_CONFIG_HOME` is set, then `$XDG_CONFIG_HOME/git/config`
> +will be used, otherwise `$HOME/.config/git/config` will be used.

And then "and the other files will not be read" can be dropped from
the first sentence of this paragraph?

Yaroslav on the original thread mentioned that reading codepath
without --file or --global does not limit to one of the three, and
this section is about "If not set explicitly with `--file`", so we'd
need to make sure if the above is what happens in reality (or update
the proposed clarification to match the reality).

Thanks.
