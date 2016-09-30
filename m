Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6D7207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 19:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932953AbcI3Tgm (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:36:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:50611 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932431AbcI3Tgl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:36:41 -0400
Received: (qmail 31251 invoked by uid 109); 30 Sep 2016 19:36:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 19:36:41 +0000
Received: (qmail 13516 invoked by uid 111); 30 Sep 2016 19:36:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 15:36:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 15:36:38 -0400
Date:   Fri, 30 Sep 2016 15:36:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH 5/6] tmp-objdir: put quarantine information in the environment
Message-ID: <20160930193638.lybw4idzwersile7@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The presence of the GIT_QUARANTINE_PATH variable lets any
called programs know that they're operating in a temporary
object directory (and where that directory is).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h      | 1 +
 tmp-objdir.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/cache.h b/cache.h
index 607c9b5..fd81a6c 100644
--- a/cache.h
+++ b/cache.h
@@ -433,6 +433,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_GLOB_PATHSPECS_ENVIRONMENT "GIT_GLOB_PATHSPECS"
 #define GIT_NOGLOB_PATHSPECS_ENVIRONMENT "GIT_NOGLOB_PATHSPECS"
 #define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
+#define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
 
 /*
  * This environment variable is expected to contain a boolean indicating
diff --git a/tmp-objdir.c b/tmp-objdir.c
index c92e6cc..9f53238 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -140,6 +140,8 @@ struct tmp_objdir *tmp_objdir_create(void)
 	env_append(&t->env, ALTERNATE_DB_ENVIRONMENT,
 		   absolute_path(get_object_directory()));
 	env_replace(&t->env, DB_ENVIRONMENT, absolute_path(t->path.buf));
+	env_replace(&t->env, GIT_QUARANTINE_ENVIRONMENT,
+		    absolute_path(t->path.buf));
 
 	return t;
 }
-- 
2.10.0.618.g82cc264

