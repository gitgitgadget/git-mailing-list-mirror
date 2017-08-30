Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5DD208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdH3HCx (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:02:53 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36921 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdH3HCw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:02:52 -0400
Received: by mail-pg0-f68.google.com with SMTP id t193so4476229pgc.4
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NuuJUSpUgxfdl/1yC0hkonP7t6OfyFoXwa33gGGA5Xc=;
        b=kK694bKRwwn33CNRwbgZsHjZhGfK30F33B4uikGLo/p2ysMlPJI9OZwxa/Qj33Q4+H
         YmnkSssPO5c5RVQhAK4d+C/rJIdYCJHELUSBtcpK5g1w6nhO9aigj9XoG/AA7upK5wkN
         4/7sjyXDEz+/lnlicmgrUx4XTUeEC5zyEO3Iff+8NnA5epBDCpu3+oS5bLwM4GQ/oQHd
         9XUMQi1D5IX7yd+jjbUNCb53a8N3dgWgrsYDerM9xS1EqOvs6Z20I0d+WllHVWgs1PUl
         OG5gz2rM5aBsgSN1Q227Yg4HhT5GqN5uc0uZcFo6mIvwH2eQayUdLak/fBGzM4jHOVkw
         MDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NuuJUSpUgxfdl/1yC0hkonP7t6OfyFoXwa33gGGA5Xc=;
        b=tVdEKHE8JlZcXnyWUwfF9UjiOnafVjXkBoRkLSeZjEKrVj2K705uE522YnvJiDs1vV
         4/hNhj8E+GrqrnnrytbXTEI7jLuekMdychvi6jkvu42mHzQ6eZmi+xzwfNpTKbRu95Pc
         y3IV28Dz9iTII+ix3W6Ra9aueFEkNVKnp4kJnhcHlcYDfKCWDWl0fSwt7ZcPS5LbXeOS
         7BpPVUl2M/cFFnyJWjxaMmR+BoyrjlSHavFZiC4F6jNnMByEkIKbKWNd4w6SxIvwyfdI
         S14ece98cAiJAJSX0HmiZXDHtRDlATTv876bDinQLLCER4nKmfSRA/bJv3G9esyqbVTl
         IbbQ==
X-Gm-Message-State: AHYfb5jgMdCo6lGHVOcDfIUXUVuG2qaGUUlxYeUfdSnhbI1H6QkYGqXy
        /SsgoghYPKUCT78TXM0=
X-Received: by 10.98.152.157 with SMTP id d29mr618353pfk.139.1504076572170;
        Wed, 30 Aug 2017 00:02:52 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id l14sm7933314pgu.46.2017.08.30.00.02.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:02:51 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:02:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 17/39] pack: add repository argument to install_packed_git
Message-ID: <20170830070250.GR153983@aiede.mtv.corp.google.com>
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

Add a repository argument to allow install_packed_git callers to be
more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c | 2 +-
 http.c        | 3 ++-
 packfile.c    | 4 ++--
 packfile.h    | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 9a725ebf4f..4c3b3d9df6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1038,7 +1038,7 @@ static void end_packfile(void)
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] = new_p;
-		install_packed_git(new_p);
+		install_packed_git(the_repository, new_p);
 		free(idx_name);
 
 		/* Print the boundary */
diff --git a/http.c b/http.c
index 3186de107b..0979053272 100644
--- a/http.c
+++ b/http.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "http.h"
+#include "repository.h"
 #include "config.h"
 #include "object-store.h"
 #include "pack.h"
@@ -2049,7 +2050,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		return -1;
 	}
 
-	install_packed_git(p);
+	install_packed_git(the_repository, p);
 	free(tmp_idx);
 	return 0;
 }
diff --git a/packfile.c b/packfile.c
index 2cd61b32a3..cea3698af5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -664,7 +664,7 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	return p;
 }
 
-void install_packed_git(struct packed_git *pack)
+void install_packed_git_the_repository(struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
@@ -766,7 +766,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 			     * corresponding .pack file that we can map.
 			     */
 			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(p);
+				install_packed_git(the_repository, p);
 		}
 
 		if (!report_garbage)
diff --git a/packfile.h b/packfile.h
index 0cdeb54dcd..7e6959d440 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,7 +34,8 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
-extern void install_packed_git(struct packed_git *pack);
+#define install_packed_git(r, p) install_packed_git_##r(p)
+extern void install_packed_git_the_repository(struct packed_git *pack);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
-- 
2.14.1.581.gf28d330327

