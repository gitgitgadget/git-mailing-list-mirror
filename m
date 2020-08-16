Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB2C433E1
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 05:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7092065D
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 05:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MuWFVJPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgHPFgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 01:36:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57242 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgHPFgI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 01:36:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06CFC77B65;
        Sun, 16 Aug 2020 01:36:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FeyWyM3sfJK6vq2Z/lfaAqDixko=; b=MuWFVJ
        PiUC6OAN3gpa859bxtuHBVjw8jBJFaB3nYTV59Pjv/cLR5feKaasI4D818fq/RIl
        pizYv2npi7JvUx21HY3OcUu3lhrkVH24w7QErFeh2fTxPntE7uugP8YUAIxG/8YS
        40dtPq9f62HEzFqP+pHZZ38T41/hVVShIzzBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IknXKvzAg4xAQ5Jj+9imMcrENVn5GT1j
        NHQtFOGAsZniL05ByZX1dthMO8fnzk3P+jdw+zx/jETJmMtiBBduOeJmXGsBTcGx
        VnudFjDiC8nh6UruoeHpuDWlJ5rrnRdi9trXe1jkSfUadhs6svzc3nDfjKNTy4h1
        IpxVoT/bWb0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF5FA77B63;
        Sun, 16 Aug 2020 01:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C89B77B62;
        Sun, 16 Aug 2020 01:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     sorganov@gmail.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, solly.ucko@gmail.com
Subject: Re: rebase -i: quick/inline reword
References: <87sggab031.fsf@osv.gnss.ru>
        <20200816001401.1144752-1-aclopte@gmail.com>
Date:   Sat, 15 Aug 2020 22:36:04 -0700
In-Reply-To: <20200816001401.1144752-1-aclopte@gmail.com> (Johannes
        Altmanninger's message of "Sun, 16 Aug 2020 02:14:01 +0200")
Message-ID: <xmqq364n5f0b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60FB562C-DF82-11EA-8B77-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

>> >   !f() { GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash "$@"; };f
>> 
>> These are very good and useful features indeed, and they are examples of
>> batch processing that is very handy for automation, but lacks
>> interactivity. What I rather have in mind is being able to put all the
>> messages /simultaneously/ into my favorite text editor and edit them
>> more or less freely till I'm satisfied, then "commit" the overall result
>> by passing it back to git. Essentially "git rebase -i" on steroids.
>
> git-revise is a third-party tool that can do this
>
> https://git-revise.readthedocs.io/en/latest/
>
> For example, "git revise -ie" allows you to edit all commit messages in
> @{u}..HEAD in a single buffer.

I only looked at its description but the UI the tool does it with
looks quite obvious and intuitive.  From its source, the "merge"
operation does not seem to handle merging a side branch that renamed
files, but that should be OK most of the time, I presume.

Nice.
