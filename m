Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741A2C1975A
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 01:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D21420716
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 01:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jhKBd1Xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCMBOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:14:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58443 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgCMBOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 21:14:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 958F83E9DE;
        Thu, 12 Mar 2020 21:14:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t7bswDDqt2GhOj3/0Qe9U17q3zM=; b=jhKBd1
        XeunoT5BScPJHeiZDTvwRN701cV2HqrYXhQ+HkWeJQTirELe/YRt9twwE3lsJx4z
        skmh6102/dQEXQI2RVVxn+3Tpk0pa51Cl50ZDkzYW4id1ORuRLUxGnlHEZ4s/pbw
        2Ur+2c4nPSpz9R++P/S9DnrBODy4eDYYKF+Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TmBjfCv7kEp6Y97xYNn1qxji/e9EPjG/
        lo1A7ClqVOJHpwCHeegg8ylVIlcRzNCqBg7GRID1sP4ytOUvkbOaB/zYYq9OjIZG
        WrbHVnbaZSJKr1gsMu8tfy/NPjAbrYjUMMvbpeNtd0+0m/+d/8gamUeipV8fzcxb
        euhuUWuJYfg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D2853E9DD;
        Thu, 12 Mar 2020 21:14:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 102FD3E9DC;
        Thu, 12 Mar 2020 21:14:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com
Subject: Re: [PATCH] connected.c: reprepare packs for corner cases
References: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
        <xmqqzhcle23x.fsf@gitster.c.googlers.com>
        <20200312211638.GA872402@coredump.intra.peff.net>
        <20200312212613.GB872402@coredump.intra.peff.net>
        <7378a863-7e2a-455e-4635-e07938ef3381@gmail.com>
Date:   Thu, 12 Mar 2020 18:14:48 -0700
In-Reply-To: <7378a863-7e2a-455e-4635-e07938ef3381@gmail.com> (Derrick
        Stolee's message of "Thu, 12 Mar 2020 20:54:34 -0400")
Message-ID: <xmqq36addpiv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08B99940-64C8-11EA-BD1E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I wonder if we could do something more complicated in the long-term,
> which was recommended to me by Jeff Hostetler: add the pack to the
> packed_git list once we've indexed it. That way, we don't reprepare
> and scan the packs one-by-one, but instead we insert to the list
> a single pack that we already know about.

Yup, that was the first thing that came to my mind, i.e. the code
that installs a new packfile on disk in our repository must be ours,
so we should be able to tell that code to add the new packfile to
the in-core list without having to scan.

We may still need to scan when that strategy "fails" to protect
against racing with simultaneous repacking, though.
