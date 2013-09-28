From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: RE: [PATCH] rebase -i: respect to core.abbrev
Date: Sun, 29 Sep 2013 00:10:13 +0300 (EEST)
Message-ID: <20130928211013.54361E0090@blue.fi.intel.com>
References: <1380384435-20846-1-git-send-email-kirill.shutemov@linux.intel.com>
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
X-From: git-owner@vger.kernel.org Sat Sep 28 23:10:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ1mZ-0002Mk-Nd
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab3I1VKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:10:18 -0400
Received: from mga14.intel.com ([143.182.124.37]:64174 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754733Ab3I1VKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:10:16 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 28 Sep 2013 14:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1001,1371106800"; 
   d="scan'208";a="366942693"
Received: from blue.fi.intel.com ([10.237.72.156])
  by azsmga001.ch.intel.com with ESMTP; 28 Sep 2013 14:10:14 -0700
Received: by blue.fi.intel.com (Postfix, from userid 1000)
	id 54361E0090; Sun, 29 Sep 2013 00:10:13 +0300 (EEST)
In-Reply-To: <1380384435-20846-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235506>

Kirill A. Shutemov wrote:
> git rebase -i collapses ids on todo list to 7 hexdigits.
> Let's use core.abbrev config option instead, if it's set.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  git-rebase--interactive.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 10bf318d0d..078c28ff1b 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -713,7 +713,8 @@ expand_todo_ids() {
>  }
>  
>  collapse_todo_ids() {
> -	transform_todo_ids --short=7
> +	abbrev="$(git config --get 'core.abbrev')"
> +	transform_todo_ids --short="${abbrev:-7}"


Simpler version is below.

>From 933a4159f0c037a37f3b251a4f13deea7f17b6c3 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Sat, 28 Sep 2013 18:53:05 +0300
Subject: [PATCH] rebase -i: respect to core.abbrev

collapse_todo_ids() uses `git rev-parse --short=7' to abbrev commit ids.
Let's drop argument from --short to use default (7) or config value
instead.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 10bf318d0d..3c6bed9a28 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -713,7 +713,7 @@ expand_todo_ids() {
 }
 
 collapse_todo_ids() {
-	transform_todo_ids --short=7
+	transform_todo_ids --short
 }
 
 # Rearrange the todo list that has both "pick sha1 msg" and
-- 
 Kirill A. Shutemov
