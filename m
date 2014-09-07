From: xmeng <xmeng@cs.wisc.edu>
Subject: Check out git-author
Date: Sun, 07 Sep 2014 18:05:13 -0500
Message-ID: <0a3b0f232ec56517d4db43c6bd6ebb63@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 01:10:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQlbe-0002nn-QP
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 01:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbaIGXKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 19:10:47 -0400
Received: from sandstone.cs.wisc.edu ([128.105.6.39]:57031 "EHLO
	sandstone.cs.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbaIGXKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 19:10:46 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Sep 2014 19:10:46 EDT
Received: from webmail.cs.wisc.edu (lilo.cs.wisc.edu [128.105.7.102])
	by sandstone.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id s87N5Dh4026713
	for <git@vger.kernel.org>; Sun, 7 Sep 2014 18:05:13 -0500
X-Sender: xmeng@cs.wisc.edu
User-Agent: Roundcube Webmail/0.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256630>

Hi all,

I have been using git-blame to track who changed a line of code or who 
to blame for a line of code. It is easy to use. For example, for this 
particular line of code:

$ git blame -L 2235,2235 fs/ext4/mballoc.c
85556c9a (Wei Yongjun 2012-09-26 20:43:37 -0400 2235)   
meta_group_info[i] = kmem_cache_zalloc(cachep, GFP_KERNEL);

The problem with git-blame is that it only reports the last 
author/commit that changed the line, regardless of the magnitude of the 
change. Sometimes, the last author may only change a tiny part of the 
code and should not be blamed. I developed a built-in tool called 
"git-author" to address this problem. Git-author is designed to track 
the complete development history of a line. For the same line of code:

$ git author -c -L 2235,2235 fs/ext4/mballoc.c
        CURRENT LINE 2235:       meta_group_info[i] = 
kmem_cache_zalloc(cachep, GFP_KERNEL);
85556c9 Wei Yongjun     :       meta_group_info[i] = 
kmem_cache_zalloc(cachep, GFP_KERNEL);
fb1813f Curt Wohlgemuth :       meta_group_info[i] = 
kmem_cache_alloc(cachep, GFP_KERNEL);
5f21b0e Frederic Bohe   :       meta_group_info[i] = kzalloc(len, 
GFP_KERNEL);
c9de560 Alex Tomas      :               meta_group_info[j] = 
kzalloc(len, GFP_KERNEL);

Git-author shows the complete development history of this line code. We 
can see "Wei Yongjun" only changed the line to call a different function 
(from "kmem_cache_alloc" to "kmem_cache_zalloc"). "Wei yongjun" is not 
responsible for the other part of the line. "Curt Wohlgemuth" changed 
the line to call a different function (from "kzalloc" to 
"kmem_cache_alloc") and to use a different parameter (from "len" to 
"cachep") and "Frederic Bohe" changed the line to use a different array 
index (from "i" to "j").

Git-author should be useful to people who wants to see the complete 
history of lines of code.

If you are interested in git-author, you can check it out at 
https://github.com/mxz297/git/tree/git-author (please check out branch 
'git-author'). Also we have a paper describing more technical details 
about git-author in ICSM 2013 
(ftp://ftp.cs.wisc.edu/paradyn/papers/Meng13Authorship.pdf).

Let me know if you have any question, feedback, bug about git-author!


Thanks

--Xiaozhu
