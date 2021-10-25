Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B4EC4167B
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B786460EE3
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhJYRKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:10:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54989 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbhJYRJM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 13:09:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33AC6F7AA8;
        Mon, 25 Oct 2021 13:06:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NJTbRgB2hwhC
        9a51UoOZG/J8Jda1ENo9vsMONG6J100=; b=Suz7rmVAnR2p4aPlqZbzY01PzS0m
        TBzAWkpDH9Pe6JERoKcKNDbKKLb332h6xDAQlx0bWTJpVyxJHHUbNvxWsvER//+M
        34sSbkpSQEKK+WMmpSSD/zIMYrmcpkfzulnRW7P86YHC/Eagq4YLmrO1lstCq5gR
        UVe1TRg0UC+/4cA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A4C0F7AA6;
        Mon, 25 Oct 2021 13:06:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BC3CF7AA4;
        Mon, 25 Oct 2021 13:06:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin <git@mfriebe.de>, git@vger.kernel.org
Subject: Re: changing the experimental 'git switch'
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
        <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
        <9c6b3041-a5c0-6fe1-860e-7bfcb292ae81@mfriebe.de>
        <da952e81-70f9-886b-42ff-2ec850f55fa0@mfriebe.de>
        <xmqqwnm2418p.fsf@gitster.g>
        <211025.86tuh5gtcc.gmgdl@evledraar.gmail.com>
Date:   Mon, 25 Oct 2021 10:06:48 -0700
In-Reply-To: <211025.86tuh5gtcc.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 25 Oct 2021 14:48:47 +0200")
Message-ID: <xmqq5ytl2fvb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F14BB35E-35B5-11EC-B7A6-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> So, it probably makes sense to be more selective that what are
>> sensibly copied and what are not.  Reflog most likely does not
>> belong to the "sensibly copyable" set.  Tracking info most likely
>> does.  Among various configuration in branch.OLD.*, there may be
>> things like description that are not sensibly copyable.
>
> It is a bit weird, but the main problem is that we'll use it for UI suc=
h
> as @{-1} or whatever in addition to things like "x days ago". So if you
> copy a branch for some ad-hoc testing, and were just running such a
> command you might expend it to work.

The event of new branch "creation" onward should be recorded to the
reflog of the newly created branch.  As of X days ago, the new
branch did not even exist, so that is not a good excuse to copy the
reflog.

Also @{-1} comes from the reflog of HEAD, which is different from
what we are discussing.

> For a user it also maps nicely to the mental model you'd have if you
> copied two directories with the "-p" option to "cp", i.e. you'll be abl=
e
> to run a "find" command on that checking mtime of N days ago and the
> like.
>
> Maybe it still doesn't make sense for those cases just some thoughts on
> UX edge cases.

To me, it makes no sense, with these analogies.  If I make a copy of
a file one month old with timestamp copied, I may appreciate that
the newly created copy hasn't yet been touched by looking at the old
timestamp, but that does not necessarily mean that I want to pretend
that the new file was there from that old date, or I want to pretend
that the last time the new file was edited before that was at an
even old time.

If I were renaming a branch, that is a totally different story.  In
the mental model, the "identity" of the branch did not change, only
the label that I use to refer to it (called "name") has changed.

But I do not expect copying to split and give half the identity of
the original to the new one.

