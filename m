Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C6AC433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 03:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5ED61411
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 03:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhD2DRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 23:17:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50429 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhD2DRE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 23:17:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98B3F130DCD;
        Wed, 28 Apr 2021 23:16:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/G7FoBICi/ZQ1iiDK1nGk6UVtMtj8Obs4UATG2
        z/7rI=; b=hLU7Y16ffJriofQkhQJIGT7zmylpzEyChMZePA9FFlslT91m2WBTpA
        F+TDBBwdzd/5kWmOg1lRuHr+LCLICAU6El4DeVBrRFMu4Wz0hni/poetomn+gqQ2
        scsyrMj9A6S8sbIyCHdcMKdBVWODquslEK5YdR1WbQwe1Q967+amE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91E5A130DCC;
        Wed, 28 Apr 2021 23:16:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA6DB130DC9;
        Wed, 28 Apr 2021 23:16:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     dwh@linuxprogrammer.org
Cc:     git@vger.kernel.org
Subject: Re: pkt-line and LF terminated lines of data
References: <20210428222219.GA982@localhost>
Date:   Thu, 29 Apr 2021 12:16:14 +0900
In-Reply-To: <20210428222219.GA982@localhost> (dwh@linuxprogrammer.org's
        message of "Wed, 28 Apr 2021 15:22:19 -0700")
Message-ID: <xmqq1rataigx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4229BB72-A899-11EB-83D6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dwh@linuxprogrammer.org writes:

> What am I missing? What should be added to this documentation that gives
> more detail on when/why/how a pkt-line would be determined to be
> non-binary and the LF stripping would occur?

There is (unfortunately) none.  What payload each packet carries is
determined by the protocol, so a man-in-the-middle who is observing
a protocol exchange without any knowledge of the protocol that runs
on top of the pkt-line layer by definition would not be able to tell
which packet is binary (as it is unaware of what exchange is made).

