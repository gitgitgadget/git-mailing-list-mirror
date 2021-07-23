Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7DFC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A178160E9C
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhGWQGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:06:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58166 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGWQGx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:06:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB306D412A;
        Fri, 23 Jul 2021 12:47:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HQ6helV+djCvC1bFuBcYE4Whw69xZQkcWIOOg2
        g+4OA=; b=sRlGi3TMJ1aZogmp48+bRB13pUlYyKIFoMv98JAT29vbe16sgX6trg
        m1A5eUXso66MKZnUcHfJ3DY+ROR9KyaWXijtd2hu7tFOkAiXt7YgpzaUhzPYzF/e
        ms+KdyN/IlAJiGpFeQx7tM+bBIlCUoCRX0b5Z3UklwVTe/rYiHyMU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2FE6D4129;
        Fri, 23 Jul 2021 12:47:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EE91D4128;
        Fri, 23 Jul 2021 12:47:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Angelo Borsotti <angelo.borsotti@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Extracting a file
References: <CAB9Jk9AafnUQr6q8t=b4Dh0PZHUA=fKJmtXxxObuGpF_w-_2wQ@mail.gmail.com>
        <871r7qvhhr.fsf@evledraar.gmail.com>
        <CAB9Jk9DqCR8C9qx6-gZmpTQfBAKnEupQTb1WkJgN3YOqSO0=2A@mail.gmail.com>
        <YPppNYOO26xAq2fn@coredump.intra.peff.net>
        <CAB9Jk9Af-GKFUQCiyN9fKmjA1hOLBw9mc_FPFBHX1m1NAnbfmQ@mail.gmail.com>
Date:   Fri, 23 Jul 2021 09:47:24 -0700
In-Reply-To: <CAB9Jk9Af-GKFUQCiyN9fKmjA1hOLBw9mc_FPFBHX1m1NAnbfmQ@mail.gmail.com>
        (Angelo Borsotti's message of "Fri, 23 Jul 2021 09:38:41 +0200")
Message-ID: <xmqqa6mdou3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A930FD6A-EBD5-11EB-BC47-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

>> You might also like "git checkout -p HASH -- A", which will let you pick
>> individual hunks from HASH:A and apply them to your working tree.
>
> This shows the differences between the committed and the current file,
> in a patch
> form, which is handy to apply to the current file to make it equal to
> the old, but
> not if I want to browse the old file and understand how it was before.

Why doesn't a straight-forward "check out the path from an old
version" work?  That is

    git checkout $old_version -- path/to/file.ext

Is it because you have changes to path/to/file.ext already (in which
case "mv path/to/file.ext path/to/file.ext-saved" would be a quick
way to save it away)?

And then path/to/file.ext can be inspected to your heart's content,
and when you are done and want to go back to the current state, you
can do "git checkout HEAD -- path/to/file.ext" (followed by the
earlier "mv" in reverse)?
