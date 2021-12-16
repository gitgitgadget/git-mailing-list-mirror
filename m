Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835BEC433FE
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbhLPVn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:43:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55129 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242325AbhLPVmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:42:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AF23EE7D5;
        Thu, 16 Dec 2021 16:42:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Iq/XUQTM/OOZ
        8YTh7ENwVoqdQ98pfK+FjfdTkP018rg=; b=qnnN3su85v1mUi7VDbO7nBSDOgV9
        3KLDDusbVXQF+f6spY3G5hNIJtLILJ1FgbLgA9NXl+RymfxOfQmuqDLrlPVua/vp
        n3VeBvX+oi9o7cfb8qG7IL3LqqlD8rMDeOzOFrLNQYGw+oUi/3dLDz8k3wyXfKGB
        K0p9z9epbS71MX4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92831EE7D4;
        Thu, 16 Dec 2021 16:42:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA547EE7D3;
        Thu, 16 Dec 2021 16:42:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     =?utf-8?Q?Jo=C3=A3o?= Victor Bonfim 
        <JoaoVictorBonfim@protonmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Fw: Curiosity
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com>
        <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com>
        <xmqq8rwl91yf.fsf@gitster.g>
        <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net>
        <xndBIO9EtrXaA932eF-0YkvHCAOL1GOKQQlIigssmcwhtZWqGxhc6I_A-lXt7vMK-j1oDrQMHUIuExlpqFS4v88nWci32qx3W5Xi1_hPpUM=@protonmail.com>
        <54fe7ba20109f974b61a7e6c24ba8264@codeaurora.org>
Date:   Thu, 16 Dec 2021 13:42:33 -0800
In-Reply-To: <54fe7ba20109f974b61a7e6c24ba8264@codeaurora.org> (Martin Fick's
        message of "Thu, 16 Dec 2021 14:33:28 -0700")
Message-ID: <xmqqtuf88bw6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 14A320E0-5EB9-11EC-908C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Fick <mfick@codeaurora.org> writes:

> On 2021-12-16 14:20, Jo=C3=A3o Victor Bonfim wrote:
>>> To expand on this, if what you're storing is already compressed, like
>>> Ogg Vorbis files or PNGs, like are found in that repository, then
>>> generally they will not delta well. This is also true of things like
>>> Microsoft Office or OpenOffice documents, because they're essentially
>>> Zip files.
>>> The delta algorithm looks for similarities between files to
>>> compress
>>> them. If a file is already compressed using something like Deflate,
>>> used in PNGs and Zip files, then even very similar files will
>>> generally
>>> look very different, so deltification will generally be ineffective.
> ...
>> Maybe I am thinking too outside the box, but wouldn't it be quite more
>> effective for git to identify compressed files, specially on edge case=
s
>> where the compression doesn't have a good chemistry with delta
>> compression,
>> decompress them for repo storage while also storing the compression
>> algorithm as some metadata tag (like a text string or an ID code
>> decided
>> beforehand), and, when creating the work mirrors, return the
>> compression
>> to its default state before checkout?
>
> I suspect that for most algorithms and their implementations, this woul=
d
> not result in repeatable "recompressed" results. Thus the checked-out
> files might be different every time you checked them out. :(

That is probably too application specific to be in core-git, but it
is probably a good application for smudge/clean filters like brian
alluded to?
