From: Junio C Hamano <junkio@cox.net>
Subject: "git-diff-tree -R A B == git-diff-tree B A"?
Date: Fri, 20 May 2005 07:56:08 -0700
Message-ID: <7vacmquet3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 16:56:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ8uO-0004rp-Go
	for gcvg-git@gmane.org; Fri, 20 May 2005 16:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVETO4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 10:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVETO4T
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 10:56:19 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:53931 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261417AbVETO4K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 10:56:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520145610.DLOV550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 10:56:10 -0400
To: torvalds@osdl.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I was preparing a set of tests for diff family because I wanted
to have something that catches screwups I am going to inflict
upon them during the coming couple of days.  One of the tests
accidentally found out that the above is not true in the current
implementation.  Just an excerpt of relevant lines [*1*]:

$ git-diff-tree -r $tree_B $tree_A

+100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
+100644 blob 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 DF/DF
-100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
-100644 blob 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM

$ git-diff-tree -R $tree_A $tree_B

+100644 blob 7e426fb079479fd67f6d81f984e4ec649a44bc25 AN
-100644 blob 71420ab81e254145d26d6fc0cddee64c1acd4787 DF
+100644 blob 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 DF/DF
-100644 blob 3c4d8de5fbad08572bab8e10eef8dbb264cf0231 DM

I personally don't care about the difference of the order these
are output, but it affects the stability of the test, and also
is inconsistent --- everybody else sorts the entries in the
cache order.

Although I do not see practical problems in this inconsistency,
I am asking you just in case if you care about it.  If there is
a downstream consumer that relies on the ordering of the entries
this may cause problems (diff-helper is OK).

[Footnote]
*1* The trees are taken from t1000-read-tree-m-3way.sh test.

