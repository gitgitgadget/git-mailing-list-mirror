From: Michael Coleman <tutufan@gmail.com>
Subject: [PATCH] builtin-fmt-merge-msg: fix bugs in --file option
Date: Tue, 27 Feb 2007 23:44:42 -0600
Message-ID: <1172641482207-git-send-email-tutufan@gmail.com>
Cc: Michael Coleman <tutufan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 06:45:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMHcb-0005Oc-FS
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 06:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXB1Fos (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 00:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbXB1Fos
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 00:44:48 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:14647 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXB1Foq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 00:44:46 -0500
Received: by nz-out-0506.google.com with SMTP id s1so43807nze
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 21:44:45 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=b5ZEI1rk5qPfb849252K0eMaSpxAqkav4MZpmPuHHSIUAcyJ8lk5bqdkYKI9VCrlsyz4y/cDVtUCIpZkpEohje73Oe90y3RErngtUZ/uQ42JVv+6fJkF0Hdp5KfzcvEk3CGUd4FUesaIlti+FZGn5OJbQhDTQ/SZWRP0tnOr+WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=WSPidYEgxGKLnej3PP8MBSOCLa+sXhMMCs8D3K08ic0Gom067hpObktR7sO2rAlE1TDhw2xhXoTgw0ED2z22fJ7ajAliJZkf9/lecz05t+1NvulGu0QJu9Zt43UzgUDHZTSUYpfajofb9hB53njdZty0rBcqsxx4OJnndvD3Cdc=
Received: by 10.65.180.7 with SMTP id h7mr146426qbp.1172641485630;
        Tue, 27 Feb 2007 21:44:45 -0800 (PST)
Received: from tutufan@gmail.com ( [69.154.17.234])
        by mx.google.com with ESMTP id j4sm270847nzd.2007.02.27.21.44.43;
        Tue, 27 Feb 2007 21:44:45 -0800 (PST)
Received: by tutufan@gmail.com (sSMTP sendmail emulation); Tue, 27 Feb 2007 23:44:42 -0600
X-Mailer: git-send-email 1.5.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40897>

If --file's argument is missing, don't crash.  If it cannot be opened,
die with an error message.
---
 builtin-fmt-merge-msg.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 1489883..5c145d2 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -259,13 +259,15 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "--no-summary"))
 			merge_summary = 0;
 		else if (!strcmp(argv[1], "-F") || !strcmp(argv[1], "--file")) {
-			if (argc < 2)
+			if (argc < 3)
 				die ("Which file?");
 			if (!strcmp(argv[2], "-"))
 				in = stdin;
 			else {
 				fclose(in);
 				in = fopen(argv[2], "r");
+				if (!in)
+					die("cannot open %s", argv[2]);
 			}
 			argc--; argv++;
 		} else
-- 
1.5.0.rc3
