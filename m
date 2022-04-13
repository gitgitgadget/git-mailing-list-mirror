Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4B2C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiDMTyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbiDMTya (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:30 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C54A49FBF
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AABA8175D53;
        Wed, 13 Apr 2022 15:52:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Cn9wpFRrfAsE
        z7b68hHbo5sL1NfdjHu7yQbx5fLtMp8=; b=pn2K7vxt5/rQuVEZGet8y4cS913X
        UUwqjAp876ao/1pzJb+0sJfpmGFAh/bvgtJnVzOSWhfwXct/b4RDTHjXSSfSM+7U
        gSU95mgiqWe8fUNtRQmbjumtxBiGYQ2HIy8ZdEcckM7nrr4soRcTsE2e++mF8kMu
        82GxxMUF3VpZN7Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A265C175D52;
        Wed, 13 Apr 2022 15:52:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE879175D51;
        Wed, 13 Apr 2022 15:52:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: reference-transaction regression in 2.36.0-rc1
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
        <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
        <220413.86r161f3qp.gmgdl@evledraar.gmail.com>
Date:   Wed, 13 Apr 2022 12:52:03 -0700
In-Reply-To: <220413.86r161f3qp.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 13 Apr 2022 16:34:46 +0200")
Message-ID: <xmqq4k2w92xo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 31995DB6-BB63-11EC-8479-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This does look lik a series regression.

Yes.

> I haven't had time to bisect this, but I suspect that it'll come down t=
o
> something in the 991b4d47f0a (Merge branch
> 'ps/avoid-unnecessary-hook-invocation-with-packed-refs', 2022-02-18)
> series.

With the issue that /var/tmp/.git can cause trouble to those who
work in /var/tmp/$USER/playpen being taken reasonably good care of
already, it seems this is the issue with the highest priority at
this point.

> I happen to know that Patrick is OoO until after the final v2.36.0 is
> scheduled (but I don't know for sure that we won't spot this thread &
> act on it before then).
>
> Is this something you think you'll be able to dig into further and
> possibly come up with a patch? It looks like you're way ahead of at
> least myself in knowing how this *should* work :)

Thanks.
