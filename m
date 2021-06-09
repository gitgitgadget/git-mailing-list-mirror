Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04015C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB4A56128A
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhFIEnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:43:08 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35357 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhFIEnF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:43:05 -0400
Received: by mail-pl1-f202.google.com with SMTP id o12-20020a170902778cb02900ff01bc1ddbso10823142pll.2
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 21:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BeMVnqXIotHk1bvE2sTEZmQbjdqeEEGRoL3SWBPE8lo=;
        b=lD+nYIx7ZbCE2s3tqEJT7l8H0tGlqFf14AASrmuSbtny866k/W61r+cn0T0H0VrrKZ
         T2fJEWKcWLap0KZrthvQD3qehDXguLTHLy7sbmKQCTACmH8RbQ4iQCw6EjdgYZoCO3W6
         MCspkPM0nAyds9mv/RuBqVeCN92a+7n8tUcFuoELjxZE7fwqDPdqqSe1c7ihYTVkCzOc
         swbdxDR8GtVoctWlrRMoMwswkYTz2sTElz9j8WjIqcU159aTpYkWDr0N5hCzYJBJXY1n
         y00TjxaTYiNTw0hooSMcGgDyccZN8Ximn3xIuNAeLIOhi2Lg5m+DNzLXWZEGZT5pnur2
         Y6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BeMVnqXIotHk1bvE2sTEZmQbjdqeEEGRoL3SWBPE8lo=;
        b=lApTz3EoBkKIPeO5IZiCxBNpTU/YPFFodgGr5HyRWjJCsB7JB0VchMaHI4hRWmls65
         pfgWGjFIEAs8aPUNx0QrnZzFHepBC4MawUB0rdGceG3O7WpdTOB6JOLY88RkH3tGKIGS
         xvt8J+UFhykMewC1WVChv0+DYMADoVlASd25rA75RKtjcLeaBBkso03efj8g0DJeOUjS
         jPGMzDblHKowV3pCtYMtOnVdN8OppJo+r8dcXUXZ2KKaSLcdsIJdGCiuDmQyha0sP+Zu
         vQtqY0O3cTnlt6aSQJTv++7PjRPFZCU5Pg/j+exVTo7w1mYs8/Q5DWN2NQIA498EIUZQ
         EqzA==
X-Gm-Message-State: AOAM5322j4wReFyWQX6t4C9fj5q7rc5yleut+H8asufs8dNSyPvW7XnP
        r5e7kkBweBrNOeTp1zy/Addd4hUg9MCYCWom00t9
X-Google-Smtp-Source: ABdhPJxJ0cGaTpUsrGfqMhciaGretl3YOhzDjBgDRKFsRMqQIwl3r1jgJo/+TRinZI5nanTMti2Fcrq105VlbxY48IIc
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:d104:b029:113:4f33:47b8 with
 SMTP id w4-20020a170902d104b02901134f3347b8mr3591896plw.14.1623213596565;
 Tue, 08 Jun 2021 21:39:56 -0700 (PDT)
Date:   Tue,  8 Jun 2021 21:39:50 -0700
In-Reply-To: <xmqqim2pq8kj.fsf@gitster.g>
Message-Id: <20210609043950.2325124-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqim2pq8kj.fsf@gitster.g>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v2 4/4] promisor-remote: teach lazy-fetch in any repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >  		/* Check if it is a missing object */
> > -		if (fetch_if_missing && has_promisor_remote() &&
> > -		    !already_retried && r == the_repository &&
> > +		if (fetch_if_missing && repo_has_promisor_remote(r) &&
> > +		    !already_retried &&
> 
> Turning has_promisor_remote() into repo_has_promisor_remote(r) does
> make tons of sense.  Is this part of the code ready to lose "'r' must
> be the_repository because has_promisor_remote() only works on the
> primary in-core repository" we had before?

Yes - that is precisely what I test with the test helper (running this
code path with "r" that is not the_repository).

> > @@ -21,6 +22,11 @@ static int fetch_objects(const char *remote_name,
> >  
> >  	child.git_cmd = 1;
> >  	child.in = -1;
> > +	if (repo != the_repository) {
> > +		prepare_other_repo_env(&child.env_array);
> > +		strvec_pushf(&child.env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
> > +			     repo->gitdir);
> > +	}
> 
> This is what prepare_submodule_repo_env_in_gitdir() does; it makes
> me wonder if it (i.e. set up environment for that other repository,
> including the GIT_DIR and possibly other per-repository environment
> variable override) should be the primary API callers would want,
> instead of a more limited prepare_other_repo_env() that does not
> even take 'repo' parameter.  Doesn't it feel somewhat strange for a
> function that is supposed to help preparing a part of child process
> by filling appropriate environ[] array to be run in a repository
> that is different from ours (which is "other repo" part of its name)
> not to want to even know which repository the "other" repo is?

Good point. I'll update prepare_other_repo_env() to have a gitdir
parameter.

> > diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
> > new file mode 100644
> > index 0000000000..3f102cfddd
> > --- /dev/null
> > +++ b/t/helper/test-partial-clone.c
> > @@ -0,0 +1,43 @@
> > +#include "cache.h"
> > +#include "test-tool.h"
> > +#include "repository.h"
> > +#include "object-store.h"
> > +
> > +/*
> > + * Prints the size of the object corresponding to the given hash in a specific
> > + * gitdir. This is similar to "git -C gitdir cat-file -s", except that this
> > + * exercises the code that accesses the object of an arbitrary repository that
> > + * is not the_repository. ("git -C gitdir" makes it so that the_repository is
> > + * the one in gitdir.)
> > + */
> 
> The reason why this only gives size is because it will eventually
> become unnecessary once the main code starts running things in a
> submodule repository properly (i.e. without doing the alternate odb
> thing),

If you mean that this code path can be tested through user-visible
commands (e.g. git grep with submodule recursion) once the main code
starts avoiding doing the alternate odb thing, so this helper will
eventually be unnecessary, then the answer is yes.

> and a more elaborate check is not worth your engineering
> effort?

Even now, I don't think a more elaborate check is worth the engineering
effort - I just want to check that the file indeed was lazy-fetched, so
any minor datum would suffice.

> Object type and object sizes are something that you can
> safely express in plain text, would be handy for testing, and would
> not require too much extra code, I'd imagine.

It would, but we can already use "git cat-file -s" (or -t) for that. The
helper is meant to test a specific code path wherein we access a
submodule object during a process running in the superproject.

> > +	printf("%d\n", (int) size);
> 
> Mimicking what builtin/cat-file.c::cat_one_file() does, for example, and
> using
> 
> 	printf("%"PRIuMAX"\n", (uintmax_t)size);
> 
> might be better (I was wondering if we can extract reusable helpers,
> but I do not think that is worth doing, if this is meant to be
> temporary stop-gap measure).
> 
> Thanks.

Sounds good - I'll change this.
