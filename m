Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD7F208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbdH3HIP (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:08:15 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38625 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdH3HIP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:08:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so3803078pfr.5
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NO8N/1eVPBc1bLCtN4pXAGAOtSddicB6PCshbWHke9Y=;
        b=Ys22iI2D8LOUvy3kHPxB69srQaD4qkJ7MISeR8CJxAc+6zTTLloz6ehJjEvG1rVX7Y
         ub5e4SXt0g6r6BV6lZliKWaj/3Fk3B3MxsNQo3hDmrnvhDpZQr1ObrolFdmbLDfDspXW
         AbWEwqxZ9+7wqhiYurlE2sQDRKt+n6CkPhWcKp8/xBx+8yBjT7MgPNseDRQaz4J3BbtP
         CkPBAZI+H/t7lngQrF527u6p3RKyetYnz47DrL+ff9jE9l/GkmnOEvCOUn5TZgHJxx2j
         rXO6pPbWv+Bhx8ba/ZcICJ5tkuksIqvuO6f4MkISPFqf8ichg5uVcFBHObRs3XQFiASD
         AH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NO8N/1eVPBc1bLCtN4pXAGAOtSddicB6PCshbWHke9Y=;
        b=UW3FUDAULZX1Ev6M7gYl7FxKobzCeIKNGH3kURAPlGK3jkBRdz9hMLBUB+9zArGFJf
         gDDOT1XRgGw7rBsFCc6sLRyZrsaxJuPO6bB0kH5oI17Bh6DRy4b7AETe+b1NAgkMRadp
         hbLdpxXgRVAZ40lxSpxFQtf0TUltt0sxrg7CQH7KBr+XGEJOyHGjPC/c71KM71lOY258
         nnTnI2vsETfgsJBYfaP1YrpgCIPGidS7ez9lgGtuQnQOvE/dyVWgfMk76lVfYLuY+FrO
         PwB43WuGN4x+Y2WEEUfOBHc2guN0NM9VmEXL0EYnSKMYDaur5qzMJZjnSorukVCvlb2x
         sfgA==
X-Gm-Message-State: AHYfb5ijGwX8VXEWKHrEoxYbzRy9OOrYjlyOKHnwPz8xWYZsxaIqopG9
        nu/pbWGrmT4Nt1UU0Kc=
X-Received: by 10.84.210.175 with SMTP id a44mr759855pli.372.1504076894357;
        Wed, 30 Aug 2017 00:08:14 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id p71sm8534234pfl.56.2017.08.30.00.08.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:08:13 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:08:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 25/39] sha1_file: allow alt_odb_usable to handle arbitrary
 repositories
Message-ID: <20170830070812.GZ153983@aiede.mtv.corp.google.com>
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

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1_file.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index e7c86e5363..b854cad970 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -25,6 +25,7 @@
 #include "repository.h"
 #include "object-store.h"
 #include "streaming.h"
+#include "path.h"
 #include "dir.h"
 #include "mru.h"
 #include "list.h"
@@ -281,17 +282,18 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-#define alt_odb_usable(r, p, n) alt_odb_usable_##r(p, n)
-static int alt_odb_usable_the_repository(struct strbuf *path,
-					 const char *normalized_objdir)
+static int alt_odb_usable(struct repository *r, struct strbuf *path,
+			  const char *normalized_objdir)
 {
 	struct alternate_object_database *alt;
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path->buf)) {
-		error("object directory %s does not exist; "
-		      "check .git/objects/info/alternates.",
-		      path->buf);
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_repo_git_path(&sb, r, "objects/info/alternates");
+		error("object directory %s does not exist; check %s",
+		      path->buf, sb.buf);
+		strbuf_release(&sb);
 		return 0;
 	}
 
@@ -299,7 +301,7 @@ static int alt_odb_usable_the_repository(struct strbuf *path,
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
-- 
2.14.1.581.gf28d330327

