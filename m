From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix various sparse warnings in the git source code
Date: Thu, 18 Jun 2009 14:48:29 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906181445530.16802@localhost.localdomain>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org> <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain> <E1MH3bD-0004g2-97@fencepost.gnu.org>
 <alpine.LFD.2.01.0906171543120.16802@localhost.localdomain> <alpine.LFD.2.01.0906171654310.16802@localhost.localdomain> <alpine.DEB.1.00.0906181012050.4848@intel-tinevez-2-302> <alpine.LFD.2.01.0906180856420.16802@localhost.localdomain>
 <alpine.DEB.1.00.0906181845020.4297@intel-tinevez-2-302> <alpine.LFD.2.01.0906181013390.16802@localhost.localdomain> <alpine.LFD.2.01.0906181021520.16802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 23:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHPUg-0004S3-Dl
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 23:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbZFRVtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 17:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbZFRVtv
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 17:49:51 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37618 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751607AbZFRVtu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 17:49:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5ILmUYh001291
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Jun 2009 14:48:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5ILmTi7015941;
	Thu, 18 Jun 2009 14:48:30 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0906181021520.16802@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.472 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121873>



On Thu, 18 Jun 2009, Linus Torvalds wrote:
> 
>  - warning: symbol 'xyz' was not declared. Should it be static?
> 
>    Sparse wants to see declarations for any functions you export. A lack 
>    of a declaration tends to mean that you should either add one, or you 
>    should mark the function 'static' to show that it's in file scope. 
> 
>    A few of these remain: I only did the ones that should obviously just 
>    be made static.

I don't know why I missed a couple.

That 'wt_status_submodule_summary' one is debatable. It has a few related 
flags (like 'wt_status_use_color') which _are_ declared, and are used by 
builtin-commit.c. So maybe we'd like to export it at some point, but it's 
not declared now, and not used outside of that file, so 'static' it is in 
this patch.

		Linus

---
 http-push.c    |    2 +-
 unpack-trees.c |    2 +-
 wt-status.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/http-push.c b/http-push.c
index e4ea395..8cc8ee0 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1750,7 +1750,7 @@ static int delete_remote_branch(char *pattern, int force)
 	return 0;
 }
 
-void run_request_queue(void)
+static void run_request_queue(void)
 {
 #ifdef USE_CURL_MULTI
 	is_running_queue = 1;
diff --git a/unpack-trees.c b/unpack-trees.c
index ac9927f..1958319 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -140,7 +140,7 @@ static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_option
 	return call_unpack_fn(src, o);
 }
 
-int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long df_conflicts, struct name_entry *names, struct traverse_info *info)
+static int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long df_conflicts, struct name_entry *names, struct traverse_info *info)
 {
 	int i;
 	struct tree_desc t[MAX_UNPACK_TREES];
diff --git a/wt-status.c b/wt-status.c
index 24a6abf..47735d8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -13,7 +13,7 @@
 
 int wt_status_relative_paths = 1;
 int wt_status_use_color = -1;
-int wt_status_submodule_summary;
+static int wt_status_submodule_summary;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
 	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
