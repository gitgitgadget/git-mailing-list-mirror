Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B677C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6519D61284
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhDGWVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:21:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63665 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDGWVV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:21:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEC44BD195;
        Wed,  7 Apr 2021 18:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pqKsiPpVc/Lz
        Yiadg0wiYfilvWw=; b=urLQfZsxVsm8M+tFBW11V4+RV5MgCxIwmrW3E5nGSj8f
        GugnB+Fjat3mkLCbk86Vk56D0YuxWmySTALAMyifMyxjMKkqO7pUc+jnUCbzQdf2
        QH6EjGr8lIwigWrZLGq0hoF41yHMfViInviFKzSoNlPuZj4OmXBsF/zfrJ0MlQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UX6SZ1
        XfpodmMnDtdlamMa8oeOapqqxlUP8X/dSaAuld474LZrnolox9pfiUSulz33cVy0
        8rSOqgJyDsa921SqPA94dQt3ktwp0uLBg5aODWBjf+uX5Tt07NcgDMWzaIEm/QQR
        8V9s9nGWIQFjywfwBW4yJ2AkUO466rduPmiDo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5C1DBD194;
        Wed,  7 Apr 2021 18:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4EA31BD193;
        Wed,  7 Apr 2021 18:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bash completion: complete CHERRY_PICK_HEAD
References: <patch-1.1-483669af7fc-20210407T105035Z-avarab@gmail.com>
Date:   Wed, 07 Apr 2021 15:21:09 -0700
In-Reply-To: <patch-1.1-483669af7fc-20210407T105035Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 7 Apr
 2021 12:50:51 +0200")
Message-ID: <xmqq35w1ybvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8E2F583E-97EF-11EB-B3FD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD; do
> +			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PI=
CK_HEAD; do
>  				case "$i" in
>  				$match*)
>  					if [ -e "$dir/$i" ]; then
>						echo "$pfx$i$sfx"
>					fi
>					;;

Hmph, it gets tempting to do this instead:

	for i in $(cd "$dir/" && echo HEAD *_HEAD)
	do
		case "$i" in
		$match*)
			echo "$pfx$i$sfx"
			;;
		esac
	done

but I am no completion expert, so I'll queue the patch as-is.

Thanks.
