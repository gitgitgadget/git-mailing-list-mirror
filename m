Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11205C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD354610A5
	for <git@archiver.kernel.org>; Fri,  7 May 2021 05:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhEGF1E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 01:27:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53372 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEGF0U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 01:26:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14E1612E942;
        Fri,  7 May 2021 01:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x8wVVJh2RjVImotkFNnJs147sVtaMRwVsc/xT7
        IvIHI=; b=ASXT5kjEvhb6a/AHpymeBFUJuTzzSb9xaArq4DMvdIOcnDVu/iUf96
        SKvPLAQBLYd8+f1XzY1LwMbIi2+BZ5+8lJ+wfufDvKN9mINQgIxLdWlqal2li9Ae
        uSA5FNAnYk2/1xUQT2heXYMzi9ukeqXAmGTfes8L0vz1tvEagDGC8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0159E12E941;
        Fri,  7 May 2021 01:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2656312E940;
        Fri,  7 May 2021 01:25:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 1/8] compat/terminal: let prompt accept input from pipe
References: <20210506165102.123739-1-firminmartin24@gmail.com>
        <20210506165102.123739-2-firminmartin24@gmail.com>
        <xmqqr1ijwi0i.fsf@gitster.g>
        <YJTH+sTP/O5Nxtp9@coredump.intra.peff.net>
Date:   Fri, 07 May 2021 14:25:16 +0900
In-Reply-To: <YJTH+sTP/O5Nxtp9@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 7 May 2021 00:54:18 -0400")
Message-ID: <xmqq1rajw1xf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C41C152-AEF4-11EB-9B25-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> For testing, wouldn't lib-terminal.sh be usable for your purpose?
>> If not, what is the reason why it is insufficient?  Can we fix that
>> instead?
>
> That doesn't work, because it insists on reading from /dev/tty and not
> the pty that lib-terminal will set up as stdin. But...

I somehow thought that lib-terminal was a bit more complete in that
it would make the pty we allocate to the controlling terminal for
the process that runs the test program.  Sigh.
