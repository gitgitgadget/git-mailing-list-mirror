From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] git checkout: don't warn about unborn branch if -f is
	already passed
Date: Mon, 24 Nov 2008 01:55:22 -0500
Message-ID: <1227509722.32583.0.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 07:56:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4VNK-0007o3-8p
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 07:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbYKXGze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 01:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYKXGze
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 01:55:34 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:54671 "EHLO
	jankymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751087AbYKXGze (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2008 01:55:34 -0500
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id E9A2D13EA9;
	Sun, 23 Nov 2008 22:55:32 -0800 (PST)
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101591>

I think it's unnecessary to warn that the checkout has been forced due to an
unborn current branch if -f has been explicitly passed.  For one project, I am
using git-new-workdir to create workdirs from a bare repository whose HEAD is
set to an unborn branch, and this warning started to irritate me.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 builtin-checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 464fd25..7f3bd7b 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -553,7 +553,7 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
 		describe_detached_head("Previous HEAD position was", old.commit);
 
-	if (!old.commit) {
+	if (!old.commit && !opts->force) {
 		if (!opts->quiet) {
 			fprintf(stderr, "warning: You appear to be on a branch yet to be born.\n");
 			fprintf(stderr, "warning: Forcing checkout of %s.\n", new->name);
-- 
1.6.0.2.593.g91df
