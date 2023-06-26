Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98506EB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjFZQR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjFZQPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:15:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2B2211E
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:14:52 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86980334BE;
        Mon, 26 Jun 2023 12:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tGP0dqVy2BQ3a7grBI7xOi0Luh5pWbZtyMgflt
        Rsn/Y=; b=CNxnrWtJVKWzW/uYiTo/Qpg3KWBVVJBzXBpYa5ju7Dg5M87J2YAC6e
        4hUYU/SV5wUVlaLGHKRsVKERs8ogc9xlKdBRptj4vBDtOzj4fiAojyU8dAcnMz2C
        F6kqbxiDc7xR3xxCIT56gX62UDFyumPpD7msbAtWqQXWR8ciPeLhw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7ED59334BD;
        Mon, 26 Jun 2023 12:14:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 95BFC334BC;
        Mon, 26 Jun 2023 12:14:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/2] for-each-ref: add --count-matches option
References: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
        <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 09:14:48 -0700
In-Reply-To: <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 26 Jun 2023
        15:09:57 +0000")
Message-ID: <xmqqbkh25hfr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93427C7C-143C-11EE-8EDA-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Each of these approaches is wasteful as it requires sending the list of
> matching reference names across a pipe plus the cost of parsing that
> output.
>
> Instead, it would be helpful to have a Git command that counts the
> number of refs matching a list of patterns.

For for-each-ref (which can be reused by branch and tag for no
cost), I am on the fence but slightly in favor (partly because the
code has already been written).  But I have to wonder where changes
that come from the above reasoning need to end, though.

Do we count branches and tags because "git branch --list | wc -l" is
too costly?  Should we teach "git remote" the same trick?  How about
"git stash list"?  "git show-index $pack_index"?  "git ls-files"?

How do we decide where to draw the line?  When a command invocation
in a large repository can produce records exceeding a million?
