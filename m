Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859A6C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 04:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE656113C
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 04:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhDTEYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 00:24:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64220 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhDTEYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 00:24:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03583CAEEC;
        Tue, 20 Apr 2021 00:23:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nibPj2E4FFa0
        hK9if0f5p9IVAU8=; b=B+rbXeBTgp98nU1uMqFLUbdT7eG5nHdHO0tF2mtxzsHE
        fWm+bExAeTl980ibuV5bEF/5hyHea3SppgCK7Z+iN47AhOkpNptnZPlrUEORAKFM
        7sNLy3Fo3ixsbUjaXGvcOIO5vn+9wlMr5/I+qBPJ2mKPclf/Wh8mH4ylcqd78Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KTJlxt
        0qIMFBwbD8CvFX9tGPb3JQovf8QEYGKZapJG16rv1H1u/dqux71Xr+w7R9Qhhra2
        5Jmj0VRMdebgFudNsUVEN/TYRrbYqfyITsRcw2CXzqqNQh0/yM8XXimg5M8xTDVC
        fIHhagiPE8CAn/O8CJjvBm8XIC3YrcsTik258=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF24CCAEEB;
        Tue, 20 Apr 2021 00:23:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 811F9CAEEA;
        Tue, 20 Apr 2021 00:23:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git <git@vger.kernel.org>
Subject: Re: [Question] git cat-file --batch cannot handle irregular path
References: <54526f48a18b11ebad130024e87935e7@oschina.cn>
Date:   Mon, 19 Apr 2021 21:23:31 -0700
In-Reply-To: <54526f48a18b11ebad130024e87935e7@oschina.cn>
        (lilinchao@oschina.cn's message of "Tue, 20 Apr 2021 11:48:56 +0800")
Message-ID: <xmqqim4h7fek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A819F0E-A190-11EB-80D0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

> but it is irregular, such as "=E6=B3=95=E5=BE=8B\(Law\)/=E6=B0=91=E6=B3=
=95\(civil\ law$'\n'\)\",
> ...
> d071ea971fb93ebc937517736c2a63d64ddbe0d9:=E6=B3=95=E5=BE=8B(Law)/=E6=B0=
=91=E6=B3=95(civil law)
> d071ea971fb93ebc937517736c2a63d64ddbe0d9:=E6=B3=95=E5=BE=8B(Law)/=E6=B0=
=91=E6=B3=95(civil law) missing

I may be misreading what you wrote, but if you mean that there is a
LF in the pathname, I do not think cat-file --batch is prepared to
handle it; as we can see in builtin/cat-cile.c:

static int batch_objects(struct batch_options *opt)
{
	...
	while (strbuf_getline(&input, stdin) !=3D EOF) {
		if (data.split_on_whitespace) {
		...
		}

		batch_one_object(input.buf, &output, opt, &data);
	}

it always treats what strbuf_getline() returns as a single record.

If properly designed, it would have

 - supported "-z" to take NUL-delimited input, and

 - when "-z" is not in effect, after reading a single line of input,
   we would have called quote API to un-cquote the string, so that
   we can express LF and other special characters in the pathname.

but those who worked on "cat-file --batch" didn't.

