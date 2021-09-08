Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96130C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A932610FF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349497AbhIHNoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347918AbhIHNog (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 09:44:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79339C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 06:43:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f18so4538489lfk.12
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r0OAFT09LAUb+FOXfUpwWL+EhSbgU66rNHWRpzW1znQ=;
        b=No5LXxP5bPZNO1Ig00X7ZF9A/9NPJZPEdz9Zaw6WBRgo8kLjWLmAPJdt9VxXv56ZH1
         vUCNyWiMU3qd2695pWg3UqcoPJO3YCauVtBBAwyrGwCYvj5C52ezbncHxFax9pM69iUh
         ofAq4Mdrthw6CbzQiyMkgim2It8Xp72rJyIcORdI58YL18MHduHvs+G0gvRATY75n5a0
         Gkp/TEfM2oDOQ6grMwN2bRkvp1QMtNV5C4U0PiLMRAJLbce9j8N8CJj0/0h2sdWuyLxt
         PMkhn0hwWT3+d0dHtqqGZN13jpuyvOemOvjVMvN7mPjMrJ/n3ad35VfyQintCMJUh1+X
         lalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=r0OAFT09LAUb+FOXfUpwWL+EhSbgU66rNHWRpzW1znQ=;
        b=kWHtQ92/xa9pTmYyg8iDMBV+2RmTjL2yWTHFOoh3Rk3nYV9h7oBMiozUCmtoHWgwbc
         sTg+Y1WBRtV/gKqrlS4XHBz65p6qIUbxorB5wHv+NuEJNa9nHLdpQTNIbiGfuUKpLiiA
         uhKbJKs3qsDwqITPxnetD/puJ9WMm6h2KYdu3kDa6dz/QDmtJmRJ1TmA4VkY0hTmx70w
         jmLFewZvUPHXwSWzkLa6tG/NvFOn8ABtpClFnn8b3bXex7z+PPivW602XVQdrnuwOQMe
         tNHKWrBU47DXDuYhhhq/m6/lssYay9uDU6dHs4L1gv5CR4euJ+NT+Sa+VWle0iLO3xHy
         Sd4A==
X-Gm-Message-State: AOAM5333tqkFhC2S4U+dvrcXlKQE6Hso98xE1eRejd/xQQDFt6I4VA5j
        Z7+6ScIPV9qirRvZ8pTNLWfEwyrJdsM=
X-Google-Smtp-Source: ABdhPJySS8x6gLs0DuPEpoAPvZYScdzcNsFZm6HGc9OlZK6R/mEYxDUpT/vBRz1eH+ZK8lZpD4W8IA==
X-Received: by 2002:a05:6512:1289:: with SMTP id u9mr2702293lfs.296.1631108606580;
        Wed, 08 Sep 2021 06:43:26 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x13sm210488lfa.260.2021.09.08.06.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:43:25 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
Date:   Wed, 08 Sep 2021 16:43:24 +0300
In-Reply-To: <xmqqy288b64q.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        07 Sep 2021 11:19:33 -0700")
Message-ID: <87pmtjkwsj.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Here is a patch that fixes diff-index to accept --cc again:
>
> Sorry for the delay; I did not notice there was a patch buried in a
> discussion thread.
>
> We might later need to do this suppression in more codepaths if we
> find more regressions, but let's have one fix at a time.

I'm pretty positive there should be nothing left. This commit was
diff-index specific, and doesn't affect anything else. Nowhere in entire
series the semantics of --cc itself has been changed, it has been only
disabled as particular option in diff-index command-line parsing.
Overall, this is pretty local change.

>
> Will queue.
>
>>  builtin/diff-index.c |  6 +++---
>>  diff-merges.c        | 14 ++++----------
>>  diff-merges.h        |  2 +-
>
> This would deserve new tests that cover the existing use cases,
> given that both of us (and other reviewers in the original thread)
> did not notice how big a regression we are causing.

I don't see it as a "big regression", but no wonder the breakage was
entirely unexpected, see below.

>
> We care about --cc naturally falling back to -p when there is only
> one other thing to compare with, and also we care about --cc that
> allows us to compare during conflict resolution, at least, I think.

The problem here is not with -c/--cc itself, it is rather with
diff-index. It's neither documented nor tested nor obvious what -c/--cc
should mean in diff-index, given -c/--cc description (e.g., in "git help
log"):

       -c
           With this option, diff output for a merge commit shows the
           differences [...]

How an option to deal with merge commits is applicable to diff-index,
that:

    git-diff-index - Compare a tree to the working tree or index

???

Besides, nobody yet told us why gitk uses --cc option in invocation of
'diff-index' in the first place. Does it actually *rely* on particular
undocumented behavior of "diff-index --cc", or is it just a copy-paste
*leftover*?

Overall, the original commit had a mistake, as the commit that was meant
to be pure refactoring had changed observable behavior, even if
undocumented. However, the essence of the commit, disabling of "diff for
merge /commits/" options in diff-index that does not deal with /commits/,
could still be the right thing to do long term.

Thanks,
-- Sergey Organov
