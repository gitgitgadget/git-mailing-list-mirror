Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AE4C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBA4613C8
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhELDbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:31:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62294 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDbI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 23:31:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 250601234E5;
        Tue, 11 May 2021 23:30:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W94nMUs1vx1sXvCgPDvEUccYi0E2Gor9Te2EvM
        Fc1tc=; b=qG28liVPGSxM60Es/NgEU7t/yIoTGTBIP5RmJrdov/oJ79qmS/nerg
        XuWRu3prGv7hrMnMlKywZoRzkrODt+/lOf6b5/rtqaDa7NEzLcQJ0jiuZ11Sroay
        QDW4NphgZeUr+pOBjwrtKfuKQe+XS1AwzpJO04AVj3QitNzJgIC3Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E45D71234E1;
        Tue, 11 May 2021 23:30:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F10B1234E0;
        Tue, 11 May 2021 23:29:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gregory Anders <greg@gpanders.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] git-send-email: use ! to indicate relative path to
 command
References: <20210511204044.69047-1-greg@gpanders.com>
        <20210511234935.65147-1-greg@gpanders.com>
        <YJsas0d4XPsYYpI7@camp.crustytoothpaste.net>
        <YJsi1jbtNFDRKXmq@coredump.intra.peff.net>
        <YJslRhzOmSwD7V2E@gpanders.com>
Date:   Wed, 12 May 2021 12:29:56 +0900
In-Reply-To: <YJslRhzOmSwD7V2E@gpanders.com> (Gregory Anders's message of
        "Tue, 11 May 2021 18:45:58 -0600")
Message-ID: <xmqqpmxwhbnv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 539F4640-B2D2-11EB-855D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders <greg@gpanders.com> writes:

> We already have sendemail.smtpServerOption to add options:
>
>     [sendemail]
>             smtpServer = !msmtp
>             smtpServerOption = -f
>             smtpServerOption = greg@gpanders.com
>
> I agree that it's not the prettiest and it's a little annoying to have
> to specify the option multiple times, but I thought it worth
> mentioning before considering another way to do the same thing.

Well, then can't we just scrap this whole topic, like

    [sendemail]
	smtpServer = /usr/bin/env
	smtpServerOption = msmtp

would already work without adding '!' support ;-)

sendemail.command is also fine; make it invoke the command line via
the shell and we can gradually depreate the "server that is an
absolute path is the name of a program to talk to the server".

