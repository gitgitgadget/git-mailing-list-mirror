Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CAFC001DF
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 18:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjGZSYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 14:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjGZSX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 14:23:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D952122
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 11:23:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ECD6B189CF;
        Wed, 26 Jul 2023 14:23:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QMQUkm8GPhc+
        8FnNLDWxuN6BRFSHiUpEYzc1ih+mcBs=; b=bzPO6B+ewrkN7Iy85Id4MXTnmdBh
        4dETtb2ZgKTaJhsV/V4QqR3SPYLBjHWyYAz3qmx/7nn6B15hyhAWqcFn2Tdj/Kyx
        7LxIax4guw0oujjpLk5QtRdQXHlzADPECSrfCgdCJ8Pubq/akm/tb7so0lgO3CCu
        drg9NNqJtDwzN9I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4D22189CE;
        Wed, 26 Jul 2023 14:23:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7A180189CB;
        Wed, 26 Jul 2023 14:23:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [QUESTION] how to diff one blob with nothing
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
        <xmqqo7k7c1yw.fsf@gitster.g>
        <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
Date:   Wed, 26 Jul 2023 11:23:52 -0700
In-Reply-To: <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 27 Jul 2023 02:00:17 +0800")
Message-ID: <xmqqila6cz0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 935EC730-2BE1-11EE-9FF9-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> If you haven't created one, of course it would fail.  It should help
>> to do
>>
>>     $ git hash-object -w --stdin </dev/null
>>
>> before running
>>
>>     $ git diff 00750edc e69de29bb
>>
>
> This is a viable solution, but it's a bit ugly since a read-only "diff"
> requires =E2=80=9Dwrite=E2=80=9C an empty blob.

If you do not even have an empty blob, you have no business
comparing some other blobs you have with it, do you?

If you do not have a file with a single line "hello, world\n" (that
hashes to 4b5fa63702dd96796042e92787f464e28f09f17d if written in a
blob), then you cannot do "git diff 4b5fa637" with anything and
expect it to work.  It is the same thing.

Besides, if you _know_ you want to compare a blob X to emptyness,
you are better of doing "git cat-file blob X" in the first place.
