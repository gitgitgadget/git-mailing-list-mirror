Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CD3C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 17:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D938E61405
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 17:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245002AbhDURts (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:49:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56071 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbhDURte (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 13:49:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DCD65133F80;
        Wed, 21 Apr 2021 13:49:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XShyDibpBLwt
        4wBQyNlpj0QY1BA=; b=c2bqn1gwwEdMHtTL/ueZfkx+HDSXeC5mu9s6iZXwH+5y
        IaeKAPMRnf2T10cakRK8NJEsw8eOgxXutAmGsTwhDsjqjys+FiZl0R9oiqX/D+R/
        MHw30+JBQE+at49hGrJ9uCnusZVaAiorFAiRuawRHXqV9phYuMCZOmxVtI7gxvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=I6LzUa
        mEwKw4AyMLhM9WQBoETHv9LxDhdIXvPPRzB7RbuGTzus1DT2r4rZcgs/30Yii6VF
        9qjwMTyN/IlNV3D39qs/yOTKRHdlFw9MikilG6eGZG4aizSTATgnX7/08JeBrtaA
        NaWP9Blzk3r88rYzjFbIZhsr9Vxc1rxTQ3hTk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4E7D133F7F;
        Wed, 21 Apr 2021 13:49:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 257CD133F7E;
        Wed, 21 Apr 2021 13:48:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Luke Shumaker <lukeshu@lukeshu.com>, git@vger.kernel.org,
        Luke Shumaker <lukeshu@datawire.io>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
References: <20210420190552.822138-1-lukeshu@lukeshu.com>
        <8735vk3vyq.fsf@evledraar.gmail.com>
Date:   Wed, 21 Apr 2021 10:48:56 -0700
In-Reply-To: <8735vk3vyq.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 21 Apr 2021 10:03:57 +0200")
Message-ID: <xmqq5z0fzfxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D93CAF36-A2C9-11EB-9888-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +	tagname =3D memmem(buf, message ? message - buf : size, "\ntag ", 5)=
;
>> +	if (!tagname)
>> +		die("malformed tag %s", oid_to_hex(&tag->object.oid));
>> +	tagname +=3D 5;
>> +	tagname_end =3D strchrnul(tagname, '\n');
>
> So it's no longer possible to export a reporitory with a missing "tag"
> entry in a tag? Maybe OK, but we have an escape hatch for it with fsck,
> we don't need one here?

We do have an escape hatch for missing "tagger" (e.g. "git cat-file
tag v0.99") in tag.c::parse_tag_buffer() that is used by fsck.

But a missing "tag " gets an immediate "return -1".
