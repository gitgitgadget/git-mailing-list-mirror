From: Jeff King <peff@peff.net>
Subject: [PATCH] docs: fix filter-branch subdir example for exotic repo names
Date: Fri, 1 Apr 2011 10:46:27 -0400
Message-ID: <20110401144627.GA3686@sigill.intra.peff.net>
References: <20110401144107.GA3103@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?Q?Jean-Fran=C3=A7ois?= Burdet <jfburdet@revelate.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 16:48:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5fdw-0004E2-6M
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 16:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158Ab1DAOqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 10:46:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59838
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757551Ab1DAOqa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 10:46:30 -0400
Received: (qmail 10880 invoked by uid 107); 1 Apr 2011 14:47:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Apr 2011 10:47:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2011 10:46:27 -0400
Content-Disposition: inline
In-Reply-To: <20110401144107.GA3103@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170591>

The GIT_INDEX_FILE variable we get from git has the full
path to the repo, which may contain spaces. When we use it
in our shell snippet, it needs to be quoted.

Signed-off-by: Jeff King <peff@peff.net>
---
This version tests fine for me with:

#!/bin/sh

repo='repo with space'

rm -rf "$repo"

git init "$repo" && cd "$repo" &&
echo content >file &&
git add file &&
git commit -m file &&
git filter-branch --index-filter \
  'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
    GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
      git update-index --index-info &&
   mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"' HEAD

 Documentation/git-filter-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 03c76c7..9dc1f2a 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -359,11 +359,11 @@ To move the whole tree into a subdirectory, or remove it from there:
 ---------------------------------------------------------------
 git filter-branch --index-filter \
 	'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
 		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
-	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
+	 mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"' HEAD
 ---------------------------------------------------------------
 
 
 
 Checklist for Shrinking a Repository
-- 
1.7.4.13.g8566c
