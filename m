Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F54C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 20:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D5160FED
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 20:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhINUfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:35:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52068 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhINUfA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 16:35:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CB55DEB44;
        Tue, 14 Sep 2021 16:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zo202rIkAP09jUcWP6k54rfOMz/SrXEgW2BLGe
        C6bgI=; b=xwmAoPEv0uVXXF6IgJtGFjvZnzaMWSh/lKVBIKqhJNgA4xFclARAtN
        Ct11UlGasbO69ruQD9JlWSRnNLFzHfFFPqq6jXNX4DF84ewgbMjEIP5BO7iSUWq/
        mbn7sHssQrXiVZTx9UBZTfcNw0QAWIID8Wv4EtRifRkpEJWQK9oLE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 335FCDEB43;
        Tue, 14 Sep 2021 16:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DC2ADEB42;
        Tue, 14 Sep 2021 16:33:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 2/6] core.fsyncobjectfiles: batched disk flushes
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
        <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
        <f8b5b709e9edc363b2de7d4afa443deec0120ca0.1631590725.git.gitgitgadget@gmail.com>
        <xmqqfsu70x58.fsf@gitster.g>
Date:   Tue, 14 Sep 2021 13:33:40 -0700
In-Reply-To: <xmqqfsu70x58.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        14 Sep 2021 12:34:11 -0700")
Message-ID: <xmqqr1dqzyl7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C88B684-159B-11EC-A347-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps
>
> 	if (value && !strcmp(value, "batch"))
> 		fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
> 	else if (git_config_bool(var, value))
> 		fsync_object_files = FSYNC_OBJECT_FILES_ON;
> 	else
> 		fsync_object_files = FSYNC_OBJECT_FILES_OFF;

By the way, in case it wasn't clear, I do mean strcmp and not
strcasecmp.  Making these things that are meant to be machine
readable tokens to be spelled in different ways in the name of
"friendliness" is a disease.

Thanks.
