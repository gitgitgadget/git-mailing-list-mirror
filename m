X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Is cp -al safe with git?
Date: Thu, 16 Nov 2006 19:47:20 +0100
Message-ID: <ejibnp$mmq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 16 Nov 2006 18:55:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 45
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: at00d01-adsl-194-118-045-019.nextranet.at
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31617>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkmOO-0004AT-0U for gcvg-git@gmane.org; Thu, 16 Nov
 2006 19:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424348AbWKPSzO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 13:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424343AbWKPSzO
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 13:55:14 -0500
Received: from main.gmane.org ([80.91.229.2]:61364 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1424354AbWKPSzM (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 13:55:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GkmO6-00045L-K7 for git@vger.kernel.org; Thu, 16 Nov 2006 19:55:02 +0100
Received: from at00d01-adsl-194-118-045-019.nextranet.at ([194.118.45.19]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 19:55:02 +0100
Received: from johannes.sixt by at00d01-adsl-194-118-045-019.nextranet.at
 with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 19:55:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

For one reason or another I would like to "clone" a local repo including the
checked-out working tree with cp -al instead of cg-clone/git-clone, i.e.
have all files hard-linked instead of copied.

Can the copies be worked on independently without interference (with the git
tool set)?

One thing I noticed is that git-reset or probably git-checkout-index breaks
links of files that need not be changed by the reset. Example:

# make 2 files, commit
$ mkdir orig && cd orig
$ git-init-db 
defaulting to local storage area
$ echo foo > a && cp a b && git-add a b && git-commit -a -m 1
Committing initial tree 99b876dbe094cb7d3850f1abe12b4c5426bb63ea

# 2nd commit modifies only one file:
$ echo bar > a && git-commit -a -m 2

# create the copy:
$ cd ..
$ cp -al orig copy
$ cd copy

# working files are hard-linked:
$ ls -l
total 8
-rw-r--r-- 2 jsixt users 4 Nov 16 19:24 a
-rw-r--r-- 2 jsixt users 4 Nov 16 19:23 b

# nuke a commit:
$ git-reset --hard HEAD^
$ ls -l
total 8
-rw-r--r-- 1 jsixt users 4 Nov 16 19:24 a
-rw-r--r-- 1 jsixt users 4 Nov 16 19:24 b

I'd have expected that the hard-link of b remained and only a's link were
broken. Does it mean that git-reset writes every single file also for large
trees like the kernel? I cannot believe this. Can someone scratch the
tomatoes off my eyes please?

-- Hannes

