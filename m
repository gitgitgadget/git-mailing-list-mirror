From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] branch --contains: default to HEAD
Date: Tue, 08 Jul 2008 18:17:32 -0700
Message-ID: <7vr6a3onyr.fsf_-_@gitster.siamese.dyndns.org>
References: <7v8wwcx446.fsf@gitster.siamese.dyndns.org>
 <20080708101452.GB19202@artemis.madism.org>
 <20080708103408.GC19202@artemis.madism.org>
 <7vvdzfoo1s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 03:18:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGOKQ-0001fE-K1
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 03:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbYGIBRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 21:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbYGIBRp
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 21:17:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbYGIBRo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 21:17:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D83316D90;
	Tue,  8 Jul 2008 21:17:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8710216D8B; Tue,  8 Jul 2008 21:17:38 -0400 (EDT)
In-Reply-To: <7vvdzfoo1s.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 08 Jul 2008 18:15:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D43D72E6-4D54-11DD-9A17-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87827>

We used to require the name of the commit to limit the branches shown to
the --contains option, but more recent --merged/--no-meregd defaults to
HEAD (and they do not allow arbitrary commit, which is a separate issue).

This teaches --contains to default to HEAD when no parameter is given.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This comes on top of the FAKELASTARG patch

 builtin-branch.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index d279702..375e5e0 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -438,13 +438,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
-		OPT_CALLBACK(0, "contains", &with_commit, "commit",
-			     "print only branches that contain the commit",
-			     opt_parse_with_commit),
+		{
+			OPTION_CALLBACK, 0, "contains", &with_commit, "commit",
+			"print only branches that contain the commit",
+			PARSE_OPT_FAKELASTARG,
+			opt_parse_with_commit, (intptr_t)"HEAD",
+		},
 		{
 			OPTION_CALLBACK, 0, "with", &with_commit, "commit",
 			"print only branches that contain the commit",
-			PARSE_OPT_HIDDEN, opt_parse_with_commit,
+			PARSE_OPT_HIDDEN | PARSE_OPT_FAKELASTARG,
+			opt_parse_with_commit, (intptr_t) "HEAD",
 		},
 		OPT__ABBREV(&abbrev),
 
-- 
1.5.6.2.255.gbed62
