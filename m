Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2044EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 18:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjGLSTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLSTi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 14:19:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE21173C
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 11:19:37 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 931821B61E8;
        Wed, 12 Jul 2023 14:19:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mza16Dbaq++v2Mpyz2rjobKoXlMUvrvLQlMe8b
        5G/GY=; b=hrkDH2hjpFVAWIWRcO5yrqW65SE79MoVNha1hKppGwKOI2CVVzlD8N
        GiyxhhBbH74Um5ULyuM4MRy31QwcXScZI1hocGm4KXkC2+GMB+NMfdDObM5oxTcM
        3HIPfJxU9ujFB+UB9Mtprbm6LoHPfurZ7Kg7um3yoiFstuzZb/wHY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A8C41B61E7;
        Wed, 12 Jul 2023 14:19:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E10AD1B61E6;
        Wed, 12 Jul 2023 14:19:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] pretty: add %r format specifier for showing refs
References: <20230712110732.8274-1-andy.koppe@gmail.com>
        <CAPig+cT3tWnSfk+ZoRWU=JTGctMiE38fH5V1ebpP7L1bGsfU4Q@mail.gmail.com>
Date:   Wed, 12 Jul 2023 11:19:34 -0700
In-Reply-To: <CAPig+cT3tWnSfk+ZoRWU=JTGctMiE38fH5V1ebpP7L1bGsfU4Q@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 12 Jul 2023 12:56:35 -0400")
Message-ID: <xmqqa5w1t2kp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A80EC1C8-20E0-11EE-8E06-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Not a proper review... just running my eye quickly over the patch...
> ...
>> Amend t4207-log-decoration-colors.sh to reflect the added color
>> controls, and t4202-log.sh to test the %r format.
>> ---
>
> Missing sign-off.
>
>> diff --git a/log-tree.h b/log-tree.h
>> @@ -13,17 +13,18 @@ struct decoration_filter {
>> +enum decoration_format {
>> +  DECO_FMT_BARE = 0,
>> +  DECO_FMT_UNWRAPPED,
>> +  DECO_FMT_WRAPPED,
>> +};
>
> Indent with TAB, not spaces.
>
> Is this enum name a bit too generic for a public header? A quick scan
> of other enums in the project shows that they usually incorporate the
> "subsystem" into their names somehow (often as a prefix); for
> instance, "enum apply_ws_ignore", "enum bisect_error".

Everything you said makes sense.

But more importantly, I doubt the wisdom of adding any more %<single
letter> placeholders to the vocabulary.  Even though I personally do
not see any need for variants other than just the plain "%d" to show
the "decorate" information (if you want anything else, just
post-process the output), if we really want to, the way we should
extend the format placeholders is to add %(decorate:<options>) that
is extensible enough that it can produce the identical output as
existing "%d" and "%D" placeholders do, and add new ones as a new
option to %(decorate).

Thanks.
