Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AEA320A40
	for <e@80x24.org>; Tue,  5 Dec 2017 16:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbdLEQco (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:32:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52767 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751473AbdLEQcn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:32:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 791A9BE451;
        Tue,  5 Dec 2017 11:32:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fx+2CFehr1Wh
        iMg4cfTUCNcvevY=; b=x5uhbapwC4kVnvHQSJzLAYxo1c/fMkLL/yfA55ln25dk
        Cg0SOmIQM/NzO/ITcdOjxnQjYmdVcGV5bYucwQREb6YteiTbKsJkUjKKACMipywv
        6yT1Tqzv3mcJilxErPR0j8IOdMx/ITTd7q+MjWMRObvF0jlalqmHRGlzMpM3wFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Jwe2V7
        H51Mpyn5qEapCoRe4QzVkN1Zx2CZQXGul2OSfhfKIWRegovWSzbXuyQaq1fxMue7
        U2RqrxBE1iUxxXt1oJoLSkSsAFCqD7d/PGsBm5qFcw3FvYujLrV6lRKozoHqX36W
        3VIukxzgpGaB0cop7m0/HA2Bk24AjYj7pKpvc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EC66BE450;
        Tue,  5 Dec 2017 11:32:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B748FBE444;
        Tue,  5 Dec 2017 11:32:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Makefile: use the sha1collisiondetection submodule by default
References: <20171128213214.12477-1-avarab@gmail.com>
        <20171128213214.12477-4-avarab@gmail.com>
Date:   Tue, 05 Dec 2017 08:32:24 -0800
In-Reply-To: <20171128213214.12477-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 28 Nov 2017 21:32:13 +0000")
Message-ID: <xmqqzi6xi19j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E4CA1FE4-D9D9-11E7-8819-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the build process so that instead of needing to supply
> DC_SHA1_SUBMODULE=3DYesPlease to use the sha1collisiondetection
> submodule instead of the copy of the same code shipped in the sha1dc
> directory, it uses the submodule by default unless
> NO_DC_SHA1_SUBMODULE=3DUnfortunatelyYes is supplied.
> ...
> This change removes the "auto" logic Junio added in
> cac87dc01d ("sha1collisiondetection: automatically enable when
> submodule is populated", 2017-07-01), I feel that automatically
> falling back to using sha1dc would defeat the point, which is to smoke
> out any remaining users of git.git who have issues cloning the
> submodule for whatever reason.

I think it makes sense to drop 'auto' if we were to go this route.
I do not think the right value for NO_DC_SHA1_SUBMODULE should be
"unfortunately yes"; it should be spelled NoThanks or something.
It's not like an external reason "unfortunately" prevents you from
using the code from the submodule---the person sets it deliberately
and by choice.

>     Makefile:1031: *** The sha1collisiondetection submodule is not
>     checked out. Please make it available, either by cloning with
>     --recurse-submodules, or by running "git submodule update
>     --init". If you can't use it for whatever reason you can define
>     NO_DC_SHA1_SUBMODULE=3DUnfortunatelyYes.  Stop.

Likewise here.
