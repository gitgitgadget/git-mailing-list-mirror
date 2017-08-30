Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13302208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbdH3HGO (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:06:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37168 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbdH3HGN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:06:13 -0400
Received: by mail-pf0-f194.google.com with SMTP id a2so3804782pfj.4
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=geJ/HmU/6CKI+TOLcMVyz02c4bG5IwgC2OFjE9GktE4=;
        b=K70evaB6Cjal29JBQH+c3DMjwvpOVi6QUQ+iYtAQ8aJZzaGMbgMAjYZjCzsljUQj3r
         W48mMWzZ9ijDHT2iwmlookmQFn4do/itl9k3SSUmYoL2FU8HY11v+oEQbe1OgvXr3Dwq
         wSRW5SmzritX03WMkV446zj/d8jGkiKXe+1O85/M3U7ArByzWhvrF2IXho9ToNWmjXCM
         jWNQ6ZQMubyzYqS7rNGRxMKEwU7rBN9ejvjT2CEaFti4A3hsnLSnFLL+9WgZ+TjILCrL
         mkI0n3tyBoQmGxOYYAnPB6SMyMOBsc/YCle4jokN/596qWFnJ40as9SWvGL8tRt0v6eh
         sWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=geJ/HmU/6CKI+TOLcMVyz02c4bG5IwgC2OFjE9GktE4=;
        b=FUCSmNUWLyzNB90GuwFnhLIVdoiYvLv9bNBP+V5s6bVGd/zzW5zznYESkzoC+TYXjE
         CRuuiEAoKFuiLsGftKUBGOVn649hy3gjdmNSxX39JUwInq2wZVllwzE/nx4RVoqSVIar
         RuQUJraBSb6ZzaAiRL1pJCAWwm/WPSYuIHDyvbT3oM3O/umRFOvPu4VXAmA1YNubJGkO
         m/h3pyCr9XfBnTAVxV9WUMPMbKYhJQl7HBjUeRzPIFh5em17tM6KuyhV2zh/YObdO89f
         4Gsz2Tlg/0kxQaLhj5V+lA9pqa43XMGWbyclWTkrdlluRK8ajVKpsnEHW+u/j5XU1VmH
         pqzg==
X-Gm-Message-State: AHYfb5gtclzlUQudPqC9mkVR+OQE+gceA7M6HV5erCYQVnuU/WDtP6p/
        ZgpvD1DKveL7Runep8Y=
X-Received: by 10.99.186.93 with SMTP id l29mr599443pgu.300.1504076772636;
        Wed, 30 Aug 2017 00:06:12 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id y81sm7707457pfi.153.2017.08.30.00.06.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:06:12 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:06:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 22/39] pack: add repository argument to reprepare_packed_git
Message-ID: <20170830070610.GW153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow reprepare_packed_git_mru callers to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Callers adapted using contrib/coccinelle/packed_git.cocci.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/gc.c                        | 2 +-
 builtin/receive-pack.c              | 3 ++-
 bulk-checkin.c                      | 3 ++-
 contrib/coccinelle/packed_git.cocci | 4 ++++
 fetch-pack.c                        | 3 ++-
 packfile.c                          | 2 +-
 packfile.h                          | 3 ++-
 sha1_file.c                         | 2 +-
 8 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 11312529c8..d0da9e5403 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -475,7 +475,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		return error(FAILED_RUN, rerere.argv[0]);
 
 	report_garbage = report_pack_garbage;
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 	if (pack_garbage.nr > 0)
 		clean_pack_garbage();
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6657ba1375..97750d0d4e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "repository.h"
 #include "config.h"
 #include "lockfile.h"
 #include "pack.h"
@@ -1779,7 +1780,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		status = finish_command(&child);
 		if (status)
 			return "index-pack abnormal exit";
-		reprepare_packed_git();
+		reprepare_packed_git(the_repository);
 	}
 	return NULL;
 }
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 9a1f6c49ab..96f37100fc 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "bulk-checkin.h"
+#include "repository.h"
 #include "csum-file.h"
 #include "pack.h"
 #include "strbuf.h"
@@ -57,7 +58,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 
 	strbuf_release(&packname);
 	/* Make objects we just wrote available to ourselves */
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 }
 
 static int already_written(struct bulk_checkin_state *state, unsigned char sha1[])
diff --git a/contrib/coccinelle/packed_git.cocci b/contrib/coccinelle/packed_git.cocci
index 7554f4773c..0cb0e95f82 100644
--- a/contrib/coccinelle/packed_git.cocci
+++ b/contrib/coccinelle/packed_git.cocci
@@ -9,3 +9,7 @@
 @@ @@
 - prepare_packed_git()
 + prepare_packed_git(the_repository)
+
+@@ @@
+- reprepare_packed_git()
++ reprepare_packed_git(the_repository)
diff --git a/fetch-pack.c b/fetch-pack.c
index 105506e9aa..e9a6683437 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "lockfile.h"
 #include "refs.h"
@@ -1168,7 +1169,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	prepare_shallow_info(&si, shallow);
 	ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 				&si, pack_lockfile);
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 	update_shallow(args, sought, nr_sought, &si);
 	clear_shallow_info(&si);
 	return ref_cpy;
diff --git a/packfile.c b/packfile.c
index 34b887e7e5..86c3964018 100644
--- a/packfile.c
+++ b/packfile.c
@@ -883,7 +883,7 @@ void prepare_packed_git_the_repository(void)
 	the_repository->objects.packed_git_initialized = 1;
 }
 
-void reprepare_packed_git(void)
+void reprepare_packed_git_the_repository(void)
 {
 	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
diff --git a/packfile.h b/packfile.h
index e543a98b23..74f293c439 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,7 +34,8 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 #define prepare_packed_git(r) prepare_packed_git_##r()
 extern void prepare_packed_git_the_repository(void);
-extern void reprepare_packed_git(void);
+#define reprepare_packed_git(r) reprepare_packed_git_##r()
+extern void reprepare_packed_git_the_repository(void);
 #define install_packed_git(r, p) install_packed_git_##r(p)
 extern void install_packed_git_the_repository(struct packed_git *pack);
 
diff --git a/sha1_file.c b/sha1_file.c
index 8c599dbfc2..6af88e5b04 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1209,7 +1209,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		if (flags & OBJECT_INFO_QUICK) {
 			return -1;
 		} else {
-			reprepare_packed_git();
+			reprepare_packed_git(the_repository);
 			if (!find_pack_entry(real, &e))
 				return -1;
 		}
-- 
2.14.1.581.gf28d330327

