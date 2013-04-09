From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH v3 1/2] clone: Fix error message for reference repository
Date: Tue,  9 Apr 2013 18:21:59 -0400
Message-ID: <1365546120-22048-2-git-send-email-aaron@schrab.com>
References: <7v8v4rtzw4.fsf@alter.siamese.dyndns.org>
 <1365546120-22048-1-git-send-email-aaron@schrab.com>
Cc: junio@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 00:23:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPgwp-00055W-C6
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 00:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935427Ab3DIWXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 18:23:23 -0400
Received: from pug.qqx.org ([50.116.43.67]:39854 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754474Ab3DIWXW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 18:23:22 -0400
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id 084D057E07
	for <git@vger.kernel.org>; Tue,  9 Apr 2013 18:23:22 -0400 (EDT)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 4011c
	by zim.qqx.org (DragonFly Mail Agent);
	Tue, 09 Apr 2013 18:23:21 -0400
X-Mailer: git-send-email 1.8.2.677.g9202ef0
In-Reply-To: <1365546120-22048-1-git-send-email-aaron@schrab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220645>

Do not report that an argument to clone's --reference option is not a
local directory.  Nothing checks for the existence or type of the path
as supplied by the user; checks are only done for particular contents of
the supposed directory, so we have no way to know the status of the
supplied path.  Telling the user that a directory doesn't exist when
that isn't actually known may lead him or her on the wrong path to
finding the problem.

Instead just state that the entered path is not a local repository which
is really all that is known about it.  It could be more helpful to state
the actual paths which were checked, but I believe that giving a good
description of that would be too verbose for a simple error message and
would be too dependent on implementation details.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git a/builtin/clone.c b/builtin/clone.c
index f9c380e..0a1e0bf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -241,7 +241,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 		free(ref_git);
 		ref_git = ref_git_git;
 	} else if (!is_directory(mkpath("%s/objects", ref_git)))
-		die(_("reference repository '%s' is not a local directory."),
+		die(_("reference repository '%s' is not a local repository."),
 		    item->string);
 
 	strbuf_addf(&alternate, "%s/objects", ref_git);
-- 
1.8.2.677.g9202ef0
