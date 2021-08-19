Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA86CC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BA960FE6
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhHSRK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:10:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64879 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhHSRK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 13:10:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98353136F73;
        Thu, 19 Aug 2021 13:10:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cEZHpY4mP+KbBksDjLQctP6bg0afHpLEgr1nGu
        LcEWE=; b=gon863u6KDAeX4wpcYJvOz3Q/4OqGA4s/YL7hw+8lBYOP9B7p9NoCA
        50Pjr4sYDuiAgnqMzRMbTfcKqGXQTcvDd1f34zBS5xDjeZd57kIUA/IlE5hdhE/I
        bUBpQPF72oXmKJm0dmwwyNKMP+g3HhWZ8vD7AiY22PjXEt6Y3DI9E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FEEF136F71;
        Thu, 19 Aug 2021 13:10:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8B0B9136F70;
        Thu, 19 Aug 2021 13:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v6] [GSOC] cherry-pick: use better advice message
References: <pull.1010.v5.git.1629075306706.gitgitgadget@gmail.com>
        <pull.1010.v6.git.1629352277151.gitgitgadget@gmail.com>
Date:   Thu, 19 Aug 2021 10:10:14 -0700
In-Reply-To: <pull.1010.v6.git.1629352277151.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Thu, 19 Aug 2021 05:51:16 +0000")
Message-ID: <xmqqlf4x2weh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53092444-0110-11EC-A4BD-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

>           Mentored-by: Christian Couder <christian.couder@gmail.com>
>      -    Mentored-by Hariom Verma <hariom18599@gmail.com>:
>      +    Mentored-by Hariom Verma <hariom18599@gmail.com>

I think you meant to move ':' not remove it.

> +		else if (opts->action == REPLAY_PICK)
> +			advise(_("Resolve all conflicts manually, mark them as resolved with\n"

Do we need to say "manually"?  Dropping the word would make the
message more concise.  Not repeating the word "resolve" by saying
something like "after resolving the conflicts, mark them with ..."
would probably be a much better phrasing, too.

> +				 "\"git add/rm <conflicted_files>\", then run\n"

<paths> (or <pathspec>) not <conflicted_files>; you can resolve many
files in a directory and give the pathspec to match the directory to
mark all the files in there as resolved.

> +				 "\"git cherry-pick --continue\".\n"
> +				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"

Inconsistent use of prose in the above and ": run" here.

        You can instead skip this commit with "git cherry-pick --skip"

> +		else if (opts->action == REPLAY_REVERT)

Likewise.

Thanks.
