Return-Path: <SRS0=89BL=BL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A47FC433DF
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 17:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7E1206E9
	for <git@archiver.kernel.org>; Sat,  1 Aug 2020 17:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbfo4RnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHAR6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 13:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgHAR6t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Aug 2020 13:58:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FEAC06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 10:58:49 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b25so25453339qto.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w/6prIGy63dy1mlmqF+4/w27iExeDU/KnlaXKOrP5Tg=;
        b=nbfo4RnW8z/tQQgUV0uNkAVWM2SNJgX0fh64jBXL4Y2vTRGgKHZzBcWvLekkQ5LVcV
         xw04zK3DntzVOXSLjhQW/E1Q4e+G5CKghS80Dg9niqM53q7moucbIVy8tKcqpuPZRWuy
         970BYjUomWxNFpxFTGMhtKzEuTmKCwFUTZS31GEqC4aaWisWabtrbPnuOrifE36jcM/h
         Abmx+6z34z+IJitPyoamCZJReoPcFvbYCJPILbTY2NAYmpfHYJ+SM81Apg55lTQcwwKp
         kGZPAgJgGgGOHj7xw2qI1s0LMILW24luFpSTyd0gIHDKYLN869IRDx8HYoFkKFiR50GG
         sDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/6prIGy63dy1mlmqF+4/w27iExeDU/KnlaXKOrP5Tg=;
        b=EY9ym4/qmydcEX/F57O1no7e3jsrSwPoMo8rxK+q+98hB9lnhvnqPU/Z1pGaGA15ma
         y5xBV7v+DMnj7swUoCAqzftyxDARTuINigLdn3EdVzKZA3xer45aTXUaFd4MzsDcvPq+
         ee3s1W/FrrkeFQ5qWEYnPs7XGbSDysNi1mLzXpeqpHBvp9ETvLPDTFUo6Q+N9bRluNEM
         PYltIaVbhnJJiaL6TvRSJkUt+tK5b9k1qk87KwMuDZPMvc/I86cI9Fs65jVwwfRZFkat
         XOUXrz78S5BWRs0i8J0OvQTF3bczT+TPvH0HmIWyOlOKrKLyUw9aJBqqbAesVFcnspGb
         SjHQ==
X-Gm-Message-State: AOAM532pXjxx6yqv1bvpX/JErp1pWo+Bdbh7SMKqHloIHt0pN4hWjS4D
        NBbmkC3K270nYf0z+cOaVHheCwaDp9Wdag==
X-Google-Smtp-Source: ABdhPJz+AVSippD1tRTBo/ce7ryHAXMQVpylVuZpG2+inAPYzycF9PXGoPEQccObcufnFX64IXl+Ug==
X-Received: by 2002:aed:2f87:: with SMTP id m7mr9246869qtd.56.1596304727859;
        Sat, 01 Aug 2020 10:58:47 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id l13sm13517405qth.77.2020.08.01.10.58.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Aug 2020 10:58:47 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v3 0/4] Introduce --first-parent flag for git bisect
Date:   Sat,  1 Aug 2020 13:58:36 -0400
Message-Id: <20200801175840.1877-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200730002735.87655-1-alipman88@gmail.com>
References: <20200730002735.87655-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ah, I was referring to the order of sign-off, helped-by, etc.

Whoops, re-ordered correctly.

> This is not a new issue, but duplication of the above and the same
> set of PATH_FUNC in builtin/bisect-helper.c looks ugly.  We may want
> to do something about it after this topic is done.

Happy to pick that up next!

> > +int read_first_parent_option(void)

> "static int", no?  I do not think we need to be able to call this
> from anywhere outside this file.

Added static keyword and removed the redundant line from bisect.h

> >  static int bisect_start(struct bisect_terms *terms, int no_checkout,
> > -     const char **argv, int argc)
> > +     int first_parent_only, const char **argv, int argc)

> Why do we need to pass this new parameter from cmd_bisect__helper(),
> when we are going to parse it out of argv/argc outselves anyway?

> I suspect that you would ask the same question to whoever added
> no_checkout to this thing, and I wouldn't be surprised if we end up
> removing both of these parameters (and parsing of the options inside
> cmd_bisect__helper()) after thinking about them, but anyway, let's
> read on.

