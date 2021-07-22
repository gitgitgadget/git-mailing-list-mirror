Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09119C6377A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42B061244
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhGUX2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGUX2V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:28:21 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A66C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:08:57 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id j1-20020a0568302701b02904d1f8b9db81so3706414otu.12
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ENZP5v3VHco8InMMe8LIhVAGFcqOLRDFvff900m/Fhs=;
        b=R1U6UZRwO5pxfIr7Oak0x7Tf1ibauS0CsYX5vhLp6wnHN1LDemtOUi1WtHOzKJcH6z
         FzgXJDpIfncJUZ9IqLyHjDeS3h5Tf3myul/XDkfdVi2mNIMj7ggKmwcMTyIQYj8f6fcC
         M608YtnESTDOqnTu/0CM0NQcBff4nhxYCoxJ6XQSc22q2mGVQthPGWGZ2zNeLr526cTt
         bzlXI2G8BuhX1C2Sy1PX678FxH4mHdCHFaNV3aVYnPkQwcATQNuw4p/ujsbFM/cDX+7Q
         fUmPFyTvQsclpYiug19p3q4PLn7W8hpUdwfOgFe4ZGSCimAo7Y29rQjGEkxrkM/QBply
         FEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ENZP5v3VHco8InMMe8LIhVAGFcqOLRDFvff900m/Fhs=;
        b=pLyqbRoRlbPW1kA2wjjSnT+ki+EA+fVtMPA8OmHoRVMI4By/CpXk8SUY6ixh+SGD71
         aaO0ptTMoY71UcQru3fnKqCmRtoflPPM3DuK2q6ZID3ww+U24jA0DGX8YImdZ/M+spXT
         +8ihgy6FSJ/xdCL9Kz4hWIXkGZi/kHbZzBHp2W96YhDyzAzM5C93OJNwtXrM4lAQuv5I
         QJEDS+B3+4PbQej/OCZjdSJMMKFhCQbgz706nT/SG3bjpcicyYnm6gGa8bJylxAawiPg
         qPvXFWTVNBzOSwIy4bbYpY99s+DdUkeCrQDfGo2+K7LXrRZQxD2PobLsxOOFKZRVAiSw
         jXcg==
X-Gm-Message-State: AOAM5327D+JkHbkX45WZOmExmI01vAb6kEVYHBpTJxcvRdI4+27tRdwr
        tNwwp1RvU2znCvDbk89p24RlGJ6LOaLDdQ==
X-Google-Smtp-Source: ABdhPJwCwiEePM6sFVMKr6rrTEF3WDPWO/kqE8gvm/Q4fmko954DAzwBD+7Ff1e22gwHyRbpSDnm/w==
X-Received: by 2002:a05:6830:1e4f:: with SMTP id e15mr1988138otj.237.1626912536716;
        Wed, 21 Jul 2021 17:08:56 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f26sm3139444oto.65.2021.07.21.17.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 17:08:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/7] fast-forward: new command with advice and documentation
Date:   Wed, 21 Jul 2021 19:08:47 -0500
Message-Id: <20210722000854.1899129-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fast-forwards have frequently been the subject of debate over the years.
Are they a modifier? (adverb), are they a command? (verb), are they an
object? (noun).

While these semantic debates are unlikely to go away, what is clear is
that people have wanted to do these fast-forwards since as far back as
2008 [1].

Moreover, all the discussions about the brokenness of `git pull` have
lead to the conclusion that to synchronize changes there are three
basic actions users might want to do:

  * fast-forward
  * merge
  * rebase

We have commands for the latter two, why not the former?

`git fast-forward` is much more user friendly than
`git merge --ff-only`, and additionally we can print an advice when the
fast-forward is not possible, plus we can explain in the documentation
what is a fast-forward, when to choose a merge, and when to choose a
rebase:

  git help fast-forward

Moreover, this will help further efforts to fix `git pull` by
simplifying the mental model of users:

  * git pull          -> git fast-forward
  * git pull --merge  -> git merge
  * git pull --rebase -> git rebase

Not to mention other efforts like my proposed `git update` [2].

This is just the first part of my `git update` patch series [2], which
actually received feedback so presumably there's a recognition of
usefulness.

I reordered the series to add the advice first due to comments from
Ævar Arnfjörð Bjarmason, added more clarifications in the commit
messages, fixed one test, and improved the documentation.

This is v1 since the previous series was a RFC and contained a lot more
changes, but I'm attaching the range-diff of these patches anyway.

[1] https://lore.kernel.org/git/loom.20080116T151930-575@post.gmane.org/
[2] https://lore.kernel.org/git/20210705123209.1808663-1-felipe.contreras@gmail.com/

