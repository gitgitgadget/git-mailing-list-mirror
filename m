Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ACDC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 23:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41F560C4B
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 23:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhJGXqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 19:46:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52550 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbhJGXqC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 19:46:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 149D9164FD2;
        Thu,  7 Oct 2021 19:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ChY3KKacG0EN
        /ChiNp2k53V+oW/yjsalXNPECQTKsKg=; b=rF0acALWwOBFHFOFDfofibb29/WT
        fmQ2lcs8vWapd6OpTlGsBdTLnemRAo9Y2Wvbt1NQuLlcbSnnxBjBkHHKcIk8x6H2
        qpC6twWoSIPcyD/IYNPY4juMZqwx7LqodSrwKyAorRtuPT1Zuj39f9231mQekRVL
        3j+3ERIjgD4/alE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0DA12164FD0;
        Thu,  7 Oct 2021 19:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 632D5164FCE;
        Thu,  7 Oct 2021 19:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Subject: Re: [PATCH] p3400: stop using tac(1)
References: <85831cc2-307f-1be8-9bb3-c44028ad07fa@web.de>
        <YVq752xjzYz+LTq6@coredump.intra.peff.net>
        <f6a1296f-f524-9042-7f88-9591522971af@web.de>
        <YVyppmEGkNCxZ+5L@coredump.intra.peff.net>
        <a3377973-4f4a-376a-f02e-94a3b20dd9ad@web.de>
Date:   Thu, 07 Oct 2021 16:44:04 -0700
In-Reply-To: <a3377973-4f4a-376a-f02e-94a3b20dd9ad@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 7 Oct 2021 22:42:08 +0200")
Message-ID: <xmqqzgrkmmd7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 75296708-27C8-11EC-AF54-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> In my mind, test is an external command.  Wikipedia [1] says it has bee=
n
> a builtin since the early 80ies, and I couldn't find a shell without it=
.
> I wonder where I picked up that outdated assumption -- I'm not actually
> _that_ old.  Time for an update..

Funny, as I was wondering about the same thing the other day in a
totally different context.

Our older shell script (like tests) tends to strongly prefer "case
... esac" over "test" for this exact reason, e.g option parsing loop
often uses

    while case $#,$1 in 0,*) break ;; *,-*) ;; *) break ;; esac
    do
	...

instead of

    while test $# -gt 0 && ...

to avoid "test".  I'm not actually _that_ old, either, but my
current suspicion is that those who traind us are old enough ;-)


