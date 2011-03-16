From: Ilya Furmanov <furious-i@yandex.ru>
Subject: git-cvsserver pserver username propagation
Date: Wed, 16 Mar 2011 18:55:39 +0000 (UTC)
Message-ID: <loom.20110316T194158-206@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 20:00:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzvxL-0007Nh-Dc
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 20:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab1CPTAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 15:00:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:50022 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239Ab1CPTAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 15:00:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pzvx0-0007g9-Fr
	for git@vger.kernel.org; Wed, 16 Mar 2011 20:00:06 +0100
Received: from alaintech.corbina.net ([alaintech.corbina.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 20:00:06 +0100
Received: from furious-i by alaintech.corbina.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 20:00:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.179.144.142 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.134 Safari/534.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169182>

Hello All!

For some specific workflow issues at my company, I need to allow some users work 
with CVS, while main repository is under git.

I've chosen git-cvsserver as implementation for this task.

I set up git repository, enabled it for gitcvs and setup a pserver simulation on 
xinetd. Everything works fine, I can work with this repository from cvs client, 
authenticating against passwd file I created through pserver emulation.

My problem is that commits that I make through CVS are shown under user who runs 
xinetd, not under user I authenticate against passwd.

i.e. I commit to CVS as user 'foo', I successfully authenticate through pserver, 
but when I look at git history of commits for this repo, i see that commit has 
been made by user 'root'.


I looked through source of git-cvsserver (http://git.kernel.org/?
p=git/git.git;a=blob;f=git-cvsserver.perl) and it seems that CVS login is used 
only for authentication, not for actual committing.
Records in SQLite database contain 'root' username too, not 'foo'


Do you have any ideas how I can propagate CVS login to git username?
