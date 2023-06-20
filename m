Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E07EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 20:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjFTUrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjFTUrB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 16:47:01 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A56E6E
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 13:46:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 764BB18E398;
        Tue, 20 Jun 2023 16:46:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+cLq7DbPgd9ialB6Hx5tCjv8M/+uQdWth1Mz/B
        PwAuw=; b=aVuWQ/jM08PkLkNptJpoP4hw9JDOyueC4xO19pDqv3zOu1L7fi9MyO
        46zjvq+odpSsoSWCl5o4inHzMI0HEcFFgQhjZqqzvc/G1NtT+yjjruigVADzuNcy
        9uZfttuGGMpAAeh7QjOkgGy32Wyfunjzaw4BYSSThQjdC9H9wHNzU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A38718E397;
        Tue, 20 Jun 2023 16:46:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C245318E396;
        Tue, 20 Jun 2023 16:46:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nadav Goldstein <nadav.goldstein96@gmail.com>
Cc:     Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] Introduced force flag to the git stash clear
 subcommand.
References: <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
        <pull.1232.v3.git.1687219414844.gitgitgadget@gmail.com>
        <xmqqy1keodjj.fsf@gitster.g>
        <1540e884-08c7-922e-1fd9-65616268c1c9@gmail.com>
Date:   Tue, 20 Jun 2023 13:46:54 -0700
In-Reply-To: <1540e884-08c7-922e-1fd9-65616268c1c9@gmail.com> (Nadav
        Goldstein's message of "Tue, 20 Jun 2023 22:54:53 +0300")
Message-ID: <xmqqpm5plv41.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97F2C244-0FAB-11EE-B75E-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nadav Goldstein <nadav.goldstein96@gmail.com> writes:

> I see, but isn't the same argument apply for git clean? if not adding
> the force flag, the same message as I wrote appear in git clean (I
> copied it from there), and it will exit without any other information,
> hence given your argument, running git clean is also not very useful.

The thing is that "git clean" by default forces people to choose
between "-f" and "-n" to force people to understand the issue.  And
once they understand the issue, they'd learn to run "clean -n"
first, which lets them see what would be removed, before they run
"clean -f".  Does your "stash clear" work the same way?  I do not
think so.

If there is "stash clear --dry-run" that runs "stash list", it might
be similar, but not similar enough.  I wonder if "stash clear", when
stashClear.requireForce is set to true and unless "--force" is
given, should do "stash list" and then error out.  I dunno.

