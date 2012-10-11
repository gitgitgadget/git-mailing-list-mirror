From: Yann Dirson <dirson@bertin.fr>
Subject: [BUG] "git commit" after "cherry-pick -n" conflict clobbers
 .git/COMMIT_EDITMSG
Date: Thu, 11 Oct 2012 11:33:52 +0200
Organization: Bertin Technologies
Message-ID: <20121011113352.006efa25@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 11:34:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMF9Y-0005Nu-6y
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 11:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201Ab2JKJdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 05:33:53 -0400
Received: from cabourg.bertin.fr ([195.68.26.10]:43636 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab2JKJdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 05:33:52 -0400
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 0014DA0FC6
	for <git@vger.kernel.org>; Thu, 11 Oct 2012 11:33:49 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id D05FBA0FBD
	for <git@vger.kernel.org>; Thu, 11 Oct 2012 11:33:49 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MBQ004592KDD600@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Thu, 11 Oct 2012 11:33:49 +0200 (CEST)
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19262.002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207469>

(only tested with 1.7.10.x for now)

~/softs/linux$ echo foo > .git/COMMIT_EDITMSG
~/softs/linux$ git cherry-pick -n b55f3d92cd
error: could not apply b55f3d9... Linux 2.6.32.26
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
~/softs/linux$ cat .git/COMMIT_EDITMSG
foo

So far, so good.  But then "git commit" brings me the message from the
cherry-picked commit plus the list of conflicted files, and I can verify that
it is now the contents of .git/COMMIT_EDITMSG.

Surely the fact I passed "-n" should prevent cloberring the message, even in the
event of a conflict.  I suppose that would imply not creating .git/MERGE_MSG in that
case, but just removing it still causes .git/COMMIT_EDITMSG to be clobbered, this
time with nothing but the "git status"-derived comments.

-- 
Yann Dirson - Bertin Technologies
