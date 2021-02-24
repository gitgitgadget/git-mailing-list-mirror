Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A2EC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1F864EDD
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 15:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhBXPxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 10:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbhBXPeB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 10:34:01 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97992C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 07:33:19 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z190so2469004qka.9
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 07:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lGPqFxnsjKwuUAFQqBT7KG/K9ZHLvIIqGhAqnWnzsR8=;
        b=elTRYNomNa9EAHengQ+iizGT44B5YizLWgyz+SV5ewYPpLiTXyffkKMm55ggqrNhzH
         /Hi+DBcHFDg0S8iyQ6AbOaMEwl/pM9JB0/Yxj1+kh7ZREWdOFiOBP3AicNMxcbAByMiZ
         qVRIsTDIRuoJpvxUsxCuetZx9vwE7KL/znyqcdEu3UO3JQ0qMKN89AGhpWWqTN0TGwju
         JnXdYbb4rRb70hGbgpHqJEVQmZHOnReu63xZ5ssmeln/b4tt+329kf0Xi58erg7L5C55
         ZbmcWhxk7dYG0ZW7NDSdP8yAXzjV3vnYTngs0edDboWuQMaZbGIO7MZrg2RyOycIirTI
         /nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lGPqFxnsjKwuUAFQqBT7KG/K9ZHLvIIqGhAqnWnzsR8=;
        b=uO8NtQl6ujUHhmsS0z56rzUXB46xgdRHiyhbxCX0HeOBInuOOWXwf4DBiA8SH9oT62
         jT1F7Y8Xgj91x8jmAD+rxRhWFzdWoJwMnS9hA8XF3y+s+ckCzPoWQPG+U9zAFgIXQhpA
         yCt4liaLBm3NpHjyZaTCDLCfjM04Uq84WDCH3EBqECkfFy5/GuddF3dnQlaz9/GDr9ca
         Nf+P8aXz+B3dAcBrFzV/ve9Nfz8g8Cdc1K875cfU8DV0DdB9IUqghyvvvDssWDIu3oFp
         OZSaPxE1VnMj8HavSUEA9fHQwBXUTE5HVr7NNSFRz4vR6J2eBpAPuVHBaLoZPVMA9zTm
         gQCg==
X-Gm-Message-State: AOAM5336b0KO6ueAflWGnSpkERvKPd6eW0wi9eYsZ0akOQ6J2FlIv9yr
        uKtjxhpLf60qe/5bTwr0vvNVt67zzZawYA==
X-Google-Smtp-Source: ABdhPJxbqnyhJGcwgEMs+yk0svrnKoAT4WSAlYlqBPfO986dTKLNtPEHPeRPOpOtZ9xHzFVgVaCUkA==
X-Received: by 2002:a37:dcf:: with SMTP id 198mr30693713qkn.257.1614180798715;
        Wed, 24 Feb 2021 07:33:18 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j67sm1737490qke.85.2021.02.24.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 07:33:17 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH v2 6/7] add: warn when pathspec only matches SKIP_WORKTREE entries
