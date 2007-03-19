From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 12:21:22 -0700
Message-ID: <45FEE2B2.6050904@midwinter.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org> <45FED31B.8070307@midwinter.com> <200703191903.20005.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Goerzen <jgoerzen@complete.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 20:21:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTNQ8-0007mF-SE
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 20:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbXCSTVY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 15:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbXCSTVY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 15:21:24 -0400
Received: from tater.midwinter.com ([216.32.86.90]:49804 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752654AbXCSTVW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 15:21:22 -0400
Received: (qmail 6731 invoked from network); 19 Mar 2007 19:21:18 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.129?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 19 Mar 2007 19:21:18 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <200703191903.20005.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42656>

Andy Parkins wrote:
> It's not really a guess; through the magic of sha-1, and provided you 
> are disciplined enough to commit the rename without any changes to the 
> content you can be sure that the rename is tracked.  The sha-1 /must/ 
> be the same before and after.  For this 100% case, git doesn't even 
> need the "-M", git-blame, git-diff and git-merge will find it anyway.
>   

I said as much in my mail. The problem is that "commit the rename 
without any changes to the content" is synonymous in many cases with 
"commit a revision that fails to compile." Which may or may not be 
acceptable in some environments but is, to me at least, a sign that 
something is inadequate in the version control system. I shouldn't be 
forced to have a broken build in my revision history just to be 100% 
certain my rename will be tracked accurately.

> The only command I've found that doesn't do the "right thing" by default 
> is git-log and I think that once the following works, all the "why 
> doesn't git track renames" people will go quietly away:
>
>  $ git init
>  $ date > file1
>  $ git add file1
>  $ git commit -m ""
>  $ git mv file1 file2
>  $ git commit -m ""
>  $ git mv file2 file3
>  $ git commit -m ""
>  $ git log -- file3
>   

The following is actually my biggest beef with git's rename tracking, 
and it has nothing whatsoever to do with git-log (though I agree git-log 
needs to track renames too):

$ ls
dir1
$ ls dir1
file1 file2 file3
$ echo "#include file1" > dir1/file4
$ git add dir1/file4
$ git commit
$ git pull
$ ls
dir1 dir2
$ ls dir1
file4
$ ls dir2
file1 file2 file3

That's just plain broken in my opinion. One can perhaps contrive a test 
case or two where that's the desired behavior, but in the real world it 
is almost never what you actually want.

By the way, I don't think fixing that is necessarily related to how 
renames get detected, so in some sense it's a different bug report / 
feature request than the rename hints one. It would be possible to 
figure out the directory had been renamed based purely on content 
analysis; a bunch of files all individually renamed to the same places 
under a new directory, and a lack of any files at all left in the old 
one, probably means the directory got renamed. The content-based rename 
detector could handle this case.

-Steve
