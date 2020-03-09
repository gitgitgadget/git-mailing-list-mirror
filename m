Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15014C10F25
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 19:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B352146E
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 19:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H0RCo76J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgCITrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:47:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55553 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCITre (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 15:47:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 731E0B4171;
        Mon,  9 Mar 2020 15:47:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VRMrcdQuVGL3FzJirokH79p3T2Y=; b=H0RCo7
        6JuyVYAA7G5GLFBWPw2CVtv94U7Nik6cDSzHP/oKRoY/DDP5TgTg/NaAF6Gryx0y
        V1je4zf8hUnpn7N0W+U+7Ijo1nBilfiUa6zIaoKmsIXzLuZ7cWcfP4Y0CCW+H9m0
        ZjGXUUJw/MHuTqdI1vM8IVcowPFX8cDc4mQGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cq2+iUyidqA860QOXKNT+uKGk6Ggy3b2
        D+cY7+00b4ZjyONUqWbRc2zXPW9OuNrbL849qgfLjt9WiNFBozaTZyJZGX8PdHg4
        HyAtgMZOOATqkcgRQFKygNKL+3D4z4grKljG3Ka6dQY0tG4A+qi+9W0FyKAtYlJY
        XRhfhysKdJc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 521A4B4170;
        Mon,  9 Mar 2020 15:47:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5E8EDB416F;
        Mon,  9 Mar 2020 15:47:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
References: <20200302230400.107428-1-emilyshaffer@google.com>
        <20200302230400.107428-3-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
        <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com>
        <xmqqr1y52w5y.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2003082319260.46@tvgsbejvaqbjf.bet>
        <xmqqr1y11sn7.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2003092013090.46@tvgsbejvaqbjf.bet>
Date:   Mon, 09 Mar 2020 12:47:27 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003092013090.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 9 Mar 2020 20:17:04 +0100 (CET)")
Message-ID: <xmqq36ah1fao.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF533232-623E-11EA-9797-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On the other hand, if we make `git-bugreport` a built-in, I cannot see any
> downsides.
>
> For me, therefore, having it as a built-in is a clear win. What am I
> missing?

The right sense of relative importance between efficiently running
the rest of Git by not bloting the main binary and making sure not
to ship Git that does not run unless "git bugreport" runs (which
makes sure that "bugreport" runs) is what you are missing, I
suspect.

Another thing is that you are giving "git bugreport" too much weight
and too little credit to inexperienced users, by assuming that we
will never hear from them when "bugreport" is incapable to run for
them.  They will report, with or without "git bugreport", and the
more important thing you seem to be missing is that after the
initial contact it would become an interactive process---there is
no reason to prioritize to ensure that the initial contact has
everything that is needed to diagnose any issue without further 
interaction.  "With my build, even 'bugreport' dumps core." is
perfectly good place to start.

Besides, wouldn't the ones on platforms, on which "git bugreport"
may have trouble running, i.e. the ones on minority and exotic
platforms, tend to be self sufficient and capable (both diagnosing
the issue for themselves, and reaching out to us as appropriate)
ones in practice (e.g. I have NonStop folks in mind)?
