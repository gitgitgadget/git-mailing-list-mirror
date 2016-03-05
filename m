From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] use setup_git_directory() in test-* programs
Date: Sat, 5 Mar 2016 17:16:50 -0500
Message-ID: <20160305221650.GF31508@sigill.intra.peff.net>
References: <20160305220829.GA31316@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 23:16:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acKVN-00025s-Hq
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 23:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbcCEWQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 17:16:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:55338 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750948AbcCEWQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 17:16:53 -0500
Received: (qmail 13368 invoked by uid 102); 5 Mar 2016 22:16:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:16:53 -0500
Received: (qmail 12218 invoked by uid 107); 5 Mar 2016 22:17:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:17:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2016 17:16:50 -0500
Content-Disposition: inline
In-Reply-To: <20160305220829.GA31316@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288334>

Some of the test-* programs rely on examining refs, but did
not bother to make sure we are actually in a git repository.
Let's have them call setup_git_directory() to do so.

Signed-off-by: Jeff King <peff@peff.net>
---
As discussed elsewhere, test-match-trees isn't actually used in the test
suite (except for the weird use which was removed in patch 1 here). So
we could also just get rid of it, but maybe somebody uses it for
debugging or something.

 test-match-trees.c      | 2 ++
 test-revision-walking.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/test-match-trees.c b/test-match-trees.c
index 109f03e..4dad709 100644
--- a/test-match-trees.c
+++ b/test-match-trees.c
@@ -6,6 +6,8 @@ int main(int ac, char **av)
 	unsigned char hash1[20], hash2[20], shifted[20];
 	struct tree *one, *two;
 
+	setup_git_directory();
+
 	if (get_sha1(av[1], hash1))
 		die("cannot parse %s as an object name", av[1]);
 	if (get_sha1(av[2], hash2))
diff --git a/test-revision-walking.c b/test-revision-walking.c
index 285f06b..3d03133 100644
--- a/test-revision-walking.c
+++ b/test-revision-walking.c
@@ -50,6 +50,8 @@ int main(int argc, char **argv)
 	if (argc < 2)
 		return 1;
 
+	setup_git_directory();
+
 	if (!strcmp(argv[1], "run-twice")) {
 		printf("1st\n");
 		if (!run_revision_walk())
-- 
2.8.0.rc1.318.g2193183
