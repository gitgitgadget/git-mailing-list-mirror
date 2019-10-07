Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1C21F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 01:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfJGBTL (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 21:19:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63362 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfJGBTL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 21:19:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1659021613;
        Sun,  6 Oct 2019 21:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lRHcIYIDBjl+
        7K4Ke+7YpoSGHkM=; b=MCUhIl/e2ZMvdvt1Q3CpkPPlMJrmapqCzLZuemaDWxJo
        B72CYRQXHnHoEf8E+mivkKAS973WOxKfANQfD3CQyxRXdoxPsCKoGGjcuIrE/dIl
        LaA/s85D0XVb/B2gYtoOucN9y95iT7jxJj7wFBjfaQtcw5EHLFg/8bElj/9fP54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=C1ZHGF
        q07Faj0mjjjkwXSve0hqaxFXyQPvVAunjxwv5cDxWDQE0toEwoB4FXSbl5rCULxu
        ctnzRegq4XE3OYxHSN26FLym9Z0Pqv1cMIZfEtx1xMpu6E3h3GTdLk42kQE0q6O1
        ls4X+o18EjlTEktXKDJh+iD0KsvdkvNCT49mg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E71221612;
        Sun,  6 Oct 2019 21:19:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6694D21611;
        Sun,  6 Oct 2019 21:19:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] tests: remove "cat foo" before "test_i18ngrep bar foo"
References: <d178227d-7658-8c49-a147-e88d31c713e3@web.de>
Date:   Mon, 07 Oct 2019 10:19:08 +0900
In-Reply-To: <d178227d-7658-8c49-a147-e88d31c713e3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 6 Oct 2019 15:26:42 +0200")
Message-ID: <xmqqsgo54ak3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 76A39518-E8A0-11E9-B0D9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Some tests print a file before searching for a pattern using
> test_i18ngrep.  This is useful when debugging tests with --verbose when
> the pattern is not found as expected.
>
> Since 63b1a175ee (t: make 'test_i18ngrep' more informative on failure,
> 2018-02-08) test_i18ngrep already shows the contents of a file that
> doesn't match the expected pattern, though.
>
> So don't bother doing the same unconditionally up-front.  The contents
> are not interesting if the expected pattern is found, and showing it
> twice if it doesn't match is of no use.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Almost formatted it using -U1..

Yeah, that's tempting ;-)

Thanks.  All looked good.
