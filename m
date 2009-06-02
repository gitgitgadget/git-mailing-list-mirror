From: sparse@infidigm.net
Subject: [Patch] Prevent cloning over http from spewing
Date: Tue, 2 Jun 2009 13:42:29 -0400
Message-ID: <20090602174229.GA14455@infidigm.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 19:50:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBY8G-0004QV-2e
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 19:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbZFBRu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 13:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbZFBRu2
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 13:50:28 -0400
Received: from ironport2-out.pppoe.ca ([206.248.154.182]:6027 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754780AbZFBRu1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 13:50:27 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2009 13:50:27 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhsDAFcAJUpFxKWY/2dsb2JhbACBT5VPuQmECwWGBw
X-IronPort-AV: E=Sophos;i="4.41,292,1241409600"; 
   d="scan'208";a="39504075"
Received: from 69-196-165-152.dsl.teksavvy.com (HELO freiheit.infidigm.net) ([69.196.165.152])
  by ironport2-out.teksavvy.com with ESMTP; 02 Jun 2009 13:40:46 -0400
Received: from sparse by freiheit.infidigm.net with local (Exim 4.50)
	id 1MBY0L-0003wk-Vc
	for git@vger.kernel.org; Tue, 02 Jun 2009 13:42:30 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120530>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When cloning over http git spews a bunch of hashs that don't really convey much.
The attached patch disables them unless --verbose is specified.

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

commit 67be7a94c94100d24bcccf1248a26afc1dec8d05
Author: Jeff Muizelaar <jmuizelaar@mozilla.com>
Date:   Tue Jun 2 13:32:41 2009 -0400

    Prevent cloning over http from spewing
    
    This propogates the verbose flag to the transport and makes
    the walker verbose only if the transport is verbose.

diff --git a/builtin-clone.c b/builtin-clone.c
index 5c46496..f25d60b 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -502,8 +502,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		if (option_quiet)
 			transport->verbose = -1;
-		else if (option_verbose)
+		else if (option_verbose) {
 			transport->progress = 1;
+			transport->verbose = 1;
+		}
 
 		if (option_upload_pack)
 			transport_set_option(transport, TRANS_OPT_UPLOADPACK,
diff --git a/transport.c b/transport.c
index 17891d5..3bb87f3 100644
--- a/transport.c
+++ b/transport.c
@@ -366,7 +366,7 @@ static int fetch_objs_via_walker(struct transport *transport,
 	walker->get_all = 1;
 	walker->get_tree = 1;
 	walker->get_history = 1;
-	walker->get_verbosely = transport->verbose >= 0;
+	walker->get_verbosely = transport->verbose > 0;
 	walker->get_recover = 0;
 
 	for (i = 0; i < nr_objs; i++)

--k+w/mQv8wyuph6w0--
