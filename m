Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE84C4346E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 02:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5224A207C4
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 02:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyxhtFzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgIYCgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 22:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgIYCgU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 22:36:20 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F9BC0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 19:36:18 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id s19so944982ybc.5
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 19:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=x4nswvaiyjP4AVyKxsIoCgEVg1T41ogG4UcGYZO9pno=;
        b=pyxhtFzkqyHQBaXE/PTah/q+zW3CTWF2Y7dJ8MDtYWm/bhIAH+0yhK1RcCGJeHUlP0
         WBMC51FQZ0fNc42A2b80wY1crmIUFtAshCpG22M2KwJ0eQDrYjgl4zAVqODybYAWbaD/
         XvuUSq/ECK7jkkthw9o/q93XSEek1sDJNks+CAuSCNQGOM0908f8j+xo0buREzmMx7mn
         oybp8dCAel2VodZgwO6u0hUbsMQaetNvT6EJOubL5yFqZxyzTFrWrI+wIA0vHMLrLCSF
         TErqppnH4GtECpezPgMJuSSJOaalpe9iOy441DjRYP0viIMTGT0LDH3n4MQfCrG2hKdT
         6m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=x4nswvaiyjP4AVyKxsIoCgEVg1T41ogG4UcGYZO9pno=;
        b=Ls7MkyXZS8Cmz6dK9lO978CQzVEFPtvxFzvG/RE/alaSMnyElpRICnUAWTfPPcfjLM
         EQn/qfG8qxysQcFjvBHYeUiGGO0XQi+1Rl6aQ9I8zJxES+pRBi3AYcbwoFSxV8gJfBCC
         eJlBzDVvX6HHFZQwOu0EhE8THRW40gek+V3tkLkZdmyqorWNbIFzwlKbpy6JUYOI3e/5
         0aypLLLqy83ROpSqhkqEmd0pJEMuUz/O23MD2hn3EUCv18tPOyl5vJVFpUlyHcyJjkpd
         4Z89xGGUE2qPo4zoxj8XiCnyfFGge4iP1PlB9XyjUny/avWn94j+y7m86+IDZ8xJjaP1
         sL2w==
X-Gm-Message-State: AOAM5311uvxZz7Q4OYZnlQ+luDsfCZMgWy3zIdrZOsA9p4FsL1l7ThMZ
        V+RBLDsR2U782Ll9nIUtQHNiZt3bHUMmM83J6X/fkm4rNyUv5A==
X-Google-Smtp-Source: ABdhPJxmDaqkwv253zYm7Bg7/6Z48IaI3Gf+SuygD6tpOoM//460RImWKosSFd3huSlZg1qATGffstPiYsCwcZBWl+w=
X-Received: by 2002:a25:c0c3:: with SMTP id c186mr2312603ybf.124.1601001377807;
 Thu, 24 Sep 2020 19:36:17 -0700 (PDT)
MIME-Version: 1.0
From:   Phil Hord <phil.hord@gmail.com>
Date:   Thu, 24 Sep 2020 19:36:06 -0700
Message-ID: <CABURp0r_VPNeU5ugbJDQo=hV_aOit7W-pf9nhDF9Og=vVJG8tw@mail.gmail.com>
Subject: RFC - concurrency causes segfault in git grep since 2.26.0
To:     Git <git@vger.kernel.org>
Cc:     matheus.bernardino@usp.br, Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi list.  It's been a while.

I can reliably reproduce a segfault in git grep when searching the
object DB. It is caused by a race when threads > 2.

I have a patch that fixes the problem, but I don't know exactly why.
Can someone else explain it and/or offer a better solution?

====

diff --git packfile.c packfile.c
index e69012e7f2..52b7b54aeb 100644
--- packfile.c
+++ packfile.c
@@ -1812,7 +1812,9 @@ void *unpack_entry(struct repository *r, struct
packed_git *p, off_t obj_offset,
                if (!base)
                        continue;

+               obj_read_lock();
                delta_data = unpack_compressed_entry(p, &w_curs,
curpos, delta_size);
+               obj_read_unlock();

                if (!delta_data) {
                        error("failed to unpack compressed delta "

====

My notes thus far:

I have seen it fail with `--threads 3`, but it fails very reliably for
me with `--threads 20`.

My repo is large (7GB) which gives grep enough to do. I'm not able to
make it fail on git.git; it seems like it's too small to run into this
problem.

The problem bisects to 1d1729caeb.  It was somewhat hard to find this,
though, because git grep disables --threads when reading from the
object store until another patch later in the same series.

====

$ git bisect run sh -c \
    "sed -i -e 's/list.nr || cached || show_in_pager/list.nr ||
show_in_pager/' builtin/grep.c || exit 129;
    make -j 30 || exit 125;
    git checkout HEAD -- builtin/grep.c ;
    ./bin-wrappers/git -C ~/git/purity grep --threads 20 --cached
'target-regex' || exit 1"

1d1729caebd41b340dd8dd61057f613da4df526c is the first bad commit
commit 1d1729caebd41b340dd8dd61057f613da4df526c
Author: Matheus Tavares <matheus.bernardino@usp.br>
Date:   Wed Jan 15 23:39:54 2020 -0300

    grep: replace grep_read_mutex by internal obj read lock

Here's what I'm testing with:
$ ./bin-wrappers/git --version
git version 2.28.0.585.ge1cfff6765

I have found that the crash always happens in cache_or_unpack_entry.
The thread that segfaults is always in patch_delta, and there are
always at least two threads inside unpack_compressed_entry at the time
of the failure.

I was able to get it to crash with just three threads one time.  I
copied a log with the stack trace of all (4) threads during that run
to a gist [1].

Another log showing four different segfaults when run with 40 threads
is also in that gist [1].

[1] https://gist.github.com/phord/02e84d003688baa493b978110225d443
