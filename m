Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8469CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6416360FC3
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhJRRMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:12:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51519 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbhJRRMB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 13:12:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A535F0736;
        Mon, 18 Oct 2021 13:09:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WZtib9zQH7mbMjLwTOtRY99Ph7kOtBldkslj8c
        LLTEU=; b=VJYhyuLiAHPTab3DU9DAtIAaszvP3NtfJ7lEsiwBsvOpjMa00uSlPw
        BPD/4SgEsdnrCH0YCvujmAflgAB2sCdQa1mbXvGlIq56FXJZ5p7ZwnQMw7aj94Xb
        JVBk9XZidwUMjJfPrlfUjbBMJHWdNc2qcnlD3uGctu3GwUYQaWYog=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91DFDF0735;
        Mon, 18 Oct 2021 13:09:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2E08F0732;
        Mon, 18 Oct 2021 13:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] Documentation: specify base point when generating
 MyFirstContribution patchset
References: <20211018124106.542050-1-bagasdotme@gmail.com>
Date:   Mon, 18 Oct 2021 10:09:46 -0700
In-Reply-To: <20211018124106.542050-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Mon, 18 Oct 2021 19:41:06 +0700")
Message-ID: <xmqqzgr6w97p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32CAC23C-3036-11EC-ADD1-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Specifying base point (commit hash) can help reviewers and testers
> interested on the patchset. Mention how to record it with `--base`
> option to `format-patch`.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes since v3 [1]:
>      - rewording (suggested by Glen)
>
>  I don't apply Junio's suggestion that use `--base=auto`, because in
>  most cases invocations of the option requires full hash of base object
>  and AFAIK people just do `git checkout -b` without specifying the
>  tracking option (`-t`).

That's actually quite sad, if it were true.

Our home, when we added "end-user/newbie friendly features" to
"checkout" (credit goes to Dscho, IIRC), was actually most new
people would not even have to say "-b" in the simplest tasks
(instead they rely on "git checkout foo" gets turned into "git
checkout -t -b foo origin/foo" by DWIMmery) and the fact that
branch.autoSetupMerge defaulting to 'true' so that they get the @{u}
and --base=auto support without even saying "-t" (as long as they do
not explicitly decline with "--no-track" from the command line, that
is).

> -$ git format-patch --cover-letter -o psuh/ master..psuh
> +$ git show -s --format="%H" master

I said this is not good in my previous response already and told you
to teach merge-base, if we were not to use the --base=auto, didn't I?

The range given to format-patch, i.e. master..psuh, would be the
correct range of commits to format, as long as you didn't rewind the
local master branch.

But that does not mean master would always be the right base, does
it?  What if you had a work totally unrelated to the contents of
this tutorial on the 'master' front?  The person on the receiving
end may not even know what object it refers to until you pushed your
'master' branch out.
