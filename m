Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB29CC433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 23:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90934206C0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 23:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PhdwHcqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgHHX0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:26:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58517 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHHX0U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 19:26:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 037D5DB269;
        Sat,  8 Aug 2020 19:26:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I8npYBbkaefemqg490UX5kmu5pE=; b=PhdwHc
        qai9ZM1E71SJdVwf2Gmokl9MwEUvE3bUxo/RNKBfdoWxzuja+RTTiaHgCRdiVmPS
        T+uhHC/qHRfw8foR6kxODldReaboQlWoLn9yhGTJ3AhNGDWCQVOMNPxWbTwwc76m
        jGpRnkFuB3+XrnCiePOVxLvEBNRxMXJByGzIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=omRkK6nARpuw+9vy4uEc2lNkaZlMI/cx
        vVyJ150SFXXh/lSBz6ADdGc8TCYPqL/5A1aMP2/XRFua04af0N2EhD6Z+8a1FkfY
        zdDYtf3usT8br9ZQRNsoN8heRfUoUlo+ArBwf0pVVFyJ6YIXeduv8UIDduh94CJP
        J5jhfAUdRc4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2A67DB268;
        Sat,  8 Aug 2020 19:26:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28DDCDB267;
        Sat,  8 Aug 2020 19:26:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/5] submodule: expose the '--for-status' option of summary
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
        <20200806164102.6707-2-shouryashukla.oo@gmail.com>
        <831df9f2-0663-0dfc-0871-d34864d1ecde@gmail.com>
        <CAP8UFD20ORozywSAV+Qayuf_vwve9A21ySAtTZVphwhv5nYWXg@mail.gmail.com>
Date:   Sat, 08 Aug 2020 16:26:14 -0700
In-Reply-To: <CAP8UFD20ORozywSAV+Qayuf_vwve9A21ySAtTZVphwhv5nYWXg@mail.gmail.com>
        (Christian Couder's message of "Sat, 8 Aug 2020 22:25:10 +0200")
Message-ID: <xmqqv9hsen3d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E487FEC-D9CE-11EA-A7AB-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Yeah, I agree that finding a good name and a good use case for the
> option would surely help.

That makes it sound like a solution looking for a problem.

The option was added and discussed in [*1*], and it was quite clear
that it was merely an implementation detail to show the same info as
"git submodule summary" in a format that would fit better in the
context of "git status".  I doubt that anything changed since then
in the past 12 years to make the option deserve more attention by
the end users, but what this patch (which is the first in a 5-patch
series) does may be worth doing if a later patch in the series
serves as that "good use case".

On the other hand, if there is no such "good use case" example in
the other changes in this series, the option can and should be kept
as an implementation detail of "git status", I would think.

Thanks.


[Reference]

*1*
https://lore.kernel.org/git/1205416085-23431-1-git-send-email-pkufranky@gmail.com/

