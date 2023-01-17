Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADCFC00A5A
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 00:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjARALn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 19:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjARALW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 19:11:22 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB845DC2D
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 15:27:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso511154pjg.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 15:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOL8Sa6jc/9GGPTwa6CRcJyMjHjB/bYW8e5mhv3ZSmQ=;
        b=O3yWxH7PIo7dCOIqui1LPRXsaQpW9suJaJ5Ch8WKpMAeO1MnjEyNg/2/aa4M71ebk1
         nTPFzu2/EH+CodygmiPPSCeh2oJZg0r+2uPuYpNy8m5kWPK0DmEa3aTWymSTFRVClJhM
         XN0uWHxGTnXBAbU5hys1A44nKPmspMlSFjqB9d3Cey6pdsAgU8jVThFBR8JqbXR+oUmD
         c0Ig2+mucyMYlJJnYm/Hxs/rqN6N2gg6F/TaLJAQPS1Sw6y7rlDtWAwBREtV4A4PzpgY
         fx5D4w4Jw7Bvkn3liELhU6gOA/Q69w7+hZyQhYc7xpRvCv56LjfJab4Bj8tQZpCfyf8L
         RZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOL8Sa6jc/9GGPTwa6CRcJyMjHjB/bYW8e5mhv3ZSmQ=;
        b=KqfImUAvCHEnYKo/kOZBFwrONr3gavk7T4JDqeacqsl4VvM29b8FOQKbiRTr602qmE
         vkMA5oWILQ3j5PZxEhv3M9YPAtL4JS0v5yCqoAeDlvewyCp6Oh5DMt/R7GxbZltrk0xo
         WYww7hn/HXeRxT+A7XQQMv9ayeYaPfk4gsFY/Ev4F6ZARDlpsc5EfEYOUCNV+RLuyQii
         o9zpOGhUSI3yYevHDEx9wxlJh6wDNQQhj6+BNuWLb41MYWP2XcZKZobfy+C2yUHVeDL7
         wOCX1MHjd6KMIA3FgysD7I4VjjMCXQlHVBWk0Q7CBt6c/888Sq3+hhB2M3eF61Lavjnk
         R0sQ==
X-Gm-Message-State: AFqh2kpBqCEyGxd1djxh/aivxS9DVCkoArtPKxEm7CZ0CKC1Fyn9Cxw1
        +Nn3PSJ+f309C7LCJGf/3qR9UGNjOnE=
X-Google-Smtp-Source: AMrXdXt/D0Y6WIdZY0x0SHo+73QTYMBUFWY9beMac2FQJa4dcVDD9jCqNX9HQqcJiApppJFTUqBOfg==
X-Received: by 2002:a17:902:c2d4:b0:193:d12:f892 with SMTP id c20-20020a170902c2d400b001930d12f892mr29166967pla.0.1673998049759;
        Tue, 17 Jan 2023 15:27:29 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709026e0200b001925016e34bsm5288395plk.79.2023.01.17.15.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 15:27:29 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] worktree: teach find_shared_symref to ignore current
 worktree
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
Date:   Tue, 17 Jan 2023 15:27:29 -0800
Message-ID: <xmqqilh491y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> We prevent some operations from being executed on a branch checked out
> in a worktree other than the current one.  An example of this was
> introduced in b5cabb4 (rebase: refuse to switch to branch already
> checked out elsewhere, 2020-02-23).
>
> "find_shared_symref()" is sometimes used to find the worktree in which a
> branch is checked out.  It performs its search starting with the current
> worktree.

"starting with the current" may be a correct statement of the fact,
but it is totally unclear what the relevance it has to the problem
being solved. Rather, it is unclear what problem you are solving.

Is it 

 - We search through the worktrees, starting with the current one,
   and stop at the first one found.

 - If the current branch the the current worktree is checked out in
   a different worktree, we get the current worktree back.

 - There are callers that want to know ONLY about other worktrees;
   they check the returned value and when they see it is the current
   one, they happily ignores the fact that it might be checked out
   elsewhere as well.

> As we allow to have the same branch checked out in multiple worktrees
> simultaneously...
>
> 	$ git worktree add foo
> 	$ git worktree add -f bar foo
> 	$ git checkout --ignore-other-worktrees foo
>
> ... if the branch checked out in the current worktree is also checked
> out in another worktree, with "find_shared_symref()" we will not notice
> this "other" working tree.

It is somewhat disturbing that your solution only needs to "ignore"
the current one.  Whatever problem you are seeing by the current
code not ignoring the current worktree, wouldn't we have a similar
problem if two non-current worktrees checked out the same branch?
Would it not be a problem because any non-current worktree returned
by the function triggers the "already checked-out" safety mechanism?

