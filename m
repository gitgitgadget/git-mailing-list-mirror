X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-format.txt: Combined diff format documentation supplement
Date: Thu, 26 Oct 2006 00:10:06 -0700
Message-ID: <7vvem7r1rl.fsf@assigned-by-dhcp.cox.net>
References: <ehoo2k$1g6$1@sea.gmane.org>
	<7vejswkoi4.fsf@assigned-by-dhcp.cox.net>
	<200610260544.50614.jnareb@gmail.com>
	<7vac3jk3g7.fsf@assigned-by-dhcp.cox.net>
	<7v1wovsgkf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 07:10:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v1wovsgkf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 26 Oct 2006 00:05:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30142>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GczNV-0005I8-SO for gcvg-git@gmane.org; Thu, 26 Oct
 2006 09:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751749AbWJZHKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 03:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWJZHKJ
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 03:10:09 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48347 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1751749AbWJZHKH
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 03:10:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026071007.YQTC22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 03:10:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ev9p1V00C1kojtg0000000 Thu, 26 Oct 2006
 03:09:50 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

This script minimally demonstrates a few interesting things an
evil merge can do.  Run it in a throw-away directory and view
the resulting merge with "git-show" with or without the patch I
sent out earlier.

One thing that you would notice is that the combined-diff code
chooses not to show the original contents of a deleted
file. while showing the whole result of a new file.  Strictly
speaking, this is inconsistent, but an evil merge is rare and
what ended up getting removed is not as interesting as what
remains as the result.

-- >8 --
#!/bin/sh

test -d .git && {
	echo Run me in an empty directory please
	exit 1
}

git init-db

echo one >file1.txt
git add file1.txt
git commit -m initial

git branch side

echo two >file2.txt
git add file2.txt
git commit -m second

git checkout side
echo uno >file1.txt
git commit -a -m side

git merge "Evil merge" HEAD master
rm -f file1.txt
echo added by the evil merge >file3.txt
echo modified by the evil merge >file2.txt
git update-index --add --remove file1.txt file2.txt file3.txt
EDITOR=: VISUAL=: git commit --amend



