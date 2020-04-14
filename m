Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D4C2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 23:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E9920578
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 23:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WrehLP2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634448AbgDNXvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634444AbgDNXvC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 19:51:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14616C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 16:51:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b8so699243pfp.8
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1zX1/19mrRIQ4NQtx5MgWYop9go1rWqyv3HnF1H2rCo=;
        b=WrehLP2e1XRP4l3W4HhwDnyL/ES++y5MTM9Wkn7/zfP7hMOAH/e75Hd84YqH15vYkV
         5DyL20+4Z30IFJXltyWP+oLpMzG4uFF6tNlZLVWWtrgFt1Ecb/xTSOPl+zyyVhSglLBo
         p9biOrSzG4LUiDOLMWQAk94iYQ1bcb6jpcxEO+E6KfR1C9pnKPBOJ3RJcn7gMRE+3wiI
         EAOrDH5jwApjZ+R0HWlSOJn57NUnkzC95qM6x5Xia4gstwF8lzSeRuAZVnoVCxEV+s/9
         ASmoNcT4o1zayuZStOr1jHj6ziPFajvY+cL81FdrCyd0deWb03TXERlVBxuDQLJcax2g
         Y83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1zX1/19mrRIQ4NQtx5MgWYop9go1rWqyv3HnF1H2rCo=;
        b=MVQowJEVmvV6c9dl6X4b0DTHnQkgMBwhrldpc2TGeGvduGEYkrSoDmNEB9YfGKUJFR
         GyxedECykh4D3/X/qq0AbRxrTW1l7Stjb67c8AiFiDC43UrGTEeWz+0I5j0d1BEoc3tK
         pUQaJKS1xNIUP7EDC+77iuTLLIqorV8rpcSNsZt+r5GDMiTN0H5nl+h+9m3/+jyiAII9
         iB+N+rz03TYmsAClT5qrmpSCe9mDbCnNDSoDoDnd32MtDbdhxNrAvxbd0TMkmWauOU8G
         H2XIw8BAVoWPrS8EtvfQ/GGLnNVF2cTwPaNVjzE+vsmPHewFz7uJzKnmx4Z9ZsSBDR7c
         mg0w==
X-Gm-Message-State: AGi0PuYrM+gFvg6RSW9tEoHUvenOom39HPZVtf+1NTydCiwArbOCwhDj
        ll5JkaRF/40oscfSNqT5OSxjzvHZ1qP0n4sR
X-Google-Smtp-Source: APiQypKrgdL2znFpLMF6L/xJsfY4jDqeS6MbTtSeiug4JaC0AGZZwo0GaG5ICCPmehNjJ3nyNSPTMg==
X-Received: by 2002:a62:188e:: with SMTP id 136mr26668133pfy.110.1586908260397;
        Tue, 14 Apr 2020 16:51:00 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i128sm2929953pfc.149.2020.04.14.16.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:50:59 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:50:57 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Is fetch.writeCommitGraph (and thus features.experimental) meant
 to work in the presence of shallow clones?
Message-ID: <20200414235057.GA6863@syl.local>
References: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
 <aca12331-f8e3-28a2-acb6-df9d7e2e70e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aca12331-f8e3-28a2-acb6-df9d7e2e70e1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 04:31:19PM -0400, Derrick Stolee wrote:
> On 4/14/2020 4:22 PM, Elijah Newren wrote:
> > Hi,
> >
> > I was building a version of git for internal use, and thought I'd try
> > turning on features.experimental to get more testing of it.  The
> > following test error in the testsuite scared me, though:
> >
> > t5537.9 (fetch --update-shallow):
> >
> > ...
> > + git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
> > remote: Enumerating objects: 18, done.
> > remote: Counting objects: 100% (18/18), done.
> > remote: Compressing objects: 100% (6/6), done.
> > remote: Total 16 (delta 0), reused 6 (delta 0), pack-reused 0
> > Unpacking objects: 100% (16/16), 1.16 KiB | 1.17 MiB/s, done.
> > From ../shallow/
> >  * [new branch]      master     -> shallow/master
> >  * [new tag]         heavy-tag  -> heavy-tag
> >  * [new tag]         light-tag  -> light-tag
> > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > fatal: unable to parse commit ac67d3021b4319951fb176469d7732e6914530c5
> >
> > Passing -c fetch.writeCommitGraph=false to the fetch command in that
> > test makes it pass.
> >
> > There were also a couple other tests that failed with
> > features.experimental=true (in t5500), but those weren't scary -- they
> > were just checking exact want/have lines and features.experimental is
> > intended to change those.  This test from t5537 was the only one that
> > showed some unexpected fatal error.
>
> Well, commit-graphs are not supposed to do anything if we have
> shallow clones. We definitely don't load a commit-graph in that
> case. Seems like we need an extra check in write_commit_graph()
> to stop writing in the presence of shallow commits.

