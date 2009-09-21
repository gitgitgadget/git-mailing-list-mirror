From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] test-genrandom: ensure stdout is set to _O_BINARY on Windows
Date: Mon, 21 Sep 2009 09:34:58 +0200
Message-ID: <4AB72CA2.1020808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Li Frank <lznuaa@gmail.com>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 09:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpdQV-0005pb-Lw
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 09:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbZIUHe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 03:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbZIUHe7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 03:34:59 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:46675 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbZIUHe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 03:34:58 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MpdQJ-00025J-8a; Mon, 21 Sep 2009 09:34:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F19326D9; Mon, 21 Sep 2009 09:34:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128867>

From: Johannes Sixt <j6t@kdbg.org>

Commit a6ca8c62 (Set _O_BINARY as default fmode for both MinGW and MSVC)
removed the definition of _CRT_fmode from mingw.c. Before this commit,
since test-genrandom is linked against libgit.a, the MinGW process
initialization code would pick up that definition of _CRT_fmode, which was
initialized to _O_BINARY. After this commit, however, text mode is used
for std(in|out|err) because it is the default in absence of _CRT_fmode.
In order to fix that, we must use git-compat-util.h, which overrides
main() to set the mode to binary.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Unfortunately, this change in an updated patch 04/15 of the MSVC series
 went to the Big Void. ;)

 -- Hannes

 test-genrandom.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/test-genrandom.c b/test-genrandom.c
index 8ad276d..b3c28d9 100644
--- a/test-genrandom.c
+++ b/test-genrandom.c
@@ -4,8 +4,7 @@
  * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
  */

-#include <stdio.h>
-#include <stdlib.h>
+#include "git-compat-util.h"

 int main(int argc, char *argv[])
 {
-- 
1.6.5.rc1.1051.gdc4fd
