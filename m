Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57271C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CA1206DB
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YMI0dnbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgAGT5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:57:45 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51098 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgAGT5o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 14:57:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9AC097F4A;
        Tue,  7 Jan 2020 14:57:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pFA/Uu7L4rSulELAAHGRRhZZnAw=; b=YMI0dn
        bKuR/YsdFd7Hb+Kj4u5rs9nrN7oLahaP4XM5a39vVz17lLNpe8b5bMBoxYMoQm5l
        TlUjy4tHk18TtcdjtV9X4aUPnI+6Jw6IfvwBWMP5URsDOsfRAIjQqesaNkyOUPgl
        Gz0dD71CVPKca0cADlyGbPHi9hvKZ7hfsYTZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uhq567q+oUvz7Q2IktrS3d+6dA3b464n
        mrikOYY56zxDUvImlxD7Ig+wBw2KGG7h9kKl/BzmE0iBOm1aJ2jagHqQnB30CgQv
        pjmm/ySpPOhXKu3DhFLuOE/oMHlsRAr09oisfxB+PNH6uUcdy6YkNzzCU02ZFIpa
        9PvzXGp5RS0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C199197F49;
        Tue,  7 Jan 2020 14:57:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8554B97F48;
        Tue,  7 Jan 2020 14:57:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Liam Huang via GitGitGadget <gitgitgadget@gmail.com>,
        Liam Huang <liamhuang0205@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/1] Update imap-send.c, fix incompatibilities with OpenSSL 1.1.x
References: <pull.516.git.1578391376.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2001071313580.46@tvgsbejvaqbjf.bet>
        <xmqqv9pn5hgl.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2001071944250.46@tvgsbejvaqbjf.bet>
Date:   Tue, 07 Jan 2020 11:57:36 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001071944250.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 7 Jan 2020 19:48:16 +0100 (CET)")
Message-ID: <xmqq7e2359an.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4CCB07A-3187-11EA-B707-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I am afraid that I do not know of any means to teach GitGitGadget to make
> that call whether it has seen a consensus.
>
> And I fear that you are asking me to punt back that decision to
> contributors, i.e. put a lot of the burden of knowing how Git
> contributions are expected to progress _away_ from GitGitGadget.

Yes, and that is why I am giving review comments to contributors to
teach how the development community works.

> Of course, I can teach GitGitGadget to not Cc: you. Like, always. Not sure
> that you would like that any better because you would not even be Cc:ed
> once consensus was reached.

That would actually be better.  Somebody in the discussion thread
would probably say "This is good enough---send it to the maintainer"
when the topic is ready.
