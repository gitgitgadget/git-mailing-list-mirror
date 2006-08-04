From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: http-push: email address problem with LOCK_REQUEST?
Date: Fri, 4 Aug 2006 22:01:33 +0100
Message-ID: <000401c6b809$2a4f62e0$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 04 23:02:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G96nU-0007Hj-Eb
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 23:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161445AbWHDVBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 17:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161446AbWHDVBY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 17:01:24 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:41230 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S1161445AbWHDVBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 17:01:22 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-36.mail.demon.net with smtp (Exim 4.42)
	id 1G96nJ-000M7y-Jp
	for git@vger.kernel.org; Fri, 04 Aug 2006 21:01:21 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24839>

Hi all,

Whilst fixing the git-format-patch "Signed-off-by identity bug", I
decided to have a look at the other calls to setup_ident(), to check
for similar problems. I noticed a couple of things that didn't look
quite right (see also next email).

In particular, http-push accesses git_default_email directly, using
it as part of a (DAV?) LOCK_REQUEST. However, since http-push does
not call git_config(), only the generic <user@localhost.localdomain>
determined by setup_ident() will be used.

Now this may not be a problem. I don't really know what the email
address is used for in the lock request; it could have no effect
on the transaction at all, apart from perhaps some message text
in the web-server logs.

Also, there may be a reason for not reading the config file. I can't
think of one, but hey ...

Unfortunately, since my config has NO_CURL, I can't even compile
http-push.c, let alone test the change given below.

comments anyone?

Ramsay


diff --git a/http-push.c b/http-push.c
index e281f70..4de62e4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2340,6 +2340,7 @@ int main(int argc, char **argv)
 
 	setup_git_directory();
 	setup_ident();
+	git_config(git_default_config);
 
 	remote = xcalloc(sizeof(*remote), 1);
 
