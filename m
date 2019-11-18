Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177EF1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 02:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfKRC1Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 21:27:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63221 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfKRC1X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 21:27:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6FDD8D7E9;
        Sun, 17 Nov 2019 21:27:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QhGdoe7R1qOyuXHeMXn9ytx9CRY=; b=hTGVMS
        K8YK635VCvZq5WI7aYtzjGUYHUROtrDo2+Id58WjMpCqi/VV7AkKKDehOCClDWB+
        QSb/tAZULzgnWwu90/oBKTPysOLF+o4vTpNur/DPSUMG6zYrCZ+rEfqPPEQMAW6w
        Ol7f29nJHGtFW90LxkeaMK6egKxVvB6s1sBfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K0hndEwYK1FxRLXb2TZ7IZPms43YSR1l
        lIDB4nlRntBRnJRWhsEQDHotuJEWjcbK38GSRqrkVXI618jb2SPEWsSswr1QXMjZ
        pss7zMwz4u1z5U89n5uB8mfgh9fY5WtEv3js5JgW14QuvrZaWGrV/BbwkmmVm/lh
        0a7dy45W58o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE4BF8D7E8;
        Sun, 17 Nov 2019 21:27:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 014698D7E7;
        Sun, 17 Nov 2019 21:27:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/8] build-in add -i: implement all commands in the main loop
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
Date:   Mon, 18 Nov 2019 11:27:16 +0900
In-Reply-To: <pull.171.git.1573821382.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 15 Nov 2019 12:36:14
        +0000")
Message-ID: <xmqqlfsd3omz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F192180A-09AA-11EA-BE56-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> ... there is so little overlap between the git add --patch part
> and the rest of git add --interactive that I could put the former
> into a totally different file: add-patch.c.

We would want to call, after "add -i in C" stabilizes, directly into
"add -p" machinery from different subcommands such as "reset",
"checkout", etc., and bypass the rest of "add -i" when we do so.  We
can credit the lack of overlap to the design that supports such
usage while it is still in a scripted Porcelain.

Preparing the "add -p" machinery in such a way that "add -i" merely
is one of the users would make a lot of sense from organizational
point of view.

Thanks.