Hmm. Is there a preferred way to to add a --first-parent line to the
output of "git bisect start --help" via the parse-options API without
removing the --first-parent option from argv in the process?

As long as we're capturing the --first-parent option in
cmd_bisect__helper(), checking argv for a --first-parent flag in
bisect_start() is pointless. So I've deleted the following lines from my
patch inside bisect_start() (for the time being, at least):

git diff v2 v3 -- builtin/bisect--helper.c
-   } else if (!strcmp(arg, "--first-parent")) {
-     first_parent_only = 1;

> > +# We want to automatically find the merge that
> > +# introduced "line" into hello.

> 'introduced'?

That's the language used by other "git bisect run" tests. If
"introduced" sounds too clinical, perhaps "added" instead?

> Let's not revert back to ancient line-folding style.

Thank you for the template. I've updated my test accordingly.

> So, we want to say "bad" if $? is 0, i.e. the file 'hello' has a
> string "line" in it and "good" if $? is not 0, i.e. the file 'hello'
> does not have such a line?

I think the other way around - an exit code of 0 from the script passed
to "git bisect run" marks a commit as good, 1 as bad.

>  - Use "write_script" to abstract away platform-specific details
>    such as which $SHELL_PATH to use on "#!" line, and "chmod +x".

>  - There is no SP between a redirection operator and its target
>    file.

Noted. Can we rewrite the other "git bisect run" tests in
t6030-bisect-porcelain.sh so that they're all consisent? That way, when
someone adds another test for "git bisect run", they'll have a few more
proper examples. (I've added a fourth commit that does this, if that's
OK.)

> The final blame must lie on a commit on the first-parent chain,
> which this test tries to ensure, but I wonder if it is also required
> that all commits offered to be tested by "git bisect" are on the
> first-parent chain, and if so, shouldn't we be make sure each and
> every time "test_script" is run, the commit that is at HEAD is on
> the first parent chain between the initial good..bad range?

That is prudent. I've altered test_script.sh to use the special -1 exit
code to abort the bisection process if it encounters a commit outside
the first parent chain.

Althernatively, if we prefer not to depend on the special -1 exit code,
we can append any tested commits outside the first parent chain to a
file and ensure that it's empty after "git bisect run" finishes.

> I'd rather call them "flags" without "bisect_".  If we are passing
> two sets of flags, one set about "bisect" and the other set about
> something else, it would make quite a lot of sense to call the first
> set "bisect_flags", but what we are seeing here is not like that.

bisect.c already uses a "flags" variable in several locations that would
collide with this. Perhaps rename the existing "flags" variable to
"commit_flags" to explicitly differentiate?

> > + if (!!skipped_revs.nr)
> > +   bisect_flags |= BISECT_FIND_ALL;
> > +

> You do not care what kind of "true" you are feeding "if()", so I do
> not think you would want to keep !! prefix here.

OK, removed.

> The set of bits to go to your "bisect_flags" are only these two new
> ones, and the existing BISECT_SHOW_ALL does not belong to it (it is
> a bit in rev_list_info.flags), but it is not apparent.  I wonder if
> there is a good way to help readers easily tell these two sets apart.
> These are flags passed to find_bisection(), so perhaps
> 
>     #define FIND_BISECTION_ALL (1U<<0)
>     #define FIND_BISECTION_FIRST_PARENT_ONLY (1U<<1)
>     // ...
>
> would be a reasonable compromise?

Sounds good, renamed.

Aaron Lipman (4):
  rev-list: allow bisect and first-parent flags
  bisect: introduce first-parent flag
  bisect: combine args passed to find_bisection()
  bisect: consistent style for git bisect run tests

 Documentation/git-bisect.txt       | 13 ++++-
 Documentation/rev-list-options.txt |  7 ++-
 bisect.c                           | 81 +++++++++++++++++++-----------
 bisect.h                           |  5 +-
 builtin/bisect--helper.c           | 14 ++++--
 builtin/rev-list.c                 |  9 +++-
 revision.c                         |  3 --
 t/t6000-rev-list-misc.sh           |  4 +-
 t/t6002-rev-list-bisect.sh         | 45 +++++++++++++++++
 t/t6030-bisect-porcelain.sh        | 64 ++++++++++++++---------
 10 files changed, 176 insertions(+), 69 deletions(-)

-- 
2.24.3 (Apple Git-128)

