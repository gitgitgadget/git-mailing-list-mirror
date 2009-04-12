From: Orestis Markou <orestis@orestis.gr>
Subject: git-svn doesn't recognise trunk as parent of branch
Date: Sun, 12 Apr 2009 19:40:46 +0300
Message-ID: <F562B0FA-6E9F-45AD-ADD5-D6EE1AD9C248@orestis.gr>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 18:42:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt2lE-0001lW-Fp
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 18:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbZDLQkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 12:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbZDLQku
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 12:40:50 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63655 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbZDLQku (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 12:40:50 -0400
Received: by fxm2 with SMTP id 2so1735289fxm.37
        for <git@vger.kernel.org>; Sun, 12 Apr 2009 09:40:48 -0700 (PDT)
Received: by 10.103.168.5 with SMTP id v5mr2863768muo.77.1239554447986;
        Sun, 12 Apr 2009 09:40:47 -0700 (PDT)
Received: from ?192.168.1.5? (athedsl-129796.home.otenet.gr [85.75.82.163])
        by mx.google.com with ESMTPS id 14sm7721339muo.50.2009.04.12.09.40.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Apr 2009 09:40:47 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116382>

Hello there - this is my first post to this ML, so please be kind!

I have previously used git-svn with great success. However, in this  
project, the svn repo layout is a bit unusual and I'm having getting  
git-svn to do the correct thing.

The repository I'm trying to clone is a subdirectory under a huge repo:

http://svn.example.com/projects/trunk/MyProject/Production

which has trunk, branches and tags and a couple of other directories  
(which I'm not interested in).

Complications so far:

* I don't have read access to the lower directories, only to Production
* Being a part of a big repo, the initial revision is something like  
2000
* trunk, branches, tags where not created in the same revision. trunk  
didn't exist until revision say 2050.


Doing 'git svn init -s http://svn.example.com/projects/trunk/MyProject/Production' 
  produces the following configuration:

[svn-remote "svn"]
url = http://svn.example.com/trunk/projects/MyProject/Production
fetch = trunk:refs/remotes/trunk
branches = trunk/projects/MyProject/Production/branches/*:refs/remotes/*
tags = trunk/projects/MyProject/Production/tags/*:refs/remotes/tags/*

Fetching this fetches only trunk and no branches.

Amending the config to be:

[svn-remote "svn"]
	url = http://svn.example.com/trunk/projects/MyProject/Production/
	fetch = trunk:refs/remotes/trunk
	branches = branches/*:refs/remotes/*
	tags = tags/*:refs/remotes/tags/*


and fetching (minor issue - have to start from scratch again), does  
fetch all commits. However, there is no link between branches and  
trunk. Using gitk (don't know how else to visualise this) shows  
branches as having no parent. Indeed, in the fetch messages there is  
no 'found possible parent' message. Also, when creating new branches  
in svn, nothing shows up in git until a change happens. Then the  
branch is created (again, with no parent).

The only case where a correct parent was set was when someone branched  
*from a branch*. Then the usual 'found possible parent' message  
appeared, and gitk shows a sane tree.

I'm on Mac OS X, git version 1.6.2.2.471.g6da14 (built from source,  
master branch). This includes a recent commit that fixed an issue with  
deep directories in git-svn, (without it I couldn't get the branches  
anyway), but it doesn't seem to have fixed the problem completely.

Any pointers welcome.

Regards,
Orestis
--
orestis@orestis.gr
http://orestis.gr/
