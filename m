Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020F92070C
	for <e@80x24.org>; Wed,  6 Jul 2016 16:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbcGFQJF (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 12:09:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932073AbcGFQJD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 12:09:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5762029FDE;
	Wed,  6 Jul 2016 12:09:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=y7cPixoiyknN
	mWjrxEBMlr1u1Sk=; b=r5C5LNvhS0deQs4Z+toteZzydNgg3fSzkvmUBp4t32GS
	PMjxtezorHwhkWtYR7Hk3+Zf550ClzM0J/2Hs8fZPbnVEUiHtH+pGaWekVL39Oq0
	gX8ZpMYvSSREMrxprIcKQGCoRNpdg8yQLv5LnRGXV7gCK+CmMZZVBsYo9dUBTos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wwdRzH
	zFIhOVj+O44ULuancL3eyhEHCGxSd5rQewaVJqY1RM7V/tBsXQE8e/bIbyFAj1XX
	1ayGSI3euHjRtEBOZzaUm4p3sAtF6h+zFzfo0Hxc9hmv9chGJ81FxSXN7JCQbV/V
	rCRCWN/cEvW4aIoaEUyezYhmkKWCMKwGyH/r8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50DA629FDD;
	Wed,  6 Jul 2016 12:09:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6DC829FDC;
	Wed,  6 Jul 2016 12:09:01 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Christoph Michelbach <michelbach94@gmail.com>
Subject: Re: [PATCH 3/5] index-pack: correct "len" type in unpack_data()
References: <1466807902.28869.8.camel@gmail.com>
	<20160705170558.10906-1-pclouds@gmail.com>
	<20160705170558.10906-4-pclouds@gmail.com> <577C17D4.6080708@kdbg.org>
	<CACsJy8ASYszXU-ErPas99EpW_J_E-FQVk197W7KqURJge_RBRQ@mail.gmail.com>
	<xmqqmvluu50w.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 06 Jul 2016 09:08:59 -0700
In-Reply-To: <xmqqmvluu50w.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 06 Jul 2016 09:04:31 -0700")
Message-ID: <xmqqinwiu4tg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F43C9A66-4393-11E6-80DB-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> What can I say, gettext is smart. In gc.c we already have this
>>
>> die(_("gc is already running on machine '%s' pid %"PRIuMAX" (use
>> --force if not)"), name, (uintmax_t)pid);
>>
>> and vi.po shows
>>
>> #: builtin/gc.c:397
>> #, c-format
>> msgid ""
>> "gc is already running on machine '%s' pid %<PRIuMAX> (use --force if not)"
>
> And translators are expcted to keep "%<PRIuMAX>" in their translated
> .po files, and whatever translates .po into .mo knows what
> %<PRIuMAX> should be mapped to?
>
> That is surprising.

gettext.info answered me ;-)

    The ‘gettext’ tools and library have special support for these
    ‘<inttypes.h>’ macros.  You can therefore simply write

         printf (gettext ("The amount is %0" PRId64 "\n"), number);

    The PO file will contain the string "The amount is %0<PRId64>\n".  The
    translators will provide a translation containing "%0<PRId64>" as well,
    and at runtime the ‘gettext’ function’s result will contain the
    appropriate constant string, "d" or "ld" or "lld".

       This works only for the predefined ‘<inttypes.h>’ macro...

Nice.
