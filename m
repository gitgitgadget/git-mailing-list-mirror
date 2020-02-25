Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD89C35E04
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 20:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879DE20CC7
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 20:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ImoctBkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgBYUJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:09:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57984 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730961AbgBYUJT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 15:09:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54FC3B0BFF;
        Tue, 25 Feb 2020 15:09:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=5VgmppJ19sH1Tz5KX0cEUFpY1Ys=; b=ImoctB
        kgyBvdANFiPC9AutzSNjQZVJZKYVon4Z1cb+ixjXnYxjCTCpy1OR4mBm+3SSSIxT
        C9c8Asr7/lWNPKbI7+aBwix9QOQ+tGi9zsHxMWNDR6LuCu9kP8t8G8FYvsmE+H9z
        9Vd66CinM6yJho+q+9jE9STXhWwxsak3BlKjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O+FmNmlbR4uxsrSqpD7aNkusnvYLdQFx
        AP+DK1WPvwIVk3q/OaSyAM19sGkjXBRX1U5vDYzpJL0r249JM+/8BgGvq+rYd7xV
        j0KZSK8Po3w5idQ6ZiqVJMi0fXgYMyZmIDYMbaAkV5Eb0IxbWrUmY9JjVBQkJ8nr
        E+sNoeDadcU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C11BB0BFE;
        Tue, 25 Feb 2020 15:09:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6642BB0BFC;
        Tue, 25 Feb 2020 15:09:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v5 2/3] advice: revamp advise API
In-Reply-To: <20200225195648.GA212281@google.com> (Emily Shaffer's message of
        "Tue, 25 Feb 2020 11:56:48 -0800")
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
        <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com>
        <20200225195648.GA212281@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Tue, 25 Feb 2020 12:09:12 -0800
Message-ID: <xmqqblpmmntj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1CFB822-580A-11EA-98F2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> ...  Your get_config_value() would then become a mere lookup
>> in advice_setting[] array, e.g.
>> 
>> 	int advice_enabled(unsigned advice_type)
>> 	{
>> 		static int initialized;
>> 
>> 		if (!initialized) {
>> 			initialized = 1;
>> 			git_config(populate_advice_settings, NULL);
>> 		}
>> 		if (ARRAY_SIZE(advice_setting) <= advice_type)
>> 			BUG("OOB advice type requested???");
>> 		return !advice_setting[advice_type].disabled;
>> 	}
>> 
>> with your "push-update-rejected has two names" twist added.
>
> I'm a little confused about the need to cache the result of
> git_config_get_bool() - isn't that a lookup from a hashmap which is
> already populated at setup time, and therefore inexpensive?

Looking up from hashmap with a string key is always more expensive
than indexing into a linear array with the array index.  Also, the
suggested arrangement makes the advice API implementation more self
contained, I'd think.


