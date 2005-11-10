From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: Check for differents trees
Date: Wed, 9 Nov 2005 22:57:14 -0800 (PST)
Message-ID: <20051110065714.88318.qmail@web26310.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 07:58:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea6N5-00018O-9d
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 07:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVKJG5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 01:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVKJG5Q
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 01:57:16 -0500
Received: from web26310.mail.ukl.yahoo.com ([217.146.176.21]:8879 "HELO
	web26310.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751234AbVKJG5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 01:57:15 -0500
Received: (qmail 88320 invoked by uid 60001); 10 Nov 2005 06:57:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gpksFqlzpMskH7ikOG5tnSKHmap3NVG9xd97iMYI59E2sdOYwugK9KhmLpcA1i5+qku8nm9OeCGP4HcMMzpdBYNVIlS+iMuR2N/evPiK3t4q+/rE4lQe6ADAfSwDeuheBAI7BrDnDR+lGg/7DIdm80sv+pNrUUNh3deUzYQKFqk=  ;
Received: from [151.44.24.184] by web26310.mail.ukl.yahoo.com via HTTP; Wed, 09 Nov 2005 22:57:14 PST
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11466>

Junio C Hamano wrote:

>Marco Costalba <mcostalba@yahoo.it> writes:
>
>>   as you said, the speed is almost the same but your way is clearly better.
>
>
>How often do you do this --diff-filter=AD and why?
>
>If it is a common enough operation, we could add a specific hack
>to stop feeding the diff machinery with unwanted kind of changes
>when diff-filter is set and none of -B/-C/-M are used.  That
>_might_ speed things up for you.
>

Sorry for late answer but I was off line a few days.

QGit has a tree viewer now. Tree view is updated when user browses through revisions. Loading the
file names of a given tree, although only for the open directories, is an expensive operation. So
qgit checks for different files anytime the user selects a new revision and the tree viewer is
open, I use this test to skip tree reloading if trees have the same files.

I have made some speed test on Linux tree with 
       git-diff-tree -r --name-status --diff-filter=AD sha1 sha2

On my box it takes from 50-100ms for near revisions to almost 2 seconds when you select a new
revision very far from current one. Add to this the fact that in distant revs case there is a high
probability that the trees are found different, so you need also to reload the tree at the end,
adding extra time before GUI update.

So definitely, It will be great to keep tree browsing snappy. I speak for qgit, but I think any
git viewer that adds tree browsing feature should benefit from this change.


  Marco

P.S: By the way, if I understand correctly, what you propone is a different behavior of
--diff-filter=AD. Not to filter for AD, but to find first match of AD. Because of this, IMHO
should be better to have a --first-match=AD flag or, better idea, to use --max-count option (from
git-rev-list) togheter with --diff-filter and have something like:

git-diff-tree -r --name-status --diff-filter=AD --max-count=1 sha1 sha2




	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
