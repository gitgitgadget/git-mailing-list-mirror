Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D331C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiAJRbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:31:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50203 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiAJRbo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:31:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CA651016A8;
        Mon, 10 Jan 2022 12:31:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4LQpQRBjLHe/AqALR0aqGmPQb3jPHyoi6qFH5Y
        Uv66g=; b=XfY7fntxNaPXmg7emeomM37LuYTuzPLg9fEqjov9lwxiLYnBmwWefx
        uVXsxpNwj5/wA5z/uRiAQXe/rk4yf7Gy/qflvphuuBoxDPjOuP4zSwJzorQr3DFA
        +KB6sL25ZO5ZH7gvHuMRjzIJjIKsecQHLjBCQHujR1yb89HiPKzvc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04C641016A7;
        Mon, 10 Jan 2022 12:31:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6560E1016A6;
        Mon, 10 Jan 2022 12:31:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Fabian Stelzer <fs@gigacodes.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: git ssh signing changed broke tag merge message contents
References: <CAHk-=whXPxWL7z3GiPkaDt+yygrRmagrYUnib7Lx=Vvrqx2ufg@mail.gmail.com>
        <YdxqshqXB/+ApOn2@nand.local>
Date:   Mon, 10 Jan 2022 09:31:41 -0800
In-Reply-To: <YdxqshqXB/+ApOn2@nand.local> (Taylor Blau's message of "Mon, 10
        Jan 2022 12:19:46 -0500")
Message-ID: <xmqqsftv1oqq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D8A92B0-723B-11EC-8AA0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I'll write up the details and post the patch shortly, but an easy fix
> is:

Ah, I am glad that you beat me ;-)

> --- 8< ---
>
> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index e5c0aff2bf..baca57d5b6 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -541,7 +541,6 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
>  			else
>  				strbuf_addstr(&sig, sigc.output);
>  		}
> -		signature_check_clear(&sigc);
>
>  		if (!tag_number++) {
>  			fmt_tag_signature(&tagbuf, &sig, buf, len);
> @@ -565,6 +564,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
>  		}
>  		strbuf_release(&payload);
>  		strbuf_release(&sig);
> +		signature_check_clear(&sigc);
>  	next:
>  		free(origbuf);
>  	}
>
> --- >8 ---
>
> Our coverage in t6200 (which should have ordinarily caught such a bug)
> is lacking and does not search for the tag message in fmt-merge-msg's
> output.

True.

Thanks, both.
