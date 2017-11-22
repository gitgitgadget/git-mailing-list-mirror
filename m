Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C061F202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 10:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbdKVKoo (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 05:44:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57408 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751575AbdKVKon (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 05:44:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E60B0BFD3A;
        Wed, 22 Nov 2017 05:44:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4NtBE5Kc5Y+w3FHnpPwtp9dLZWY=; b=f1qel4
        kFPLjdJwJXZ18+IF9f/EEEl4oboREPJJ6m++tXE4KnpD3rjtgh/WAKwnCVPAlEOJ
        OlDb3dc+Kc33/5BskDxKBeOwkfua69aYRw3g0h7tTiwQaF7GJr5Wuli7QfRh2W9f
        +G/gKevivsVRf8Z3eEZ4QBRRwVRXy/T7HEyk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z/j8gLvX1BV4iGEPK8Rk4OvpKI5P0oOh
        7LrCDf137S0dxOydT+EqAtIuhvgse8FyaMgiTVmG6Y2eTHoOHaztb6+Z+/SP135x
        LJaW0/w7ffxF2UwjPpZVAw1CSvb/cA0sx6KwyFfjAS5Eq4RXXsmgCq+5hp6JZ1pD
        KrkPAX536q0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC23ABFD39;
        Wed, 22 Nov 2017 05:44:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F49BBFD38;
        Wed, 22 Nov 2017 05:44:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     Thomas Adam <thomas@xteddy.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
References: <20171116154814.23785-1-alex.bennee@linaro.org>
        <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
        <87wp2jwe9o.fsf@linaro.org> <20171121205206.fvwjkkwhil4abmmk@laptop>
        <b131cc195280498ea3a77a37eff8444e@BPMBX2013-01.univ-lyon1.fr>
        <q7h97euiradu.fsf@orange.lip.ens-lyon.fr>
Date:   Wed, 22 Nov 2017 19:44:41 +0900
In-Reply-To: <q7h97euiradu.fsf@orange.lip.ens-lyon.fr> (Matthieu Moy's message
        of "Wed, 22 Nov 2017 09:22:05 +0100")
Message-ID: <xmqqtvxmsicm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25B71E52-CF72-11E7-BEBD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:

> My point in cc907506 ("send-email: don't use Mail::Address, even if
> available", 2017-08-23) was not that Mail::Address was bad, but that
> changing our behavior depending on whether it was there or not was
> really bad. For example, the issue dealt with in this thread probably
> always existed, but it was present only for *some* users.

Yes, I understand and agree with you that having a single
implementation would make things simpler for both users and bug
wranglers than two sperate implementaions with two different sets of
glitches.

I am just wondering if we picked the right one back then, given this
thread; that's all.
