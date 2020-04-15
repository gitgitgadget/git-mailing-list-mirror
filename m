Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA5DC2BA2B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 04:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FF22078B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 04:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="sKafc+zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbgDOE3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 00:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgDOE3e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 00:29:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E96C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 21:29:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i3so947678pgk.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 21:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6jvuVymPpnXURx0vw0AMTqbutc8WcY8rf7IlayjqHYo=;
        b=sKafc+zyqKIBauvN7HMNgFax8Tu752g9Y4OT68lmkOsfqdjz/ihMrH3/HDHL0m8ZEl
         3VLXFZTaRPnj1v1AomDIzmOE92hdQgn/7pGMqH1XjZgEJrO2zAlV8yzzu8AchatSWESB
         Hc2j0SJg7hkweeiObH2RQAACzrpqW7zvDoXgFwNopY1MAtpmsUKh74UTRwimu8mmOGFR
         zDN3HO0XKSyOgFX1W+pGApl/9naudDBimYl0aSuECh6JfrWTVvDdwjx5KQ8sbhufbGBE
         T002SJS/l+Gcj2BP+A+z4z7WtcojD4Alillh0ZIZhniJoUuNr/n3TFPddBTaVmEdLxIf
         jwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6jvuVymPpnXURx0vw0AMTqbutc8WcY8rf7IlayjqHYo=;
        b=U7wtD3HD1Q5+3BuLT9v6prpqAOtJzZDOyNcfK/qcJofPvzj6OHRTET81uwinE/joFS
         vWONkK6FYOS2MeWInldMUsKnGhM2hzFor/e+/UL+ZeUjcB8LSXfcG6nrahNkqjVPGZo5
         XYmjDSkwAcvGX4TNeMy1sLgk9YvSyEcAd58BE4fGJjcXk7T4vt9fvw7FJ+GDBW49VH+G
         nSuDgHci2FjKWm67eI2Ge9BAIIDUfDDKyZYYqr1MQsDTEdOw/KEfjlwT4vk76dF7UI63
         Knz95sYouLYmKFgpV8M040KbARrzFO0seug9ziBSTeMf/Qwfov/FDGW53nGJdxbnz9RT
         4OlA==
X-Gm-Message-State: AGi0PuYvGoeD/PiAKtE6kaMubkA3ZFg8f63qJSxyov2AAmHjZ1LZ9Rd9
        Qq88kXSfMrDUf7n+Zk38iEuGDo4EvtAn85U1
X-Google-Smtp-Source: APiQypL0IrkzZ8smH7bzn0pLvb0Lv1q6CNDi0rNBtF7j6B1sTlXM5iIZq3ELU09U9m0ZIdSfjGMraw==
X-Received: by 2002:aa7:8042:: with SMTP id y2mr11902493pfm.94.1586924972679;
        Tue, 14 Apr 2020 21:29:32 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q187sm7904435pfb.131.2020.04.14.21.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 21:29:31 -0700 (PDT)
Date:   Tue, 14 Apr 2020 22:29:30 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH 7/7] commit-graph.c: introduce '--[no-]check-oids'
Message-ID: <20200415042930.GA11703@syl.local>
References: <cover.1586836700.git.me@ttaylorr.com>
 <1ff42f4c3d568dd25889d2808cda3edf38a36cb9.1586836700.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ff42f4c3d568dd25889d2808cda3edf38a36cb9.1586836700.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whoops. I sent the wrong version of this patch. It should be the below:

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
