Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A601C433FE
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 05:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJIFTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 01:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJIFTp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 01:19:45 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E1B63A0
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 22:19:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 895221C1361;
        Sun,  9 Oct 2022 01:19:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=LRWnEPHBv4R/ZAsIf+LbVtoqa
        b/amMuy1oMzvr0usUQ=; b=ceSvbV3YpTFEmq5aZCSFhrPFc1otqjwV3qYL9oy1a
        CV3sT9Qj+ugLPCqV2TFXReNJhcYg70glbCF9cvyODua2WxgchRsNmLRTA1OII/uI
        zNaHmVe0eEnUVGql1tyQUevFxr9eEM13/b/p/y0przbZFHBXjcQJmESb8YE+I6gg
        NY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7872B1C1360;
        Sun,  9 Oct 2022 01:19:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A59921C135F;
        Sun,  9 Oct 2022 01:19:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
        <0f67ca77-f17f-d844-e689-ca9a9bdf7993@jeffhostetler.com>
        <xmqqpmf3frr5.fsf@gitster.g>
        <ec920650-4334-a6f2-6d6f-241899dd79ec@web.de>
        <58d3ef47-2196-4f59-692a-fc86dfbc1252@jeffhostetler.com>
        <xmqqtu4fco9d.fsf@gitster.g>
        <CAPig+cS=k80JdCBAHbSqcOUBc=iGDetoT3u84oRj2CKpFs7CGg@mail.gmail.com>
        <a8b83ff1-97b6-e2d2-91c7-ace597013368@web.de>
Date:   Sat, 08 Oct 2022 22:19:36 -0700
Message-ID: <xmqqr0zh8tg7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F81EC8DA-4791-11ED-8E7A-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 08.10.22 um 05:46 schrieb Eric Sunshine:
>> On Fri, Oct 7, 2022 at 5:36 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
>>> I do agree that one is dense, but aims for the same thing, and a bit
>>> more.  It might be easier to read if written in longhand, but ...
>>>
>>> ifeq ($(uname_s),Darwin)
>>> ifeq ($(filter clang12,$(COMPILER_FEATURES)),)
>>> DEVELOPER_CFLAGS +=3D -Wno-missing-braces
>>> endif
>>> else
>>> ifeq ($(filter clang9,$(COMPILER_FEATURES)),)
>>> DEVELOPER_CFLAGS +=3D -Wno-missing-braces
>>> endif
>>> endif
>>>
>>> ... we'd need to repeat ourselves, so...
>>
>> The repetition is a very minor downside. The big benefit of this
>> version is that it's easy to understand at-a-glance, unlike the
>> "dense" version with its high cognitive load.
>
> It's certainly easier.
>
> It triggers for any compiler that is not clang, though, which is
> a bit much.

Yeah, of course you are right.  In my "here is a translation to
human-language" I did explain what "clang1" was doing in your
version, but of course, I forgot all about it when writing the above
variant.
