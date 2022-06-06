Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3342BC43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 19:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiFFTIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiFFTIS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 15:08:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B7265CC
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 12:08:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DCE8819F7CF;
        Mon,  6 Jun 2022 15:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eTM7Sj8ny/a4
        AMz1Qg1b2vfBSy3VPH7HCEhcO2swzHs=; b=np8ItpwzTtWhQ4LuYtuHsuw+8nKc
        rScYJL3dayDpwjQh5drLLghGwE5QGxfg9W9g6pXxRgfHpN7ESlP2z2V8q2dUu2Ir
        nZxqCkz5mPxy94XSJe1Yq3JaKCt+iiQgRkzc05T3tGVapytpraJ4GJUihmwd0+Mw
        CJ25tRLlBoEK5kc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D39CB19F7CE;
        Mon,  6 Jun 2022 15:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 50AD719F7CD;
        Mon,  6 Jun 2022 15:08:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] tests: don't depend on "git init" using the
 template
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
        <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
        <xmqq8rqdftfg.fsf@gitster.g>
        <220604.86tu91w8un.gmgdl@evledraar.gmail.com>
Date:   Mon, 06 Jun 2022 12:08:11 -0700
In-Reply-To: <220604.86tu91w8un.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 04 Jun 2022 02:41:16 +0200")
Message-ID: <xmqqa6ap7gpw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 02BA1696-E5CC-11EC-83E2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>  * Since the original submission we've fixed the bug I found in the
>    sparse-checkout code where it had a hard reliance on our default
>    templates, which "init" and "clone" allow you to customize.

I actually would not call that a bug.  At least, it is not an
interesting "bug".

If your custom template lacks .git/info directory, some things may
not be created correctly, and we could work it around by "mkdir -p".

But if your template creates a file there, we cannot get you unstuck
without removing it before "mkdir -p", but we probably do not want
to lose information that we do not even understand.

If your customization of your template breaks your repository in
certain ways, you can keep both halves.  I do not think we should
really cater to such "customize to break" use case.

>    This series doesn't get us there, i.e. the default is still to
>    provide them, but with these changes it'll be trivial to flip that
>    switch in the follow-up series.

So, I do not buy that goal in the first place.  Why not stop at
saying "don't do stupid things to your templates to break your
repository" and move on?  Don't we have bigger fish to fry?

Thanks.
