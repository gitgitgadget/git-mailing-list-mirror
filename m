Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAB1C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 19:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CAC20775
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 19:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MlcmxnxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgCUTl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 15:41:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52141 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgCUTl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 15:41:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6BFC517A2;
        Sat, 21 Mar 2020 15:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jtCoORM1ZUFxlid7zyzzSIgEnYs=; b=Mlcmxn
        xJNrL/n3W2wh4Z7ePKQA2JokmCko4Mw4eaefYoG5081olxmMNo4QUWFHMvE/+drE
        50OVq1T9TM/org7fb6HF30QzBKJJjCw99+fwHgjgRB8hD5a1LOxvv4lD5UbLcNDb
        pz2T2W+wYDLgzaWO9eKt1xKMmsnz4zjqEvaaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V9uEK2VVA0eZO++VvKeKmwrU8tyEQ274
        V0eKQHYP0eSGL2Ob9pmTxWhux2ZoCBRwpJEj4hzTmG1udrZoCmhDEaho9xfF3QIo
        EN85HodklpnC47NGMKODGeneyuvWXmDOEWHLfw2xhuUVxnVaMf86zlbL/0MQ9XoP
        M1oI55ozcIQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE2CD517A1;
        Sat, 21 Mar 2020 15:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D6D2517A0;
        Sat, 21 Mar 2020 15:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jnareb@gmail.com,
        christian.couder@gmail.com
Subject: Re: [RFC]rev-parse: rev-parse.h does not exist for rev-parse.c
References: <20200321183545.GA17453@konoha>
Date:   Sat, 21 Mar 2020 12:41:56 -0700
In-Reply-To: <20200321183545.GA17453@konoha> (Shourya Shukla's message of
        "Sun, 22 Mar 2020 00:05:45 +0530")
Message-ID: <xmqqy2rt8ph7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 065A4790-6BAC-11EA-813F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> using 'argv_array_pushl()', I thought maybe I could call 'rev-parse.h'
> and use the 'cmd_rev_parse()' function directly.

Never call cmd_foo() from within your program for any value of
foo(), as it is not part of the approved API.  cmd_foo() is meant to
be the entry point of "run once and exit" function, it is not just
allowed but is expected to exit, and it also will do the in-core
repository setup etc.
