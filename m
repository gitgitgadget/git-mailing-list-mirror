Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4CAC4320A
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089BB60F38
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGWUJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 16:09:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53328 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhGWUJI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 16:09:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F45113AE90;
        Fri, 23 Jul 2021 16:49:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zwedLc1U0XzP
        gYcf73mzWfhZBfiSLoOlh3dNILQO4vI=; b=IYLwQ0vDsXuSSYC7jVokXbNYFuvY
        Fa1c47vYLUgK9NkEmLvzTZA1FeX7oyax6w8BIJNXkvPgUa9oY0P4sZV8SFpbRDMq
        i5cTTIjMOQ/jM6fPG3appaCtLDUdwvTRfa0GgXsqTtZZvDfehACTa2X413rWLIqB
        YZnWBze9BjA9Uv0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77B8D13AE8F;
        Fri, 23 Jul 2021 16:49:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C374E13AE8D;
        Fri, 23 Jul 2021 16:49:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 06/12] refs API: pass the "lock OID" to reflog "prepare"
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
        <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
        <patch-06.12-295594fe8ae-20210720T102051Z-avarab@gmail.com>
        <xmqq35s7efb3.fsf@gitster.g> <xmqqy29zd0dv.fsf@gitster.g>
        <CAFQ2z_PuNJ_KtS_O9R2s0jdGbNNKnKdS3=_-nEu6367pteCxwA@mail.gmail.com>
        <87lf5wstlv.fsf@evledraar.gmail.com>
Date:   Fri, 23 Jul 2021 13:49:37 -0700
In-Reply-To: <87lf5wstlv.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 23 Jul 2021 21:41:47 +0200")
Message-ID: <xmqqzguclpr2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F2EF252-EBF7-11EB-A265-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jul 21 2021, Han-Wen Nienhuys wrote:
>
>> On Wed, Jul 21, 2021 at 7:48 PM Junio C Hamano <gitster@pobox.com> wro=
te:
>>
>>  Junio C Hamano <gitster@pobox.com> writes:
>>
>>  > This obviously breaks the latest round of reftable topic, as it
>>  > still wants this type to take const oid, and I do not think using
>>  > on-filesystem lock as if we are using the files backend is not a
>>  > good solution.
>>
>>  Sorry for redundant negation.  "I do not think it is a good solution
>>  to have everybody pretend as if they are files backend when they
>>  lock refs." was what I meant.
>>
>> Reftable could easily read the current OID for the reference, if neces=
sary.=20
>
> (I'm replying to a mail of Han-Wen's that didn't make it on-list due to
> inline HTML, quoted here in its entirety sans signature, see
> https://lore.kernel.org/git/87eebptr7i.fsf@evledraar.gmail.com/)
>
> Junio: I can change the const around if desired. I thought we weren't
> particularly concerned about it in general except to avoid the verbosit=
y
> of frequent casting, and in this case the lock API doesn't have "const"=
.
>
> But as for the reftable incompatibility it seems to me irrespective of
> backend that a reflog API that supports expiry is going to want to have
> a callback for "give me a lock to expire this branch" and give you a
> reply of "OK, you have the lock, you can expire the log, and it's at
> this OID".
>
> Why would it be file-backend specific?

If you feed const oid to *_reflog_expire() method of any backend
(including the ones that that are *not* files backend), and if you
expect they all will use lockfile API to copy it into lock->old_oid
so that it can be fed safely to prepare_fn(), then the arrangement
for constness you have set up in your series would work out OK for
everybody.  But for any backend that does not use one-file-per-ref
filesystem mapping, it is rather strange to use lockfile API for
locking refs, no?  THat is what I meant by files-backend specific.
