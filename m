Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17559C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 17:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiI3RBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 13:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiI3RBL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 13:01:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF684E905F
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:01:06 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D7B81C875F;
        Fri, 30 Sep 2022 13:01:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lCymtJG18z5X
        +H4IiPnY2mu807XvCcGXwt9dZLZ3/IM=; b=cSl6LVzLcC2bDtlYvXeorx2tNE6C
        4ED8se1kKyLBsinBUpwNYsW+l8wvfShVmEcpR68RhSwFmg0emqc9AIYyZh6Vc8QB
        NI36nW2NZoljMcBMbmf+lXMPWcz3EPQgVhGqnQpA8/hTi/zL+4p0XixJ43JIGQBF
        xRny5mz2Uvfd2Fw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14E171C875E;
        Fri, 30 Sep 2022 13:01:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 825BD1C875B;
        Fri, 30 Sep 2022 13:01:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] branch: do not fail a no-op --edit-desc
References: <xmqqczbftina.fsf@gitster.g> <xmqq8rm1mz1d.fsf@gitster.g>
        <220930.86v8p5updv.gmgdl@evledraar.gmail.com>
Date:   Fri, 30 Sep 2022 10:01:01 -0700
In-Reply-To: <220930.86v8p5updv.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 30 Sep 2022 12:21:48 +0200")
Message-ID: <xmqq7d1klrua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 76EDE1A8-40E1-11ED-9767-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> The end result is OK in that the configuration variable does not
>> exist in the resulting repository, but we should do better, by using
>> git_config_set_gently() and ignoring only the specific error that is
>> returned when removing a missing configuration variable.
> ...
> I was curious to follow up on your suggestion in your 3rd paragraph, so
> I tried implementing this in the config API, results below, if you're
> interested in it assume my SOB.

Did I make any suggestion?  I am assuming that what I left in the
quote above is the paragraph you are referring to, and that is not a
suggestion but a description of what the patch did, so I am puzzled.

> But, having done that I discovered that your code here has a bug,
> admittedly a pretty obscure one. The CONFIG_NOTHING_SET flag on "set"
> doesn't mean "nothing to set, because it's there already", it means
> "either <that>, or the key is multi-value and I'm bailing out".

Ah, OK, so in short, _gently() is still unusable to use for that.  I
guess it means that the approach taken by v1 would be a better
solution, then.

Thanks.
