From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Weird filename encoding issue
Date: Fri, 17 Oct 2008 10:55:24 +0200
Message-ID: <48F852FC.2070506@viscovery.net>
References: <c6c947f60810170059s3859d906r9935b5e80d8a41c6@mail.gmail.com> <c6c947f60810170108q3038b66bj2ad89bdcb7105903@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 10:56:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kql8S-0004rr-UH
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 10:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbYJQIz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 04:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbYJQIz3
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 04:55:29 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57197 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbYJQIz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 04:55:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kql7E-0001QF-UN; Fri, 17 Oct 2008 10:55:25 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 891A8AFCC; Fri, 17 Oct 2008 10:55:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <c6c947f60810170108q3038b66bj2ad89bdcb7105903@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98460>

Alexander Gladysh schrieb:
> 3. Clone repo to OS X machine and see the weird behaviour. Git status
> can't decide how file should be named, "%CA%EE%EF%E8%FF.txt" or
> "\312\356\357\350\377.txt".

It's not 'git status' that cannot decide how to name the file. It's OS X.

> $ git status
> # On branch master
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #	%CA%EE%EF%E8%FF.txt
> nothing added to commit but untracked files present (use "git add" to track)
> $ ls
> %CA%EE%EF%E8%FF.txt

git asked OS X:

   Does the file "\312\356\357\350\377.txt" exist?

and OS X said: "Yes". Because otherwise, you would have seen the file
listed as "deleted:" in the 'git status' call above.

But then git also requested a file listing from OS X in order to list the
untracked files. And now OS X returned the name "%CA%EE%EF%E8%FF.txt". How
could you expect git to tell that this is the same file when OS X cannot
decide how to name it?

The solution: Do not use file names with some local (let alone Windows
specific) encoding if you have to use the files on OS X, too.

-- Hannes
