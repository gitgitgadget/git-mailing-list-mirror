Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452CCC77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjEAPsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjEAPsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:48:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60953C7
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:48:02 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so3057311b3a.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682956082; x=1685548082;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdHNDljMO6/25ULpN5h8pddly/XiCdiTKza6L8DxbVM=;
        b=EYI9teT63OIUBnrLbamUi/GtjGLYRBfh3arwCvySO2Vpg5Vl4vbbOkQJ8377XDi8u1
         GaOFIaFJIAEJnqaSj8MXJL4ezW1ArOt8CXUDZyDeeMC6sQMMFLOfYTkPBSFUXXKF2uYI
         H77tcSccVWWA96Jv0817ri7LMyofgYwiZF4cV8ExUnmDbK+802P5vnDRrPzbpxLEUMzo
         NF/ZJaZEZLY26gt+7s7gjgyCRwvowq/SKj9Yx6AooX8CZMXfhAqLP5xSMp6i/ZEBo6Jn
         kO6DdM1+u+rQ/F+WjuSmuSnvDlFiJ3C7Vw3fttJzc4fEOPmH3aEVB8/JorVCUjVznlmR
         g08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682956082; x=1685548082;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DdHNDljMO6/25ULpN5h8pddly/XiCdiTKza6L8DxbVM=;
        b=gY90pM8pkQ9LS00oPbtWjUYht9fKWxyI2eWwdOxKiw2+WUKbCavhlSxjK4fUfEoK+U
         DuLJ9gkSbwN3cUAd4DLo56be7vCv0U67u07LYfBSMlK57rgT4UT4B6nfg55LekUt5kI7
         GKAkwPrUbdoDVQpaZzoKrifPZMjiWQdh76b3sohPjVyAg6FJ4m1KnmQKY2IZY6QtXOEi
         4Yz+0T1hbP1NK8lEuXjvYVuYG5w7GAhaIY+BeZVf/IKrt+is94hLSrgsEKcMnxMYeaSL
         4Jy6SvXAU4ZckLmljLbTSRnkIVbthP9+u23buo/LAp6MnUwWfOdwZwqNuUcSNluFACf2
         3new==
X-Gm-Message-State: AC+VfDxh0uyx69Rpu9DuqxzLI/AfEc+FE1DydBvpHz06qw+vyC1HonAK
        pQ2v+Z0NxoaJvhu9d1YuqTfqanM8I0Q=
X-Google-Smtp-Source: ACHHUZ4u62ZZZ+5R2r8t82jubhJMdI4JD3dd9PbT41TlpX6PzdJxB/s53nHi6YMraYXr23oGd4BFKA==
X-Received: by 2002:a05:6a00:1255:b0:63c:6485:d5fd with SMTP id u21-20020a056a00125500b0063c6485d5fdmr19238258pfi.2.1682956081621;
        Mon, 01 May 2023 08:48:01 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id o131-20020a62cd89000000b0063b7bd920b3sm20705065pfg.15.2023.05.01.08.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:48:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Subject: Re: Change branch in the middle of a merge
References: <CAPMMpohyoaH92B9f46hwdX2S5WOYeRB2yMSKW-4UCrHe29SAZQ@mail.gmail.com>
Date:   Mon, 01 May 2023 08:48:00 -0700
In-Reply-To: <CAPMMpohyoaH92B9f46hwdX2S5WOYeRB2yMSKW-4UCrHe29SAZQ@mail.gmail.com>
        (Tao Klerks's message of "Mon, 27 Feb 2023 13:12:55 +0100")
Message-ID: <xmqqpm7k6ojz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> At first I hoped that "git switch" might have fixed this - and in a
> limited sense it has, in that instead of *silently discarding* the
> merge state/metadata, it refuses with "fatal: cannot switch branch
> while merging".

I think this is in generally seen as a vast improvement over the
"silently discarding" to have the safety valve.

> I'd like to understand whether this behavior, the fact that you can't
> easily/straightforwardly/intuitively complete a merge onto a new
> branch (with the exact same "first parent" commit of course), is
> intentional for some reason that I am failing to grasp, or just a
> missing feature.
>
> It makes complete sense, of course, that switching to a *different
> commit* than the one you were on when you started the merge, should be
> illegal... but why would switching to the *same* commit be either
> illegal (git switch behavior) or destructive (git checkout behavior),
> as opposed to just letting you get on with it, as it does with other
> in-progress local working tree states?

I think this is mostly that nobody spent enough brain cycles to
ponder on things like:

 - Is it always safe to switch from a merge in progress to a newly
   created branch that point at the same commit as HEAD?  Why?  Is
   the story the same if the switched-to branch is an existing one
   that happens to point at the same commit as HEAD?

 - Maybe the answer to the above question is not "it is not quite
   safe to switch during a conflicted merge, but by adjusting X and
   Y while switching to a new branch, we could make it safe".
 
 - Even if the answer to the question above is "yes it is always
   safe", if it is not safe for a similar situation that ends up in
   unmerged index (i.e. the index with any path at non-0 stage), the
   way we determine if we are in "a merge in progress" situation
   must be reliable.  Is it?

 - Conversely, perhaps it is also safe to switch to a different
   branch that points at the same commit as HEAD from the conflicted
   state after some (but not necessarily all) of the following
   operations: "am -3", "cherry-pick" (single commit), "revert"
   (single commit), etc.  Can we come up with a reliable way to
   determine if we are in such a situation?

 - These "other mergy operations" that can leave unmerged index may
   share the same "is not safe out of the box, but can be made safe
   by adjusting some stuff".

After that is done, we could update the codepath in "git switch"
that says "ah, your index is unmerged, so I will not let you switch"
to instead say "your index is unmerged; let's first see if you are
switching to the same commit as HEAD and then the way your index is
unmerged was caused by an operation that we decided is safe to
switch out of.  It seems to be one of the situations that could be
made safe, so let's do adjustment X and Y and let you switch".

And the reason why "git switch" punts is because nobody bothered to,
not because there fundamentally is some reason why it shouldn't work.
