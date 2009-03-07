From: Jakub Narebski <jnareb@gmail.com>
Subject: [GSoC] Google Summer of Code 2009 - new ideas
Date: Sat, 7 Mar 2009 01:44:17 +0100
Message-ID: <200903070144.17457.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 01:43:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfkdx-0007bR-WE
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 01:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbZCGAma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 19:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754100AbZCGAma
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 19:42:30 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:57527 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbZCGAm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 19:42:29 -0500
Received: by fxm24 with SMTP id 24so593196fxm.37
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 16:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=AVvq9/vh3OZ2rXKaY8QPQm1O4pBJp33WwyjYGT4VK7I=;
        b=DHEIAKsEcqaIWdXJjVIJvMD57zx0VRW5OA3HhxTO9n2be+zGp6XVKKMg5hMyiHdMvp
         I7L+qZdXiugig3To9cdUstPLiUjhaZuA4hDCscylPFZkeEd/lw9dHK3kIxBdz7vUcdlE
         BlkjmP7aZOLo6IFPMuhQVN/RuTNmCnuMdoCG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=FmeDHk5ztJDyYFtRxHwGiq0NzvY0C06Oz8qj6HYw8YHy5VA/yLgkXFDc8EqX/rnZtU
         qqPVbrV7T2HOb9qzEtJoTdg1ttAaWojdfeoiyHmAWEHSArCwE7kpw6r4puia3Kwm9BVP
         1fApmOSiYq7rhkamoOdTfva+idto9ZkBfPnrY=
Received: by 10.103.137.12 with SMTP id p12mr1335116mun.94.1236386545914;
        Fri, 06 Mar 2009 16:42:25 -0800 (PST)
Received: from ?192.168.1.13? (abvg205.neoplus.adsl.tpnet.pl [83.8.204.205])
        by mx.google.com with ESMTPS id u26sm1851135mug.29.2009.03.06.16.42.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 16:42:25 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112497>

Time to submit application as mentoring organization to
Google Summer of Code 2009 is close:  March 9 -- March 13.

I'd like to add a few ideas to SoC2009Ideas wiki page, but before I do 
this I'd like to ask for comments.  (The proposals also lacks proposed 
mentor).

I am wondering if it would be worth it to make a separate class between 
"New to Git?" easy tasks, and "Larger Projects" hard tasks...

BTW. some of ideas didn't make it from SoC2008Ideas wiki page to current 
year page, namely: 
 * Apply sparse To Fix Errors
 * Lazy clone / remote alternates
 * Implement git-submodule using .gitlink file
 * Teach git-apply the 3-way merge fallback git-am knows
 * Better Emacs integration
Was this ommision deliberate or accidental?


-- >8 --

= New To Git? New To Open Source Development? =

== Packfile caching for git-daemon ==

Even with delta reuse, enumerating objects to be present in packfile 
generates significant load on server for pack-generating protocols, 
such as git:// protocol used by git-daemon.  Many of requests result in 
the same packfile to be generated and sent; examples include full 
clone, or fetch of all branches since last update.  It would make sense 
then to save (cache) packfiles, and if possible avoid regenerating 
packfiles by sending them from cache.  (Possible extension would be to 
send slightly larger pack than needed if one can reuse cached packfile 
instead).

The goal is for git-daemon to cache packfiles, use cached packfiles if 
possible, and to manage packfile cache.  Note that one would need in 
the final version some way to specify upper limit on packfile cache 
size and some cache entry expire policy.

'''Goal:''' Support for packfile cache in git-daemon,
            benchmark server load
'''Language:''' C

== Single credentials ==

Currently if you don't save your username and password in plain-text 
`.netrc` file (for HTTP transport), or avoid need for interactive 
credentials using public key / private key pair (for SSH), you need to 
repeat credentials many times during single git-fetch or git-clone 
command.  The goal is to reuse existing connections if possible, so the 
whole transaction occurs using single connection and single 
credentials; if that is not possible cache credentials (in secure way) 
so user need to provide username and password at most once.

'''Goal:''' git-fetch and git-clone over HTTPS and git:// 
            requiring providing username and password at most once
'''Language:''' C (perhaps also shell script)


= Larger Projects =

== Directory renames ==

Git deals quite well with renames when merging.  One of the corner cases 
is when one side renamed some directory, and other side created ''new 
files'' in the old-name directory.  Git currently creates new files in 
resurrected old-name directory, while it could create new files under 
new-name directory instead.

There is a bit of controversy about this feature, as for example in    
some programming languages (e.g. Java) or in some project build tool  
info it is not posible to simply move a file (or create new file in    
different directory) without changing file contents.  Some say that    
is better to fail than to do wrongly clean merge.

'''Goal:''' At minimum option enabling wholesame directory rename 
detection.  Preferred to add dealing with directory renames also to 
merge.  At last, one can try to implement "git log --follow" for 
directories.
'''Language:''' C
'''See:''' [http://thread.gmane.org/gmane.comp.version-control.git/99529 
|RFC PATCH v2 0/2| Detection of directory renames] thread on git 
mailing list (via GMane)
'''See also:'''
 * 
[http://thread.gmane.org/gmane.comp.version-control.git/80912/focus=81362 
merge renamed files/directories?] subthread on git mailing list
 * [http://thread.gmane.org/gmane.comp.version-control.git/108106 
Comments on "Understanding Version Control" by Eric S. Raymond] thread 
contains some thoughts on wholesame directory rename detection
 * [http://blog.teksol.info/2008/01/16/directory-renames-under-git 
Directory renames under Git] blog post notice the issue
 * [http://www.markshuttleworth.com/archives/123 Renaming is the killer 
app of distributed version control] blog post by Mak Shuttleworth 
(pro-Bazaar).

-- 
Jakub Narebski
Poland
