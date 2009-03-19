From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] git clone needs to know executability of template files
Date: Thu, 19 Mar 2009 22:43:38 +0100
Message-ID: <20090319214338.GA7653@blimp.localdomain>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com> <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de> <20090319214001.GA6253@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:46:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQ3N-0004Z7-S7
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757463AbZCSVn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 17:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757263AbZCSVn4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:43:56 -0400
Received: from mout1.freenet.de ([195.4.92.91]:36377 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195AbZCSVn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 17:43:56 -0400
Received: from [195.4.92.18] (helo=8.mx.freenet.de)
	by mout1.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #76)
	id 1LkQ1j-0006zz-F2; Thu, 19 Mar 2009 22:43:47 +0100
Received: from x62b3.x.pppool.de ([89.59.98.179]:46961 helo=tigra.home)
	by 8.mx.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 587) (Exim 4.69 #76)
	id 1LkQ1j-0006wx-6e; Thu, 19 Mar 2009 22:43:47 +0100
Received: from blimp.localdomain (ubuntu.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 48AAE277D8;
	Thu, 19 Mar 2009 22:43:39 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 08CBE36D27; Thu, 19 Mar 2009 22:43:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090319214001.GA6253@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113835>

Use posix_lstat for template source. The copy_templates_1 needs to
know the file mode information for the copy of the template. The
copying of the executable bit always work on POSIX systems and
sometimes even on Cygwin.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-init-db.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index ee3911f..0b6dc16 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -66,7 +66,7 @@ static void copy_templates_1(char *path, int baselen,
 		else
 			exists = 1;
 
-		if (lstat(template, &st_template))
+		if (posix_lstat(template, &st_template))
 			die("cannot stat template %s", template);
 
 		if (S_ISDIR(st_template.st_mode)) {
-- 
1.6.2.1.237.g7206c6
