Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08EE420958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbdCWTdL (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:33:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59576 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751235AbdCWTdK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:33:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 758926573E;
        Thu, 23 Mar 2017 15:33:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=glpt9lH2zABH
        Ap2VpB3XlNcoRFE=; b=JTBpNUDA9f7EzcwC+PkVgAVMgxcADtJ9a67YxmaxCd5i
        qExJn6z4Z70xVHoWjht1AR9fqBIf3knGD12tFKvoCKwV/9et/2+iHWYf7lwPoJQC
        pAbNedhlgpGswWvulLYYlUGh4fIAjDatH/eofAbnAiEFUsdcr9/yy4RWPMWO1PQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=tm1xZg
        otdKjPKDKbY/KzmXXE0p4X9k7T24mu20Yh7lkgnP/7/gDjdBDBUTXLiiDAU3Vphz
        K7DoqAULarJYsLpgg2KJiCjrBiieJF3Tup/lwRH5cVbCUNzbJ00VT1W02KljF/v4
        zhvzAAtMOQYZTb7XQC7nxEnH8mAmznKL7tCUI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C8926573D;
        Thu, 23 Mar 2017 15:33:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB3686573C;
        Thu, 23 Mar 2017 15:33:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs.c: use skip_prefix() in prettify_refname()
References: <20170323155012.6148-1-szeder.dev@gmail.com>
        <4382e211-63f6-811f-6f33-1cf5d2c087a8@web.de>
        <20170323192313.ytr56pjpnillnh63@sigill.intra.peff.net>
Date:   Thu, 23 Mar 2017 12:33:06 -0700
In-Reply-To: <20170323192313.ytr56pjpnillnh63@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Mar 2017 15:23:13 -0400")
Message-ID: <xmqqvaqzbxfx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8AD630E4-0FFF-11E7-A1EB-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 23, 2017 at 08:18:26PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> Am 23.03.2017 um 16:50 schrieb SZEDER G=C3=A1bor:
>> > This eliminates three magic numbers.
>> >=20
>> > Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> > ---
>> >  refs.c | 10 +++++-----
>> >  1 file changed, 5 insertions(+), 5 deletions(-)
>> >=20
>> > diff --git a/refs.c b/refs.c
>> > index e7606716d..0272e332c 100644
>> > --- a/refs.c
>> > +++ b/refs.c
>> > @@ -366,11 +366,11 @@ int for_each_glob_ref(each_ref_fn fn, const ch=
ar *pattern, void *cb_data)
>> >=20
>> >  const char *prettify_refname(const char *name)
>> >  {
>> > -	return name + (
>> > -		starts_with(name, "refs/heads/") ? 11 :
>> > -		starts_with(name, "refs/tags/") ? 10 :
>> > -		starts_with(name, "refs/remotes/") ? 13 :
>> > -		0);
>> > +	if (skip_prefix(name, "refs/heads/", &name) ||
>> > +	    skip_prefix(name, "refs/tags/", &name) ||
>> > +	    skip_prefix(name, "refs/remotes/", &name))
>> > +		; /* nothing */
>> > +	return name;
>>=20
>> Nice, but why add the "if" when it's doing nothing?
>
> It's short-circuiting in the conditional.

I think Ren=C3=A9 meant this:

     /* just for side effects */
     skip_prefix(name, "refs/heads/", &name) ||
     skip_prefix(name, "refs/tags/", &name) ||
     skip_prefix(name, "refs/remotes/", &name);

     return name;

which still short-sircuits, even though I do think it looks
strange; "correct but strange".
