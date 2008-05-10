From: Ingo Molnar <mingo@elte.hu>
Subject: git-remote questions: --reference? Plus a git-clone --remote
	observation.
Date: Sat, 10 May 2008 12:52:36 +0200
Message-ID: <20080510105235.GA17577@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 12:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JumiK-0007K5-TA
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 12:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbYEJKwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 06:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbYEJKwv
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 06:52:51 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:44996 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbYEJKwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 06:52:50 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1Jumgv-00050O-QS
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Sat, 10 May 2008 12:52:48 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 89B023E21DB; Sat, 10 May 2008 12:52:36 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81661>


git-1.5.4.3-2.fc8.

Today i tried to set up a new tracking repository from scratch and used 
git-remote to populate it. It took a lot of time because it downloaded 
it all from the remote site - but i already had most of those commits 
locally.

I'm using git-clone --reference quite extensively to speed up the 
creation of such new repositories, and i'm wondering whether something 
similar is available/planned for git-remote as well?

Also, i noticed a weirdness about "git-clone --reference" today.

As per the log below, i tried to use a large repository with lots of 
remote tracking branches as a reference for cloning - but there were a 
suprisingly large number of objects to be downloaded - 18K of them.

When i did the same with a linux-2.6.git repository (Linus's upstream 
tree), i only had 1915 commits to fetch.

But Linus's tree is already tracked in the linux.trees.git 
super-repository! I double-checked that both linux-2.6.git and 
linux.trees.git had the exact same head for Linus's tree. So why did 
--reference=super-tree have to download much more than if i used the 
smaller reference tree?

now, i'd expect --reference to just fetch every object locally that it 
can - regardless of the composition of that tree. Apparently it matters 
what the current head is in a repository that is used via --reference?

	Ingo

---------->

$ git-clone --reference=linux.trees.git ssh://master.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git linux-tmp6
Initialized empty Git repository in /home/mingo/linux-tmp6/.git/
remote: Counting objects: 18014, done.
remote: Compressing objects:  31% (5273/17009)

$ git-clone --reference=linux-2.6.git ssh://master.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git linux-tmp5
Initialized empty Git repository in /home/mingo/linux-tmp5/.git/
remote: Counting objects: 1915, done.
remote: Compressing objects: 100% (765/765), done.
