From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] reflog: actually default to subcommand 'show'
Date: Mon, 01 Aug 2011 13:20:42 +0200
Message-ID: <4E368C0A.7020901@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 13:20:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnqYM-0000aG-JR
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908Ab1HALUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:20:54 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:53802 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784Ab1HALUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:20:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id C79B3DE72D
	for <git@vger.kernel.org>; Mon,  1 Aug 2011 13:20:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MMvdu1Gc1-iV for <git@vger.kernel.org>;
	Mon,  1 Aug 2011 13:20:52 +0200 (CEST)
Received: from [192.168.1.101] (e177095245.adsl.alicedsl.de [85.177.95.245])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 9A5D6DE725
	for <git@vger.kernel.org>; Mon,  1 Aug 2011 13:20:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110628 Thunderbird/5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178331>

The reflog manpage says:

	git reflog [show] [log-options] [<ref>]

the subcommand 'show' is the default "in the absence of any
subcommands". Currently this is only true if the user provided either
at least one option or no additional argument at all. For example:

	git reflog master

won't work. Change this by actually calling cmd_log_reflog in
absence of any subcommand.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 builtin/reflog.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index ebf610e..3a9c80f 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -777,6 +777,5 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "delete"))
 		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
 
-	/* Not a recognized reflog command..*/
-	usage(reflog_usage);
+	return cmd_log_reflog(argc, argv, prefix);
 }
-- 
1.7.6.351.gb35ac
