Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24923C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A48F60F5C
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhJHRNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 13:13:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51937 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhJHRNL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 13:13:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F3F714ADFE;
        Fri,  8 Oct 2021 13:11:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ApU0MSa0DGFSysMd7yHEV8CAlbb7/JVxUOil/
        WrCt4=; b=IXk5BlLI7qundpy2cFWVCtc/0SZmi1sgSMyCVrqL7/1UxCGvg6XIQ0
        pIArZm0X8HWXwofTa3oYSOU6WDa/j8Tn0kVXqBMwXiCMzUlDE1k99fge/XdkC/rx
        rdoI7EROEg3LUTudnXQx0wZpCMqxVnQwhj4R4h+GWB5NFKfUjZwag=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 96A0214ADFC;
        Fri,  8 Oct 2021 13:11:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F3AB014ADFA;
        Fri,  8 Oct 2021 13:11:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 2/7] update-index: add --force-full-index option for
 expand/collapse test
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <f7cb9013d46731855c3ed42add62b021c0ad0c73.1633440057.git.gitgitgadget@gmail.com>
        <CABPp-BHD3khX+q7crk4JnNbGd9fN-vJW0L1x=5JdzkFL6X1BBg@mail.gmail.com>
        <3cfa0810-4449-1170-1f7b-cd029e5ce434@github.com>
        <CABPp-BF+bEUcyE0N79uRCkpCayJx_NMqOpnMSHHrpJM5a9hAWw@mail.gmail.com>
Date:   Fri, 08 Oct 2021 10:11:11 -0700
In-Reply-To: <CABPp-BF+bEUcyE0N79uRCkpCayJx_NMqOpnMSHHrpJM5a9hAWw@mail.gmail.com>
        (Elijah Newren's message of "Thu, 7 Oct 2021 20:42:21 -0700")
Message-ID: <xmqqmtnjl9w0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD53042A-285A-11EC-8B29-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I see the issue of introducing a test-only option (when sparse index is
>> integrated everywhere, shouldn't it be deprecated?). If there's a way to
>> make this more obviously internal/temporary, I'm happy to modify it. Or, if
>> semi-frequent updates of the command in the test aren't a huge issue, I can
>> revert to V1.
>
> If it's a test-only capability you need, I'd say add it under
> t/helpers/ somewhere, either a new flag for an existing subcommand of
> test-tool, or a new subcommand for test-tool.

Is the ability to force expanding to full index completely useless
in the field?  For diagnosing breakage the end-users may see in the
wild, or perhaps in a specialist usecase for whatever reason working
on full index is preferable and the user may want to force it once
to correct an earlier mistake to enable sparse-index before toggling
the configuration off, or something?

If we do not foresee any such reason, I'd agree it is good to move
that to t/helpers/; otherwise, I think update-index is as good as
any other place, and the option will sit well next to other options
like "--[no-]skip-worktree", "--[no-]assume-unchanged".  It would
most likely need to be used together with "--force-write-index" (or
be made to imply the latter) to be useful, I suspect.

Thanks.
