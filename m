From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] .gitattributes: CR at the end of the line is an error
Date: Fri, 19 Jun 2009 19:42:53 +0900
Message-ID: <20090619194253.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 12:43:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHbZG-0006zQ-8y
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 12:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788AbZFSKnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 06:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755598AbZFSKnX
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 06:43:23 -0400
Received: from karen.lavabit.com ([72.249.41.33]:46239 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755367AbZFSKnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 06:43:22 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 613FA11B7F1
	for <git@vger.kernel.org>; Fri, 19 Jun 2009 05:43:24 -0500 (CDT)
Received: from 4160.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 4C9TT6HTFGAE
	for <git@vger.kernel.org>; Fri, 19 Jun 2009 05:43:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=JnWqK+bxJOHK7NLZ5ExOIOlbBkCSm5QElYftjqH3ouv35yRJQMkS2yinevo6dLtJeJgOUK/yZANwU14afnaWuxpIR4LpFWpiMT5dY5gCzI7BEou8cbQb1vCPZ5m79/D7F8tXk4dhNV4Ce8j1UKO90Fp2ZDBWb/pP+87AiO1OCtA=;
  h=From:To:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121895>

When a CR is accidentally added at the end of a C source file in the git
project tree, "git diff --check" doesn't detect it as an error.

    $ echo abQ | tr Q '\015' >>fast-import.c
    $ git diff --check

I think this is because the "whitespace" attribute is set to *.[ch] files
without specifying what kind of errors are caught. It makes git "notice
all types of errors" (as described in the documentation), but I think it
is incorrectly setting cr-at-eol, too, and hides this error.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

diff --git a/.gitattributes b/.gitattributes
index 6b9c715..bb03350 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,2 +1,2 @@
 * whitespace=!indent,trail,space
-*.[ch] whitespace
+*.[ch] whitespace=indent,trail,space

-- 
1.6.2.GIT

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
