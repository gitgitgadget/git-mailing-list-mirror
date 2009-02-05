From: Pascal Obry <pascal@obry.net>
Subject: [PATCH] Fix Git install directory.
Date: Thu, 5 Feb 2009 08:37:24 +0100
Message-ID: <a2633edd0902042337jaa9d1cfqee3c61f486adadd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 08:38:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUyp4-00032F-Ge
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 08:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbZBEHh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 02:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbZBEHh2
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 02:37:28 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:14704 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbZBEHh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 02:37:27 -0500
Received: by fk-out-0910.google.com with SMTP id f33so76909fkf.5
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 23:37:25 -0800 (PST)
Received: by 10.223.114.135 with SMTP id e7mr43971faq.89.1233819444979; Wed, 
	04 Feb 2009 23:37:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108511>

Remove trailing slash in gitexecdir and template_dir.
With a trailing slash Git gets installed into a wrong location. If
prefix is /usr/local it gets installed into /usr/local/usr/local.
This is because the comparison in Makefile:

   ifeq ($(abspath $(gitexecdir)),$(gitexecdir))
      gitexec_instdir = $(gitexecdir)

is always wrong as abspath does remove the trailing slash. In this case
the else part is used and prefix is added in front of the already absolute
pathname:

   else
      gitexec_instdir = $(prefix)/$(gitexecdir)

Signed-off-by: Pascal Obry <pascal@obry.net>
---
 config.mak.in |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 55b25c3..7cce0c1 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -13,9 +13,9 @@ TCLTK_PATH = @TCLTK_PATH@
 prefix = @prefix@
 exec_prefix = @exec_prefix@
 bindir = @bindir@
-gitexecdir = @libexecdir@/git-core/
+gitexecdir = @libexecdir@/git-core
 datarootdir = @datarootdir@
-template_dir = @datadir@/git-core/templates/
+template_dir = @datadir@/git-core/templates

 mandir=@mandir@

-- 
1.6.1.2.351.g80f18.dirty


-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
