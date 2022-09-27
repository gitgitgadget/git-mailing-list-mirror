Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA31C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiI0Qbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiI0QbU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:31:20 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AEADF98
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:31:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A18561ACC96;
        Tue, 27 Sep 2022 12:31:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EwymQVhx6SeIdGkLZKHwey93A20rzU0UZO8OVS
        j0zgg=; b=x68T6mOXwTBSbALUgdMErfLg1513Twe6VwinDXsOjPsWo4/a+J5eKv
        AX1G9+f/ycEHY6zMKehq5/CZ6Ti4BalWHyXo99OlyJ/DbtCppxglvJZgU7Qodp44
        nZ84jwuq5R6vJF5HgXEgpJPXDX+knDnFeLvEeb3tNFqnuZpJlWUqs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9917B1ACC95;
        Tue, 27 Sep 2022 12:31:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A708E1ACC90;
        Tue, 27 Sep 2022 12:31:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 0/4] scalar: make unregister idempotent
References: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
        <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 09:31:13 -0700
In-Reply-To: <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 27 Sep 2022 13:56:57
        +0000")
Message-ID: <xmqqtu4s7p9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE0CC2E0-3E81-11ED-9851-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I noticed this while we were updating the microsoft/git fork to include
> v2.38.0-rc0. I don't think 'git maintenance unregister' was idempotent
> before, but instead some change in 'scalar unregister' led to it relying on
> the return code of 'git maintenance unregister'. Our functional tests expect
> 'scalar unregister' to be idempotent, and I think that's a good pattern for
> 'git maintenance unregister', so I'm fixing it at that layer.
>
> Despite finding this during the 2.38.0-rc0 integration, this isn't critical
> to the release.
>
> Perhaps an argument could be made that "failure means it wasn't registered
> before", but I think that isn't terribly helpful.

I happen _not_ to share the idea that "unregister is expected to be
idempotent" is a good pattern at all, and it is a better pattern to
make failure mean that the object specified to be acted upon did not
even exist (cf. "rm no-such-file").  But that aside, does what the
above paragraphs mention still true for this round, namely, you are
"fixing" it at that (i.e. "maintenance unregister") layer?

The cover letter does not become part of the permanent history, so
it is not a huge deal as long as the reviewers know what they are
looking at ;-).  Just leaving a note in case somebody who missed the
iterations up to v3 is now interested in the topic.

Thanks for a quick iteration.
