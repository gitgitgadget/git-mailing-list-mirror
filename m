From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Disallow empty GIT_AUTHOR_NAME or GIT_COMMITTER_NAME
Date: Fri, 06 Jul 2007 12:50:11 -0500
Message-ID: <468E80D3.5060706@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 19:54:07 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6s0M-0004fo-U5
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 19:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760967AbXGFRyC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 13:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760396AbXGFRyC
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 13:54:02 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40234 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088AbXGFRyA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 13:54:00 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l66HmTa4028598;
	Fri, 6 Jul 2007 12:48:32 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Jul 2007 12:50:12 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
X-OriginalArrivalTime: 06 Jul 2007 17:50:12.0082 (UTC) FILETIME=[19E7A520:01C7BFF6]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15280000
X-TM-AS-Result: : Yes--11.864400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQ0LTcwOTI1My03MDA3?=
	=?us-ascii?B?NTYtNzAzOTY5LTcwNzY1NC03MDkyNTEtMTEzMjI4LTcwMDQ3Ni03?=
	=?us-ascii?B?MDM3MTItNzA0NDMwLTcwMDYxOC03MDIwNDQtNzAyMzU4LTcwNDk4?=
	=?us-ascii?B?My03MDAxNjAtNzAyNjM4LTcwMTg1NC03MDQ5MzAtNzAyMDUwLTcw?=
	=?us-ascii?B?MTQ1MC0xODcwNjctMTg4MTIxLTcwMTkzNy03MDI3OTEtNzAyMDc5?=
	=?us-ascii?B?LTcwMTM4NC03MDU3MzMtNzAxNTc2LTEwNTA0MC0xMjE1OTQtNzAz?=
	=?us-ascii?B?ODUxLTcwNDQyNS0xODgwMTktNzAzOTA3LTcwNzA2Ni03MDQ3NDct?=
	=?us-ascii?B?NzAyNjA5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51777>

Attempt normal methods for determining user name if
GIT_AUTHOR_NAME or GIT_COMMITTER_NAME is set to the empty
string. Then fall back to using the user login name.

Previously, if these environment variables were set to the
empty string, a message would be printed complaining about
missing gecos information. In this case the gecos information
was never checked.

This still allows an empty GIT_AUTHOR_EMAIL or GIT_COMMITTER_EMAIL.
Possibly someone would want to use these variables to disable
the respective email address string?

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Trivial one-liner. I made this patch against master, not
on top of my previous patch. I assume this is the preferred way.

In case anyone is interested, I am submitting this using thunderbird
by the following method.

Set thunderbird config variables according to SubmittingPatches doc.
i.e.:
   Compose messages in HTML format
   mailnews.send_plaintext_flowed  => false
   mailnews.wraplength             => 0

Then I send the patch to myself using git-format-patch and then
git-send-email. These two format the patch appropriately for
submission and allow me to set the message-id.

Then I select the message, right-click and choose "Edit As New...",
edit, select the recipients, and send. I also now have a record of
the sent message which I would not have if I used only git-send-email.

-brandon


 ident.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ident.c b/ident.c
index 3d49608..6932ccf 100644
--- a/ident.c
+++ b/ident.c
@@ -193,7 +193,7 @@ const char *fmt_ident(const char *name, const char *email,
 	int i;
 
 	setup_ident();
-	if (!name)
+	if (!name || !*name)
 		name = git_default_name;
 	if (!email)
 		email = git_default_email;
-- 
1.5.3.rc0.30.g114f-dirty
