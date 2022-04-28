Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68EBC433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 06:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbiD1GpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 02:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiD1GpL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 02:45:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD835F266
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 23:41:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC15013936B;
        Thu, 28 Apr 2022 02:41:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=A4uY5qHLnrYl
        CEiycUMS2zk5KQ+EbhsA3/bVDnOFjm0=; b=OHpVXhmY+rv0bzk96yCODw/iInKJ
        bctGTMtojz8eieCQb899HA9MBkYaBVUadGngFy5IgfQhkPIKE1PvIPcCRi9E3NeO
        0CgIbWQ6E/0bOBLUumUptreONMnHBKbHihtaGKp3vvenQgmaU6HMkNIW0LWYykPV
        +Pfg81tUdLKbxAo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0A59139369;
        Thu, 28 Apr 2022 02:41:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE2D5139368;
        Thu, 28 Apr 2022 02:41:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH 1/2] Documentation: explain how safe.directory works
 when running under sudo
References: <20220427222649.63516-1-carenas@gmail.com>
        <20220428033544.68188-1-carenas@gmail.com>
        <20220428033544.68188-2-carenas@gmail.com>
        <xmqqlevphjmg.fsf@gitster.g>
        <CAPUEsphE1PkZ_oZVAizUqeJRaA3muL1t8ONH=7bCqvxOksf2zg@mail.gmail.com>
Date:   Wed, 27 Apr 2022 23:41:50 -0700
In-Reply-To: <CAPUEsphE1PkZ_oZVAizUqeJRaA3muL1t8ONH=7bCqvxOksf2zg@mail.gmail.com>
        (Carlo Arenas's message of "Wed, 27 Apr 2022 22:58:07 -0700")
Message-ID: <xmqqh76dg15d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 497188A8-C6BE-11EC-8668-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Wed, Apr 27, 2022 at 10:17 PM Junio C Hamano <gitster@pobox.com> wro=
te:
>> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>> > diff --git a/Documentation/config/safe.txt b/Documentation/config/sa=
fe.txt
>> > index 6d764fe0ccf..67f8ef5d766 100644
>> > --- a/Documentation/config/safe.txt
>> > +++ b/Documentation/config/safe.txt
>> > @@ -26,3 +26,11 @@ directory was listed in the `safe.directory` list=
. If `safe.directory=3D*`
>> >  is set in system config and you want to re-enable this protection, =
then
>> >  initialize your list with an empty value before listing the reposit=
ories
>> >  that you deem safe.
>> > ++
>> > +When git tries to check for ownership of git repositories it will o=
bviously
>>
>> Comma before "it will obviously".
>
> Obviously my whole paragraph could be improved further, do you want
> a reroll with this fix, or would instead fixup locally?

I think the patches (including the previous one) are still fluid and
expect them to be reworked; local fix-ups would be a bit premature
and leads to waste.  At least not yet.

>> This raises a design question.  In a repository is owned by root,
>> shouldn't "sudo git describe" work?  IOW, I am wondering if the
>> "instead" at the end of the description is what we want, or if we
>> want to check both the original user and "root".
>
> I think it makes sense to have both, and your implementation below
> seems like a good way to do it but it might not be as safe as it
> seems, since sometimes directories owned by root might be also world
> writable and therefore not necessarily safe.

I am not quite following you; that logic applies to directories
owned by euid (not necessarily root).  As we are loosening to make
"sudo" usable again, the use case to visit root-owned repository as
root via "sudo" is worth discussing, if not worth immediately
supporting, I would think.  I do not think it is absolutely needed
as there is an easy workaround (see below).

Assuming we will go without "same euid, whether it is root or not,
plus SUDO_UID when run as root", here a test addition, updated from
the one I gave you in the review of [2/2]

test_expect_success SUDO 'in root owned repository' '
	mkdir root/p
        sudo chown root root/p &&
	sudo git init root/p &&

	# owned by other person (root), do I see it as a repository?
	(
		cd root/p &&
		test_must_fail git status
	) &&

	# owned by root, can I access it under sudo?
	(
		cd root/p &&
		test_must_fail sudo git status
	) &&

	# workaround #1, giving GIT_DIR explicitly
	(
		cd root/p &&
		sudo "
			GIT_DIR=3D.git GIT_WORK_TREE=3D. git status
		"
	) &&

	# workaround #2, discarding SUDO_UID
	(
		cd root/p &&
		sudo "
			unset SUDO_UID;
			git status
		"
	)
'


