From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] import-zips: fix thinko
Date: Sun, 29 Mar 2009 22:42:27 +0200 (CEST)
Message-ID: <a66d575d61ccfe945467eed58fdb80a6b8350f5a.1238359324u.git.johannes.schindelin@gmx.de>
References: <cover.1238359324u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 29 22:44:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo1rP-0003sg-7W
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 22:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbZC2Umd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 16:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754595AbZC2Umc
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 16:42:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:56227 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752994AbZC2Umb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 16:42:31 -0400
Received: (qmail invoked by alias); 29 Mar 2009 20:42:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 29 Mar 2009 22:42:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RX/BRo73Rf1XkEJlun2FZyacQ2ZTlTgbqbm8HUm
	7xHzdQwXwyEQim
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1238359324u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115037>

Embarrassingly, the common prefix calculation did not work properly, due
to a mistake in the assignment: instead of assigning the dirname of the
current file name, the dirname of the current common prefix needs to
be assigned to common prefix, when the current prefix does not match the
current file name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/fast-import/import-zips.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/import-zips.py
index c674fa2..7051a83 100755
--- a/contrib/fast-import/import-zips.py
+++ b/contrib/fast-import/import-zips.py
@@ -44,7 +44,8 @@ for zipfile in argv[1:]:
 			common_prefix = name[:name.rfind('/') + 1]
 		else:
 			while not name.startswith(common_prefix):
-				common_prefix = name[:name.rfind('/') + 1]
+				last_slash = common_prefix[:-1].rfind('/') + 1
+				common_prefix = common_prefix[:last_slash]
 
 		mark[name] = ':' + str(next_mark)
 		next_mark += 1
-- 
1.6.2.1.493.g67cf3
