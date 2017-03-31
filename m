Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8E921FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 19:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754387AbdCaTfa (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 15:35:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52479 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753986AbdCaTf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 15:35:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 925F97D656;
        Fri, 31 Mar 2017 15:35:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FL9p0CjfvXC1mIo9NtLvSo0pg9o=; b=rUP+iH
        +WTMza94VcWG4zIsVEF9BPlx5EueMcmThNYFFlURjuW/vuGQ1DmHCAElqqTzJeTq
        OpKdgEicZP94RAUY6Hva+DAec4bbO0QBYY27PbeN4qg/UKpTCVgvOj3216yJEJmi
        LUTW51R/4djvRyRikiuUbTChCDLLqmsuf5dhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cgMs9kWoTEjYa3gZh/P94YqKmY7c9jjQ
        ljByjqm2l8yjq5XnzubAETL2T/uct4APW1Cr8vwA7MwVXtf8YlVx/vHHusv6z5GE
        ugiEnuTOVwhC7DXMITILp9zL4IaqCMA00WFtBHkBCulNIoaROwWdMvHc2+kZ8qKe
        voTFCEBB+4U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A7597D655;
        Fri, 31 Mar 2017 15:35:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D16597D64D;
        Fri, 31 Mar 2017 15:35:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net, kewill@microsoft.com,
        Kevin Willford <kewillf@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] name-hash: fix buffer overrun
References: <20170331173214.47514-1-git@jeffhostetler.com>
        <20170331173214.47514-2-git@jeffhostetler.com>
Date:   Fri, 31 Mar 2017 12:35:21 -0700
In-Reply-To: <20170331173214.47514-2-git@jeffhostetler.com>
        (git@jeffhostetler.com's message of "Fri, 31 Mar 2017 17:32:14 +0000")
Message-ID: <xmqqo9whxmrq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EA96408-1649-11E7-AB6A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:

> From: Kevin Willford <kewillf@microsoft.com>
>
> Add check for the end of the entries for the thread partition.
> Add test for lazy init name hash with specific directory structure
>
> The lazy init hash name was causing a buffer overflow when the last
> entry in the index was multiple folder deep with parent folders that
> did not have any files in them.
>
> This adds a test for the boundary condition of the thread partitions
> with the folder structure that was triggering the buffer overflow.
>
> The fix was to check if it is the last entry for the thread partition
> in the handle_range_dir and not try to use the next entry in the cache.
>
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>
> ---

Will queue with ...

>  name-hash.c                             |  4 +++-
>  t/t3008-ls-files-lazy-init-name-hash.sh | 19 +++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>  create mode 100644 t/t3008-ls-files-lazy-init-name-hash.sh

... this thing fixed by "chmod +x" (otherwise the tests won't start).

Thanks.
