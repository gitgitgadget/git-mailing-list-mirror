Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9037EEB64D9
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 00:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjGKAzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 20:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGKAzH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 20:55:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E91A0
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 17:55:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF4101FC1A;
        Mon, 10 Jul 2023 20:55:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=I9TBrflki2j6WmKyCT5KKw8EA
        LOMvq6h68qvIPbUVso=; b=ntTLQs1Qn8opEO62Ga6q2EHWoNye+b+7uV3j91Z4g
        8W7z8hWoKdIU0M3MXAdfYeqFwd5ZQdFSq243RHAE/ciUHV0N5EgdPrwJssveL2SH
        Nucm2I2uYBY5Jv2/kZf/58FXFBvd918oMP7prqHzMkij8VVNAqxg/NRdp8OolrPv
        lI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B79F41FC19;
        Mon, 10 Jul 2023 20:55:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 39A521FC18;
        Mon, 10 Jul 2023 20:55:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
        <20230706040111.81110-1-alexhenrie24@gmail.com>
        <20230706040111.81110-2-alexhenrie24@gmail.com>
        <xmqqttugbxds.fsf@gitster.g> <xmqqo7kobwpj.fsf@gitster.g>
        <CAMMLpeS9_P=XXMoOdTAM3jZbaxfLEJNwYArS6p9pMXisT3TRtw@mail.gmail.com>
        <xmqq8rbra9ti.fsf@gitster.g>
        <CAMMLpeQ2P+qQxo17dEdWhMHcmAfTiBoEifp2wUjWVrP+oGSzxQ@mail.gmail.com>
        <xmqqbkgl6f04.fsf@gitster.g>
        <CAMMLpeSwadTcd+z0-J1t=vUgz0wFiVaE5KaT-Wy1cckT3=fFGQ@mail.gmail.com>
Date:   Mon, 10 Jul 2023 17:55:01 -0700
Message-ID: <xmqqsf9v2roa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91D0D24A-1F85-11EE-8BD5-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> On Sat, Jul 8, 2023 at 7:38=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>>
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>> > I agree, showing this message in the middle of `git commit` is not
>> > ideal. However, that's a separate issue that can be fixed later; it'=
s
>> > not part of the problem I'm trying to solve in this series.
>>
>> That is debatable.  Even "by the way you can pull and reconcile
>> early before you have fully finished working on the topic and are
>> ready to push back" is irrelevant during `git commit`.  "Reconciling
>> the differences is not the only way to deal with divergence; you may
>> decide to simply discard what they have with push --force" is even
>> less relevant at that time.  So it seems to be very much an integral
>> part of the problem you are tackling, at least to me.
>
> I thought we just agreed that we don't need to mention force-pushing
> in this particular message? I guess you're saying that we'd still be
> over-encouraging `git pull` if we don't remove this message from `git
> commit` altogether?

I do not think so.

I was saying that, when the user during `git commit` is wondering
what to write in the log message of the commit they are working on
(which may not yet make the current branch ready to be pushed to or
integrated with the remote), the user is not ready to even choose
between "forcing push to overwrite" and "integrate and then push".

It can be fixed later, but it is a part of "how to avoid giving
confusing message to users, especially the new ones" theme.  After
all, "do not make it sound like they always have to integrate" is
how you started this journey, no?

Thanks.

