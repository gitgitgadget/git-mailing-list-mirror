Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29382C25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 15:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjAXPWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjAXPWo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 10:22:44 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18C62702
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:22:43 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d10so11470460pgm.13
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nm47pe6Vx9JwCsRr4EMETxZCDmrHrFsgFiQQZ8jz+nQ=;
        b=Q3YkrdDuFjufxqUu7qsOPvROZPcfJW7rvzoFzjD777LOdI3QYpY2Vp9Us/gGEVNTA/
         0CkTp7EQiZ6uIKly37CO0VAMxAMk26ouiTO+f815jZ2/6/TPPDQuqFr+jYRbH8St13xQ
         mksC4H80W6oLcLUPIjn6yswIog7YjX3eLzTX/IsvHjG38fAaGwzifn4H0nY+r+YX5tQK
         yE/ILAdZ+1x1Yvwnjx3FvLPco5CKYu/0ZaNbYMSC6hR93poyDXLoGgTGzI0FdGUiLB0f
         MwqgnAEn85L1YFOzJHgHSWKdlQOt1chOt9ARW0t3qVAg3UM1+4r8tCo3OpdAVkwRUt2W
         c0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nm47pe6Vx9JwCsRr4EMETxZCDmrHrFsgFiQQZ8jz+nQ=;
        b=AVKZ4H/M+87MN2RuylBqGj6jQgizu7rwuVfyWXW4Xw+8CYuGFjZeDPxUQAacawds/J
         KE9RUAVuKAi7u7IsF2YKaXAdBvdKYPjhe5ibd3IEBeVHaipPe7Rq7nnfD2uipybrH2L6
         abULr5HxeSxHWX4HPY3jrmko4q+oUxfasAYHNOyBb4t2vFXQhfx0Vcg6V/VlkZG399JD
         kz+0bFZ9MBRJDVt25ykm2FuEaipszyfvnuolfSqmrfv3Cwg3kpDcHa9GvnWxQ+Hy2NOk
         6QTx7GVy8ZhtI0AOqYyiwmVM9RSQmybiXoUI78R5GPUOi+b56QgKs4qQAWvsJwvzSTC3
         6p/Q==
X-Gm-Message-State: AFqh2krYhWZCBxZl6sgR7pHo67asPUElJVs4U4hBYjC+Nrd9C4Y92BE/
        vLEyVwDp4Eg7BFQd5Qre9PQ=
X-Google-Smtp-Source: AMrXdXuuxYSLNN1ojol2TYoEBX+uB/UAVQ5/gL5Rh6rjIAvWlIAD0JgOm+lc4UGJYnjxEiU2QVDwOA==
X-Received: by 2002:a05:6a00:3317:b0:589:f66e:60ca with SMTP id cq23-20020a056a00331700b00589f66e60camr31972837pfb.9.1674573762801;
        Tue, 24 Jan 2023 07:22:42 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a28-20020aa78e9c000000b0058193135f6bsm1730933pfr.84.2023.01.24.07.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 07:22:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
Subject: Re: [PATCH v2 01/10] bundle: optionally skip reachability walk
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
        <xmqqsfg1m8l6.fsf@gitster.g>
        <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
        <xmqqilgxm2ky.fsf@gitster.g> <xmqqtu0glw81.fsf@gitster.g>
        <771a2993-85bd-0831-0977-24204f84e206@github.com>
Date:   Tue, 24 Jan 2023 07:22:42 -0800
In-Reply-To: <771a2993-85bd-0831-0977-24204f84e206@github.com> (Derrick
        Stolee's message of "Tue, 24 Jan 2023 07:27:04 -0500")
Message-ID: <xmqq5ycwj6t9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I'll focus on this area today and see what I can learn and how I
> can approach this problem in a different way. The current options
> that I see are:
>
>  1. Leave verify_bundle() as-is and figure out how to refresh the
>     refs. (This would remain a stricter check than necessary.)

Even if we switch to "assume everything is OK, remember a few key
facts (like prerequisites and tips) about each bundle as we unpack
them, and sanity check the results at the end" approach, doesn't
that last step require us to be able to see the final state of the
refs?  If so, wouldn't we need to figure out how to refresh the refs
no matter what?

>  2. Find out how to modify verify_bundle() so it can do the more
>     relaxed connectivity check.

I am not sure what kind of relaxing you have in mind, but as long as
we can guarantee the connectedness of the end result

>  3. Take the connectivity check that fetch uses before updating
>     refs and add that check before updating refs in the bundle URI
>     code.

This is optional at much lower priority, isn't it?  In the second
example in the message you are responding to, I do not think it is
too bad to reject the bundle based on '8' that has been rewound away
(in other words, a bundle publisher ought to be basing their bundles
on well publicized and commonly available commits).  Only when we
try to be overly helpful to such a use case, it becomes necessary to
loosen the rule from "all prerequisites must be reachable from
existing refs" to "or prerequisites that are not reachable from any
refs are also OK if they pass check_connected()".

The current check to require that prerequisites are reachable from
refs does not have to check trees and blobs, because any commit that
is reachable from an existing ref is complete[*] by definition.

    Let's define a term: a commit is "complete" iff it is not
    missing any objects that it (recursively) references to.

The check done by check_connected() is more expensive because it has
to prove that a commit, which is found in the object store and may
or may not be reachable from any refs, is complete.  The tranversal
still can take advantage of the fact that commits _reachable_ from
refs are guaranteed to be complete, but until the traversal reaches
a commit that is reachable from refs (e.g. when inspecting commits
'8' and then '7' until it reaches '6', in the second example in the
message you are responding to) we need to look at trees and blobs.

> There could also be a combination of (2) and (3), or others I have
> not considered until I go poking around in the code.
>
> I'll let you know what I find.

Thanks.  Unlike areas that allow glitches as long as workarounds are
available (e.g. UI), the object store + refs layer is where it is
absolutely required to be correct.  I am happy to see capable minds
are on it.
