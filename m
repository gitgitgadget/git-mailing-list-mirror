From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git reveals a bug in (some versions) BSD diff
Date: Fri, 12 Aug 2005 14:32:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508121424500.24891@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 12 14:35:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3YjW-0006ij-SJ
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 14:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVHLMc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 08:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVHLMc6
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 08:32:58 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21996 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751157AbVHLMc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 08:32:57 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id C658FE252F
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 14:32:54 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id B0F419CCA4
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 14:32:54 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 76FF8997B9
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 14:32:54 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 61AB7E252F
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 14:32:54 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

big was my surprise when my daily routine of "git pull" && "make test" 
failed. "git bisect" revealed that commit 8e832e: "String comparison of 
test is done with '=', not '=='." was the culprit.

But it isn't. The version of diff present on my iBook (OS 10.2.8) does not 
work properly in this case:

	(echo a; echo b | tr -d '\012') >frotz.2
	(echo a; echo c; echo b | tr -d '\012') >frotz.3
	diff -u frotz.2 frotz.3

yields

	--- a1  2005-08-12 14:24:19.000000000 +0200
	+++ a2  2005-08-12 14:24:27.000000000 +0200
	@@ -1,2 +1,3 @@
	 a
	+c
	 b

Note the missing "\ No newline at end of file". The same happens on 
sourceforge's compile farm's OS 10.1 server, but not on its OS 10.2 
server.

How to go about that? Silently ignore the missing line in apply.c? Force 
users to update their diff to a sane version?

Ciao,
Dscho
