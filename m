From: Paolo Bonzini <bonzini@gnu.org>
Subject: push.default???
Date: Mon, 22 Jun 2009 12:02:33 +0200
Message-ID: <h1nks1$vdl$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 12:03:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIgMe-0004Ah-H3
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 12:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbZFVKCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 06:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbZFVKCu
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 06:02:50 -0400
Received: from main.gmane.org ([80.91.229.2]:36535 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbZFVKCt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 06:02:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MIgMU-0007q9-PD
	for git@vger.kernel.org; Mon, 22 Jun 2009 10:02:50 +0000
Received: from nat-pool-brq.redhat.com ([62.40.79.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 10:02:50 +0000
Received: from bonzini by nat-pool-brq.redhat.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 10:02:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-pool-brq.redhat.com
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122024>

Hi all, I just upgraded to git 1.6.3 and found this new little gem 
called push.default...

Now, having gone through an attempt of proposing a different semantics 
for "git push", this stroke me as total nonsense, because now we have 
two totally incompatible ways to specify push refspecs.

A sensible implementation would have been something like this:

1) Also in 1.6.3, invent a special refspec for "tracking", something 
like "HEAD>" (of course this is not a special case; "refs/heads/*>" 
would also work, yadda yadda)

2) Also in 1.6.3, add a "--push={current,tracking,matching,mirror}" 
option to "git remote add" that would set up a push refspec without the 
need to actually know refspec syntax. (--mirror would become just a 
synonym for --push=mirror).

3) Possibly, in 1.6.3 make "git clone" add a "push = :" line for the 
origin branch.  This was actually suggested in a patch by myself.

4) in 1.6.4 or 1.7.0, make "git push" fail outright if there is no push 
line, with text suggesting

   For remotes that you will create in the future, please use the
   `--push' argument to `git remote add'.  For existing remotes,
   you can use the following command to obtain the same behavior as
   git 1.6.3:

     git config --add remote.origin.push :

   For alternative configurations, please look at the release notes
   for git 1.6.4.

so that it's a quick cut'n'paste into the shell to fix this (though once 
per repository).


I know it's my fault that I did not follow the development of git last 
March, but I could not help ranting that it is extremely wrong to 
specify what to push without a refspec (in the configuration, not in the 
command line -- the cmdlines can always have more "porcelain" attached 
to them).

(1) and (2) in particular can still be straightened, and (4) too maybe. 
  I can work on the implementation if we agree on the details.

Paolo
