From: Mike Smullin <mike@smullindesign.com>
Subject: git-svn bug report: %20 in http:// should translate to a space '
 ' automatically
Date: Sat, 15 Aug 2009 11:48:10 -0600
Message-ID: <4A86F4DA.5090605@smullindesign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Aug 15 19:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McNU7-000630-Bp
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 19:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbZHORz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 13:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbZHORz4
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 13:55:56 -0400
Received: from ns1.smullindesign.com ([74.208.46.157]:58961 "EHLO
	smullindesign.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751164AbZHORzz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 13:55:55 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Aug 2009 13:55:55 EDT
Received: (qmail 10525 invoked from network); 15 Aug 2009 11:46:41 -0600
Received-SPF: none (no valid SPF record)
Received: from 206-251-44-142.directcom.com (HELO ?10.1.10.50?) (206.251.44.142)
  by ns2.smullindesign.com with SMTP; 15 Aug 2009 11:46:41 -0600
User-Agent: Thunderbird 2.0.0.22 (X11/20090719)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126014>

Hello,

This one took me over an hour to figure out with the help of doener in 
#git on irc.freenode.net:

(10:11:15) jeanrussou: i am using git-svn clone to checkout individual 
directories from an svn repo as separate .git repos on my local hdd. 
some of the git-svn clone attempts get all of svn repo history, this one 
gets only the last commit. an svn log of the same path returns a history 
of at least 5 commits. i only have the most recent one in my git log 
after git svn clone. any idea why?
...
(10:18:37) charon: jeanrussou: git-svn only tracks svn rename/copy 
operations that are "visible" to it, i.e., happen entirely within the 
paths cloned
(10:18:53) charon: jeanrussou: try 'svn log -v' to see if the directory 
was moved
(10:18:54) jeanrussou: charon: yes, i did move the path. is there a 
workaround? can i tell git-svn the original path before the move, or 
something?
(10:23:46) doener: jeanrussou: so what's the situation you have? Cloning 
repo/foo and repo/foo/bar was repo/goo in the past?
(10:23:56) doener: jeanrussou: or cloning repo/foo which was repo/bar in 
the past?
(10:24:59) jeanrussou: in the beginning there was 
http://repo/projects/Client%20Name/Project, then over time it became 
http://repo/projects/archive/Client%20Name/Project. i am now attempting 
git-svn clone on the latter url
(10:25:28) jeanrussou: there were no changes to the project after it 
went into archive
(10:25:36) jeanrussou: i believe this is why it appears to only be 
grabbing the last commit (which was the move)
(10:25:49) doener: jeanrussou: if that was a direct rename from one to 
the other, git-svn should be able to follow that
... (trying -T, also svn+ssh://) ... finally the cause is found ...
(11:27:49) jeanrussou: i wrap it in double-quotes and replace %20 with a 
space ' ' and it works
(11:31:40) jeanrussou: oh if i just replace %20 with a space the http:// 
url works too
(11:31:48) doener: *lol*
(11:31:57) jeanrussou: dangit
(11:32:20) jeanrussou: thanks doener
(11:32:23) jeanrussou: u rock
(11:32:25) doener: you're welcome
(11:33:10) doener: too bad that the bug reports I found didn't have the 
space issue, would likely have saved some time ;-)
(11:33:38) jeanrussou: ya we should make one
(11:34:01) jeanrussou: that would be cool if git-svn could unescape the 
url encodings for http:// paths
(11:34:17) doener: well, the path could contain a literal %20
(11:34:46) doener: not very common, but I guess the "give me the plain 
path, please" approach of git-svn is ok
(11:35:39) jeanrussou: ya i could see that with svn+ssh:// and file:// 
but with http:// its going over WebDAV and i'd have to read the RFCs but 
it might even be an HTTP thing about accessing URLs that % is not valid 
in URLs
(11:36:37) doener: yeah, those need to be escaped as %25 (IIRC). And 
it's kinda weird that the one without -T works
(11:36:49) jeanrussou: o ya definitely. that too
(11:36:56) doener: so yeah, a bug report might be the right thing
(11:36:57) jeanrussou: thats what threw me off. i thought the url was 
working because of that
(11:37:14) jeanrussou: okay cool lets see if i can find the git bug tracker

Hope this helps! :)

--
Respectfully,

Mike Smullin
Senior Web Systems Director
Smullin Design and Development, LLC

http://www.smullindesign.com
http://www.linkedin.com/in/mikesmullin

2112 E. Frontier St.
Eagle Mountain, Utah 84005
United States

toll-free: +1 800-819-7431
mobile: +1 801-652-5849
skype: smullindesign
