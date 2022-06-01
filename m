Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D885CCA477
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 15:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355212AbiFAPsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 11:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347705AbiFAPsb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 11:48:31 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6DCA3092
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 08:48:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6A7A13A307;
        Wed,  1 Jun 2022 11:48:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vejTQldQz+IB
        GeGG26NfTws9We7Yo+LaGfVc3bJ//q4=; b=LlIr9LQzzZ3dyqrX0+u3DFUC0IuB
        aEEk24JXquTxi8O60f2rnGw02NPQ5ziWtViNLp9TlG9kWlEkguo40KH2wyvngNX0
        lPNQ3xhPwHTezitiMMRm4VcT/OJAhODrduz09FrOFpSd1FKrBHyFdeZRdmCP2kZH
        4CuWb3vmFcFB8pQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EC4313A306;
        Wed,  1 Jun 2022 11:48:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13F5C13A305;
        Wed,  1 Jun 2022 11:48:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re* jc/http-clear-finished-pointer
References: <xmqqzgj41ya2.fsf@gitster.g>
        <220526.86v8ts3z2k.gmgdl@evledraar.gmail.com>
        <xmqq7d68ytj8.fsf_-_@gitster.g>
        <220601.86pmjs2679.gmgdl@evledraar.gmail.com>
Date:   Wed, 01 Jun 2022 08:48:25 -0700
In-Reply-To: <220601.86pmjs2679.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 01 Jun 2022 09:26:14 +0200")
Message-ID: <xmqq35gov0za.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 46E575F8-E1C2-11EC-9668-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ... as a follow-up we should have a revert
> of 9c539d1027d (config.mak.dev: alternative workaround to gcc 12 warnin=
g
> in http.c, 2022-04-15) which this patch makes redundant.

It is a good point that 9c539d10 (config.mak.dev: alternative
workaround to gcc 12 warning in http.c, 2022-04-15) hides problems.
Unfortunatelly https://github.com/git/git/runs/6665825113 dies early
without reaching the point where it touches http.c X-< so we cannot
tell.

I am OK to do a revert of the redundant one on 'next', which should
give us a confirmation that the particular version of GCC12 is OK
with the code we happen to have and letting its -Wdangling-pointer
trigger would not harm us with any other false positives.  Then we
can do the same on the 'master' front with that revert with Dscho's
other three GCC12 fixes (they are fixes, like the "realloc then use"
one) graduating first (which should break http.c) and then the patch
in this thread as separate steps, if we really wanted to.

Thanks.