This rang a bell to me, too. There's a bug, but it's due to the mutative
side-effects of 'is_repository_shallow' along with '--update-shallow' (a
normal 'git fetch' works fine here, with or without
fetch.writeCommitGraph).

Here's a patch that I didn't sign-off on that fixes the problem for me.

--- >8 ---

Subject: [PATCH] shallow.c: use 'reset_repository_shallow' when appropriate

In bd0b42aed3 (fetch-pack: do not take shallow lock unnecessarily,
2019-01-10), the author noted that 'is_repository_shallow' produces
visible side-effect(s) by setting 'is_shallow' and 'shallow_stat'.

This is a problem for e.g., fetching with '--update-shallow' in a
shallow repsoitory with 'fetch.writeCommitGraph' enabled, since the
update to '.git/shallow' will cause Git to think that the repository
*isn't* shallow when it is, thereby circumventing the commit-graph
compatability check.

This causes problems in shallow repositories with at least shallow refs
that have at least one ancestor (since the client won't have those
object(s), and therefore can't take the reachability closure over
commits to be written to the commit-graph).

Address this by introducing 'reset_repository_shallow()', and calling it
when the shallow file is updated, forcing 'is_repository_shallow' to
re-evaluate whether the repository is still shallow after fetching in
the above scenario.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit.h     |  1 +
 fetch-pack.c |  1 +
 shallow.c    | 15 ++++++++-------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/commit.h b/commit.h
index 008a0fa4a0..ee1ba139d4 100644
--- a/commit.h
+++ b/commit.h
@@ -251,6 +251,7 @@ int register_shallow(struct repository *r, const struct object_id *oid);
 int unregister_shallow(const struct object_id *oid);
 int for_each_commit_graft(each_commit_graft_fn, void *);
 int is_repository_shallow(struct repository *r);
+void reset_repository_shallow(struct repository *r);
 struct commit_list *get_shallow_commits(struct object_array *heads,
 					int depth, int shallow_flag, int not_shallow_flag);
 struct commit_list *get_shallow_commits_by_rev_list(
diff --git a/fetch-pack.c b/fetch-pack.c
index 1734a573b0..051902ef6d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1630,6 +1630,7 @@ static void update_shallow(struct fetch_pack_args *args,
 		if (*alternate_shallow_file == '\0') { /* --unshallow */
 			unlink_or_warn(git_path_shallow(the_repository));
 			rollback_lock_file(&shallow_lock);
+			reset_repository_shallow(the_repository);
 		} else
 			commit_lock_file(&shallow_lock);
 		alternate_shallow_file = NULL;
diff --git a/shallow.c b/shallow.c
index 7fd04afed1..fac383dec9 100644
--- a/shallow.c
+++ b/shallow.c
@@ -40,13 +40,6 @@ int register_shallow(struct repository *r, const struct object_id *oid)

 int is_repository_shallow(struct repository *r)
 {
-	/*
-	 * NEEDSWORK: This function updates
-	 * r->parsed_objects->{is_shallow,shallow_stat} as a side effect but
-	 * there is no corresponding function to clear them when the shallow
-	 * file is updated.
-	 */
-
 	FILE *fp;
 	char buf[1024];
 	const char *path = r->parsed_objects->alternate_shallow_file;
@@ -79,6 +72,12 @@ int is_repository_shallow(struct repository *r)
 	return r->parsed_objects->is_shallow;
 }

+void reset_repository_shallow(struct repository *r)
+{
+	r->parsed_objects->is_shallow = -1;
+	stat_validity_clear(r->parsed_objects->shallow_stat);
+}
+
 /*
  * TODO: use "int" elemtype instead of "int *" when/if commit-slab
  * supports a "valid" flag.
@@ -362,6 +361,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 		 * shallow file".
 		 */
 		*alternate_shallow_file = "";
+	reset_repository_shallow(the_repository);
 	strbuf_release(&sb);
 }

@@ -411,6 +411,7 @@ void prune_shallow(unsigned options)
 			die_errno("failed to write to %s",
 				  get_lock_file_path(&shallow_lock));
 		commit_lock_file(&shallow_lock);
+		reset_repository_shallow(the_repository);
 	} else {
 		unlink(git_path_shallow(the_repository));
 		rollback_lock_file(&shallow_lock);
--
2.26.0.106.g9fadedd637
