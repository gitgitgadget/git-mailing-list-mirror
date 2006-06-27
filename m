From: Andreas Ericsson <ae@op5.se>
Subject: cvs importer woes
Date: Tue, 27 Jun 2006 12:05:36 +0200
Message-ID: <44A102F0.9090604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 27 12:05:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvARy-0002OX-CQ
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 12:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWF0KFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 06:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWF0KFj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 06:05:39 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:13490 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751311AbWF0KFi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 06:05:38 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id BD2766BCE0
	for <git@vger.kernel.org>; Tue, 27 Jun 2006 12:05:36 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22721>

Sadly, the cvsimport command no longer works to create new repositories 
from scratch. I'm not nearly perl literate enough to fix it, but the 
problem seems to be firstly 061303f0b50a648db8e0af23791fc56181f6bf93. In 
particular "Also, make sure that the initial git-read-tree is 
performed." which fails if there is not a complete git repo already 
created with at least one tree committed.

Some sample output:

$ git cvsimport -k -u -d:local:/home/CVS packages
fatal: Not a git repository: '/data/home/exon/git/packages/.git'
read-tree failed: 32768

Removing the unconditional read-tree call, I get this (still in an empty 
directory which isn't a repo):

$ git cvsimport -k -u -d:local:/home/CVS packages
fatal: Not a git repository: '/data/home/exon/git/packages/.git'
read-tree failed: 32768

$ git init-db
defaulting to local storage area

$ git cvsimport -k -u -d:local:/home/CVS packages
fatal: Not a valid object name origin
read-tree failed: 32768

Bisect running now. v1.3.1 is good and imports the stuff properly to an 
empty directory.

Oh, now it's done (4 minutes for 620 revisions with automated testing 
between good/bad. *LOVE* bisect).

The culprit is definitely 061303f0b50a648db8e0af23791fc56181f6bf93.

Any perl-literate takers? Otherwise, just reverting the patch makes 
things work (for me) again.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
