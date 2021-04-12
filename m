Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E261C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF2861221
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbhDLShB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 14:37:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56122 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbhDLShA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 14:37:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF56F12F322;
        Mon, 12 Apr 2021 14:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EM667jS7umid4UMBT9A8cvMBXnY=; b=WAU+dV
        oSLS5Exq8HwKr3JSe9b+iTGuPc1Bp0So93gcN966ml8G2J3zYU70L2WMzpIOMoCs
        kP/c6TJqwZGGIK/wQyzbgHEzSpxQ9Zhz5SdXaTqnrivwWJwVp8LPnIhHdpR3r2WL
        9g/r4pOW1PeFDBmHX+UchRdypiXZO1ZGrOJJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qCLlhcFVESHuQpqkKTnhSZjNv34qh1kE
        CbXuS8VbQmBvEEPfKLonOLnPOTSsq0PCEOTIdWRKjmoNffChOFdXJ+1Avf06um65
        Dlz/29LW6AV74Ya3cOG8lmw0+srZphL2NjtLFBmnEDuU5m0ikKQ/MpIU8eUiX4hN
        avps+lYVKFc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A73C612F321;
        Mon, 12 Apr 2021 14:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED67912F31F;
        Mon, 12 Apr 2021 14:36:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/16] check-non-portable-shell: complain about "test"
 a/-o instead of &&/||
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-01.16-8e4b4a2a216-20210412T110456Z-avarab@gmail.com>
        <CAPig+cQFFsLeE921WpzTxVnBMnNRiKs4N=hUQ2UQi1VznNEQwg@mail.gmail.com>
        <926894000.404076765.1618247601502.JavaMail.zimbra@matthieu-moy.fr>
Date:   Mon, 12 Apr 2021 11:36:37 -0700
In-Reply-To: <926894000.404076765.1618247601502.JavaMail.zimbra@matthieu-moy.fr>
        (Matthieu Moy's message of "Mon, 12 Apr 2021 19:13:21 +0200 (CEST)")
Message-ID: <xmqqwnt7cpu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04B333F0-9BBE-11EB-B294-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <git@matthieu-moy.fr> writes:

> And also in Git's Documentation/CodingGuidelines, which motivates the advice with an example:
>
>      test -n "$x" -a "$a" = "$b"
>
>    is buggy and breaks when $x is "=", but
>
>      test -n "$x" && test "$a" = "$b"
>
>    does not have such a problem.

Good advice to cite Documentation/CodingGuidelines in the log
message.

Thanks (and nice to hear from you again ;-).

