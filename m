From: Caleb Marchent <cmarchent@aminocom.com>
Subject: Re: Interpretation of '/' changed sparse-checkout
Date: Wed, 23 May 2012 14:09:24 +0000 (UTC)
Message-ID: <loom.20120523T160215-390@post.gmane.org>
References: <loom.20120521T183651-286@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 16:09:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXCG9-0004Uj-6X
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 16:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045Ab2EWOJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 10:09:46 -0400
Received: from plane.gmane.org ([80.91.229.3]:59995 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755158Ab2EWOJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 10:09:45 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SXCFt-0003ph-MA
	for git@vger.kernel.org; Wed, 23 May 2012 16:09:37 +0200
Received: from mail.aminocom.com ([62.255.172.253])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 May 2012 16:09:37 +0200
Received: from cmarchent by mail.aminocom.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 May 2012 16:09:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.255.172.253 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.46 Safari/536.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198285>

Caleb Marchent <cmarchent <at> aminocom.com> writes:

Corrected cut-paste errors on first submission, seems I missed a bunch of 
terminating '/' when hand-copying the text in from the sparse-checkout files :-( 
Sorry.

I have a system where I checkout by default everything except one directory. 
Then the rules in the top-level sources can selectivly reintroduce 
subdirectories as required for the build target.
I have deployed, using git 1.7.2.5, a set of git trees which use the following 
sparse-checkout rules to achieve this.

/
!exclude/
exclude/reinclude/


I have however discovered that if the reincluded directory is the same as the 
first part of any other path then that path will also be checked out.
 
/
!exlcude/
exclude/wanted/

 
will checkout both:

exclude/wanted/
exclude/wanted_not/


This appears to have bee fixed in git 1.7.10.2 but from that version of git 
onwards using '/' to request everything and then exclude a specific directory 
from it no longer works.
 
While I have been able to contrive the same effect with recent versions of git 
using the following updated sparse-checkout rules
 
/*
!exclude/
exclude/reinclude/

 
Even with this work-around there are two problems:

1) If I have a path: exclude/reinclude/exclude, this will now be exluded where 
I would expect it to be included as it was with 1.7.2.5
 
2) I have a large number of deployed trees across a number of machines that 
have the existing format which will break when git operations are performed 
after a upgrade to the latest git.
 
I believe that the interpretation of '/' should be 'everything in the repo', 
from which later rules can exclude. I think this is a bug in recent versions 
of git. I have been working on some ideas for a fix to the git code based along 
these lines. Can anyone confirm if my analysis is correct or provide an 
alternate solution?
 
Also I would like to know if anyone knows the solution to point 1) above as 
this also blocks upgrading to the latest version of git.
 
 
