From: "David S. Miller" <davem@davemloft.net>
Subject: ORIG_HEAD
Date: Mon, 20 Jun 2005 22:10:55 -0700 (PDT)
Message-ID: <20050620.221055.71088925.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 21 07:13:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dkb4B-0000Ch-23
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 07:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVFUFSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 01:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVFUFNF
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 01:13:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48281
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261224AbVFUFLB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2005 01:11:01 -0400
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.50)
	id 1Dkb2F-0001jw-Iv
	for git@vger.kernel.org; Mon, 20 Jun 2005 22:10:55 -0700
To: git@vger.kernel.org
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Is there a really good reason why git-pull-script runs are deleting
that file now?

All my scripts use ORIG_HEAD so that I can look at the changelog after
I pull from someone.  There is now no record left around of what the
head was before the pull.

I could take the SHA1 output by the git-pull-script, but it'd be nice
if it was sitting under .git somewhere in case I forget to record
that information somewhere.

This is my "git-mklog" script, for example:

#/bin/sh

git-rev-tree HEAD ^ORIG_HEAD | sort -n | cut -d' ' -f2 >commit-list
cat commit-list | git-diff-tree --stdin -p | diffstat -p1 
echo ''
for i in $(cat commit-list)
do
    git-diff-tree -s -v ${i}
    git-diff-tree -p ${i} | diffstat -p1
    echo ''
done

rm -f commit-list

