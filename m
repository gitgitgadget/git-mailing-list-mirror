From: Samuel Tardieu <sam@rfc1149.net>
Subject: [StGIT PATCH] Do not mess-up with commit message formatting when
	sending email
Date: Thu, 31 Jul 2008 14:50:05 +0200
Message-ID: <20080731125005.894.10592.stgit@dawn.rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 14:51:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOXcj-0004qm-RW
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 14:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888AbYGaMuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 08:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756659AbYGaMuK
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 08:50:10 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:36158 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756837AbYGaMuI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 08:50:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 1A05AE0F18;
	Thu, 31 Jul 2008 14:50:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XBUXH0VPr-03; Thu, 31 Jul 2008 14:50:05 +0200 (CEST)
Received: from dawn.rfc1149.net (unknown [192.168.9.2])
	by mail.rfc1149.net (Postfix) with ESMTP id B9B58E0486;
	Thu, 31 Jul 2008 14:50:05 +0200 (CEST)
Received: from dawn.rfc1149.net (localhost [127.0.0.1])
	by dawn.rfc1149.net (Postfix) with ESMTP id 75D5B8050;
	Thu, 31 Jul 2008 14:50:05 +0200 (CEST)
User-Agent: StGIT/0.14.3.213.g16b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90941>

The short description, which will be used as the email subject,
gets its leading and trailing whitespaces removed.

The long description only gets its trailing whitespaces removed
to preserve commit message formatting, e.g. in the case of a
ChangeLog-style commit message, as well as empty leading lines.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 stgit/commands/mail.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index a833efc..bdc3fcc 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -401,8 +401,8 @@ def __build_message(tmpl, patch, patch_nr, total_nr, msg_id, ref_id, options):
         options.edit_patches = True
 
     descr_lines = descr.split('\n')
-    short_descr = descr_lines[0].rstrip()
-    long_descr = '\n'.join(descr_lines[1:]).lstrip()
+    short_descr = descr_lines[0].strip()
+    long_descr = '\n'.join([l.rstrip() for l in descr_lines[1:]]).lstrip('\n')
 
     authname = p.get_authname();
     authemail = p.get_authemail();
