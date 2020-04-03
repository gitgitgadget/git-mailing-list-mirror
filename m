Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0870C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 17:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360292080C
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 17:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HFUP7tnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgDCRfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:35:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54514 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgDCRfs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 13:35:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D93E4A2B2;
        Fri,  3 Apr 2020 13:35:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kQMNzl8aQrCr4UqmMAAalJ/pC9g=; b=HFUP7t
        njmL2fmSvh7OFhfQDrfD1TJ6s5g8PWYhpIN+DNSfNyFis48TxxGLCMrxt2aaZ8Wm
        l3H7NCv+9MnVaMSBAkbhllpz77sTIP54y0teLR3Jos4SyyNuwBQ7/tPCuoh0kQsb
        gxblRpAUNRLAh8TEsfITvVfAGDWJL45NgFV/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ax+Av0lyp7t1UxO5Gv5zgZ4L7Jqa4wHg
        g2oUieIC9KK8KNgOpohLc/ai4/0b1ZhU6ukUp41QMVqF9Uo8SLA1Yt3+FUi1uL7r
        fWnQZb7CG8daLcL4KxgnUIK9O5z3ceI+HfFlmehUo7Vao+VataI8wLpiSYhfGCwe
        1/dPMIuE2Oc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25AF44A2B1;
        Fri,  3 Apr 2020 13:35:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A801C4A2B0;
        Fri,  3 Apr 2020 13:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 9/9] update-ref: implement interactive transaction handling
References: <cover.1585129842.git.ps@pks.im> <cover.1585811013.git.ps@pks.im>
        <5670bea2b15bafbd93d7d507b35e54980ad06fb9.1585811014.git.ps@pks.im>
        <fd4b874a-478f-2139-e910-c000b8a1f396@gmail.com>
        <xmqqa73s1njt.fsf@gitster.c.googlers.com>
Date:   Fri, 03 Apr 2020 10:35:45 -0700
In-Reply-To: <xmqqa73s1njt.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 03 Apr 2020 10:33:58 -0700")
Message-ID: <xmqq5zeg1ngu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CADA51A-75D1-11EA-A7FA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ... but I am not so sure about the actual
> implementation in this topic ...

I take this part back---given that this is merely building on top of
the existing atomic update, we should be OK.
