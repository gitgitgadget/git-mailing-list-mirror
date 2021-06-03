Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A764DC4708F
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 03:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C537613D6
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 03:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFCDir (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 23:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCDiq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 23:38:46 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ADBC061763
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 20:31:47 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bl11-20020ad4564b0000b029021d1fdffd5aso3446336qvb.1
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 20:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Ke9pq3VR+01J2ELteB8D1mYO7fz8UFB4CwvXM2WMGzU=;
        b=CkG3wnsXzWhUm1Q26D5oWC/ottGvLlVQJ/wDtgxt9X3WX7PtgSayP8uvtoscUOQctM
         +ngqfCnsvdF8nj4jk36tM6uRfjg6GG+vbiWGu6yhxIyiwNa9Sl04cXFt8Fo/ehydigw6
         FPIdDIf9NUM7nWp/VJbCEQTDv3YYLymANrouEOSRzTem02id9kXLR8E8ULxl9Vf+51f5
         hM+xt8x//5r8KY30SZwC8uPjkoXc35ZCmcHHFRgQlb11U1FAZ9hRwXt9dkXGFWLWC6Oe
         yM6FVVbCgQ6EcKVOpnSTTJ1Pu905MlZim25lu8zfZSNugThzLAjl9/OA7ykGZ5xKU1z/
         55FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Ke9pq3VR+01J2ELteB8D1mYO7fz8UFB4CwvXM2WMGzU=;
        b=tDr4k7y7pY+UnrxDGDoYBbujIHzYBCjfcQu3BSOvWyE/y2naeeaktA/qK8fxyRlSpQ
         UlFChaVN1jU8QmlZno/b1D2LDoCSq1NF2/ezW4AjVfEwkT2nLOUlQOtTkvHEsZtkx2Ys
         I0m7T7gfWPv5Y3W0rUkU2r6rdxfb579rS8I+7v8DrtSCLvZmn+v9gWHjPt7LnNqZFlaW
         XAekh+jyZ3YXud44Fx/oS81NyHeZEprSDtpR/OjaXk807qvsk7PJTFJISbicEzPKI8k4
         0JCiQaEXgRWQfs0rgJ/kjOkiUNi3WtuKY1444yMGf6YdIGdBDc5Pw6VwOSK2GUZbWDA2
         3Tdg==
X-Gm-Message-State: AOAM5309x/uphr6wVi4SB+CkLIC/Ib6YWqMP/uPbLyzgBMbirYwb/GYi
        twlZJcKM3zduCrHYDzzw/RDEKN37UPj1+Hvaq8uc
X-Google-Smtp-Source: ABdhPJz0IcRihckEK/OAIs+3yatFAz0O3FuOf0rnIOACkldaD3lXMiGrL5TZAvfM7O1Oxazru0b4JJnOqNszP9qBH53P
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:162a:: with SMTP id
 e10mr16843745qvw.49.1622691107113; Wed, 02 Jun 2021 20:31:47 -0700 (PDT)
Date:   Wed,  2 Jun 2021 20:31:42 -0700
In-Reply-To: <pull.908.v4.git.1620241892929.gitgitgadget@gmail.com>
Message-Id: <20210603033142.353066-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <pull.908.v4.git.1620241892929.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH v4] hooks: propose project configured hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, albertqcui@gmail.com,
        sandals@crustytoothpaste.net, avarab@gmail.com,
        emilyshaffer@google.com, stolee@gmail.com, emaste@freebsd.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +* After clone, repository suggests hooks to the user
> +
> +    ** User receives a non-interactive message advertising hooks availab=
le to
> +    install
> +
> +    ** User can see what hooks and commands are being suggested and from=
 what
> +    remote.

From the implementation point of view, would it be sufficient to just
advertise that hooks are available? Assuming that the hooks will be
available from a specially named ref (as stated below), then we would
only need to inform the user that this ref exists and hooks can be
inspected using a special command. Likewise for when we fetch and notice
that the ref now points to a different object. Then, we wouldn't need to
do any extra fetching upon clone/fetch, saving time and bandwidth, but
just do so if the user requests it.

> +Feature Requirements
> +~~~~~~~~~~~~~~~~~~~~
> +
> +Minimum Feature Set
> +^^^^^^^^^^^^^^^^^^^

[snip]

> +* The configuration specifies where the hook commands reside
> +
> +    ** This could be a path to a script/binary within the repository
> +
> +    ** This could be a path to a script/binary contained within submodul=
es of
> +    the repository
> +
> +    ** This could be a user installed command or script/binary that exis=
ts
> +    outside of the repository and is present in `$PATH`

Right now hooks are fixed files (well, not counting Emily Shaffer's work
on config hooks). Would it be sufficient to just provide replacements
for those files?

> +* The configuration lives outside the worktree.
> +
> +    ** Allows updated hooks to apply across history and branches, reduci=
ng
> +    the maintenance burden of keeping hooks updated.
> +
> +    ** Allows different remotes to specify different configuration. This=
 is
> +    useful for public vs private central repositories or for repositorie=
s which
> +    support different Git functionality.

Hmm...what would be a use case of this? And how would, say, a pre-commit
hook know which remote it is for?

> +* The user receives advice to install hooks.
> +
> +    ** The advice should clearly indicate the suggested hook command(s) =
and hook
> +    event(s) as well as the central repository that is suggesting them (=
via
> +    remote URL).
> +
> +    ** The user should be able to use configuration to turn off this adv=
ice.
> +
> +    ** The advice should appear at the following times:
> +
> +        *** After a clone
> +
> +        *** After a suggested hook would have run if not already install=
ed. The
> +        advice should include commands for installing the hook and invok=
ing it.
> +        For example, for a hook on 'git commit', the user should receive=
 advice
> +        to amend their commit after hook installation.

This seems contradictory to a point above where we only inform the user
upon clone (when the user is in the setup mood).

> +* If, after fetch, the central repository suggests new or updated hooks,=
 the
> +user should receive advice to install these new hooks (note: implementat=
ion
> +should not interfere with requirement listed in=E2=80=9CFast Follows")

In Git, the term "advice" seems to be used more for extra
explanations that you can turn off once you're experienced with Git.
Here, these seem like things that we would want to notify users about
regardless of experience level, so maybe the word "notification" is more
appropriate.

> +* Works across Windows/Linux/macOS
> +
> +Fast Follows
> +^^^^^^^^^^^^
> +
> +* Behind configuration, a user can opt to automatically install hook upd=
ates
> +from a given remote.
> +
> +* Allow users to make trust decisions based on GPG signing e.g. if the
> +configuration came from a signed commit, the signature could be shown al=
ong
> +with the remote it came from.

For the MVP, do we need this?

> +Implementation Exploration: Check special config branch at fetch time
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> +
> +* Perform fetch as normal
> +
> +* After fetch is complete, Git checks for a "magic" config branch (e.g.
> ++origin/refs/recommended-config+) which contains information about confi=
g lines
> +an end-user may want, including hooks.
> +
> +* As part of the fetch subcommand, Git alerts users (but not interactive=
ly) they
> +can install install the configs contained there.

This doesn't describe what the "magic" ref points to, but it could point
to a tree containing the hooks.
