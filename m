From: Ingo Molnar <mingo@elte.hu>
Subject: [script] ge: export commits as patches
Date: Tue, 19 Apr 2005 15:48:43 +0200
Message-ID: <20050419134843.GA19146@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:47:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNt3K-0003px-8T
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 15:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVDSNtl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 09:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVDSNtl
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 09:49:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62629 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261522AbVDSNt1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 09:49:27 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 19CA43204E8;
	Tue, 19 Apr 2005 15:48:04 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 42A821FC2; Tue, 19 Apr 2005 15:48:47 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


is there any 'export commit as patch' support in git-pasky? I didnt find 
any such command (maybe it got added meanwhile), so i'm using the 'ge' 
hack below.

e.g. i typically look at commits via 'git log', and then when i see 
something interesting, i look at the commit via the 'ge' script. E.g.  
"ge 834f6209b22af2941a8640f1e32b0f123c833061" done in the kernel tree 
will output a particular commit's header and the patch.

	Ingo

#!/bin/bash

if [ $# != 1 ]; then
 echo 'ge <commit-ID>'
 exit -1
fi
TREE1=$(cat-file commit 2>/dev/null $1 | head -4 | grep ^tree | cut -d' ' -f2)
if [ "$TREE1" = "" ]; then echo 'ge <commit-ID>'; exit -1; fi
PARENT=$(cat-file commit 2>/dev/null $1 | head -4 | grep ^parent | cut -d' ' -f2)
if [ "$PARENT" = "" ]; then echo 'ge <commit-ID>'; exit -1; fi
TREE2=$(cat-file commit 2>/dev/null $PARENT | head -4 | grep ^tree | cut -d' ' -f2)
if [ "$TREE2" = "" ]; then echo 'ge <commit-ID>'; exit -1; fi

cat-file commit $1
echo
git diff -r $TREE2:$TREE1

