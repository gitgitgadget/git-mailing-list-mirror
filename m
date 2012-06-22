From: "Brecht Machiels" <brecht+gmane@mos6581.org>
Subject: git-svn and spaces in branch names
Date: Fri, 22 Jun 2012 19:57:26 +0200
Message-ID: <op.wgbf51qi518yxf@krusty>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 18:05:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SipJJ-0006qR-Ru
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 18:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab2FXQFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 12:05:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:55764 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189Ab2FXQFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 12:05:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SipJ9-0006lA-Hs
	for git@vger.kernel.org; Sun, 24 Jun 2012 18:05:03 +0200
Received: from 83.101.57.79 ([83.101.57.79])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 18:05:03 +0200
Received: from brecht+gmane by 83.101.57.79 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 18:05:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 83.101.57.79
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200536>

Hello,

I believe I have run into a bug in git-svn. I'm trying to clone a large  
subversion repository. It's layout looks roughly like this:

project/
   1.0/
     branches/
       some_feature
       anotherFeature
     tags/
       1.0 IR1
       1.0 IR2
       merge_tags/
         ...
       daily_builds/
         ...
   1.1/
     ...

I created a custom git-svn configuration to map the branches and tags to  
git remotes. As the tags dir inside each version dir contains the  
merge_tags and daily_builds folders, I have manually specified the tags to  
match:

   branches = 1.0/tags/{1.0 IR1,1.0 IR2}:refs/remotes/tags/1.0/*
   branches = 1.0/tags/daily_builds/*:refs/remotes/daily_builds/1.0/*
   branches = 1.0/tags/merge_tags/*:refs/remotes/merge_tags/1.0/*

The {} operator seems to fail on entries containing spaces. The tags seems  
to be cloned correctly, however, git-svn chokes on accessing them. I'm not  
at work now, so I can't paste the exact error, but it included the  
following error message:
fatal: Not a valid object name: 'remotes/tags/1.0/1.0%20IR1'.

I noticed this difference:
     ".git/refs/remotes/tags/1.0/1.0%20IR1" versus
".git/refs/svn/remotes/tags/1.0/1.0 IR1" (space versus HTML entity)

In an attempt to sidestep the issue, I tried the following configuration:

   branches = 1.0/tags/*:refs/remotes/tags/1.0/*

... and additionally using --ignore-paths on the daily_builds and  
merge_tags paths (I can take care of those later). This approach doesn't  
result in errors, so the problem must lie with the {} construct.

If any more information is required, I can provide it after the weekend.

Cheers,
Brecht
