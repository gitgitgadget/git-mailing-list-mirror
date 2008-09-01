From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] Git.pm: Require File::Temp 0.14 for new()
Date: Mon, 1 Sep 2008 15:34:35 +0530
Message-ID: <20080901100435.GC6555@toroid.org>
References: <48BBB59F.9080204@statsbiblioteket.dk> <vpqvdxggpw6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 12:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6IA-0006hC-BH
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYIAKEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 06:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYIAKEo
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:04:44 -0400
Received: from fugue.toroid.org ([85.10.196.113]:58219 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbYIAKEo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 06:04:44 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id B5F105583E5;
	Mon,  1 Sep 2008 12:04:42 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id B6C6CADC36D; Mon,  1 Sep 2008 15:34:35 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <vpqvdxggpw6.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94556>

File::Temp->new() was introduced in File::Temp 0.14, but 5.8.0 shipped
with File::Temp 0.13, as pointed out by Tom G. Christensen. Since the
dependency is optional anyway, we can require 0.14.

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---

At 2008-09-01 11:46:17 +0200, Matthieu.Moy@imag.fr wrote:
>
> > The problem is that Git.pm depends on the "new" method of File::Temp
> > introduced in 0.14. [...]
> 
> Isn't that fixed by c14c8ceb13b299892f286757e22e6af4f6cffab5 ?
> (Git.pm: Make File::Spec and File::Temp requirement lazy, a few
> commits before 1.6.0)

No, because _verify_require only checks that File::Temp exists, not that
File::Temp 0.14 exists. This patch fixes that.

-- ams

 perl/Git.pm |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 102e6a4..4e901b6 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1032,7 +1032,10 @@ sub _temp_cache {
 }
 
 sub _verify_require {
-	eval { require File::Temp; require File::Spec; };
+	eval {
+            require File::Spec;
+            require File::Temp; File::Temp->VERSION(0.14);
+        };
 	$@ and throw Error::Simple($@);
 }
 
-- 
1.6.0.49.gea35
