Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499261F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 10:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbeKNUYo (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 15:24:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58372 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeKNUYo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 15:24:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3CAC11E855;
        Wed, 14 Nov 2018 05:22:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IGkxNz/1/eFdSLaX2Z3xNf/UxGM=; b=iAQh12
        ef6uguSvF5pAifNxVy/rG+UNmxMw+8kuW/M9WA3h5iZzjtmaGbx6czZEDtAbWU1w
        ZoG/daxaGZHpbcK9QhaRmvxeLwMy+T9yzNYelIaIEqNZG/W2nfu1WDCLGrPrl7Ef
        hJFYtzGG8wskkaN+IjUPeMUHhC+dZpxaXLQmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eiHESGE+gOlaxbkWEk9Je4DEAM0VpnKe
        WhQqyKD2OMjy8RHhKAEEyrbLXPfZy7POwNz84ji4vSTwRtfO0GDONcmZqgOA2vkD
        cUa0+Gu9TmIWfNjYPopB+pNCigajw4djZ9JjYigsqNmd4+bFMSBmS5jIBpNlbzKa
        6WJWL/xMKzs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BE5711E854;
        Wed, 14 Nov 2018 05:22:04 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F60B11E853;
        Wed, 14 Nov 2018 05:22:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/1] Advertise multiple supported proto versions
References: <cover.1542059029.git.steadmon@google.com>
        <cover.1542162201.git.steadmon@google.com>
Date:   Wed, 14 Nov 2018 19:22:03 +0900
In-Reply-To: <cover.1542162201.git.steadmon@google.com> (Josh Steadmon's
        message of "Tue, 13 Nov 2018 18:30:09 -0800")
Message-ID: <xmqqin10m01g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 218ED2CC-E7F7-11E8-960A-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Fix several bugs identified in v3, clarify commit message, and clean up
> extern keyword in protocol.h.

It is good to descirbe the change relative to v3 here, which would
help those who are interested and reviewed v3.

To help those who missed the boat and v4 is their first encounter
with this series, having the description relative to v3 alone and
nothing else is not very friendly, though.

>     + diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
>     + --- a/builtin/upload-archive.c
>     + +++ b/builtin/upload-archive.c
>     +@@
>     + #include "builtin.h"
>     + #include "archive.h"
>     + #include "pkt-line.h"
>     ++#include "protocol.h"
>     + #include "sideband.h"
>     + #include "run-command.h"
>     + #include "argv-array.h"
>     +@@
>     + 	if (argc == 2 && !strcmp(argv[1], "-h"))
>     + 		usage(upload_archive_usage);
>     + 
>     ++	register_allowed_protocol_version(protocol_v0);
>     ++
>     + 	/*
>     + 	 * Set up sideband subprocess.
>     + 	 *

This one unfortunately seems to interact rather badly with your
js/remote-archive-v2 topic which is already in 'next', when this
topic is merged to 'pu', and my attempt to mechanically resolve
conflicts breaks t5000.


