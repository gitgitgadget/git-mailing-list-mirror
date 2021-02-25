Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D388FC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B02664E28
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhBYU7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 15:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbhBYU5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 15:57:03 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB829C0611BC
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 12:56:17 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id o27so4683019pgb.14
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 12:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aW2OxY6qB+KnPln0NBGGKaYMDXOCbLyB9OGrWEx/NKo=;
        b=USvwKqR6e5gug2PrEvpLY5mt7YaTJJMx4aks3fNrLqbBtkC+P4TpVbGANmjVK+82KJ
         A9UW8fnB+x8bxI+CYV7Uemrmz04rmrzlAKUNtthiJ4R1e4SytGS5S+Zl84YnEh3n0YdR
         NqGhiPfn2yPOjczDXVXkqigtAP+rXWbVgzToaloQgbjxNq168Db58RoPCZKSxV5iAjLM
         QpdFAsYOnf3ROP46ks8x/zU603NG+NRI5MbZyWItKeZY8OQtdQhKxi8oe9jlBhOSFUIj
         SEMTMjvKLgFo529syUvYD5Dk3Qw2V6yF3CNz/DKvKGPJbhLc8Z1HAndNRzDAS8QSXjiW
         hZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aW2OxY6qB+KnPln0NBGGKaYMDXOCbLyB9OGrWEx/NKo=;
        b=HyJozl/tPT0uOZAZ7/sdAJTky/NbLT7WDmF5MulryyQYaKmQt/nJIzbMn6ffl2DmRH
         M8pRQ0W8CyqlZxTwntamLbMJYngJpoTgEsfEytnIickjUBOtj7FKbaOT6ygyMfmw3BHH
         ++AICfEhbhByeCqbyLk+LIDhKpJnnqnyw0CZ0kHD9GpYavB9UafbaBvBr46IWtHcZ66t
         +1KhFQHwTdMFdjBjCloB7b+VrDXc60YTge+NyS6myYhTylTbwSNDEaPp2lPtVLayOvTe
         Tc/kH/bidd7xR1QgXRTOLyJ0i9o35vATtVv3rFBDI5t1fhAMFAUs8qoW+Fx30toCqUbB
         HDpQ==
X-Gm-Message-State: AOAM530XwpKvXVLjr0ndrRt/U+Pw0b0I7QeDJezVEPYPZwxOlUk9BgD/
        JLRKo05PHrCtDQn9SQqGiRAh5Jsk4YdpJnEnUqmP
X-Google-Smtp-Source: ABdhPJytdfqa/ZegfCoTt0S41Z9HoVTnU4Z4PyNczT1QzYd5QLOq50x8QMQUh+5SKgmONKRgAenNGCx+DE2+YZkb56Aw
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:947d:0:b029:1ed:a78c:59ea with
 SMTP id t29-20020aa7947d0000b02901eda78c59eamr4948818pfq.36.1614286576550;
 Thu, 25 Feb 2021 12:56:16 -0800 (PST)
Date:   Thu, 25 Feb 2021 12:56:11 -0800
In-Reply-To: <YDVdGNefUehBknRB@google.com>
Message-Id: <20210225205612.2061342-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YDVdGNefUehBknRB@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH v7 15/17] hook: provide stdin by string_list or callback
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > When would we need per-hook state? I see in patch 14 that you give each
> > running process little by little (in pp_buffer_stdin()), perhaps so that
> > each hook can make progress at roughly the same pace, but I don't think
> > we can expect all hooks to work the same, so I don't think it's worth
> > complicating the design for all that.
> 
> I agree that this is a complicated way of doing it, and if you have a
> better design I'd be really excited to hear it.
> 
> It seemed like this was what was necessary for hooks like
> https://lore.kernel.org/git/20201222000435.1529768-15-emilyshaffer@google.com
> where the hook and the invoking process talk back and forth, or like
> https://lore.kernel.org/git/20201222000435.1529768-17-emilyshaffer@google.com
> which generates stdin on the fly for hooks which cannot be parallelized
> (and so won't run at the same pace).
> 
> The former example - proc-receive - does have a constraint that multiple
> hooks can't be specified, so we could theoretically keep the old
> implementation and just pick up the single hook's location from the new
> hook library. But the latter example still makes me think this much
> complexity is needed.

Ah, I see. From your explanation, in these 2 cases, only one hook
executes at a time (in the former case, because there is only one hook,
and in the latter case, you said that the hooks cannot be parallelized).
So it seems to me that the global state (in struct run_hooks_opt) would
be sufficient to keep track of what's going on. (The feed_pipe_fn
function can use pp_cb to keep track of the last executing pp_task_cb
and then compare it against the new pp_task_cb, I think, to keep track
of when a new hook has started.)

Even in the case of multiple hooks run in series (as opposed to a single
hook), I would think that the reason they can't be run in parallel is
because the nature of execution of a hook depends on what happened
during the execution of the previous hook, which seems to me to be even
more reason to centralize the state in struct run_hooks_opt.

Having said that, if my suggestion of not having per-hook state makes
certain patches more complicated, then that might be reason enough to
have per-hook state. In that case, you should write "per-hook state,
though strictly not necessary, makes <case> simpler" (or something like
that) in the commit message.
