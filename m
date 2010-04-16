From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH RFC 4/5] reachable: Made the gc aware of the ce_norm_sha1.
Date: Fri, 16 Apr 2010 18:10:01 +0200
Message-ID: <b352ea29de407108dae6840e459f85e6f3005dda.1271432034.git.grubba@grubba.org>
References: <cover.1271432034.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 18:43:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2odX-00053s-36
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758561Ab0DPQnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Apr 2010 12:43:17 -0400
Received: from mail.roxen.com ([212.247.29.220]:47428 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758134Ab0DPQnP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:43:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 1BA67628231
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jsVyjiuJN0r8 for <git@vger.kernel.org>;
	Fri, 16 Apr 2010 18:10:12 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 8B2A9628237
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:07 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o3GGA7V1021804;
	Fri, 16 Apr 2010 18:10:07 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o3GGA7C2021803;
	Fri, 16 Apr 2010 18:10:07 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1271432034.git.grubba@grubba.org>
In-Reply-To: <cover.1271432034.git.grubba@grubba.org>
References: <cover.1271432034.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145074>

Avoid having the gc zap the normalized blobs in the index.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 reachable.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/reachable.c b/reachable.c
index b515fa2..61ea623 100644
--- a/reachable.c
+++ b/reachable.c
@@ -191,6 +191,8 @@ static void add_cache_refs(struct rev_info *revs)
 		 * added them as objects, we've really done everything
 		 * there is to do for a blob
 		 */
+		if (active_cache[i]->norm_flags)
+			lookup_blob(active_cache[i]->norm_sha1);
 	}
 	if (active_cache_tree)
 		add_cache_tree(active_cache_tree, revs);
--=20
1.7.0.4.369.g81e89
