Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EED0C43142
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08721206A1
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbhAZWE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:04:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50502 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388257AbhAZUQe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 15:16:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FEB31153AE;
        Tue, 26 Jan 2021 15:15:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JjhPkAzuiGI0nzKlat70+1QDD2c=; b=u4Z3Hj
        YC3qAw0RDBHiMPwGc9fXtCexctnVq/N6eYrRLL3G/JMZ4r5QpbJSCSaNI6VH0/vb
        LgtY0ocMODOHFezXNRO6WhZ6kb81j4ubnqNp8OTZccnQsFfwss+2A04cW3dOnZ7u
        eCqgFjMYs1GWgk4Bt6fHl7ARA0HWW9FfHqqsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uh/wEv+u7zTzG6inhaLuv9ZrutXnSbL6
        AqmOF7eSIREmd6RCu4cS5CoWNSNtO6BIrMTG7/BF0ke4hMVNq4JF3Ac0DFtXOYIi
        413XpnDiVQPcnpb6tYwar3dOY5kfXkuAnF+wRHEcCZI8XQpPljIUbveA5dA9LEEK
        zrKkdmVFzXw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98BC01153AD;
        Tue, 26 Jan 2021 15:15:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DEFFE1153AB;
        Tue, 26 Jan 2021 15:15:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?6Zi/5b6354OI?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?6Zi/5b6354OI?= <adlternative@gmail.com>
Subject: Re: [PATCH] strbuf.c: optimize program logic
References: <pull.846.git.1611637582625.gitgitgadget@gmail.com>
        <xmqqy2gg2pdm.fsf@gitster.c.googlers.com>
        <YBBeLIhd+VHS25CE@coredump.intra.peff.net>
Date:   Tue, 26 Jan 2021 12:15:48 -0800
In-Reply-To: <YBBeLIhd+VHS25CE@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 26 Jan 2021 13:23:40 -0500")
Message-ID: <xmqqft2n1mkr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 485798A8-6013-11EB-B372-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> PS The original patch does not seem to have made it to the list for some
>    reason (I didn't get a copy, and neither did lore.kernel.org).

Yes, it seems today's one of these days where vger is hiccuping.  I
see out of order deliveries of responses to messages I've yet to
see.
