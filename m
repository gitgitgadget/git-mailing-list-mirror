Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8375C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 16:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A98B61975
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 16:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhGEQxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 12:53:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51199 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGEQxc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 12:53:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22248C4F23;
        Mon,  5 Jul 2021 12:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RB8y7236edSTp1ZrRearn+0xj0G4jt8eVNyItQ
        spifM=; b=qxjilcFCXeQALBHdnDoJC+OZQSbAhAlB3DYgU/I0OxxP/i9NlfG+VB
        oxiLhuGTtQzOpy1yRo45hql9ROJ9meElGUlPCh3mJ7O42h3vFsyblcby3xpxTO7p
        rpApPNNf/uP1RfmWgsmH/aW4tLP6aW4gMJX1Vk8B0+pLhD/ZBIRxo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A04DC4F22;
        Mon,  5 Jul 2021 12:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0374C4F21;
        Mon,  5 Jul 2021 12:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        newren@gmail.com
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
        <349748b4-3c48-7ca7-eb0f-e859a15cab0f@gmail.com>
        <7ee36923-0806-4316-729c-8418df5b6555@gmail.com>
Date:   Mon, 05 Jul 2021 09:50:54 -0700
In-Reply-To: <7ee36923-0806-4316-729c-8418df5b6555@gmail.com> (Phillip Wood's
        message of "Mon, 5 Jul 2021 16:29:20 +0100")
Message-ID: <xmqqpmvwn1qp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29E433EC-DDB1-11EB-B616-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Looking at origin/seen:builtin/pull.c we already check if we can
> fast-forward and unconditionally merge in that case irrespective of
> any '--rebase' option or pull.rebase config. It should be simple for
> pull to error out if '--ff-only' is given and we cannot fast-forward.

Excellent.

Even though teaching even more special case on the "git pull" side
makes me feel somewhat dirty, but I think it would be a small price
to pay, and the end result would save an useless fork whose sole
purpose is to make the integration step after fetch fail when "pull"
can easily tell, as you said, that it ought to fail, so overall it
would probably be a net win.

Thanks.
