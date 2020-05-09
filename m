Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B63C28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6AC21775
	for <git@archiver.kernel.org>; Sat,  9 May 2020 16:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U+ufNX5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEIQ2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 12:28:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58421 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgEIQ2M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 12:28:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F5D7553BE;
        Sat,  9 May 2020 12:28:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/0X9iH/b7xpCYH8t6LCs176VjYI=; b=U+ufNX
        5awiC7rysA8T+ng8tsmpMF6qI6RjAVlLozy8sTFDf3eXoNI51zHvkbevkGD++oKp
        4AHtuVTk5CypxEb+hc+Thm8KQDWyG5AkyqBEpVl0u4+ySRCVyQYSfrhN7Q0+iK5z
        M7GmFSrpE6FrOJfY4/1+P7O34pIdCndrhsA60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZQNgkLMZSwjhyfrnVRuNrr2I/JDkJJHX
        gNkFF+fmGauJiJXu2v3C4LBQrjZDwHR2hLH/8aNJ098WzPSoHagO51++QvZLHEks
        VoCKe1shoLS4yjMhnqqy0jejy2UHaEXe/2gfBm+b63fw070pWSSjysc/oJdbJYNT
        Bt1F5BRzmAU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06C54553BD;
        Sat,  9 May 2020 12:28:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53FFD553BC;
        Sat,  9 May 2020 12:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Christopher Warrington \(CHRISTOPHER\)" 
        <Christopher.Warrington@microsoft.com>
Cc:     Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Christopher Warrington via GitGitGadget 
        <gitgitgadget@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [EXTERNAL] Re: [PATCH] bisect: fix replay of CRLF logs
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
        <20200507222510.GA42822@coredump.intra.peff.net>
        <xmqq5zd72vjp.fsf@gitster.c.googlers.com>
        <20200508130831.GB631018@coredump.intra.peff.net>
        <xmqqh7wq1n52.fsf@gitster.c.googlers.com>
        <xmqq8si2z8zb.fsf@gitster.c.googlers.com>
        <SN6PR00MB044634979E0EA55CCAAF8B469BA20@SN6PR00MB0446.namprd00.prod.outlook.com>
Date:   Sat, 09 May 2020 09:28:08 -0700
In-Reply-To: <SN6PR00MB044634979E0EA55CCAAF8B469BA20@SN6PR00MB0446.namprd00.prod.outlook.com>
        (Christopher Warrington's message of "Fri, 8 May 2020 22:59:19 +0000")
Message-ID: <xmqqblmxvzs7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11C83C5E-9212-11EA-861D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Christopher Warrington (CHRISTOPHER)"
<Christopher.Warrington@microsoft.com> writes:

> This approach is much cleaner. Thank you, Eric, Junio, and Peff.
>
> I can confirm 6c722cbe5a (bisect: allow CRLF line endings in "git bisect
> replay" input, 2020-05-07) works on a CRLFed bisect log when I apply it to
> git version 2.26.2.windows.1.

Thanks.
