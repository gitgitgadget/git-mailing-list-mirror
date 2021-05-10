Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AD0C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4D161430
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhEJFCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 01:02:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58683 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhEJFCE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 01:02:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A9D1140D73;
        Mon, 10 May 2021 01:01:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MlwRAtb5mIkifDNBr7snfcl1mmhCJGVf8XsoXU
        rqIDo=; b=ebBXx0gBgPyJCPVAfx5Byu0G1A4rXg5lpr3+Lvlj0P/cPC3lRYLQR1
        r4P2PtxZ90gb0di0JZT0qPfzgnBxVzOx9/EMARuVMk0jGFtTTtBXWoQY6GcIwlL0
        jo9+2ZVkoUO5NPcLeWSkMNSzjHRK24Q6/0aTDinZMdpfGpebMjMqU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62145140D72;
        Mon, 10 May 2021 01:01:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4BBE5140D71;
        Mon, 10 May 2021 01:00:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 2/8] [RFC] dir: report number of visited directories
 and paths with trace2
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <8b511f228af8e047d8b38159da658b10174c40e8.1620503945.git.gitgitgadget@gmail.com>
Date:   Mon, 10 May 2021 14:00:54 +0900
In-Reply-To: <8b511f228af8e047d8b38159da658b10174c40e8.1620503945.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 08 May 2021
        19:58:58 +0000")
Message-ID: <xmqqfsyvrxmh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B42A6F8A-B14C-11EB-B5A7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Provide more statistics in trace2 output that include the number of
> directories and total paths visited by the directory traversal logic.
> Subsequent patches will take advantage of this to ensure we do not
> unnecessarily traverse into ignored directories.

And this change is the reason behind how the call to the trace
statistics helper is now outside the "if (untracked)" block after
patch 1/8; makes sense to me.

