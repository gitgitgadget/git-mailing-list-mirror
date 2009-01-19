From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: parent-filter loses my merged branch -- what am I doing wrong?
Date: Sun, 18 Jan 2009 19:45:35 -0800
Message-ID: <7578B9A6-BF81-4096-B0FD-F433AD62A41E@develooper.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 04:47:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOl6L-0001Do-7X
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 04:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937AbZASDpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 22:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757777AbZASDph
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 22:45:37 -0500
Received: from x8.develooper.com ([216.52.237.208]:47424 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757711AbZASDpg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 22:45:36 -0500
Received: (qmail 20549 invoked from network); 19 Jan 2009 03:45:36 -0000
Received: from gw.develooper.com (HELO embla.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 19 Jan 2009 03:45:36 -0000
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106313>

Hi everyone,

I'm converting another svn repository to git (yay).  It's only about  
1000 commits, but over more than 7 years and a cvs->svn conversion.

On Sam Villain's recommendation I'm spending a bit of time cleaning up  
the branches and merges with git filter-branch, but I don't think I'm  
quite understanding how it's supposed to work.

I put the repository up here (about 1MB):
	git clone git://git.develooper.com/qpsmtpd.git

I started out making a temporary tag for each svn commit, to have  
easier to use reference points:

for c in `git rev-list --all --date-order --timestamp | sort -n | awk  
'{print $2}'`; do
   svnid=`git show -s $c | tail -1 | sed 's/.*svn.perl.org\/qpsmtpd 
\///' | sed 's/\ .*//' | sed 's/^branches\///'`
   git tag -f $svnid $c
done

Then I tried getting the first merge adjusted to show both parents.     
The commit tagged v010@56 should be the second parent for trunk@57  
(the original/other parent for trunk@57 is trunk@20).

I tried using:

git filter-branch --tag-name-filter cat --parent-filter '
                  if test $GIT_COMMIT = $(git rev-parse trunk@57)
                  then
                     echo "-p $(git rev-parse trunk@20) -p $(git rev- 
parse v010@56)"
                  else
                     cat
                  fi
         ' \
master

...  but that seems to just basically throw away the "v010" branch!   
What did I do wrong?  (Some of the other problems with this repository  
is that we moved the branches around with "svn mv", so some of the  
branches don't even have the branch point as a parent; but I'll get  
back to that when I get this simple case working).

(The script also loses all the temporary tags I added; I thought "-- 
tag-name-filter cat" would preserve them?)


  - ask

-- 
http://develooper.com/ - http://askask.com/
