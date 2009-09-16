From: daicoden <daicoden@copypastel.com>
Subject: Git Hooks
Date: Wed, 16 Sep 2009 16:24:11 -0700 (PDT)
Message-ID: <25482688.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 01:24:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo3rH-00085m-B8
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 01:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933567AbZIPXYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 19:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933561AbZIPXYK
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 19:24:10 -0400
Received: from kuber.nabble.com ([216.139.236.158]:40088 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933529AbZIPXYH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 19:24:07 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Mo3r9-00033l-77
	for git@vger.kernel.org; Wed, 16 Sep 2009 16:24:11 -0700
X-Nabble-From: daicoden@copypastel.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128695>


Hi,

I have a git repo host at /home/git/blog.git.  I have a copy checked out at
/var/www/blog.  I have a script as follows:

cd /var/www/blog
thin -s 2 -C config.yml -R config.ru stop
git pull origin master
thin -s 2 -C config.yml -R config.ru start 

>From a local machine I can commit to the repo, push, and then run this
script and the server will update just fine.  I wanted to make this
automatic so I wrote the following post-receive hook.

if git log -n1 | grep -q "#publish" || git log -n1 | grep -q "#Publish"
then
        ~/bin/update-blog
fi

If #publish is in the commit message then it runs the first script.  I found
through trial and error that when you use the command git from within a git
hook it needs to be executed in a .git directory, so I changed the first
script to.

cd /var/www/blog
thin -s 2 -C config.yml -R config.ru stop
cd .git
git pull origin master
cd ..
thin -s 2 -C config.yml -R config.ru start 

Everything executes, I see the messages of the server stopping, the new info
being pulled, then the server starts again, but the server does not reflect
any changes.  If I then manually stop the server, use git reset --hard, and
then start the server again it works fine.

My only thought is that the cause of this has something to do with git
operating differently when you call it from within a hook.  Unfortunately, I
don't have any thoughts on how to fix it.
-- 
View this message in context: http://www.nabble.com/Git-Hooks-tp25482688p25482688.html
Sent from the git mailing list archive at Nabble.com.
