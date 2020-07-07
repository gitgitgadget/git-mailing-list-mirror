Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C403BC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A87E2073E
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x0gx2oer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGGQuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:50:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57361 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGQuE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 12:50:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7781B6E4C5;
        Tue,  7 Jul 2020 12:50:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xnI/XW7zEUFpOxIBXx8UQcRO3Gs=; b=x0gx2o
        erxFsuADJm0kcCMbvj6WrPbCtj1xwfB4gC5ROeqUjyQVRvW83ftfHp8G5CidhgIF
        u5gY0KzRaz12pg6/MeXi7pw6luELzSfgn4ctwL+2Cwu2mdZmmu0e+fg8Zyb+RMg/
        kJIfw2d4FpHCMZg/1n07WVwA5CZdX3TYXR/ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h/R4Bxi/lxn2vV9WrEFaDtshXEo8nCbA
        mdAsnLKudxrI2/ekVbCLNJPdZnHqCErdjA9a3K9dkRJW/Ht+LBOpMsFwzQ/KW64M
        G8G46pTskBjkpVdzXX0+F8Jkr473YqJjhheT7iSqB82k0UcKh8F4rUGB9EYImXXS
        LEj33cuf9iE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA73E6E4C3;
        Tue,  7 Jul 2020 12:50:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD5556E4C2;
        Tue,  7 Jul 2020 12:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] experimental: default to fetch.writeCommitGraph=false
References: <20200707062039.GC784740@google.com>
        <xmqq8sfv745r.fsf@gitster.c.googlers.com>
        <20200707151735.GA27992@syl.lan>
Date:   Tue, 07 Jul 2020 09:50:00 -0700
In-Reply-To: <20200707151735.GA27992@syl.lan> (Taylor Blau's message of "Tue,
        7 Jul 2020 11:17:35 -0400")
Message-ID: <xmqqeepn5kxz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5DE5E00-C071-11EA-94B6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> I wonder if we perhaps wnat to add to the documentation for
>> writeCommitGraph configuration that its use is currently not
>> recommended in a shallow clone or something (I know it is not
>> a problem just to use it with shallow but the breakage needs
>> to involve unshallowing, but by definition those who do not
>> use shallow would not hit the unshallowing bug, so...).
>
> I think this is a good direction if you don't want to take the patch I
> sent in [1] for v2.28.0. If you do, though, I don't think that this
> would be necessary.

Good timing.  I didn't know a "fix" was already being worked on ([1]
is the patch from this morning, right?  I haven't seen it except for
its subject).

We could obviously do both excluding it from the usual experimental
set and applying your fix, so that those who are really curious can
help us make sure your fix would be all that is needed.  Let's see
what Jonathan says...

Thanks.
