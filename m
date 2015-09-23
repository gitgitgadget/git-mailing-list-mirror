From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] worktree: don't use C99 feature
Date: Wed, 23 Sep 2015 11:33:00 +0100
Message-ID: <56027FDC.1070905@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, rappazzo@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 12:33:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZehMW-0002u3-QD
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 12:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbbIWKdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 06:33:06 -0400
Received: from avasout08.plus.net ([212.159.14.20]:58282 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbbIWKdF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 06:33:05 -0400
Received: from [10.0.2.15] ([81.174.177.104])
	by avasout08 with smtp
	id LaZ01r0072FXpih01aZ1rd; Wed, 23 Sep 2015 11:33:02 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=IMS4QkGEsjO3VZZSAZDX8w==:117 a=IMS4QkGEsjO3VZZSAZDX8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=UtjujdMcXWndgBvFfTAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278480>


Commits 9c0b9f6 ("worktree: add 'list' command", 18-09-2015) and
40ca3d3 ("worktree: add functions to get worktree details", 18-08-2015)
both introduce the use of a C99 feature (declare the loop control
variable in the loop header initializer section).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

The pu branch doesn't build for me. Do you have -std=c99 set somewhere?

Could you please squash the relevant parts of this patch (or something
like it) into the two commits mentioned above.

Thanks!

ATB,
Ramsay Jones

 builtin/worktree.c | 6 +++---
 worktree.c         | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index e6e36ac..b318c39 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -415,16 +415,16 @@ static int list(int ac, const char **av, const char *prefix)
         usage_with_options(worktree_usage, options);
     else {
         struct worktree **worktrees = get_worktrees();
-        int path_maxlen = 0;
+        int i, path_maxlen = 0;
 
         if (!porcelain) {
-            for (int i = 0; worktrees[i]; i++) {
+            for (i = 0; worktrees[i]; i++) {
                 int len = strlen(worktrees[i]->path);
                 if (len > path_maxlen)
                     path_maxlen = len;
             }
         }
-        for (int i = 0; worktrees[i]; i++) {
+        for (i = 0; worktrees[i]; i++) {
             if (porcelain)
                 show_worktree_porcelain(worktrees[i]);
             else
diff --git a/worktree.c b/worktree.c
index 41c229e..d17b5b6 100644
--- a/worktree.c
+++ b/worktree.c
@@ -5,7 +5,9 @@
 
 void free_worktrees(struct worktree **worktrees)
 {
-    for (int i = 0; worktrees[i]; i++) {
+    int i;
+
+    for (i = 0; worktrees[i]; i++) {
         free(worktrees[i]->path);
         free(worktrees[i]->git_dir);
         free(worktrees[i]->head_ref);
@@ -207,8 +209,9 @@ char *find_shared_symref(const char *symref, const char *target)
     struct strbuf sb = STRBUF_INIT;
     struct worktree **worktrees = get_worktrees();
     int symref_is_head = !strcmp("HEAD", symref);
+    int i;
 
-    for (int i = 0; worktrees[i]; i++) {
+    for (i = 0; worktrees[i]; i++) {
         if (!symref_is_head) {
             strbuf_reset(&path);
             strbuf_reset(&sb);
-- 
2.5.0
