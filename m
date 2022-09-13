Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B5EC54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 20:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIMUlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 16:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIMUlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 16:41:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C821438458
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:41:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCDD615E08B;
        Tue, 13 Sep 2022 16:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=epugSv+Zb+IBTa6Zq5Kv71zAz52AEduznrZ50J
        NuyB4=; b=w8TDKI4fbXcN9v4LHs2HLyD2+bKhQWWdKPo8+P/mCnAeX/R+hItQWX
        qrBGxuSJV1qttNX+N1c5dUcTFpa1mSXY3yHQNXe6pFfUx75WC4Icxd9kdvsKI6c4
        YCE8FlWCtox2UjNXSWz0O6UQn73zLaudniXbtfHYPvOVQcLThpEL8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D531C15E08A;
        Tue, 13 Sep 2022 16:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 454A415E089;
        Tue, 13 Sep 2022 16:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Diomidis Spinellis <dds@aueb.gr>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        avarab@gmail.com
Subject: Re: [PATCH v4] grep: fix multibyte regex handling under macOS
References: <20220826085815.2771102-1-dds@aueb.gr>
        <xmqqzgf389k9.fsf@gitster.g>
        <a8ba447f-d087-1c5e-0ce0-a9040ad080d1@aueb.gr>
Date:   Tue, 13 Sep 2022 13:41:13 -0700
In-Reply-To: <a8ba447f-d087-1c5e-0ce0-a9040ad080d1@aueb.gr> (Diomidis
        Spinellis's message of "Tue, 13 Sep 2022 21:09:21 +0300")
Message-ID: <xmqqmtb380t2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68B98370-33A4-11ED-9231-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diomidis Spinellis <dds@aueb.gr> writes:

>> Perhaps cook this in 'next' and see if anybody screams?

Let's do this.

> I was programming in C before locale.h was introduced, so its
> availability was something that worried me as well.  I looked up
> whether we could/should use a GNU autoconf macro to test for the
> locale.h availability.  According to autoconf's documentation "All
> hosted environments that are still of interest for portable code
> provide all of the headers specified in ISO C90 (as amended in 1995):
> assert.h, [...] locale.h [...], and wctype.h. Most programs can safely
> include these headers unconditionally." [1]

Yeah, but there are folks on minor platforms where full POSIX
compliance is iffy, so whatever autoconf's documentation says
unfortunately does not weigh as much as we wish it does.


