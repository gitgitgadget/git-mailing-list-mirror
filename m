From: Samuel Tardieu <sam@rfc1149.net>
Subject: [StGIT v2 PATCH] Do not mess-up with commit message formatting when
	sending email
Date: Mon, 04 Aug 2008 17:19:14 +0200
Message-ID: <20080804151913.4269.74254.stgit@dawn.rfc1149.net>
References: <20080804141640.GB12232@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: kha@treskal.com
X-From: git-owner@vger.kernel.org Mon Aug 04 17:20:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ1rF-0000bx-1V
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 17:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbYHDPTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 11:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbYHDPTX
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 11:19:23 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:57297 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbYHDPTX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 11:19:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 2FFFCE2519;
	Mon,  4 Aug 2008 17:19:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SV6PWhHE3XUV; Mon,  4 Aug 2008 17:19:15 +0200 (CEST)
Received: from dawn.rfc1149.net (unknown [192.168.9.2])
	by mail.rfc1149.net (Postfix) with ESMTP id 2C943E04A7;
	Mon,  4 Aug 2008 17:19:15 +0200 (CEST)
Received: from dawn.rfc1149.net (localhost [127.0.0.1])
	by dawn.rfc1149.net (Postfix) with ESMTP id BFDCD8050;
	Mon,  4 Aug 2008 17:19:14 +0200 (CEST)
In-Reply-To: <20080804141640.GB12232@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.3.213.g2044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91371>

The short description, which will be used as the email subject,
gets its leading and trailing blanks removed.

The long description gets its trailing blanks removed as well
as any leading empty lines. Leading blanks are left untouched
to preserve the formatting.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 stgit/commands/mail.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index a833efc..61e3f3a 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -401,8 +401,8 @@ def __build_message(tmpl, patch, patch_nr, total_nr, msg_id, ref_id, options):
         options.edit_patches = True
 
     descr_lines = descr.split('\n')
-    short_descr = descr_lines[0].rstrip()
-    long_descr = '\n'.join(descr_lines[1:]).lstrip()
+    short_descr = descr_lines[0].strip()
+    long_descr = '\n'.join(l.rstrip() for l in descr_lines[1:]).lstrip('\n')
 
     authname = p.get_authname();
     authemail = p.get_authemail();
