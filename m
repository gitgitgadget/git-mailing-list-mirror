Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22224C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 17:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443950AbiEFRFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 13:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380050AbiEFRFq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 13:05:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9A02AC65
        for <git@vger.kernel.org>; Fri,  6 May 2022 10:02:03 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AED4011859C;
        Fri,  6 May 2022 13:02:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=TbUVEBjsqEHnQz/lWi+t/6EE3KFOWCmJ3LS4FehNYBo=; b=EMnj
        oDSj1u3t8APnpuCQ6kO4AhjuY03fftKisKk+WXE1BgonanrybvEK3qgJD+IBOFV9
        Kvu9vunJwGDBQgCHk714fP3ZjzvtwRkRsQYzXvjnzxABSlkqxSnTq/ZIfvEA/hCH
        K8zvRF02WReJ9Fk92z/5TZRp+/UnGH5k+1i/HO8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A52811859B;
        Fri,  6 May 2022 13:02:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87E04118599;
        Fri,  6 May 2022 13:02:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Goss Geppert <gg.oss.dev@gmail.com>
Cc:     git@vger.kernel.org, christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [RFC PATCH 0/1] dir: consider worktree config in path recursion
References: <20220505203234.21586-1-ggossdev@gmail.com>
Date:   Fri, 06 May 2022 10:02:00 -0700
Message-ID: <xmqqilqimw6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F63D82E-CD5E-11EC-BB6C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goss Geppert <gg.oss.dev@gmail.com> writes:

> Please see the commit message for a description. Effectively, since
> 8d92fb2927 (dir: replace exponential algorithm with a linear one,
> 2020-04-01) the following no longer does what it used to do:
>
> ```
> test_repo="$(mktemp -d /tmp/git-test-XXXXXXX)"
> cd "$test_repo"
> >test-file
> git init
> git config core.worktree /tmp
> git add test-file

And this is supposed to add a new entry to the index at
"git-test-123456/test-file"?

If it added a new index entry 'test-file', that means "git config
core.worktree" is completely ignored, because we are not treating
"/tmp" as the root of the working tree as it is instructed and that
sounds like a bug.  Is that what you mean by "no longer does what it
used to do"?

Thanks for raising an issue (although it is not quite clear yet to
me what the issue is, exactly ;-).
