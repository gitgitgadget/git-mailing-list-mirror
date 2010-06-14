From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] pretty.c: %S format specifier for source ref
Date: Mon, 14 Jun 2010 16:50:05 +0200
Message-ID: <96891c0177b947c6d737c1f05687b3bd736a502b.1276526878.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 16:51:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOB07-0006Mu-K0
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 16:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab0FNOuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 10:50:52 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54416 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754980Ab0FNOuv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 10:50:51 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 096E8F8AF0
	for <git@vger.kernel.org>; Mon, 14 Jun 2010 10:50:47 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 14 Jun 2010 10:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=Rp9NeUrblZCvRt0SPG9UmqtF7Sc=; b=RvqzDqiPHSk0DDWhSNsWMBHWaidGPqY64zUEPAggFYIVh5F4zq1oHYdtaG4GuaoKAx6zx05LRyJ6/Ga2gwAeQtHWeUzlpCeVAlaIzH3dAVRmKip+Qwcsdk0Ra+/XE4IzJKRLYRMxpElTKvw0emFkwAKAJltzdcAuVFf5yTtRDRE=
X-Sasl-enc: NbfIFNC1HbLSuIChMqkR4WWpV4u9ZEJXJPosnz6jUfeC 1276527039
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0B5F04A47B7;
	Mon, 14 Jun 2010 10:50:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.511.gfbed4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149098>

Currently, there is no way to combine --source with a format string for
log and friends.

Introduce a %S format specifier which outputs the source ref if --source
is given also. This is analogous to specfiers like %gs which are empty
unless used with -g.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Notes:
    I'm not sure whether it's worth introducing pretty_ctx.show_source to
    keep track of the use of --source. commit->util is possibly used by
    other codepaths also. Even without this patch, --cherry-pick --source
    does not work (in the sense that there is an empty source output) because
    of this.
    
    RFC obviously also so that I don't have to write doc and tests just yet :)

 pretty.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index 8b18efd..146320f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -867,6 +867,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	case 'd':
 		format_decoration(sb, commit);
 		return 1;
+	case 'S':
+		if (/* revs->show_source && */commit->util)
+			strbuf_addstr(sb, (char *) commit->util);
+		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
 		case 'd':	/* reflog selector */
-- 
1.7.1.511.gfbed4
