Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78193C433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFDA2071A
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q88jmPbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgFNVhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:37:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63331 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNVhO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 17:37:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41662B9B8C;
        Sun, 14 Jun 2020 17:37:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UekCOL+/j6rudl5XcqfNpfrkfkw=; b=Q88jmP
        bXQflIkvKHzYBZE9ewDz8WoApp3xtlRDeR7nVaSU0W3EVb/wAAkFi2SjOLpV7HUM
        etKnaeahYiOhXNakomzBIfHClK/d9azbzlb3Dem05FuH8VxST8phiMmwIkkR6K9S
        E/gnSMniRMKZmBzJXnlUs3B7oD8Fauphmraws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L1MewnRQcEZHWG46P4HdyzCaPO+gOfiO
        NPYc/5MhUtLH9JP2hJ6cGbeYMI/14trEUKX0nV7OOczDV2d5asHMPHdCti08xeQx
        aIj6MncIS6m3FUd2/1Z/FUGQCez5vFCm37X7HsVJLDHuS7gHKRE+Xd5lM5ax9yr2
        8GPPd53/IP8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39B45B9B8B;
        Sun, 14 Jun 2020 17:37:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86B84B9B8A;
        Sun, 14 Jun 2020 17:37:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] checkout: teach --worktree
References: <d10cb03dd8ce00cb6033c61ff9b9b30bbf5f9c89.1592058281.git.liu.denton@gmail.com>
        <CAPig+cQ_G+N=mYqO+=7UaAYft27MhZ2_3v8=QzYpDn5hQySp+A@mail.gmail.com>
Date:   Sun, 14 Jun 2020 14:37:07 -0700
In-Reply-To: <CAPig+cQ_G+N=mYqO+=7UaAYft27MhZ2_3v8=QzYpDn5hQySp+A@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 13 Jun 2020 22:51:47 -0400")
Message-ID: <xmqqa715xrb0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 337A38F2-AE87-11EA-97C3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       When writing contents, only modify files in the worktree. Do not
>> +       modify the index. This option is essentially a no-op when used
>> +       without a `<tree-ish>`.
>
> Why a no-op rather than actually diagnosing that --worktree makes no
> sense in that case and erroring out?

Should it be a no-op?  If checking paths out of the index, with or
without the new --worktree option, the files in the working tree
will be affected and the contents in the index won't change.

