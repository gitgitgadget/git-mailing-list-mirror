From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/3] sparse: Fix some "symbol not declared" warnings
Date: Sun, 11 Sep 2011 20:38:39 +0100
Message-ID: <4E6D0E3F.3090304@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 21:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2pxY-0005Cj-Jj
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 21:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248Ab1IKTow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 15:44:52 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:36409 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754088Ab1IKTow (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 15:44:52 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1R2pww-00044Z-e2; Sun, 11 Sep 2011 19:44:50 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181187>


In particular, sparse issues the "symbol 'a_symbol' was not declared.
Should it be static?" warning for the following symbols:

    submodule.c:321:5: 'submodule_needs_pushing'
    submodule.c:355:5: 'push_submodule'
    builtin/revert.c:662:20: 'commit_list_append'

These symbols only require file scope, so we simply add the static
modifier to their declarations.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/revert.c |    4 ++--
 submodule.c      |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 5e97622..5f1cee8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -659,8 +659,8 @@ static void read_and_refresh_cache(struct replay_opts *opts)
  *     assert(commit_list_count(list) == 2);
  *     return list;
  */
-struct commit_list **commit_list_append(struct commit *commit,
-					struct commit_list **next)
+static struct commit_list **commit_list_append(struct commit *commit,
+						struct commit_list **next)
 {
 	struct commit_list *new = xmalloc(sizeof(struct commit_list));
 	new->item = commit;
diff --git a/submodule.c b/submodule.c
index 38d9877..5a02890 100644
--- a/submodule.c
+++ b/submodule.c
@@ -318,7 +318,7 @@ static int has_remote(const char *refname, const unsigned char *sha1, int flags,
 	return 1;
 }
 
-int submodule_needs_pushing(const char *path, const unsigned char sha1[20], void *data)
+static int submodule_needs_pushing(const char *path, const unsigned char sha1[20], void *data)
 {
 	int *needs_pushing = data;
 
@@ -352,7 +352,7 @@ int submodule_needs_pushing(const char *path, const unsigned char sha1[20], void
 	return 1;
 }
 
-int push_submodule(const char *path, const unsigned char sha1[20], void *data)
+static int push_submodule(const char *path, const unsigned char sha1[20], void *data)
 {
 	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
 		return 1;
-- 
1.7.6
