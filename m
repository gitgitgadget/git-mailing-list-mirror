From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Prefer $EMAIL over auto-generated user@hostname.
Date: Fri, 06 Jul 2007 11:14:46 -0500
Message-ID: <468E6A76.6060806@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Uwe_?= =?ISO-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, mkraai@beckman.com,
	madcoder@debian.org, Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 18:15:50 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6qTC-0008Mq-VL
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 18:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088AbXGFQPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 12:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbXGFQPo
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 12:15:44 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41314 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477AbXGFQPn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 12:15:43 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l66GD3Ho027897;
	Fri, 6 Jul 2007 11:13:06 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Jul 2007 11:14:47 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
References: 81b0412b0707060859u6a1c3a24p4399a71d84038615@mail.gmail.com
X-OriginalArrivalTime: 06 Jul 2007 16:14:47.0097 (UTC) FILETIME=[C58C4290:01C7BFE8]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15280000
X-TM-AS-Result: : Yes--14.688800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQ0LTE1MDY3MC03MDA2?=
	=?us-ascii?B?MTgtNzAzNDM2LTcwMzc4OC03MDM5NjktNzAxNTc2LTcwMDc1Ni03?=
	=?us-ascii?B?MDAxNjAtNzA0NzA5LTcwMDA3NS0xMzkwMTAtNzA0MzM5LTEwNjY0?=
	=?us-ascii?B?MC03MTE2MDgtNzAwNjQ4LTcwMDQ4MS0xMTMyNTYtNzA3MDY2LTE4?=
	=?us-ascii?B?ODAxOS03MDYyOTAtNzA0NzQ3LTcwMDMyNC03MDI2MDktMTQ4MDUx?=
	=?us-ascii?B?LTIwMDQw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51770>

This makes $EMAIL the second to last resort ahead of
username@hostname rather than the last resort when
GIT_AUTHOR_EMAIL or GIT_COMMITER_EMAIL and user.email
are not set.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Alex Riesen wrote:
> On 7/6/07, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>>
>> Is the recommended tab stop 8 characters as it is for linux? or 4?
>>
> 
> Tab is always 8 spaces. It is indentation which can be 8, 4, 3, 2, and
> even 1.
> It is 8 in Git.

Here's an updated patch using tabs.

-brandon


 ident.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index 3d49608..be5efcd 100644
--- a/ident.c
+++ b/ident.c
@@ -73,6 +73,7 @@ static void copy_email(const struct passwd *pw)
 static void setup_ident(void)
 {
 	struct passwd *pw = NULL;
+	char *email;
 
 	/* Get the name ("gecos") */
 	if (!git_default_name[0]) {
@@ -82,6 +83,9 @@ static void setup_ident(void)
 		copy_gecos(pw, git_default_name, sizeof(git_default_name));
 	}
 
+	if (!git_default_email[0] && (email = getenv("EMAIL")) != NULL)
+		strlcpy(git_default_email, email, sizeof(git_default_email));
+
 	if (!git_default_email[0]) {
 		if (!pw)
 			pw = getpwuid(getuid());
@@ -197,8 +201,6 @@ const char *fmt_ident(const char *name, const char *email,
 		name = git_default_name;
 	if (!email)
 		email = git_default_email;
-	if (!email)
-		email = getenv("EMAIL");
 
 	if (!*name) {
 		struct passwd *pw;
-- 
1.5.3.rc0.30.g114f-dirty
