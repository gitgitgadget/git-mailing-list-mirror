From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/RFC v2 1/2] parse-options: export opterr, optbug
Date: Sun,  3 Jul 2011 17:04:04 +0600
Message-ID: <1309691045-30180-1-git-send-email-divanorama@gmail.com>
References: <20110629202959.GJ22556@elie>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 13:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdKSM-0003wo-2s
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 13:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695Ab1GCLDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 07:03:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59696 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567Ab1GCLDA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 07:03:00 -0400
Received: by bwd5 with SMTP id 5so3507998bwd.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=s3KetFuVKnqIioVqsHbHB7wldtoCbOImm+/Rz2QjHpM=;
        b=ETKCu0m6Sp4gPXGg9HPm5Ib7YA7kgiHf5UGotDe5a/w2hYCkf8C2cXpwXPGyMSTmnk
         6c1Df90EVaCpGcNEz5gXa3AZV7yH3vrzkyr+zUr52kfvbZ3Dnbkk7Q2KTeN7tIu9R9Jm
         f6kkylAzGqAZJFRp55oj3WhmyUkawksW5gihs=
Received: by 10.204.83.33 with SMTP id d33mr4441504bkl.55.1309690979117;
        Sun, 03 Jul 2011 04:02:59 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id n3sm4598570bka.16.2011.07.03.04.02.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 04:02:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <20110629202959.GJ22556@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176574>

opterror and optbug functions are used by some of parsing routines
in parse-options.c to report errors and bugs respectively.

Export these functions to allow more custom parsing routines to use
them in a uniform way.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 parse-options.c |    4 ++--
 parse-options.h |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 73bd28a..37a1d3b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -11,14 +11,14 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
-static int optbug(const struct option *opt, const char *reason)
+int optbug(const struct option *opt, const char *reason)
 {
 	if (opt->long_name)
 		return error("BUG: option '%s' %s", opt->long_name, reason);
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
-static int opterror(const struct option *opt, const char *reason, int flags)
+int opterror(const struct option *opt, const char *reason, int flags)
 {
 	if (flags & OPT_SHORT)
 		return error("switch `%c' %s", opt->short_name, reason);
diff --git a/parse-options.h b/parse-options.h
index d1b12fe..b392590 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -162,6 +162,8 @@ extern NORETURN void usage_msg_opt(const char *msg,
 				   const char * const *usagestr,
 				   const struct option *options);
 
+extern int optbug(const struct option *opt, const char *reason);
+extern int opterror(const struct option *opt, const char *reason, int flags);
 /*----- incremental advanced APIs -----*/
 
 enum {
-- 
1.7.3.4
