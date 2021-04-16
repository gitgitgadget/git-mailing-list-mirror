Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14862C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 20:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D120E6124B
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 20:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhDPUlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:41:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64167 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbhDPUlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 16:41:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A24C1168C8;
        Fri, 16 Apr 2021 16:40:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZFyBa1uo+EJw
        eszb0lJDxHDXc9w=; b=eKBG2FJJbHDkaQtbz3ylNjECbKccn0nK92v3y2Jm38gM
        5432egZSowaS7vXAM0Izdodysx0qJguBlP5hcX0sw+LwmNNfRIXFYn7cln5Sa4QL
        WmxmyiWHSxyMt0LBsF0FKL+JfvpWEUnJCmzw4HPFCao+5dmswMOVvB3EWTj+fac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=n6vJNp
        On7HwbzV/lp+EUu99laYdOT4cVJNIc9IwE0llCVxwrysvd17WF0YSpzil3RLVLVh
        AXfXxAkNzPUcGSDeEeXZyO6dhwiyeOeow+l95UmE9rgKGZMUk3syX1FToRUzxDY4
        +B+sD5dQNZpdG2sqUBjONEn9Z4Hxas7yH/6YI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 537B11168C7;
        Fri, 16 Apr 2021 16:40:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E8491168C6;
        Fri, 16 Apr 2021 16:40:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: avoid aliased command lookup error in
 nounset mode
References: <20210416191939.1120651-1-ville.skytta@iki.fi>
Date:   Fri, 16 Apr 2021 13:40:46 -0700
In-Reply-To: <20210416191939.1120651-1-ville.skytta@iki.fi> ("Ville
 =?utf-8?Q?Skytt=C3=A4=22's?=
        message of "Fri, 16 Apr 2021 22:19:39 +0300")
Message-ID: <xmqq7dl2klo1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 06B49188-9EF4-11EB-AD58-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> Aliased command lookup accesses the `list` variable before it has been
> set, causing an error in "nounset" mode. Initialize to an empty string
> to avoid that.
>
>     $ git nonexistent-command <Tab>bash: list: unbound variable
>
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, will queue.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index dfa735ea62..49e76e9d08 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1129,7 +1129,7 @@ __git_pretty_aliases ()
>  # __git_aliased_command requires 1 argument
>  __git_aliased_command ()
>  {
> -	local cur=3D$1 last list word cmdline
> +	local cur=3D$1 last list=3D word cmdline
> =20
>  	while [[ -n "$cur" ]]; do
>  		if [[ "$list" =3D=3D *" $cur "* ]]; then
