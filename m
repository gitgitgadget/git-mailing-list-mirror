Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC894C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 21:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901C1207DA
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 21:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O9Ct9eXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHRVGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:06:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55042 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgHRVGt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 17:06:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C13B57AAE6;
        Tue, 18 Aug 2020 17:06:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0PGzy2OVButuXQZxhl6o+xwVO7g=; b=O9Ct9e
        XtzzOCtaAHzwCYnFk98sbmxTPTGqiMPooD3Ej6F9Nkif0gJX+0iImmk1trg0MjTe
        1SW0HK25az3wc1LWrkOwzbbVtIKxwLQrqpStmJmH5+DP5MalgsZT8lWHFNlXXyqX
        Fnx+xpH6S8hQ2unEBWXKE0UaRtosKbAi0EeGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FctdAahaf7OWr6zTKdMayk6Q3cvMqRGf
        7sw9rsAJlZUXCePOH0IBaW9TmkzG5v8AQ4JkoAZVtYuUC/DryAnXSKDLRbmji1/o
        84VAVD57YGtOEl3z/7DRRzWR/o6vyXoFjdXz3O8mO+vjzDNLI8dw0QRG0osvXCTb
        RAvwG+O0dy8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B79647AAE5;
        Tue, 18 Aug 2020 17:06:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42C687AAE4;
        Tue, 18 Aug 2020 17:06:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 3/3] Treat REVERT_HEAD as a pseudo ref
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
        <173d81dbb41c3a7f4ab5187c1a056da182c4f6e5.1597753075.git.gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:06:45 -0700
In-Reply-To: <173d81dbb41c3a7f4ab5187c1a056da182c4f6e5.1597753075.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Tue, 18 Aug 2020
        12:17:55 +0000")
Message-ID: <xmqqo8n7wtne.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9924C9E-E196-11EA-9896-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---

This does what was advertised by the proposed log message in the
previous patch for REVERT_HEAD.  I see nothing questionable here.

Nice.
