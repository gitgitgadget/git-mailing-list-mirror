Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC6AC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 18:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E5624199
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 18:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GhlLcCtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgKQS5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 13:57:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55282 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgKQS5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 13:57:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC6E7FF041;
        Tue, 17 Nov 2020 13:56:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=C9KxONg4uoNp
        eiTmzZnSH1RLxEw=; b=GhlLcCtlmy/hRF3snjp6OpHvzxSPS26l/51AohFULsxN
        v1t0KXKZ20fA+PveJjJHHvUnQ/k2Ay+kg7NPGPUeNoeVeZKfUEtgDZ2LNLGcFWs2
        7nJBKPMXm+Ym9aIvgeia6MoP1gh3vvIVX1LFtgOA462kBk3UXnnovBswLYd7dUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=I/40DE
        UuyaXdlzElPcAYUR77sxXlpB69wtvEo8axKacJOGqXsT+Qi4IbIEmEwUJqGZfKnW
        EplKut2tGCHqTXWYNPIUMf7iMPtiKg6t01YLvgaaQL1Wbx/a5w16/mS19o5dhD0k
        S2dwH1314sbVFxBP8XZczjh6rM0ctdxp3EW5o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4F5EFF040;
        Tue, 17 Nov 2020 13:56:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E83FFF03F;
        Tue, 17 Nov 2020 13:56:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: bash: improve alias loop detection
References: <20201112223452.1526315-1-felipe.contreras@gmail.com>
Date:   Tue, 17 Nov 2020 10:56:54 -0800
In-Reply-To: <20201112223452.1526315-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Thu, 12 Nov 2020 16:34:52 -0600")
Message-ID: <xmqqtutn6ccp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A9D43774-2906-11EB-8121-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It is possible for the name of an alias to end with the name of another
> alias, in which case the code will incorrectly detect a loop.
>
> We can fix that by adding an extra space between words.
>
> Suggested-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

OK.  An extra local variable would not hurt and makes the code
easier to read.

Will queue.


> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index ce0dc1e0f8..cd2a02bafd 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1121,16 +1121,17 @@ __git_pretty_aliases ()
>  # __git_aliased_command requires 1 argument
>  __git_aliased_command ()
>  {
> -	local cur=3D$1 list word cmdline
> +	local cur=3D$1 last list word cmdline
> =20
>  	while [[ -n "$cur" ]]; do
> -		if [[ "$list" =3D=3D *"$cur "* ]]; then
> +		if [[ "$list" =3D=3D *" $cur "* ]]; then
>  			# loop detected
>  			return
>  		fi
> =20
>  		cmdline=3D$(__git config --get "alias.$cur")
> -		list=3D"$cur $list"
> +		list=3D" $cur $list"
> +		last=3D$cur
>  		cur=3D
> =20
>  		for word in $cmdline; do
> @@ -1154,7 +1155,7 @@ __git_aliased_command ()
>  		done
>  	done
> =20
> -	cur=3D"${list%% *}"
> +	cur=3D$last
>  	if [[ "$cur" !=3D "$1" ]]; then
>  		echo "$cur"
>  	fi
