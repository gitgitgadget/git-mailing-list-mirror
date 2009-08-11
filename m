From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: RFC for 1.7: Do not checkout -b master origin/master on clone
Date: Tue, 11 Aug 2009 17:17:36 +0200
Message-ID: <4A818B90.9050206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:18:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mat6v-0002N6-Qp
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbZHKPRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 11:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755215AbZHKPRw
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:17:52 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47105 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753208AbZHKPRv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 11:17:51 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DEF9A13605
	for <git@vger.kernel.org>; Tue, 11 Aug 2009 11:17:50 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 11 Aug 2009 11:17:50 -0400
X-Sasl-enc: 6vrfO/pyv69EWayVvAHB1Z6sb0tyAVZ4SEQxbToDSJvK 1250003870
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7BB2A5F9A
	for <git@vger.kernel.org>; Tue, 11 Aug 2009 11:17:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090811 Lightning/1.0pre Shredder/3.0b4pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125572>

One common source of confusion for newcomers is the fact that master is
given such a special treatment in git. While it is certainly okay and
helpful to set up a default branch in a new repository (git init) it is
not at all clear why it should be treated specially in any other
situation, such as:

- Why is master the only local branch which git clone sets up (git
checkout -b master origin/master)?

- Why does git svn set up a local branch with an svn upstream which is
determined by latest svn commit at the time of the first git svn fetch?

This behaviour not only is hard to justify; in fact it gives users a
completely wrong impression: by pretending that master is special, but
also by hiding core concepts (distinguishing local/remote branches,
detached heads) from the user at a point where that very hiding leads to
confusion.

Under the hood, it is of course HEAD which is given special treatment
(and which in the majority of repos points to master), and git clone
sets up a local branch according to HEAD (and does some other guess work
when cloning bare repos), which means that git clone shows the same
"random" behaviour which git svn clone does: Which local branch is set
up by default depends on the current value of HEAD/most recent commit at
the time of the cloning operation.

So, I suggest that starting with git 1.7:

- git clone does not set up any local branches at all
- git svn fetch does not set up any local branches at all

Ducking under my desk...
Michael
