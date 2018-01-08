Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A4B1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 19:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933266AbeAHTee (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 14:34:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53543 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933109AbeAHTed (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 14:34:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E30E1D4913;
        Mon,  8 Jan 2018 14:34:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ggTIS4OKLgR9M59ZGnzO3yFDEAI=; b=X37KCu
        mFrf/tgKv/wnDYMQhcQqJOIXjnLYzO2jTmGoE3nUkgBJRuAFPKjxMsWAFe67oWOV
        a+UwxB8VF5AIRZdEBeu1+dD3rtuYCqQaLpUs+RfJBQGIGXuCV++3dgSM+5R6SjW0
        pYOLriy3wHUbhOOdHcFAMtAjhrVqOtGo/7pC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I6Y0+AqyY2jhYCQWoT9eHLxFKMWNdgyu
        oEDBQ9DXx3qoahKZVuQnme/UO1dLdnqh1muaAi9TVuEuCdKFHnDKF4k6qLN6WMtR
        9wxfY/8jtc422oIs5hOWzXi9xxYhiZ87UtdxqALKta5k8bw/kiYpv7BU5W6jjXwN
        S2vY+YoW1zw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB221D4912;
        Mon,  8 Jan 2018 14:34:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5682ED4910;
        Mon,  8 Jan 2018 14:34:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org
Subject: Re: [PATCHv3 2/4] builtin/blame: dim uninteresting metadata
References: <20171110011002.10179-1-sbeller@google.com>
        <20180104224007.214548-1-sbeller@google.com>
        <20180104224007.214548-3-sbeller@google.com>
Date:   Mon, 08 Jan 2018 11:34:31 -0800
In-Reply-To: <20180104224007.214548-3-sbeller@google.com> (Stefan Beller's
        message of "Thu, 4 Jan 2018 14:40:05 -0800")
Message-ID: <xmqqk1ws87qw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F36D01B0-F4AA-11E7-8715-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +color.blame.repeatedMeta::
> +	Use the customized color for the part of git-blame output that
> +	is repeated meta information per line (such as commit id,
> +	author name, date and timezone). Defaults to dark gray.
> +
> ...

"Dark gray on default background" may alleviate worrries from those
who prefer black ink on white paper display by hinting that both
foreground and background colors can be configured.

Do we want to make this overridable from the command line,
i.e. --color-repeated-meta=gray?


> +#define OUTPUT_COLOR_LINE	02000

The name of the macro implies that this is (or at least can be) a
lot more generic UI request than merely "paint the same metadata on
adjacent lines in a different color".

> +		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),

Should this eventually become "--color=<yes,no,auto>" that is more
usual and generic, possibly defaulting to "auto" in the future, I
wonder?

> diff --git a/color.h b/color.h
> index 2e768a10c6..2df2f86698 100644
> --- a/color.h
> +++ b/color.h
> @@ -30,6 +30,7 @@ struct strbuf;
>  #define GIT_COLOR_BLUE		"\033[34m"
>  #define GIT_COLOR_MAGENTA	"\033[35m"
>  #define GIT_COLOR_CYAN		"\033[36m"
> +#define GIT_COLOR_DARK		"\033[1;30m"
>  #define GIT_COLOR_BOLD_RED	"\033[1;31m"
>  #define GIT_COLOR_BOLD_GREEN	"\033[1;32m"
>  #define GIT_COLOR_BOLD_YELLOW	"\033[1;33m"

How about using CYAN just like "diff" output uses it to paint the
least interesting lines?  That way we will keep the "uninteresting
is cyan" consistency for the default settings without adding a new
color to the palette.
