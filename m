From: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
Subject: cvsps wierdness
Date: Mon, 12 Jun 2006 22:47:01 +0200
Organization: Dewire
Message-ID: <200606122247.02727.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jun 12 22:47:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FptJb-0000uH-2C
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 22:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWFLUrM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 16:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWFLUrL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 16:47:11 -0400
Received: from [83.140.172.130] ([83.140.172.130]:31025 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1751059AbWFLUrK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 16:47:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 48D91802669
	for <git@vger.kernel.org>; Mon, 12 Jun 2006 22:45:49 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04197-02 for <git@vger.kernel.org>; Mon, 12 Jun 2006 22:45:49 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by torino.dewire.com (Postfix) with ESMTP id EC649802654
	for <git@vger.kernel.org>; Mon, 12 Jun 2006 22:45:46 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21739>


I sometimes get out-of-order imports with git-cvsimport when consecutive 
commits have the same message. I narrowed it down to a small demo:

#!/bin/bash -x
mkdir demo
cd demo
export CVSROOT=$(pwd)/cvsrepo
mkdir $CVSROOT
cvs init
mkdir $CVSROOT/x
cvs co -d sandbox x
cd sandbox
echo X >k.txt
cvs add k.txtsometimes 
cvs commit -m "A commit"
sleep 1
echo a >v.txt
cvs add v.txt
cvs commit -m "A commit"
sleep 1
echo b >v.txt
cvs commit -m "A commit"
cvsps -x --norc

-- end --

The script creates a small CVS repo with three commits on two files. What's 
odd is that cvsps lists revision 1.2 of the file v.txt *before* version 1.1, 
like this:

---------------------
PatchSet 1
Date: 2006/06/13 00:34:15
Author: roro
Branch: HEAD
Tag: (none)
Log:
A commit

Members:
        k.txt:INITIAL->1.1
        v.txt:1.1->1.2

---------------------
PatchSet 2
Date: 2006/06/13 00:34:17
Author: roro
Branch: HEAD
Tag: (none)
Log:
A commit

Members:
        v.txt:INITIAL->1.1

Maybe someone with cvsps insight can spot the error? If you don't get the
same error I wouldn't be surprised because I had a similar example that would
not repeat itself on both of the machines I tried it. This one however "works" 
every time (on my machines).

-- robin
