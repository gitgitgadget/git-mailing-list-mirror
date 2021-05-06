Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C0BC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AF661175
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhEFIno (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 04:43:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56888 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhEFInn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 04:43:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C88061223E2;
        Thu,  6 May 2021 04:42:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6VuivnUstnhc
        vTtrUo6ECDZpJ9qCODBEGDjIQMFIOO0=; b=UjZ0HW30tW29S1AgOkxhgp+crwHX
        quHO+sBB3WlocpWBlYsqwndwmSycQNSIeOLXIU7U4EKGEjGB11KRtySeaJDCYLO1
        nnuKHSoKxhdFmFYTQ9PAVm2Bgk56ItWjmlrZPozyynpNetwjGl4CZiLgXNlyPAjM
        GCExj8Lcdo9KVkE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1A3E1223E0;
        Thu,  6 May 2021 04:42:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E11D1223DF;
        Thu,  6 May 2021 04:42:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] Makefile: don't re-define PERL_DEFINES
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
        <patch-1.4-ed2005a2fbf-20210505T121857Z-avarab@gmail.com>
        <YJKm0dnwHBwQuTi+@coredump.intra.peff.net>
        <87y2csv0qm.fsf@evledraar.gmail.com>
Date:   Thu, 06 May 2021 17:42:41 +0900
In-Reply-To: <87y2csv0qm.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 06 May 2021 08:23:28 +0200")
Message-ID: <xmqq7dkcz20u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05F42026-AE47-11EB-9C29-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> -PERL_DEFINES =3D $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ=
)
>>> -
>>> -PERL_DEFINES :=3D $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_S=
Q)
>>> +PERL_DEFINES :=3D
>>> +PERL_DEFINES +=3D $(PERL_PATH_SQ)
>>> +PERL_DEFINES +=3D $(PERLLIB_EXTRA_SQ)
>>> +PERL_DEFINES +=3D $(perllibdir_SQ)
>>>  PERL_DEFINES +=3D $(RUNTIME_PREFIX)
>>
>> I don't think we generally use simply-expanded variables in our Makefi=
le
>> unless there's a reason. Do we actually need it here? Obviously not ne=
w
>> in your patch, but just a curiosity I noticed while reading it.
>
> I didn't notice it at the time. I suppose it could be changed to not do
> expansion, but per-se unrelated to the more narrorw bugfix in this
> patch.

Actually, strictly speaking there was *no* bug because assigning
three items with :=3D made sure the previous recursively expanded one
to be ineffective.  In other words, there was a valid reason to use
":=3D" there in the original version.

Now your patch removed the recursively expanded one that was
immediately invalidated, there no longer is a reason to use :=3D
there.  So "unrelated to the more narrow bugfix" is a rather lame
excuse to do only half a task.  If we remove that extra one (which
is a good thing), then we should correct :=3D into =3D because the
original used :=3D only because there was the unwanted extra one, no?
