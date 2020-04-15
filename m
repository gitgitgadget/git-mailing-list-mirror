Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63719C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336502076D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jeu4peI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgDOWCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730034AbgDOWCr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 18:02:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AD5C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 15:02:45 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so638441pfc.12
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RFy410QuTVY/tRn1RZK+4meEBtrSGNmaG+W8E0BnsZc=;
        b=jeu4peI3pUPnozX/Rpm/CtC7Iw7n3Aqg4bhbzmTEL+3MeNQZlRoukxvWJHYbtad990
         +Dg69nG5qkW/EcYPNpyY1gIx9vc5dVzgTPptd/jNKmYPqRA9BJT/zGrbJ/VrQdHbiLXg
         tMFCjEHhoRBxRvlAvHkmpylKavfLsvVhDRXpDKUNqyl8VeTAeaxs/qFtYS2M4x4swKjF
         spGNgNw0Q+ZdKkCwwcJMOoE8VXv+LSsWLgfTaP14W3w0t/8PoGTe2tFGRXVj2iHK5fVM
         VC+FHh9YX0W2HM86kFQ0FNuTStLojfo6MtxKMDH9BFCA5OflPY4PTXVmfQurlJEBymm0
         cnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RFy410QuTVY/tRn1RZK+4meEBtrSGNmaG+W8E0BnsZc=;
        b=S2HcZdb7kH2o9XW1UjQmd1jjY6GTLpPwihJ5a14Us7kEZ7tbfUFisUvSg+0BcOJZlX
         JdP3E7eLjjoOAq+wISjo2X6QAD6SYZmCXMVN27apEH5O09Rjfs7MBaKh6VcvU0nbwFvi
         85/NKBt3N2cRf3fgeadsj5SqA7mzi3cmqx2gFXM4QPUUBgzpZYzPRXJTHXq3L/3/oD5y
         6XM+O9hAvZl2vEOFJGGBaV8f3dQsna4Xdqd/KKEbTkNhdwcYZ6at1MBZzcZe29rmf4wC
         NUzI03nscWeTXMZgqAZ67nb9gI3dgRdH6PqwXvy10f3dvSJkbahRPmiGWVOCmIJoX8Yq
         9sBw==
X-Gm-Message-State: AGi0Pua0enZ6nTGvujroz6ihq/zFWwnFf12g+5ZgTl2ptou27yhZgTSe
        SD5gdWyTFyQLPGyuF5m2+Pw8mtOI+dDCHzD1
X-Google-Smtp-Source: APiQypIkEZM8y2ZVgbxZmZPhH76qaxBADlRn27TINSMk123JNdLS+AecxHqNU8LTNOoUgFaKw33gPA==
X-Received: by 2002:a63:e54a:: with SMTP id z10mr28490439pgj.346.1586988165004;
        Wed, 15 Apr 2020 15:02:45 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id l24sm1022678pgo.79.2020.04.15.15.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 15:02:44 -0700 (PDT)
Date:   Wed, 15 Apr 2020 16:02:42 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vasil Dimov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vasil Dimov <vd@freebsd.org>
Subject: Re: [PATCH 1/2] range-diff: fix a crash in parsing git-log output
Message-ID: <20200415220242.GA45241@syl.local>
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
 <2375e34100e571f9c3ce658d28aba6648fba18a6.1586960921.git.gitgitgadget@gmail.com>
 <xmqqsgh47okk.fsf@gitster.c.googlers.com>
 <20200415162326.GG2464307@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415162326.GG2464307@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, Apr 15, 2020 at 12:23:26PM -0400, Jeff King wrote:
> On Wed, Apr 15, 2020 at 08:31:39AM -0700, Junio C Hamano wrote:
>
> > "Vasil Dimov via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > From: Vasil Dimov <vd@FreeBSD.org>
> > >
> > > `git range-diff` calls `git log` internally and tries to parse its
> > > output. But `git log` output can be customized by the user in their
> > > git config and for certain configurations either an error will be
> > > returned by `git range-diff` or it will crash.
> > >
> > > To fix this explicitly set the output format of the internally
> > > executed `git log` with `--pretty=medium`. Because that cancels
> > > `--notes`, add explicitly `--notes` at the end.
> >
> > Good finding.
> >
> > Shouldn't we also disable customizations that come from the
> > configuration variables like diff.external, diff.<driver>.command?
>
> If range-diff were a script, I would say it should be using the
> "rev-list | diff-tree --stdin" plumbing under the hood, rather than
> "log".
>
> The read_patches() function does let callers pass options to git-log,
> but I don't _think_ this is exposed to the user. We only allow a few
> --notes options to be passed, and we should be able to apply those to
> diff-tree. So converting it to use plumbing might be an option.
>
> Though I think there is another bug:
>
>   $ git rev-list HEAD | git diff-tree --stdin --pretty=medium --notes
>   commit 8f3d9f354286745c751374f5f1fcafee6b3f3136
>   git: notes.c:1308: format_display_notes: Assertion `display_notes_trees' failed.
>   Aborted

Nice find. I think that I have a patch addressing this below. Please let
me know what you think:

--- >8 ---

Subject: [PATCH] diff-tree.c: load notes machinery with '--notes'

Since its introduction in 7249e91 (revision.c: support --notes
command-line option, 2011-03-29), combining '--notes' with '--pretty'
causes 'git diff-tree' to fail a runtime assertion:

  $ git rev-list HEAD | git diff-tree --stdin --pretty=medium --notes
  commit 8f3d9f354286745c751374f5f1fcafee6b3f3136
  git: notes.c:1308: format_display_notes: Assertion `display_notes_trees' failed.
  Aborted

This failure is due to diff-tree not calling 'load_display_notes' to
initialize the notes machinery.

Ordinarily, this failure isn't triggered, because it requires passing
both '--notes' and '--pretty'. Specifically, passing '--pretty' sets
'opt->verbose_header', causing 'show_log()' to eventually call
'format_display_notes()', which expects a non-NULL 'display_note_trees'.
Without initializing the notes machinery, 'display_note_trees' remains
NULL, and thus triggers an assertion failure. This doesn't occur without
'--pretty' since we never call 'format_display_notes()' without it.

Fix this by initializing the notes machinery after parsing our options,
and harden this behavior against regression with a test in t4013.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/diff-tree.c     | 2 ++
 t/t4013-diff-various.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index cb9ea79367..17c1cc8c3c 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -126,6 +126,8 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)

 	precompose_argv(argc, argv);
 	argc = setup_revisions(argc, argv, opt, &s_r_opt);
+	if (opt->show_notes)
+		load_display_notes(&opt->notes_opt);

 	while (--argc > 0) {
 		const char *arg = *++argv;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index dde3f11fec..6ae8cfb271 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -398,6 +398,7 @@ diff --no-index --raw --no-abbrev dir2 dir

 diff-tree --pretty --root --stat --compact-summary initial
 diff-tree --pretty -R --root --stat --compact-summary initial
+diff-tree --pretty --notes initial
 diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
--
2.26.0.106.g9fadedd637
