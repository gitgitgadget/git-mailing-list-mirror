Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B344AC282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726F8214D8
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DX2bAAsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgAGUPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:15:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54475 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgAGUPU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 15:15:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BD682D863;
        Tue,  7 Jan 2020 15:15:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ezvby62mqJV/So7cu+L+gxRNvy4=; b=DX2bAA
        sDV6Y04kCN43B6/eJd1ObNZdw/B2/SEtgFC7uvhT4YXaG0QhYnk8UH8+JscjVCtE
        cCVdFhzWmeKBHPFjP/w1H69mVfsThTFv+0oA+cA1+8/cVWErD8LqJSe+qAU6ZE8z
        F30UcN8aFb40KW2v2Zqc3OYThSIP650O/QjBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bR4dYM4HP4VymSwhQRW4Ph1pYXN06DAn
        IiU+au5z41OFP2kNiq4V6/hZnI395PUGBeBmwZXBGg2xunsNDeNOvmsXhCUKhajE
        I7jDBXkpj8niuV3ZRZyVJKcLT17rxZ+vB56ERXh2TXeA8hIhURZC+yfE/ghrHNqb
        AcbJGXft95c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 120962D862;
        Tue,  7 Jan 2020 15:15:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 694942D861;
        Tue,  7 Jan 2020 15:15:18 -0500 (EST)
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
        <xmqq7e2359an.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 07 Jan 2020 12:15:17 -0800
In-Reply-To: <xmqq7e2359an.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 07 Jan 2020 11:57:36 -0800")
Message-ID: <xmqqtv573twq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C8A8DA6-318A-11EA-B45D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Of course, I can teach GitGitGadget to not Cc: you. Like, always. Not sure
>> that you would like that any better because you would not even be Cc:ed
>> once consensus was reached.
>
> That would actually be better.  Somebody in the discussion thread

s/better/much much &/;

> would probably say "This is good enough---send it to the maintainer"
> when the topic is ready.

Besides, when they send out patches they would also add area experts
and those who participated in the review of the earlier round to Cc:
so GGG needs to have a mechanism to allow the end user to do so.  And
by treating the maintainer merely just one of the reviewer, that
mechanism can naturally be reused.
