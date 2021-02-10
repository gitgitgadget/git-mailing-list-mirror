Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2214FC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B881464E35
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhBJUGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:06:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52618 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhBJUGT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 15:06:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FC1A1059BA;
        Wed, 10 Feb 2021 15:05:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5x2V+AADJtfwpp63JvJczieCmnk=; b=fRJrUC
        eWuFzT3jI2dCcmcoYLRiNk3Z1DP8ZNcSl1w5CoXU7+6NdJlrhTmjcvJi1lJcOA1J
        MUrmrEL5jYf54Nzuq8baSqBGFFzM1e1/98OTHKnGEYoHLUCI3sNYOt6xqDbbN8XM
        F/sCHYTdE7vGx9HgeTqNtqmAQd9T91+iJcMnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lc/ggDKE1TmXZ590LFE2ukMEko3XbJ3U
        cPRlKrAw6Mhb5GZkILXN+imbrTtNWPx+/QFsASoua2vJxg0Elw8l1oiYtDnOo8lq
        +F3hkfuLE8TVIFQQIM/nwiGD1Q3KHnGd9xnT/epTzxS6SFpS50c8T7/YNRuDLVx1
        XwKFi9YqPdI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58EE31059B9;
        Wed, 10 Feb 2021 15:05:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CDB2F1059B8;
        Wed, 10 Feb 2021 15:05:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: Re: [PATCH v3] difftool.c: learn a new way start from specified file
References: <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com>
        <pull.870.v3.git.1612884654078.gitgitgadget@gmail.com>
        <xmqqeehp2jis.fsf@gitster.c.googlers.com>
        <CAOLTT8QbutZ2pHZ7Zg7vEJAy=d66YKP12rVW=RSJV+8fH6RRMw@mail.gmail.com>
        <xmqqk0rf3i07.fsf@gitster.c.googlers.com>
Date:   Wed, 10 Feb 2021 12:05:31 -0800
In-Reply-To: <xmqqk0rf3i07.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 10 Feb 2021 10:16:56 -0800")
Message-ID: <xmqqft233cz8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54BCB60E-6BDB-11EB-8D11-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So "difftool --start-at=<file>" can of use "diff --rotate-to=<file>"

sorry; s/can of/can of course/.
