Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B613AC2BA19
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 23:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674F721973
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 23:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IXjvjfvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgDRXMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 19:12:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57990 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgDRXMK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Apr 2020 19:12:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 468C147F08;
        Sat, 18 Apr 2020 19:12:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=elMLSjWC82L1
        s1hgUQmz+8CUyeE=; b=IXjvjfvO285mdGlGMyiEs++p4M0X0FBC3s4foHVEZXUc
        ieUenV9Z1DgEJsyBDJ+iaIR/BXuLRUzC5Key6Shn5vam6pjfLf1PAxZ1mtpPah/2
        B3EdUhtWorXoz71NYc6xqF58Q1vLACe173q9Uq3Cc634LVeQPL/Du9fCz8Z1u9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dFEc9o
        3n5ELQSPxIbDZ7KL1enFAsb9bzhtWQKUd7CdBFQWU2Md9Ca4VUdMhkIIE5lq0jxU
        uemDPP80cRqwd3WaKuMFDM7ReYhsK9Ipm8pzSbLCginFKShcSB7+UGdFIioIz2fE
        OUVttHWr87BH/6rV+k1k3YpcREx7zG9HkTnH8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BCE647F06;
        Sat, 18 Apr 2020 19:12:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88BB347F05;
        Sat, 18 Apr 2020 19:12:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c::convert_to_utf8: reuse strlen info
References: <20200418035449.9450-1-congdanhqx@gmail.com>
        <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com>
Date:   Sat, 18 Apr 2020 16:12:06 -0700
In-Reply-To: <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sat, 18 Apr 2020 21:56:34
 +0200")
Message-ID: <xmqqk12ctmm1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 06358002-81CA-11EA-B953-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> This is equivalent as long as `line->len` is equal to
> `strlen(line->buf)`, which it will be (should be) because it's a
> strbuf. Ok.

For the guarantee to hold true, line->buf[0..line->len] should not
have any '\0' byte in it. =20

This helper has two callers, but in either case, it needs to be
prepared to work on output of decode_[bq]_segment().  Is there code
anywhere that guarntees that the decoding won't stuff '\0' in the
line?