1:  456cc92db3 ! 1:  c04cae2379 merge: improve fatal fast-forward message
    @@ Metadata
      ## Commit message ##
         merge: improve fatal fast-forward message
     
    +    The documentation of --ff-only says:
    +
    +      With `--ff-only`, resolve the merge as a fast-forward when possible.
    +      When not possible, refuse to merge and exit with a non-zero status.
    +
    +    So when the user does --ff-only, and a fast-forward is not possible, the
    +    user wants git to abort, therefore an error message of:
    +
    +     fatal: Not possible to fast-forward, aborting.
    +
    +    is redundant; no need to say ", aborting".
    +
    +    Additionally, use lowercase and lose the full stop to be consistent with
    +    other die() messages.
    +
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## builtin/merge.c ##
5:  fbbde141b3 ! 2:  d99c5ec51e fast-forward: add advice for novices
    @@ Metadata
     Author: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Commit message ##
    -    fast-forward: add advice for novices
    +    merge: add diverging advice for novices
     
    -    It doesn't hurt showing it on `git merge --ff-only` too.
    +    Diverging branches is one of the most confusing aspects of distributed
    +    version control systems for novices, so a little help explaining what to
    +    do on those situations will come in handy.
    +
    +    Right now this advice will be displayed only when the user does
    +    `git merge --ff-only`, `git pull --ff-only`, or has configured
    +    `pull.ff=only` for `git pull`, but in the future it's expected that
    +    --ff-only will be the default for `git pull`, and a proposed `git
    +    fast-forward` command will imply --ff-only, in addition to `git update`.
    +
    +    So it makes sense to add the advice in preparation for those future
    +    changes, although even currently it helps.
     
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
    @@ advice.h: void NORETURN die_resolve_conflict(const char *me);
      #endif /* ADVICE_H */
     
      ## builtin/merge.c ##
    -@@ builtin/merge.c: static int merge_common(int argc, const char **argv, const char *prefix,
    +@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
      		}
      	}
      
6:  75be93e2f6 ! 3:  7bb27c22ad fast-forward: make the advise configurable
    @@ Metadata
     Author: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Commit message ##
    -    fast-forward: make the advise configurable
    +    merge: make the diverging advise configurable
     
         With advice.diverging.
     
2:  4430c62ccc = 4:  d7943e9826 merge: split cmd_merge()
3:  891462cc8b ! 5:  f70db9b464 fast-forward: add new builtin
    @@ Commit message
         This is one of the most common git operations, it makes sense it has its
         own built-in.
     
    +    Additionally it's more user friendly than `git merge` because by default
    +    does --ff-only and thus shows the diverging advice.
    +
    +    Moreover, the documentation about fast-forwards is scattered, by having
    +    a standalone command users can be referred to it very simply:
    +
    +      git help fast-forward
    +
         This is basically the same as `git merge --ff-only` (for now).
     
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
    @@ t/t7600-merge.sh: test_expect_success 'merges with --ff-only' '
     +	test_must_fail git fast-forward c3 &&
     +	test_must_fail git fast-forward c2 c3 &&
     +	git reset --hard c0 &&
    -+	git merge c3 &&
    ++	git fast-forward c3 &&
     +	verify_head $c3
     +'
     +
4:  111a1d7ca4 ! 6:  e4e64401b5 doc: fast-forward: explain what it is
    @@ Documentation/git-fast-forward.txt: DESCRIPTION
     +Then `git fast-forward` will advance the local `master` to `origin/master`:
     +
     +------------
    -+    D---C---B---A master, origin/master
    ++    D---C---B---A origin/master
    ++		^
    ++		|
    ++	      master
     +------------
     +
    -+This operation is not always possible; if you made changes and the branches
    -+have diverged:
    ++This operation is not always possible; if you've made changes and the branches
    ++diverged:
     +
     +------------
     +    D---C---B---A origin/master
7:  d9b0f2c60d ! 7:  d242ac06ae fast-forward: add help about merge vs. rebase
    @@ Metadata
      ## Commit message ##
         fast-forward: add help about merge vs. rebase
     
    +    Now that we have a locus for merge versus rebase documentation, we can
    +    refer to it on the diverging advice.
    +
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Documentation/git-fast-forward.txt ##
    @@ Documentation/git-fast-forward.txt: synchronize the two branches.
     +MERGE OR REBASE
     +---------------
     +
    -+The decision to whether merge or rebase depends on the situation, and the
    ++The decision to whether merge or rebase depends on the situation and the
     +project. Traditionally git has prefered merge over rebase, but that creates a
     +new commit, and that's frowned up on some projects, so you can't just simply
     +choose to merge blindly.
    @@ Documentation/git-fast-forward.txt: synchronize the two branches.
     +------------
     +
     +The nature of distributed version control systems make this divergence
    -+unavoidable. You must decide how to synchronize this divergence.
    ++unavoidable; you must decide how to synchronize this divergence.
     +
    -+If you choose to merge, the two heads (master and origin/master) will be joined
    ++Should you choose to merge, the two heads (master and origin/master) will be joined
     +together in a new commit:
     +
     +------------
    @@ Documentation/git-fast-forward.txt: synchronize the two branches.
     +	  X---Y---+
     +------------
     +
    -+This new commit is called a merge commit and has two parents (A and Y).
    ++This new commit is called a "merge commit" and has two parents (A and Y).
     +
     +Rebasing on the other hand rewrites the history:
     +

Felipe Contreras (7):
  merge: improve fatal fast-forward message
  merge: add diverging advice for novices
  merge: make the diverging advise configurable
  merge: split cmd_merge()
  fast-forward: add new builtin
  doc: fast-forward: explain what it is
  fast-forward: add help about merge vs. rebase

 .gitignore                             |   1 +
 Documentation/config/advice.txt        |   2 +
 Documentation/git-fast-forward.txt     | 107 +++++++++++++++++++++++++
 Makefile                               |   1 +
 advice.c                               |  15 ++++
 advice.h                               |   2 +
 builtin.h                              |   1 +
 builtin/merge.c                        |  47 +++++++----
 contrib/completion/git-completion.bash |  10 +++
 git.c                                  |   1 +
 t/t7600-merge.sh                       |  21 +++++
 11 files changed, 194 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/git-fast-forward.txt

-- 
2.32.0.40.gb9b36f9b52

