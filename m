Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B55C07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 16:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8569D611F2
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 16:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346532AbhGSQEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:04:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51867 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349885AbhGSQCi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:02:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18784C68D3;
        Mon, 19 Jul 2021 12:43:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nJCEuHxy7ZO3
        6LJyl2JyD9SujgWeOSpnW6AVdOYfdso=; b=eUQYaDAQ9AqJg9Q6l3pv76BYDoec
        Jdw4WkrrbtXWkPIHVjpstbtfLsh5lBSUAU04Dp6BAvIRirnAfaNpiHSkqULAx722
        GlhMLvl8Z5sdwCvq2MHWT5dkZ2ZyzSvrMTZ9wHeaNAZ1JkZ877i+dZwys1+V59Cp
        hmr8Uu6FTTbeT0U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FAFFC68D2;
        Mon, 19 Jul 2021 12:43:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8825BC68D0;
        Mon, 19 Jul 2021 12:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 08/11] refs/files: add a comment about
 refs_reflog_exists() call
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
        <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
        <patch-08.11-1e25b7c59c5-20210716T140631Z-avarab@gmail.com>
        <YPI7k7TnfQSQM7YF@coredump.intra.peff.net>
Date:   Mon, 19 Jul 2021 09:43:14 -0700
In-Reply-To: <YPI7k7TnfQSQM7YF@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 16 Jul 2021 22:08:19 -0400")
Message-ID: <xmqqa6mintjx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A08684E-E8B0-11EB-9C90-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 16, 2021 at 04:13:04PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> Add a comment about why it is that we need to check for the the
>
> s/the the//
>
>> existence of a reflog we're deleting after we've successfully acquired
>> the lock in files_reflog_expire(). As noted in [1] the lock protocol
>> for reflogs is somewhat intuitive.
>
> Did you mean unintuitive here?
>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index ec9c70d79cc..f73637fa087 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -3068,6 +3068,17 @@ static int files_reflog_expire(struct ref_store=
 *ref_store,
>>  		strbuf_release(&err);
>>  		return -1;
>>  	}
>> +
>> +	/*
>> +	 * When refs are deleted their reflog is deleted before the
>> +	 * ref itself deleted. This race happens because there's no

"... before the ref itself gets deleted", or some verb there.  A
comma in "When refs are deleted, there reflog is ..." would help
making it more readable, too.

>> +	 * such thing as a lock on the reflog, instead we always lock
>> +	 * the "loose ref" (even if packet) above with
>> +	 * lock_ref_oid_basic().
>> +	 *
>> +	 * If race happens we've got nothing more to do, we were asked
>> +	 * to delete the reflog, and it's not there anymore. Great!
>> +	 */
>>  	if (!refs_reflog_exists(ref_store, refname)) {
>>  		unlock_ref(lock);
>>  		return 0;
>
> I think everything is accurate here, though I wouldn't have made the
> distinction with "locking the loose ref". There is no such thing as
> locking a packed ref; we always take the loose lock.
>
> s/packet/packed/, and maybe s/If race/If a race/.

Meaning, there is no such thing as locking a packed ref or a loose
ref, we just lock a "ref" and the way it is done in files backend is
by creating a lockfile as if we are creating/updating a loose one?

I do agree that the second sentence needs rewriting to make it less
confusing.  lock_ref_oid_basic() being the way to lock "a ref" is
not limited to cases where we want to do something to do to the
reflog.

Taking all together, perhaps:

	When refs are deleted, their reflog is deleted before the
	ref itself is deleted.  This is because there is no separate
	lock for reflog---instead we take a lock on the ref with
	lock_ref_oid_basic().

        If a race happens we've got nothing more to do...


>
> -Peff
