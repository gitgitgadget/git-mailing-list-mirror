From: Jeff Jenkins <Jeff@ShopWiki.com>
Subject: checkout and rm
Date: Thu, 6 Sep 2007 22:59:14 -0400
Message-ID: <4F2CF06E-CCC6-4597-A1BF-663BC36B9A94@ShopWiki.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 05:18:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITUM2-0003zw-DA
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 05:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbXIGDPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 23:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbXIGDPS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 23:15:18 -0400
Received: from rs19.luxsci.com ([65.61.136.23]:59261 "EHLO rs19.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932643AbXIGDPR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 23:15:17 -0400
X-Greylist: delayed 954 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Sep 2007 23:15:17 EDT
Received: from [192.168.0.103] (cpe-69-201-182-174.nyc.res.rr.com [69.201.182.174])
	(authenticated bits=0)
	by rs19.luxsci.com (8.13.7/8.13.7) with ESMTP id l872xMDW017316
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 6 Sep 2007 21:59:22 -0500
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57969>

I couldn't find a thread in the archive about this.  Here's the  
abbreviated scenario:

$ git add bar.c
$ git-rm foo.c
rm 'foo.c'
$ git-status
# On branch FOO
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   bar.c
#       deleted:    foo.c
#

$ git-checkout master
M       bar.c
Switched to branch "master"
$ git-status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   bar.c
#

When I change branches:
- the modified files in the index/working directory stay there  
(that's fine)
- the *removed* files are re-added to the working directory when the  
branch changes
- the remove entries aren't in the index anymore

There was no warning about any the lost changes, and if the intent  
was to commit these changes to master because you were in FOO by  
accident, then only some would be committed if you weren't paying  
close attention.  If working directory/index changes are going to be  
kept when a branch switch is done, then the remove changes should be  
propagated as well.

Ideally there would be a config setting which would stop checkouts if  
the working directory or index were dirty (and a flag on checkout  
which overrode the setting).    With stash in 1.5.3 the only reason I  
can think of to allow working directory changes to propagate is gone  
(though i haven't tested how stash works with rm'd files).  At the  
very least, there should be a warning and a prompt if some of the  
changes are going to vanish by a user action

-Jeff Jenkins
