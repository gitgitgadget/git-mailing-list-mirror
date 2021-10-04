Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3ACC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EA061373
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbhJDQhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:37:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50837 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbhJDQhw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:37:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18403EB154;
        Mon,  4 Oct 2021 12:36:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dnOAQyvZ6au9
        Mjrew1wb6jgJ6lyv58pmwKAXM9rG1xw=; b=EkSEc1AgUxkjaAoxob6iWg86aOB8
        64taWFiLL3v5+hpTkcPoUAQRUJcR/Mn7U/vFaZQx3pH81A7nc9YZ2IExzhwKG3Mw
        QwUaQFD/qR8a6ucsihH09Nw0ChifensDz55PByaFZsrFG7YP0cWefES9hLU9NOlk
        NqxzxEcFnEz+FZk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F9B0EB153;
        Mon,  4 Oct 2021 12:36:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 791CFEB152;
        Mon,  4 Oct 2021 12:36:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/2] terminal: teach git how to save/restore its
 terminal settings
References: <20211002153654.52443-1-carenas@gmail.com>
        <20211004072600.74241-1-carenas@gmail.com>
        <20211004072600.74241-2-carenas@gmail.com>
Date:   Mon, 04 Oct 2021 09:36:00 -0700
In-Reply-To: <20211004072600.74241-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 4 Oct 2021 00:25:59 -0700")
Message-ID: <xmqq1r50ycgf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 29B6C034-2531-11EC-9A8E-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> diff --git a/compat/terminal.c b/compat/terminal.c
> index 43b73ddc75..1fadbfd6b6 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -8,7 +8,7 @@
> =20
>  #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
> =20
> -static void restore_term(void);
> +void restore_term(void);

Curious why you need this because (1) we do not have the same for
save_term() here, and (2) we include compat/terminal.h where these
two are declared next to each other.
