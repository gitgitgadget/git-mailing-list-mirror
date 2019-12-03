Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0E1C432C3
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 15:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A502080A
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 15:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DSwZkdAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfLCPl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:41:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62511 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLCPl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 10:41:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A1D6B3466;
        Tue,  3 Dec 2019 10:41:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/t/xUoH72uTgg7ewxloeUfQon94=; b=DSwZkd
        AstS4F9zX2H1g8zrefBaIEgKaU7ARf7PMh57gLHTPDIhxJlkfMJmcny0wJBwvQjv
        laJ6ToCGpjAdMRCppAcApPQfrPk73i1eWwwallAsdS0vkwFOUErdqbHVvkRrwESx
        OFTdmN+qNnxdq56OkiPjVc+n+bmqfDOjt50Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r7b04nmOjZTBE5+XxWg5IJpRm/OSDmBm
        DpI8J324cI9aru714owIdByzfUpfsxsZu9bVxNvuHBV6yMIq6NAS9U6Q4Bt3etR6
        4jTeSEnOHeYU4jZEmD9e4JJqaNksC+jLo8cjpMnAGTgOnU3MExBY7lho3dBV2EMV
        /Sfb9MS4ecU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EE75B3465;
        Tue,  3 Dec 2019 10:41:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 53368B3464;
        Tue,  3 Dec 2019 10:41:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 22/26] t7700: consolidate code into test_no_missing_in_packs()
References: <cover.1574731022.git.liu.denton@gmail.com>
        <cover.1574884302.git.liu.denton@gmail.com>
        <a99a45cb6f2cc7328ef0e52fc2ea8fec537bfba9.1574884302.git.liu.denton@gmail.com>
        <xmqq7e3i4b1p.fsf@gitster-ct.c.googlers.com>
        <20191202205037.GA43606@generichostname>
        <xmqqo8wqwd9m.fsf@gitster-ct.c.googlers.com>
        <20191202232816.GA26892@generichostname>
Date:   Tue, 03 Dec 2019 07:41:19 -0800
In-Reply-To: <20191202232816.GA26892@generichostname> (Denton Liu's message of
        "Mon, 2 Dec 2019 15:28:16 -0800")
Message-ID: <xmqqblsp76xs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AD0208E-15E3-11EA-B473-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> Especially if it is near the end of the series, just a single step
>> is OK.  But is there anything that is glaringly wrong that needs a
>> reroll?  Or would it be "this is good enough, so let's have them
>> cook in 'next' and graduate to 'master'---further clean-up can be
>> done after all the dust settles"?  I have an impression that we
>> reached the latter by now.
>
> Perhaps the log message could use some improvement to document the
> discussion we had? I don't know if that's worth a reroll, though. Aside
> from that, I agree that it's ready for 'next'.

Sure, let's see what you have in mind.

Thanks for working on this.
