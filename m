Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8B1C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 18:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79CD207BB
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 18:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CpuBw02w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGJSuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:50:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55115 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgGJSuP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 14:50:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1947D13A4;
        Fri, 10 Jul 2020 14:50:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9D/LMTxluXB1cfm2IGDTRs8uUdE=; b=CpuBw0
        2wwl926M/pW35hvaTeYeT3wJQk+1CD1TatbYqLuzMSvpeK6ZqueI5Zh1i8h4qNC6
        AH+bmhAAimOWhLii4XJHHof/xbxfOm3NlfGr+AXrjoeQ8jB/exrirUP8ri59J0AR
        iRyzmlJuw+UvacpHF1BIjCQdEu3Fv6HkNoX+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PyUN29oyyGquw04DVK7iWZ9WRG0OB65U
        uziB/MadAhkLVOCd/Vpjv32IaTuT7ErKvdbLvj/l5eG57gLPNphEITszqrVZv89A
        JteeyLEs5tvtO+rv/lW+DfTQehlDEDsfjIwEo+Zofie3wc5eCZQUSF1YI2Z3F6UG
        EI4ozfIhizw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8BADD13A3;
        Fri, 10 Jul 2020 14:50:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E3C5D139D;
        Fri, 10 Jul 2020 14:50:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] progress: remove redundant null-checking
References: <20200710014242.1088216-1-emilyshaffer@google.com>
        <20200710014242.1088216-3-emilyshaffer@google.com>
        <aebbc1ca-9936-ce1b-bacc-855d353f83f9@gmail.com>
        <20200710022040.GB39052@syl.lan>
Date:   Fri, 10 Jul 2020 11:50:08 -0700
In-Reply-To: <20200710022040.GB39052@syl.lan> (Taylor Blau's message of "Thu,
        9 Jul 2020 22:20:40 -0400")
Message-ID: <xmqq1rljurvj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EBAC3DE-C2DE-11EA-BAE7-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> To me too, although note that this will generate merge conflicts with
> Szeder's patch from earlier today[1].
>
> Unfortunately, the conflicts are a little deeper than "we both removed
> an unnecessary 'if' statement", since Szeder's patch moves the
> 'stop_progress()' call earlier to avoid a bug that I introduced.
>
> This is just something for Junio to look out for while queuing,

Actually that is something contributors learn to play better with
each other ;-)

Thanks for a heads-up.
