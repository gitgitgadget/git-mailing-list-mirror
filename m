Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44473C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 18:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AA220726
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 18:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xoXGVHpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGS51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:57:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54387 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGS51 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 13:57:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D11EA4BE42;
        Fri,  7 Feb 2020 13:57:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nWspTzZeZxhP
        UVGnhi5CWOeTu60=; b=xoXGVHpkVqqZRRC2S3KzVCLZtJ9HCttWyU81stjmWntS
        Y3IoF/Tpel5APDqtQNqE6wj2Uyl8GOSD2yRsTbkngf4KUOPqJ9ZNVBzrirkGVgtv
        OeImC1hM+j1QRAp8HXC43xJoMWppT805In3Zt2UnLCGnwtU9LOfkQhxCskOr9l8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RQTm5R
        UT3/rjrEz9iJ7wR3KfnBCUAbHV/RcHt48C0/NKQJP2Nd358mdiVZiatbZzaD7Q9o
        XkgaIMhUGZD8xD5CAH+Ie/Eb5fjEJsFDszQHpMDkvUHe4oghFKEa0mvCZ7gw+DEf
        eixQB8ypyg94RI0q4hGng/w/nkILGYY2s/f9U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C76E84BE41;
        Fri,  7 Feb 2020 13:57:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 243014BE40;
        Fri,  7 Feb 2020 13:57:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased branch during rebase
References: <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
        <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
        <20200112121402.GH32750@szeder.dev>
        <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
        <20200124224113.GJ6837@szeder.dev>
        <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
        <20200131155228.GF10482@szeder.dev>
        <CAJ+F1CLtDET6L-CGo=j0Yj0aPVSbec=57MPgaGrhr3L8dpCSSQ@mail.gmail.com>
        <20200131161630.GG10482@szeder.dev>
        <CAJ+F1CJaszsOMeuUmk5MKXpjkX1gHNuK6xyf_mmHtnToL2Y_7A@mail.gmail.com>
        <20200207100247.GA1111@szeder.dev>
        <CAJ+F1CJc4kEvxLr-wLXpvXOC8YRVf5xP1HuJh9-cYa6mGmbyXg@mail.gmail.com>
Date:   Fri, 07 Feb 2020 10:57:23 -0800
In-Reply-To: <CAJ+F1CJc4kEvxLr-wLXpvXOC8YRVf5xP1HuJh9-cYa6mGmbyXg@mail.gmail.com>
        (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 7 Feb 2020
 15:16:32 +0100")
Message-ID: <xmqq1rr6444s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ADDA88EC-49DB-11EA-9CEB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Also, when doing --edit-description there are comments like:
>
> # Please edit the description for the branch
> #   unrelated-history
>
> What else do you suggest?

How about teaching "git branch --edit-description [HEAD]" notice
when/if HEAD is detached and always error out, no matter what
operation is in progress?

