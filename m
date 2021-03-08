Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB62DC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA1C65259
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhCHVst (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 16:48:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52448 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhCHVsd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 16:48:33 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F269EBAA20;
        Mon,  8 Mar 2021 16:48:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N7KuIDbHR+es
        /1C2iO7ejxACOdo=; b=amyzMJRNKQ2OYDO0zreWRnNZARG5ui4H3BuuMk9VZuSN
        rLDqQ8XCd+4Juk5Lyu6zPmErAwtVIPAnUzD8Yh5zdivf+RuRQqPtylv4Gs6Lyhhv
        qg68doX0tETQiVLWWKEwq0PkNcZ0rxF5cEzV+Rw2XSbnG8sp41ZsqjC1Wfeij6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S+Xkbd
        jTluMALBlTn1nxm0zGJQE2LEfr91sH2KTVU7bSl8Cli3qGTG96BOBL9D3vZeRG3w
        uF/v6+sJp4fTLlEpROWkaptL+YYdSMrFicB68NuQMzHtY3LPueSl0GB/a7bcC+ac
        5dY5dPh9pjFNxyePLBKorVfGM+jWdvOJ3TKuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E910EBAA1F;
        Mon,  8 Mar 2021 16:48:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A448BAA1E;
        Mon,  8 Mar 2021 16:48:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/7] object.c: make type_from_string() return "enum
 object_type"
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
        <20210308200426.21824-3-avarab@gmail.com>
Date:   Mon, 08 Mar 2021 13:48:31 -0800
In-Reply-To: <20210308200426.21824-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 8 Mar 2021 21:04:21 +0100")
Message-ID: <xmqq1rcp5nbk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 06D73FCC-8058-11EB-9B06-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the type_from_string*() functions to return an "enum
> object_type", and refactor their callers to check for "=3D=3D OBJ_BAD"
> instead of "< 0".
>
> This helps to distinguish code in object.c where we really do return
> -1 from code that returns an "enum object_type", whose OBJ_BAD happens
> to be -1.

"We will be adding different error modes and the plan is to signal
them by returning negative values other than -1" would make sense
(if that is what we are going to see in the remainder of the
series), but not the above.

To the callees, what comes back from a function is -1 either way,
and they cannot tell -1 resulting from OBJ_BAD and -1 resulting from
error() apart, can they?

