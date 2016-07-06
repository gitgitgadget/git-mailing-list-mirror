Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37832070E
	for <e@80x24.org>; Wed,  6 Jul 2016 16:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbcGFQEf (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 12:04:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754175AbcGFQEe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 12:04:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A15FC273A0;
	Wed,  6 Jul 2016 12:04:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Wv/6MF9r6PoZ
	yjK07Ik5bztJ0Ac=; b=HxoI4AOMP2kM35CAb0xDMU9HjIYUd+11BHSxnqV+yxYy
	FN2lkLVAw/aTTLnujXYFXHbFAv0oQGehcc9zdIx5hePTLvWITESyWwjGQMkBbe8e
	KYlk6FxBRcldwBT9Saf49sve2i1/Q9cT/qum9LwpHUnVLaahXl0YIc1Nx4/ztj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HawPDQ
	T2TUqC2k3u6vhZeKCyBZQy14xkll08/PigjYzq1uuUckRu+lBut7MscCBcTQjZfT
	QHRii4mUICPkR2zIEq06VgxSmQblT14A7AF4whQiit2apvlXe2nVPLGV4OamN/Ci
	7SVFuEWj/alzOVHXcO9iG6AkdQWjeIzg1fwuY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9983E2739F;
	Wed,  6 Jul 2016 12:04:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BE232739E;
	Wed,  6 Jul 2016 12:04:33 -0400 (EDT)
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
Date:	Wed, 06 Jul 2016 09:04:31 -0700
In-Reply-To: <CACsJy8ASYszXU-ErPas99EpW_J_E-FQVk197W7KqURJge_RBRQ@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 6 Jul 2016 17:25:29 +0200")
Message-ID: <xmqqmvluu50w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 54149642-4393-11E6-A3E3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> What can I say, gettext is smart. In gc.c we already have this
>
> die(_("gc is already running on machine '%s' pid %"PRIuMAX" (use
> --force if not)"), name, (uintmax_t)pid);
>
> and vi.po shows
>
> #: builtin/gc.c:397
> #, c-format
> msgid ""
> "gc is already running on machine '%s' pid %<PRIuMAX> (use --force if not)"

And translators are expcted to keep "%<PRIuMAX>" in their translated
.po files, and whatever translates .po into .mo knows what
%<PRIuMAX> should be mapped to?

That is surprising.

On a related but not surprising tangent, I see this example in
gettext.info that may be relevant.

       About larger integer types, such as ‘uintmax_t’ or ‘unsigned long
    long’: they can be handled by reducing the value to a range that fits in
    an ‘unsigned long’.  Simply casting the value to ‘unsigned long’ would
    not do the right thing, since it would treat ‘ULONG_MAX + 1’ like zero,
    ‘ULONG_MAX + 2’ like singular, and the like.  Here you can exploit the
    fact that all mentioned plural form formulas eventually become periodic,
    with a period that is a divisor of 100 (or 1000 or 1000000).  So, when
    you reduce a large value to another one in the range [1000000, 1999999]
    that ends in the same 6 decimal digits, you can assume that it will lead
    to the same plural form selection.  This code does this:

         #include <inttypes.h>
         uintmax_t nbytes = ...;
         printf (ngettext ("The file has %"PRIuMAX" byte.",
                           "The file has %"PRIuMAX" bytes.",
                           (nbytes > ULONG_MAX
                            ? (nbytes % 1000000) + 1000000
                            : nbytes)),
                 nbytes);



