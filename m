From: Simon Holm =?ISO-8859-1?Q?Th=F8gersen?= <odie@cs.aau.dk>
Subject: bug related to branches using / in name
Date: Thu, 26 Jun 2008 21:42:30 +0200
Message-ID: <1214509350.28344.31.camel@odie.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 22:39:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KByFx-0007pP-Ay
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 22:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759933AbYFZUic convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2008 16:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761075AbYFZUic
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 16:38:32 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:36156 "EHLO smtp.cs.aau.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761073AbYFZUib (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 16:38:31 -0400
X-Greylist: delayed 3388 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jun 2008 16:38:30 EDT
Received: from [10.0.0.2] (port939.ds1-abc.adsl.cybercity.dk [212.242.156.194])
	(authenticated bits=0)
	by smtp.cs.aau.dk (8.14.1/8.14.1) with ESMTP id m5QJfiRw015916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jun 2008 21:41:46 +0200
X-Mailer: Evolution 2.22.2 
X-Spam-Level: () 0.263
X-Scanned-By: MIMEDefang 2.62 on 130.225.194.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86483>

Hi git community

I have a bug report I think is most easily explained by a list of
commands that illustrates the bug.

cd /tmp
mkdir git-bug
cd git-bug
git init
touch foo
git add foo
git commit -a -m '...'
git branch sched
git clone file:///tmp/git-bug /tmp/git-bug-clone
git branch -d sched
git branch sched/urgent
git branch sched/devel
cd /tmp/git-bug-clone
git pull

The last command does not succeed, but produces the following output

error: unable to resolve reference refs/remotes/origin/sched/devel: Not
a directory
>From file:///tmp/git-bug
 * [new branch]      sched/devel -> origin/sched/devel
error: unable to resolve reference refs/remotes/origin/sched/urgent: No=
t
a directory
 * [new branch]      sched/urgent -> origin/sched/urgent

I can work around it by
rm /tmp/git-bug-clone/.git/{,logs/}refs/remotes/origin/sched

but git should take care of this automatically, right?

I'm on git version 1.5.6.


=EF=BB=BFSimon Holm Th=C3=B8gersen
