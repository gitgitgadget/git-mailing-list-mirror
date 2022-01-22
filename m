Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734B5C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 06:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiAVGgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 01:36:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59888 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiAVGgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 01:36:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 614DF104E37;
        Sat, 22 Jan 2022 01:36:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=QcBAoUK/Ws0X4oGkBsFNxNKln
        Sh0oEI7WTRwGTBp/Tc=; b=AVJUa5ANIPAOxlabTsM/GyFsj19h1PxAkVRB8Yx6E
        vj+eC8ABVV9CgmaC3iglTgPkNDwvIvDbFxAZEbKzGFpsfuHsLnzLiGiLH8QtegRu
        PFHNrdbp73czHxLRrwsripPQBDt718DCYf+Aby1a2Adx+PEZwcNKKtN1Ubak34Y3
        1o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5854F104E35;
        Sat, 22 Jan 2022 01:36:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2464104E34;
        Sat, 22 Jan 2022 01:36:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 3/3] Makefile: replace most hardcoded object lists
 with $(wildcard)
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
        <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com>
        <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
        <211106.86tugpfikn.gmgdl@evledraar.gmail.com>
        <40dbf962-2ccd-b4d6-7110-31317eb35e34@gmail.com>
        <xmqqtugl102l.fsf@gitster.g>
        <220121.86o845jnvv.gmgdl@evledraar.gmail.com>
Date:   Fri, 21 Jan 2022 22:36:06 -0800
Message-ID: <xmqq35lgb7l5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 949A68C0-7B4D-11EC-BCBF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> change is (adding new files is not that common) but I think using the
>>> established "git ls-files || find" pattern would be a good way of
>>> globbing without picking up rubbish if there is a compelling reason t=
o
>>> drop the lists.
>>
>> Yes.

To avoid any misunderstandings, the above "Yes" was given to the
statement, including the "if there is a compelling reason" part
(and there isn't a compelling reason).

> Reviewing the reftable coverity topic I was reminded of this
> patch. I.e. in it we have this fix:
> https://lore.kernel.org/git/xmqqtugl102l.fsf@gitster.g/

I didn't give any "fix" in that message, though.

> Which shows another advantage of using this sort of $(wildcard) pattern=
,
> i.e. if we had this:
> =09
> 	diff --git a/Makefile b/Makefile
> 	index 5580859afdb..48ea18afa53 100644
> 	--- a/Makefile
> 	+++ b/Makefile
> 	@@ -2443,33 +2443,9 @@ XDIFF_OBJS +=3D xdiff/xutils.o
> 	 .PHONY: xdiff-objs
> 	 xdiff-objs: $(XDIFF_OBJS)
> 	=20
> 	+REFTABLE_SOURCES =3D $(wildcard reftable/*.c)
> 	+REFTABLE_OBJS +=3D $(filter-out test,$(REFTABLE_SOURCES:%.c=3D%.o))
> 	+REFTABLE_TEST_OBJS +=3D $(filter test,$(REFTABLE_SOURCES:%.c=3D%.o))
> 	=20
> 	 TEST_OBJS :=3D $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/he=
lper/%,$(TEST_BUILTINS_OBJS))
>
> We'd have a shorter Makefile, not need to manually maintain the list,

Both are not all that important.

> and we'd have been getting linker errors all along on the dead code
> (just showing one of many here):

I am not sure if I follow.  You are forgetting to tell us something.

Are you talking about an error you would see when you do what?

Perhaps after you remove reftable/generic.c and have the definition
of reftable_table_seek_ref() that used to be there in
reftable/reftable.c?

Assuming that is the scenario you have in mind, ...

> 	$ make
> 	[...]
> 	/usr/bin/ld: reftable/libreftable.a(generic.o): in function `reftable_=
table_seek_ref':
> 	/home/avar/g/git/reftable/generic.c:17: multiple definition of `reftab=
le_table_seek_ref'; reftable/libreftable.a(reftable.o):/home/avar/g/git/r=
eftable/reftable.c:17: first defined here

... I do not think concrete list of filenames vs list of filenames
created by $(wildcard) has any effect on that the fact that lib.a
that is incrementally updated by the "ar r lib.a" command does not
lose a stale object file from it.

If we have a concrete filename list and removed generic.c, if we
forget to remove it from the list, it will be noticed way before
"ld" has the chance to complain.  We fail to produce generic.o,
which may be a plus.  If we did not forget to also remove it from
the list when we removed the file, then $(wildcard) will give us the
same list of filenames, so you'd see the same error from your ld,
no?
