Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEADC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiGURf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGURf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:35:57 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7CE18E05
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:35:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 994451386F8;
        Thu, 21 Jul 2022 13:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1VLFJt/+HWua
        DRuC141+zlUXyqZFFvH6I6CaGY/tui8=; b=tszHjzJdMBLX1uaZVJy7NhD5C9HS
        oRYcdw4K/KfntIVWxJ1X297lxhib3vQS2Kb9lfeUDiTHRM6x6B0erPh8AFjPL9rA
        ml7rP9OjI9g7qkxa4RtlPENMisUGtTQpPS+Y5EcdNWyOqjIXsfp8i1y0Sycp/WZz
        Fu4TACojmfDMp1g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 925491386F7;
        Thu, 21 Jul 2022 13:35:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E49381386F5;
        Thu, 21 Jul 2022 13:35:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: On-branch topic description support?
References: <xmqqilnr1hff.fsf@gitster.g>
        <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
        <20220721162620.f5ffcedkbvvdhhu7@meerkat.local>
Date:   Thu, 21 Jul 2022 10:35:51 -0700
In-Reply-To: <20220721162620.f5ffcedkbvvdhhu7@meerkat.local> (Konstantin
        Ryabitsev's message of "Thu, 21 Jul 2022 12:26:20 -0400")
Message-ID: <xmqqk086id1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9193ED8E-091B-11ED-B2E2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Thu, Jul 21, 2022 at 04:53:18PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> I tried now with "git rebase --rebase-merges -i", and it supports it
>> properly, i.e. I could re-arrange it so that it's:
>>=20
>>               A---C---B---M topic
>>              / \         /
>>         X---Y   ---------
>>              \
>>               master
>
> This is clever, but it has a hard restriction that nothing happens to A=
:
>
> - you can't move it so it's B---A---C---M
> - you can't squash A+B
>
> Unless all the tools are taught to properly modify the merge commit.
>
> Or am I not reading this right?

I think the drawing is about a two-commit topic that has B and C

Or the drawing is wrong and M's other parent should have been Y.
IOW, "git merge-base M^1 M^2" is the bottom of the topic (and our
ranges always exclude the bottom end, X..Y does not include X but
does include Y).  "git rev-list M^1...M^2" are the commits on the
topic.

Then you can shuffle A--B--C in whatever way you like with "rebase
-i" or "filter-branch", using "git merge-base M^1 M^2" as the base.
