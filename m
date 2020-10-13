Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F664C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7A925204
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EHDcrZrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgJMPtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:49:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65132 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgJMPtP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 11:49:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B44F0F9C89;
        Tue, 13 Oct 2020 11:49:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PAGjYh6UHzBM
        FZHFfAXCqLMGcQE=; b=EHDcrZrD0iVnaPzM91Y0SGbizgzA3WMmUg3EfGPkusz4
        XzoUgI7TtGhI2UnodtbzwB9zT4ZCRzqVZUN9pXYNTjP+xeyfOcMOdNqSGyY6Hx9U
        BfZdlTNpBNaMM81ja9++3olyQvBz9HcUKhbLEIUQ3cyTzusS0yrYXoWd93MQfTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EymzDr
        UlK43KFY1PoPuzDiskcnzgkc0mGxynh7JQYShvRRmizbubuTEUXBBwSq9oJec1zG
        YPGxM5xdGsCLpV/PQwqHTKkN4Mx7BFM9NYS/5SsSQOtujMWGrU61tIrqkUfMqt66
        ubAK2SBhBDQByT9TyDXlbPk+pdlDOmqgNb9t0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C6CFF9C88;
        Tue, 13 Oct 2020 11:49:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B5B5DF9C86;
        Tue, 13 Oct 2020 11:49:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching changes
References: <20201001120606.25773-1-michal@isc.org>
        <20201012091751.19594-1-michal@isc.org>
        <20201012091751.19594-3-michal@isc.org>
        <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet>
        <xmqqo8l7nrjc.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010122236130.50@tvgsbejvaqbjf.bet>
        <xmqqpn5nm87u.fsf@gitster.c.googlers.com>
        <20201013063722.GC3278@larwa.hq.kempniu.pl>
Date:   Tue, 13 Oct 2020 08:49:09 -0700
In-Reply-To: <20201013063722.GC3278@larwa.hq.kempniu.pl> (=?utf-8?B?Ik1p?=
 =?utf-8?B?Y2hhxYIgS8SZcGllxYQiJ3M=?=
        message of "Tue, 13 Oct 2020 08:37:22 +0200")
Message-ID: <xmqqk0vuktxm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2B8B39A-0D6B-11EB-85DD-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Micha=C5=82 K=C4=99pie=C5=84 <michal@isc.org> writes:

> ...  xcalloc()'s semantics
> ("allocate one structure of this size") appealed to me, ...

FWIW, it appeals to me, too ;-)  But if we are going to pass it to
regcomp(), there is no point clearing it beforehand.
