Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04CE207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031210AbdDTVIo (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:08:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:37257 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031098AbdDTVIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:08:43 -0400
Received: (qmail 2029 invoked by uid 109); 20 Apr 2017 21:08:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 21:08:43 +0000
Received: (qmail 9654 invoked by uid 111); 20 Apr 2017 21:09:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 17:09:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:08:41 -0400
Date:   Thu, 20 Apr 2017 17:08:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] branch: add edit_description() helper
Message-ID: <20170420210840.hufdbroebp2dpcsz@sigill.intra.peff.net>
References: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420210754.bzrnc74dpjs7fgpf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than have a variable with a short name that is fed to
git_path(), let's add a helper function that returns the
full path. This avoids the dangerous git_path() function.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0552c42ad..48a513a84 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -504,7 +504,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	strbuf_release(&newsection);
 }
 
-static const char edit_description[] = "BRANCH_DESCRIPTION";
+static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
 {
@@ -519,9 +519,9 @@ static int edit_branch_description(const char *branch_name)
 		      "  %s\n"
 		      "Lines starting with '%c' will be stripped.\n"),
 		    branch_name, comment_line_char);
-	write_file_buf(git_path(edit_description), buf.buf, buf.len);
+	write_file_buf(edit_description(), buf.buf, buf.len);
 	strbuf_reset(&buf);
-	if (launch_editor(git_path(edit_description), &buf, NULL)) {
+	if (launch_editor(edit_description(), &buf, NULL)) {
 		strbuf_release(&buf);
 		return -1;
 	}
-- 
2.13.0.rc0.363.g8726c260e

