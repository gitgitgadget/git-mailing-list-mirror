Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7245DC433E0
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 20:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D0220674
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 20:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NjI8fCNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgGLUwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 16:52:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56768 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbgGLUwY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 16:52:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B584E49D4;
        Sun, 12 Jul 2020 16:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m8EGYslqoYjB67obv/YDO/WIucI=; b=NjI8fC
        NXsJTYI/lAODB3NlE3+Og2+jR7oQ8PsN1h0cYR5tFX2AwmAtWgGbQdMGzOkoSWqc
        rWYYHw484ibWDvst+a/Ou1ztyAuL0bW69zF7tCWeAqAyjJPWfS1qcHPHN1nPsRA1
        nDcjrefSykj22/FDIvBhuzvIWOtR3v/79DvB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=maamXH5m1KgZOcCTzcMIIzf6pNJq7AYI
        XJk+eJ1uQjaQpYnpLwAiv42yyyryklX2tdw5DZ/kV+DeOhF9C/BJDO+WI4Ip49dT
        XjrD2+0ZYCBC7i/oB7zOQmXAPC3cCQjMrfoUyI3a7oM3t1LrsJkfBlW15uS0/P4N
        ecXt4z+d+d0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24542E49D3;
        Sun, 12 Jul 2020 16:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 72176E49D2;
        Sun, 12 Jul 2020 16:52:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
        <xmqqimetrcay.fsf@gitster.c.googlers.com>
        <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
        <xmqqblkkr63u.fsf@gitster.c.googlers.com>
        <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
Date:   Sun, 12 Jul 2020 13:52:17 -0700
In-Reply-To: <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Sun, 12 Jul 2020 16:25:02 -0400")
Message-ID: <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93A04450-C481-11EA-B73F-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> I also discovered that symlinking FETCH_HEAD to /dev/null works as well 
> and thus saves a few IO cycles.

We could teach "git fetch" a new "--write-fetch-head" option and
teach "git pull" to pass it when calling "git fetch".  It is very
plausible that some folks rely on "git fetch" to leave FETCH_HEAD
without being told, so the option must default to on for a few
development cycles before we flip the default to off, and for those
who want to live in the future a bit earlier, we can also introduce
fetch.writeFetchHEAD configuration variable that determines what
happens when "git fetch" is run without "--write-fetch-head" option
on the command line.  That way, you could drop 

	[fetch]
		writeFetchHEAD = 0

in say /etc/gitconfig or in ~/.gitconfig of the user that runs the
mirroring automation.



