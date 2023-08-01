Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6047DC0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 19:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjHATbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 15:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjHATbo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 15:31:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03222103
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 12:31:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AB1C2229E;
        Tue,  1 Aug 2023 15:31:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9OWyPBufV2iZXb/VDs/MbXcQjquWDe0NTpobIV
        eM2BE=; b=E5TXRiR02SXhmTVqIQFh0lY0x2gbGMGeBjZqa/9Ilf1UNjNuqaqYXL
        5PAAOkKIGRfpHUcA/LOceXRUc1ko+rIbVFMnh6dw2aPNcK5zFwLRxysbBIrsIv+J
        t9j2/9y478ePvs/qvW6+SpLM0ZZeBLBhqvR5GNA54jXnbtSZUnGAQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 61F582229D;
        Tue,  1 Aug 2023 15:31:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0027E2229C;
        Tue,  1 Aug 2023 15:31:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 1/7] rebase -i: move unlink() calls
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <1ab1ad2ef07687c25c1d346b5b7b26f38bafe5b9.1690903412.git.gitgitgadget@gmail.com>
        <xmqqa5vad6ea.fsf@gitster.g>
        <48fefaf0-6a31-0518-3424-73d93343f1d8@gmail.com>
Date:   Tue, 01 Aug 2023 12:31:38 -0700
In-Reply-To: <48fefaf0-6a31-0518-3424-73d93343f1d8@gmail.com> (Phillip Wood's
        message of "Tue, 1 Aug 2023 19:42:15 +0100")
Message-ID: <xmqq7cqeblut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09AC8BF6-30A2-11EE-B6D0-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> The files will never exist when the "if TODO_BREAK" is executed
> because we've removed them before entering the loop and as I tried and
> seemly failed to explain in the commit message they are only created
> when we're about to break out of the loop.

Specifically, they are not created when we voluntarily leave the
loop via TODO_BREAK.  They are created when we leave the loop via
the other exit paths (e.g. path_message may be created from MERGE_MSG
in error_with_patch() but the control flow to reach error_with_patch()
in the loop would break out of the loop without ever reaching the
TODO_BREAK codepath).

Or something like that?  I didn't follow thru the other two files.

OK.  I am slow to read and understand a patch from more than 3
months ago X-<; sorry for the confusion.

Thanks.



