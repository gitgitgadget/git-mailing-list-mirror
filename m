Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E9CC43219
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 22:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiDYWZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 18:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbiDYVhr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 17:37:47 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE1E388E
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 14:34:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 097EC18919D;
        Mon, 25 Apr 2022 17:34:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jPPqfPJbI2gfPPMjl0GsawFwGvvY0UkP1QBD62
        CheHA=; b=uns31h9wc1HA8PG+6yslJypw9PVuWvgSkfEbQlIhb271qIvCgI3cL5
        coAmzUcoDEFdAwgGpM0WehQLxMFUtF1REM4p6bbpB0NQeKqeaHYCD1uEexuicmFh
        78U32zAxYU86wRjehgoIHNufPGi3QfNN4Lxay2h1o2Jbccl/I6psI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0334118919C;
        Mon, 25 Apr 2022 17:34:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C14618919B;
        Mon, 25 Apr 2022 17:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/7] stash: integrate with sparse index
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
        <f6cf05a5bee9e4ebc174bab0385a13cc1cdb4014.1650908958.git.gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 14:34:34 -0700
In-Reply-To: <f6cf05a5bee9e4ebc174bab0385a13cc1cdb4014.1650908958.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Mon, 25 Apr 2022 17:49:12
        +0000")
Message-ID: <xmqq5ymwvod1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 808EDEE8-C4DF-11EC-A322-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Enable sparse index in 'git stash' by disabling
> 'command_requires_full_index'.
>
> With sparse index enabled, some subcommands of 'stash' work without
> expanding the index, e.g., 'git stash', 'git stash list', 'git stash drop',
> etc. Others ensure the index is expanded either directly (as in the case of
> 'git stash [pop|apply]', where the call to 'merge_recursive_generic()' in
> 'do_apply_stash()' triggers the expansion), or in a command called
> internally by stash (e.g., 'git update-index' in 'git stash -u'). So, in
> addition to enabling sparse index, add tests to 't1092' demonstrating which
> variants of 'git stash' expand the index, and which do not.

As always, it is suprising that the change id deceptively easy, but
it is only true because various components like the merge machinery
used by the code have been taught to expand the sparse index entries
as needed.  Looking good so far.
