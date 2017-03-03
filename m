Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03DF20133
	for <e@80x24.org>; Fri,  3 Mar 2017 17:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdCCRtL (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:49:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56446 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751083AbdCCRtK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:49:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 081816266F;
        Fri,  3 Mar 2017 12:47:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=w9dIwunX4pfX
        AkNuJBVh4Dr5lTo=; b=TOjElsIBUJqTs6QWIqN9LHOXN4iQVaKkcxFEo8fDObOR
        epO5h0Uev680rref6A10q/w21E8i6aM+IBp9LcdZLliLYXnaRTxUmGu8IgfibIG4
        q04dcxmvk3adJUoIlPCU0zqatR0tvGUVObeh9XEGjFsKEYX7F+REtMwPx1D5ttw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HcQ2Ws
        l1BkK3HcRPKqATaekyN9m0DUNZDP+Ym9f8o9dlxx1grQVNJ/NEynQTtOisg9USEy
        iW0RkKiqh0VQua2EhZ89E71EvKfbprLOeMtQ9wLu6etOzqK25KGoV/XMuQ6Epand
        CilhRoRA/bDKUHYBYctuZDyZ2Yyk0bvck1tiQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3E2D6266E;
        Fri,  3 Mar 2017 12:47:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58DAB6266D;
        Fri,  3 Mar 2017 12:47:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Mike Crowe <mac@mcrowe.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with CRLF conversions
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
        <20170301170444.14274-1-tboegi@web.de>
        <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
        <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
        <20170302142056.GB7821@mcrowe.com>
        <xmqqbmtjcyug.fsf@gitster.mtv.corp.google.com>
        <20170302200356.GA31318@mcrowe.com>
        <ae2b144a-5e39-8178-5161-1d8eb673b6f0@web.de>
Date:   Fri, 03 Mar 2017 09:47:18 -0800
In-Reply-To: <ae2b144a-5e39-8178-5161-1d8eb673b6f0@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 3 Mar 2017 18:02:56
 +0100")
Message-ID: <xmqq37eu2qxl.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 73300EF4-0039-11E7-B4AC-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Understood, thanks for the explanation.
>
> quiet is not quite any more..
>
> Does the following fix help ?
>
> --- a/diff.c
> +++ b/diff.c
> @@ -2826,6 +2826,8 @@ int diff_populate_filespec(struct diff_filespec *=
s,
> unsigned int flags)
>         enum safe_crlf crlf_warn =3D (safe_crlf =3D=3D SAFE_CRLF_FAIL
>                                     ? SAFE_CRLF_WARN
>                                     : safe_crlf);
> +       if (size_only)
> +               crlf_warn =3D SAFE_CRLF_FALSE;

If you were to go this route, it may be sufficient to change its
initialization from WARN to FALSE _unconditionally_, because this
function uses the convert_to_git() only to _show_ the differences by
computing canonical form out of working tree contents, and the
conversion is not done to _write_ into object database to create a
new object.

Having size_only here is not a sign of getting --quiet passed from
the command line, by the way.
