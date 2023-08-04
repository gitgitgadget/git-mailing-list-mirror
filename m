Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA6EC001DE
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 19:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjHDTAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 15:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHDTAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 15:00:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70D146B2
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 12:00:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 781061AB9C;
        Fri,  4 Aug 2023 15:00:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=x9cNpG+q/tA0
        mbmOjnrnVstRf/HNukf0uJ8xrlwfLGQ=; b=a54x4IFSr8iOj8CwjPmxjbO3N/4y
        SUUFjwYKy7is9m49J3IFH54DiHbCG1gaH4VKMrV9iGkJKAe3fdIwuoeFKFgKNSCq
        kE6XdIL9gppbgB5eEg90N2d5ooYYmR9C7Qd3EakxWrVX0DMiJNyXaBn5A3sUScG7
        p5g55WBPdO8qfy0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7031F1AB9B;
        Fri,  4 Aug 2023 15:00:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 020271AB98;
        Fri,  4 Aug 2023 15:00:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [QUESTION] how to diff one blob with nothing
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
        <xmqqo7k7c1yw.fsf@gitster.g>
        <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
        <xmqqila6cz0n.fsf@gitster.g> <ZMKtcaN7xYaTtkcI@nand.local>
        <CAOLTT8Ru+3efmUNMOwbhzwRu-FW-SVPYn88-xtrRQiRuweFG+Q@mail.gmail.com>
        <CAOLTT8S=_1Vd2Y4rBqq03JsJ1megRBcx9v-HYAWXe88jDek98Q@mail.gmail.com>
        <ZMvGsYSystLu6oBY@nand.local>
        <CAOLTT8Tc9NevyUfwiPscEH7BqShSscb=iZP4r+7mjsEwouLeXg@mail.gmail.com>
        <CAP8UFD2GV+1LhZDrSsgQ5=gRgYSTYsS36i2ugoBEHu-Oto-Sow@mail.gmail.com>
        <ZM1EvGVGv2ZYrpuT@nand.local>
Date:   Fri, 04 Aug 2023 12:00:11 -0700
In-Reply-To: <ZM1EvGVGv2ZYrpuT@nand.local> (Taylor Blau's message of "Fri, 4
        Aug 2023 14:34:36 -0400")
Message-ID: <xmqqmsz6ljk4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 242D4408-32F9-11EE-8D96-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Aug 04, 2023 at 10:28:53AM +0200, Christian Couder wrote:
>> On Fri, Aug 4, 2023 at 6:42=E2=80=AFAM ZheNing Hu <adlternative@gmail.=
com> wrote:
>>
>> > Actually, there is no need to support a default empty blob.
>> > For example, with the command "git diff --no-index <file> /dev/null"=
,
>> > it can compare a file with /dev/null, but it can only compare <file>
>> > and not <oid>.
>> > Therefore, using commands like "git diff <oid> /dev/null",
>> > "git diff --no-index <oid> /dev/null", or even "git diff <oid> --std=
in"
>> > could potentially solve this issue.
>>
>> Maybe it would be clearer to have a new option, called for example
>> "--blob-vs-file", for that then. It could support both:
>>
>> $ git diff --blob-vs-file <blob> <file>
>>
>> and:
>>
>> $ git diff --blob-vs-file <file> <blob>
>
> Hmm. This feels like a case of trying to teach 'git diff' to do too
> much.

Worse yet, I do not quite get the original use case in the first
place.  What is the series of diff output that result in comparing a
random pair of blob object names going to be used for?

The reply to <ZMKtcaN7xYaTtkcI@nand.local> says that the original
use case was to express the evolution of a single path since its
creation until its removal, but the thing is, a diff with an empty
blob and a creation or a deletion event are expressed differently in
the patch output, exactly because the patch has to be able to
express "before this change, a file with zero byte content was
there" and "before this change, there was nothing at this path"
(vice versa for contents-removal vs deletion).

For that reason, I have a hard time to find any merit in the earlier
complaint that said "can be achieved by manually adding them, but it
is not very compatible with the original logic", whatever the
"original logic" refers to.  If creation needs to be recorded as
creation and not as a change from an empty and existing blob, there
has to be something that needs to be manually done to turn the
latter (which is the only thing "diff" between two blobs or even a
blob and a file can give) into the former *anyway*.  Whatever the
thing that is looping over the history/evoluation of a single path
needs to have a three-arm switch for each iteration to deal with
creation, modification, and removal, and iterating over the contents
of the files and prefixing "+" or "-" on each and every line would
be the _easiest_ part of such a necessary tweak to turn "diff
between an empty contents and something else" into "creation or
deletion of a file."

