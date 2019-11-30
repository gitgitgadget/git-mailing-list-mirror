Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DB7C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 22:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737702082E
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 22:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OCH6DIMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfK3WJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:09:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58488 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfK3WJe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 17:09:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA7A08C091;
        Sat, 30 Nov 2019 17:09:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7gohZB1nGgrz6uyUzdAS/tJGTd8=; b=OCH6DI
        MRVxXAZnqxVXqY9k6IGKiLAQSG2Vj+XVBJQhJotNAw85qyEx/k36yz9+Kc531ttq
        Hm9YV504n9XkXJJkayJyaSYiEt8qlr6EMmqHf5aQwuy6/5W3PKCtznThGoIVPEYp
        mcLJTso+ttyf6G6L+Ka7gU3M+4pLJmcL9hZvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bZBsl4nEQW0AfFpl5CUrj+Vzk8EUssbC
        5jNc+cmZb1UBzwJpPK6avP+PGTUraN/Rd+PAYEZ2mQH4gyXJV3SmDnJl2h1c/Orl
        q6lVSB/PxRNN2dYtHoFj2bmljiMMhfokELukICUQ+LwNA4fJU1i6Ah5Y+gOySHBM
        Rik0WtGk1fY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C19458C08F;
        Sat, 30 Nov 2019 17:09:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DB9798C08A;
        Sat, 30 Nov 2019 17:09:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of js/mingw-inherit-only-std-handles
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
        <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
        <7a88a80d-76db-3ca5-c5e1-134b82b5bcbf@kdbg.org>
Date:   Sat, 30 Nov 2019 14:09:28 -0800
In-Reply-To: <7a88a80d-76db-3ca5-c5e1-134b82b5bcbf@kdbg.org> (Johannes Sixt's
        message of "Sat, 30 Nov 2019 20:20:11 +0100")
Message-ID: <xmqqk17h10fb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 153B9D4A-13BE-11EA-B93F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> This series fixes the observed failure. The changes look good. Thank you
> for the quick turn-around.
>
> Tested-by: Johannes Sixt <j6t@kdbg.org>

Thanks, both.
