Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF0B20C32
	for <e@80x24.org>; Wed,  6 Dec 2017 23:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdLFXGi (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 18:06:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58018 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751598AbdLFXGi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 18:06:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7ED85B3ED9;
        Wed,  6 Dec 2017 18:06:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=naVL6BFwadbV0UKTC3RYKE+qR58=; b=xf2tll
        KeEtnwF8CaYud42pEteaex45XTPwLcAJjmdaIOFuwVH714cHH0xM5bRdCDZWMgAK
        IqPqpqbCvBippDxh17ve0PqTWZzvfIh4/u4rn24qkQcv4XrrkfsNnCzITy+fFyQ1
        q4v8Dpl23uux+bKVToNYGU9CbLA3/zqW5wKdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bh28YQbhfTZDx+77I7vEWZb2sYNpV8sV
        PHN9fo00VdkIXmoIwhxO9maT2jr1xO8Xfx5EC48OZKEY6N3L61iumwEpxM3vqgJZ
        VG6JuUDhpYbqoRMCmY0d+4GqBii94ViB+iB15Rr60r0LcnuwjCEwTWLw3d24yC5P
        dWRNIEX0QP0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7675BB3ED8;
        Wed,  6 Dec 2017 18:06:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1AD4B3ED7;
        Wed,  6 Dec 2017 18:06:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nathan PAYRE <second.payre@gmail.com>
Cc:     Nathan Payre <nathan.payre@etu.univ-lyon1.fr>,
        Git Mailing List <git@vger.kernel.org>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: Re: [PATCH v2] send-email: extract email-parsing code into a subroutine
References: <xmqqlgiiobcy.fsf@gitster.mtv.corp.google.com>
        <20171206153821.24435-1-nathan.payre@etu.univ-lyon1.fr>
        <xmqqvahjfsdx.fsf@gitster.mtv.corp.google.com>
        <CAGb4CBWZciqxdfpSkK1vezhiuSYX5Yy-xSq=Uj4h+vhRo9uyoQ@mail.gmail.com>
Date:   Wed, 06 Dec 2017 15:06:35 -0800
In-Reply-To: <CAGb4CBWZciqxdfpSkK1vezhiuSYX5Yy-xSq=Uj4h+vhRo9uyoQ@mail.gmail.com>
        (Nathan PAYRE's message of "Wed, 6 Dec 2017 23:55:09 +0100")
Message-ID: <xmqqd13rfock.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C39FB6A-DADA-11E7-B949-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nathan PAYRE <second.payre@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com>: writes:
>
>> ... throughout this patch, not limited to this section, indentation
>> is strange and there seem to be many "print" that show messages that
>> do not seem to be meant for end-user consumption.  I can see that
>> this aspires to improve the readability, but not quite yet ;-).
>
> Hmmm I'm wondering who place thoses print in my code !
> I will fix it fast. :-)

Don't make waste by being hasty, though.  The print statements were
bad, but funny indentation was more distracting and will be worse
hindrance from the maintainabaility's point of view.

Thanks.
