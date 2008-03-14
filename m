From: Teemu Likonen <tlikonen@iki.fi>
Subject: builtin-remote bug: Stale tracking branch after "git clone"
Date: Fri, 14 Mar 2008 09:51:36 +0200
Message-ID: <200803140951.36514.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 08:52:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja4i9-000669-Fq
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 08:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbYCNHvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 03:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbYCNHvj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 03:51:39 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:62184 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078AbYCNHvi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 03:51:38 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout4-sn2.hy.skanova.net (7.3.129)
        id 478BE663003348DF for git@vger.kernel.org; Fri, 14 Mar 2008 08:51:37 +0100
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77188>

Hi

I have found a recently added bug. I'm using git version 
1.5.4.4.537.gb75aa ('master' branch). I can't describe it technically 
so I just type instructions how to reproduce it:


1) Clone some git repository. I think any repo will do.

2) Type "git remote show origin" in that cloned repo. You'll see 
something like this:

* remote origin
  URL: [...]
  Remote branch merged with 'git pull' while on branch master
    master
  Stale tracking branch (use 'git remote prune')
    HEAD
  Tracked remote branch
    master

$ find .git/refs/remotes
.git/refs/remotes/
.git/refs/remotes/origin
.git/refs/remotes/origin/HEAD
.git/refs/remotes/origin/master

3) As git asked, type "git remote prune origin".

4) Do "git remote show origin" again and it will display this:

* remote origin
  URL: [...]
  Remote branch merged with 'git pull' while on branch master
    master
  New remote branch (next fetch will store in remotes/origin)
    master [Hmm, interesting]

Seems like .git/refs/remotes/origin/master was deleted:

$ find .git/refs/remotes/
.git/refs/remotes/
.git/refs/remotes/origin
.git/refs/remotes/origin/HEAD

5) Now fetch that "new" remote branch again with "git fetch" and you'll 
see this:

error: refs/remotes/origin/HEAD points nowhere!
From [...]
 * [new branch]      master     -> origin/master

6) Now we're back in the beginning. See item 2.
