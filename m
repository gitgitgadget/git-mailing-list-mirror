Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD10C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJTWCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJTWCG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:02:06 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C3821A841
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:02:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D657151090;
        Thu, 20 Oct 2022 18:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=i6saKtD5aC4u
        iIrYEgA7cCebQ0RWK//We+ExTDcI464=; b=uiUpjtbblneAJgU7hvJ7R+h8/dUS
        AYWh/eXef+l0QllMxYc1HpEr7djqwB6mj+C3c4VUHefCZmmYwZvIYEmrFewVlv8o
        33viFPERHRTAgDebMMNzYD7+A7D5fjD+35ioOucugBKAa+5ZcjppW5yn5ehwCz/8
        3k62uDnX4rxJB3M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32CAD15108F;
        Thu, 20 Oct 2022 18:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D5A515108E;
        Thu, 20 Oct 2022 18:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqczammrf5.fsf@gitster.g>
Date:   Thu, 20 Oct 2022 15:01:57 -0700
In-Reply-To: <xmqqczammrf5.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        20 Oct 2022 08:43:42 -0700")
Message-ID: <xmqqtu3yqhm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D1657C18-50C2-11ED-BE94-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> At $DAYJOB, we observed that this topic breaks MacOS builds with sha1d=
c:
>>
>>   $ make NO_APPLE_COMMON_CRYPTO=3D1 DC_SHA1=3D1 NO_OPENSSL=3D1 compat/=
fsmonitor/fsm-ipc-darwin.o =20
>
> Glen, =C3=86var has cherry-picked the SHA_CTX -> git_SHA_CTX build fix
> and I have merged it to 'next'.  Can you test-build to see if that
> change is sufficient to fix "does not even build from the source"
> issue for you guys?  You do not have to go through any official full
> qualification cycle or release procedure---just checking that you
> would be OK when you need to do the build the next time before it
> has to happen is sufficient.
>
> Thanks.

FYI, https://github.com/git/git/actions/runs/3292710187 is a
successful (wow, what's a rare event these days) run of CI on 'seen'
that includes

 * Peff's -O0 fix for unconfusing LSan to prevent it from giving
   false positives

 * Eric DeCosta's change, cherry-picked by =C3=86var, to let fsmonitor
   stuff compile with sha1dc as well as Apple's Common Crypto.

 * A tweak to make one of the macOS CI jobs to build with sha1dc.

among all the other topics in flight.  I plan to merge all of them
to 'next' (I think the first two are already in 'next') and fast
track them down to 'master'.
