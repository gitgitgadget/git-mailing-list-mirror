Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF291C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 16:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJSQ3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 12:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiJSQ3B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 12:29:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648951C9057
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 09:29:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68E8F1C0D7D;
        Wed, 19 Oct 2022 12:28:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4148tpMtrJIM922WWtDCYl1skAXehj3DgUMoIH
        CKcvc=; b=pW4FkN1I8O3s0LDY9By4VG43U13Zu22z4w2QNsCVexa//dcOp2Cowx
        dLmB/rrlxue9/NgKMY2xjwO7j3q29QC3ehZDNsZheB4U6sJX2h4muoH1WHh7qhq8
        YmF2ruNn/tD6kDnUgbSkdAFAxF+8cMi1aors9QgK2ceMvq+JfX8wI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 617C41C0D7C;
        Wed, 19 Oct 2022 12:28:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 958E61C0D7B;
        Wed, 19 Oct 2022 12:28:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3?= =?utf-8?Q?n?= 
        <carenas@gmail.com>, Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 3/4] Makefile: really use and document
 sha1collisiondetection by default
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
        <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
        <patch-v2-3.4-78ef8636c57-20221019T010222Z-avarab@gmail.com>
        <CAPig+cS8jvUn9bR=1ywWgCC3gPosgycdcdbm+aASo59mXz6rfw@mail.gmail.com>
Date:   Wed, 19 Oct 2022 09:28:55 -0700
In-Reply-To: <CAPig+cS8jvUn9bR=1ywWgCC3gPosgycdcdbm+aASo59mXz6rfw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 18 Oct 2022 22:59:23 -0400")
Message-ID: <xmqqo7u7srp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20D768C2-4FCB-11ED-AE2D-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/Makefile b/Makefile
>> +ifdef DC_SHA1
>> +$(error the DC_SHA1 flag is no longer used, and has become the default. Adjust your build scripts accordingly)
>> +endif
>
> bikeshedding: Do we really need to penalize (abuse) people merely for
> asking us to do what we're already doing anyhow?

A valid question.

I can understand and very much appreciate [1/4] as a very focused
fix to the problem.  Very small part of this step, namely, make the
DC_SHA1 the default everywhere, is also very much welcome.

Everything else I see in these patches are extra "while we are at
it" that should not exist.  These "while at it" changes tend to
somehow implement more subjective choices that will cause more
discussion and take more review resources.  Not all "white at it"
may be more subjective, but at least in this series, they appear
to be.

They distract us from the core changes and slows us down.  It is OK
to do them as totally unrelated clean-up changes long after the dust
settles, but not entangled with the other more important changes
like these patches.

Thanks.