Date:   Wed, 24 Feb 2021 12:33:10 -0300
Message-Id: <20210224153310.151772-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <CABPp-BEpnaR1tydJ-vcWAUYnT-TFcfCMMqwbmOz1Dx+nvsHZMQ@mail.gmail.com>
References: <CABPp-BEpnaR1tydJ-vcWAUYnT-TFcfCMMqwbmOz1Dx+nvsHZMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 3:50 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Feb 23, 2021 at 8:05 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > +void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
> > +{
> > +       struct string_list_item *item;
> > +
> > +       if (!pathspec_list->nr)
> > +               return;
> > +
> > +       fprintf(stderr, _("The following pathspecs only matched index entries outside the current\n"
> > +                         "sparse checkout:\n"));
> > +       for_each_string_list_item(item, pathspec_list)
> > +               fprintf(stderr, "%s\n", item->string);
>
> Was the use of fprintf(stderr, ...) because of the fact that you want
> to do multiple print statements?  I'm just curious if that was the
> reason for avoiding the warning() function, or if there was another
> consideration at play as well.

Yes, that was one of the reasons. The other was to use the same style as
the ignored files message, which doesn't print the "warning:" prefix.
But I don't have any strong preference here, I'd be OK with using
warning() too.

> > -static void refresh(int verbose, const struct pathspec *pathspec)
> > +static int refresh(int verbose, const struct pathspec *pathspec)
> >  {
> >         char *seen;
> > -       int i;
> > +       int i, ret = 0;
> > +       char *skip_worktree_seen = NULL;
> > +       struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
> > +       int flags = REFRESH_DONT_MARK_SPARSE_MATCHES |
> > +                   (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
> >
> >         seen = xcalloc(pathspec->nr, 1);
> > -       refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET,
> > -                     pathspec, seen, _("Unstaged changes after refreshing the index:"));
> > +       refresh_index(&the_index, flags, pathspec, seen,
> > +                     _("Unstaged changes after refreshing the index:"));
> >         for (i = 0; i < pathspec->nr; i++) {
> > -               if (!seen[i])
> > -                       die(_("pathspec '%s' did not match any files"),
> > -                           pathspec->items[i].original);
> > +               if (!seen[i]) {
> > +                       if (matches_skip_worktree(pathspec, i, &skip_worktree_seen)) {
> > +                               string_list_append(&only_match_skip_worktree,
> > +                                                  pathspec->items[i].original);
> > +                       } else {
> > +                               die(_("pathspec '%s' did not match any files"),
> > +                                   pathspec->items[i].original);
> > +                       }
> > +               }
> > +       }
> > +
> > +       if (only_match_skip_worktree.nr) {
> > +               advise_on_updating_sparse_paths(&only_match_skip_worktree);
> > +               ret = 1;
> >         }
>
> On first reading, I missed that the code die()s if there are any
> non-SKIP_WORKTREE entries matched, and that is the reason you know
> that only SKIP_WORKTREE entries could have been matched for this last
> if-statement.

Hmm, I may be misinterpreting your explanation, but I think the
reasoning is slightly different. The code die()s if there are _no_
matches either among sparse or dense entries. The reason why we know
that only sparse entries matched the pathspecs in this last if-statement
is because the `only_match_skip_worktree` list is only appended when a
pathspec is not marked on seen[] (dense entries only), but it is marked
on skip_worktree_seen[] (sparse entries only).

> Hmm...here's an interesting command sequence:
>
> git init lame
> cd lame
> mkdir baz
> touch baz/tracked
> git add baz/tracked
> git update-index --skip-worktree baz/tracked
> rm baz/tracked.  # But leave the empty directory!
> echo baz >.gitignore
> git add --ignore-missing --dry-run baz
>
>
> Reports the following:
> """
> The following pathspecs only matched index entries outside the current
> sparse checkout:
> baz
> hint: Disable or modify the sparsity rules if you intend to update such entries.
> hint: Disable this message with "git config advice.updateSparsePath false"
> The following paths are ignored by one of your .gitignore files:
> baz
> hint: Use -f if you really want to add them.
> hint: Turn this message off by running
> hint: "git config advice.addIgnoredFile false"
> """

That's interesting. You can also trigger this behavior with a plain add
(i.e. without "--ignore-missing --dry-run").

Since we only get the list of ignored paths from fill_directory(), we
can't really tell whether a specific pathspec item had matches among
ignored files or not. If we had this information, we could conditionally
skip the sparse warning.

I.e. something like this (WARNING: hacky and just briefly tested):

diff --git a/builtin/add.c b/builtin/add.c
index fde6462850..90614e7e76 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -597,3 +597,3 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		int i;
-		char *skip_worktree_seen = NULL;
+		char *skip_worktree_seen = NULL, *ignored_seen = NULL;
 		struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
@@ -621,3 +621,14 @@ int cmd_add(int argc, const char **argv, const char *prefix)

-			if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
+			if (dir.ignored_nr) {
+				int j, prefix_len = common_prefix_len(&pathspec);
+				ignored_seen = xcalloc(pathspec.nr, 1);
+				for (j = 0; j < dir.ignored_nr; j++) {
+					dir_path_match(&the_index, dir.ignored[j],
+						       &pathspec, prefix_len,
+						       ignored_seen);
+				}
+			}
+
+			if (ignored_seen && !ignored_seen[i] &&
+			    matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
 				string_list_append(&only_match_skip_worktree,
diff --git a/dir.c b/dir.c
index d153a63bbd..a19bc7aa0b 100644
--- a/dir.c
+++ b/dir.c
@@ -136,3 +136,3 @@ static int fnmatch_icase_mem(const char *pattern, int patternlen,

-static size_t common_prefix_len(const struct pathspec *pathspec)
+size_t common_prefix_len(const struct pathspec *pathspec)
 {
diff --git a/dir.h b/dir.h
index facfae4740..aa2d4aa71b 100644
--- a/dir.h
+++ b/dir.h
@@ -355,2 +355,3 @@ int simple_length(const char *match);
 int no_wildcard(const char *string);
+size_t common_prefix_len(const struct pathspec *pathspec);
 char *common_prefix(const struct pathspec *pathspec);


Now `git add baz` would only produce:

The following paths are ignored by one of your .gitignore files:
baz
hint: Use -f if you really want to add them.
hint: Turn this message off by running
hint: "git config advice.addIgnoredFile false"

