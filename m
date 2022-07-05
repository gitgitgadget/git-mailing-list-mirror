Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B8C433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 17:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiGERqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiGERqw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 13:46:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD301BEAB
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 10:46:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3EFC619E1EE;
        Tue,  5 Jul 2022 13:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fr0HuhZmFw2h
        r7XzBSsQo0+qsHmMojW01rpM9Kj5l88=; b=J5f/EpuFa78FXBFcYirBrko2SGFN
        wB9pv9Bryc9HnCKTTFbrk9el6fJvOa1xbQqvU4GeonMUeY3McOl0Ga3wM2WMNRxJ
        Zmje//gJnjOoJYapia4CFHTyAK5ScdZ+ZqcF1xBQC4hcrMdhcTBrdnD8l63v9XDz
        tQkcmRpqSjKumxk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3723019E1ED;
        Tue,  5 Jul 2022 13:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB7BA19E1EB;
        Tue,  5 Jul 2022 13:46:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] http: support building on RHEL6
References: <pull.1277.git.1656692646303.gitgitgadget@gmail.com>
        <Yr8kfCqKHwO1QqS6@tapette.crustytoothpaste.net>
        <xmqqpmio7c3m.fsf@gitster.g> <xmqq7d4w7bcw.fsf@gitster.g>
        <220704.867d4tb8oo.gmgdl@evledraar.gmail.com>
Date:   Tue, 05 Jul 2022 10:46:44 -0700
In-Reply-To: <220704.867d4tb8oo.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 04 Jul 2022 09:38:06 +0200")
Message-ID: <xmqq8rp7laez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 702A7CD2-FC8A-11EC-A8FB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> But I do not think the patch text, what the patch does, is that bad.
>>> We advertise in INSTALL that you need 7.19.4 to build without NO_CURL=
;
>>
>>> IOW, you should be able to build Git with 7.21.3 or later.
>>
>> That conclusion is nonsense.  "with a version before 7.21.3 as long
>> as it is newer than 7.19.4" is what I should have said.
>
> I find this line of argument to be circular legalese without a
> distinction.
>
> As 644de29e220 (http: drop support for curl < 7.19.4, 2021-07-30) notes
> (which I submitted as part of the git-curl-compat.h series) the reason
> we have 7.19.4 as a cut-off is entirely due to RHEL.

Ah, I didn't dig deep enough.

On that backdrop, it becomes a reasonable alternative change to bump
the minimum required version to 7.21.3 with something like the "I
wonder if the attached patch is worth considering" patch I sent in
the upthread, without adding the conditional based on
GIT_CURL_HAVE_CURLOPT_RESOLVE cpp macro.

We could pick an even later cut-off point, but that requires a
separate discussion.

Thanks.
