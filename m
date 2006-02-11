From: Christian Biesinger <cbiesinger@web.de>
Subject: Experiences with git-svnimport
Date: Sat, 11 Feb 2006 19:22:58 +0100
Message-ID: <43EE2B82.5040204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Feb 11 19:23:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7zP0-0004cE-Bf
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 19:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWBKSXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 13:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWBKSXL
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 13:23:11 -0500
Received: from smtp07.web.de ([217.72.192.225]:58043 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S932314AbWBKSXL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 13:23:11 -0500
Received: from [85.124.17.142] (helo=[192.168.1.4])
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.105 #340)
	id 1F7zOi-0002Wy-00
	for git@vger.kernel.org; Sat, 11 Feb 2006 19:23:04 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060209 SeaMonkey/1.5a
To: git@vger.kernel.org
X-Sender: cbiesinger@web.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15954>

Hi,

since I now got git-svnimport to work, I thought I'd post my experiences 
with it, as that may be helpful for others.

I had various setups here. One of them was the usual (?) one, where I 
had a subversion repository at https://servername/svn, containing three 
projects.

One of them followed the usual structure:
   projectname/trunk
   projectname/branches/...

Now, the straightforward way would be:
   git-svnimport -C somedir https://servername/svn projectname

It turns out that this is equivalent to
   git-svnimport -C somedir https://servername/svn/projectname
if the -d or -D option is not specified, and those can't be used with https.

And that doesn't work. The problem is that the SVN repository contains 
urls relative to the top of the repository, i.e. /projectname/trunk/...
That doesn't match the /trunk/ that's expected by svnimport.

The solution for this: Apply the patch I sent earlier and use:
   git-svnimport -v -C somedir -T projectname/trunk -b 
projectname/branches https://servername/svn/

It turned out that the other two projects on this server didn't use the 
trunk/branches structure (I forgot about that when setting them up), but 
that was not a problem: I could just do:

   git-svnimport -v -C somedir -T projectname https://servername/svn/

This also works fine for a svn+ssh:// repository.

Now, maybe my setup was unusual, and I should instead have used separate 
repositories for different projects. However, this worked for me, and my 
experiences in getting this to work might be of interest to others.
