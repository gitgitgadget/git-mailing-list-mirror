From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] sample pre-commit hook: don't trigger when recording a merge
Date: Sat, 09 Jan 2010 08:16:52 +0900
Message-ID: <20100109081652.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 00:17:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTO57-0007Bf-KQ
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 00:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab0AHXRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 18:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021Ab0AHXRV
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 18:17:21 -0500
Received: from karen.lavabit.com ([72.249.41.33]:40705 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995Ab0AHXRU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 18:17:20 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id E399E11B87F
	for <git@vger.kernel.org>; Fri,  8 Jan 2010 17:17:19 -0600 (CST)
Received: from 4792.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id EWB985YJLKBI
	for <git@vger.kernel.org>; Fri, 08 Jan 2010 17:17:19 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=wwy8S9zdMnjsJ3V75ohpsSzvsK4M3sekAlKgGE6riVe5yiDDeQbxZlzY77DI1pjSNr9NJSQZJiKpGzrGFNvEe31R5w1xNPffACM7UsaJldaiBoGwKfPQ8OOuDBafU4qU+I4bfjKVasCkf3l9qdvY/dJJSn/Qd9zVjxnsavkWJlE=;
  h=From:To:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136492>

When recording a merge, even if there are problematic whitespace errors,
let them pass, because the damage has already been done in the history. If
this hook triggers, it will invite a novice to fix such errors in a merge
commit but such a change is not related to the merge. Don't encourage it.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 templates/hooks--pre-commit.sample |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 439eefd..66e56bb 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -7,6 +7,11 @@
 #
 # To enable this hook, rename this file to "pre-commit".
 
+if test -f "${GIT_DIR-.git}"/MERGE_HEAD
+then
+	exit 0
+fi
+
 if git-rev-parse --verify HEAD >/dev/null 2>&1
 then
 	against=HEAD
-- 
1.6.6

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
