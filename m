From: Tim Chase <git@tim.thechases.com>
Subject: Splitting a commit with rebase -i and keeping a commit message
Date: Tue, 16 Apr 2013 20:38:25 -0500
Message-ID: <20130416203825.3701d98b@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 17 04:03:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USHid-00062z-Sn
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 04:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936220Ab3DQCD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 22:03:28 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:52079 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936204Ab3DQCD1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 22:03:27 -0400
X-Greylist: delayed 1597 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2013 22:03:27 EDT
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:36913 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1USHIn-0000Ch-KI
	for git@vger.kernel.org; Tue, 16 Apr 2013 20:36:49 -0500
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221496>

I asked this on IRC and played with some of their ideas, but struck
out with anything satisfying.  I walked through [1] with the
following setup:

  git init foo
  cd foo
  touch a.txt b.txt
  git add a.txt b.txt
  git commit -m "Initial checkin"
  echo "Modify A" >> a.txt
  git commit -am "Modified A"
  echo "Modify B" >> b.txt
  git commit -am "Modified B"
  echo "Modify A2" >> a.txt
  echo "Modify B2" >> b.txt
  git commit -am "Modified B"
  git commit -am "Long-bodied commit comment about b.txt changes"
  # whoops, just wanted B
  git rebase -i HEAD^^
  # change the "Added b.txt..." commit to "edit"
  git reset HEAD^  # pull the changes out of the pending commit
  git add a.txt
  git commit -m "Tweaked a.txt"
  git add b.txt
  git commit ${MAGIC_HERE}
  git rebase --continue

I haven't been able to figure out a good way to keep the "long-bodied
commit comment" for the final commit where the ${MAGIC_HERE} is.  Is
there a right/easy way to go about pulling in the commit-message from
the commit the rebase is transplanting?

-tkc

[1]
http://git-scm.com/book/en/Git-Tools-Rewriting-History#Splitting-a-Commit
