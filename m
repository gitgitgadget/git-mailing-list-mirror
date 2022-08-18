Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B09C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 17:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344198AbiHRRcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiHRRcj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 13:32:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5D0B69DB
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 10:32:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C341E1BF87C;
        Thu, 18 Aug 2022 13:32:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mSVdPzHxZzQj
        IVVQwao8LwuTDPt2t4fJUKOszF0FM0g=; b=A6r3gBcdgcvxoMmZ6ACdU9eR/rgQ
        qZ14aSQufCSiLrNa4Of980UWNqc2QcDaJhBhIw9TJ7T0nP4FiD3Qi6ursHZBu/Ip
        9LriYRpZmqsdA83bzNhfKrvGJIk6Vy6fAuv1+7J9jjBaoKW5D1OFemgnhY9rT+Jr
        zEXobH1DbezEOB4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBEC71BF87B;
        Thu, 18 Aug 2022 13:32:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 312D01BF87A;
        Thu, 18 Aug 2022 13:32:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
References: <20210317204939.17890-1-alban.gruin@gmail.com>
        <20220809185429.20098-1-alban.gruin@gmail.com>
        <20220809185429.20098-9-alban.gruin@gmail.com>
        <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
        <xmqqilmzkd7p.fsf@gitster.g>
        <qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr>
        <xmqqedxgt1zx.fsf@gitster.g>
        <848p4p89-2219-7874-ss50-2o0rp4r02902@tzk.qr>
        <CABPp-BGSFYWvA5HktLf33=w7JB95iDLDNoE0gdA3oUtb+qYoQQ@mail.gmail.com>
        <xmqq7d36vfur.fsf@gitster.g>
        <220818.868rnlaa0h.gmgdl@evledraar.gmail.com>
Date:   Thu, 18 Aug 2022 10:32:34 -0700
In-Reply-To: <220818.868rnlaa0h.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Aug 2022 16:24:38 +0200")
Message-ID: <xmqqmtc1pidp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BF494B50-1F1B-11ED-94CD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I may have missed something in this thread, but wouldn't an acceptable
> way to please everyone here be to:

Why pile on MORE cruft on top of a needless rewrite into an internal
call, when it is cleaner to just get rid of the part that makes an
internal call?
