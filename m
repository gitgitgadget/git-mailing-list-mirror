From: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
Subject: Re: Efficient cloning from svn (with multiple branches/tags   subdirs)
Date: Wed, 14 Oct 2009 10:07:27 +0100
Message-ID: <4AD594CF.5000304@manchester.ac.uk>
References: <hb2fvu$8qi$1@ger.gmane.org> <20091014060307.GA17178@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 11:16:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxzwS-0004qZ-Kg
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 11:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757683AbZJNJJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 05:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755582AbZJNJJx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 05:09:53 -0400
Received: from lo.gmane.org ([80.91.229.12]:38876 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbZJNJJw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 05:09:52 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MxzqU-0004x2-C9
	for git@vger.kernel.org; Wed, 14 Oct 2009 11:08:34 +0200
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 11:08:34 +0200
Received: from Bruno.Harbulot by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 11:08:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rain.gmane.org
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
In-Reply-To: <20091014060307.GA17178@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130270>

Hi Eric,

Eric Wong wrote:
> Hi Bruno,
> 
> That looks like there's two levels of tags.  You should be able to do
> this with your version of git in $GIT_CONFIG:
> 
> 	[svn-remote "svn"]
> 		url = http://restlet.tigris.org/svn/restlet
> 		fetch = trunk:refs/remotes/svn/trunk
> 		branches = branches/*:refs/remotes/svn/*
> 		tags = tags/*/*:refs/remotes/svn/tags/*/*
> 		; note the */* to glob at multiple levels

Thank you, here is what I had (with the multiple -t/-b):

[svn-remote "svn"]
         url = http://restlet.tigris.org/svn/restlet
         branches = branches/1.0/*:refs/remotes/svn/*
         branches = branches/1.1/*:refs/remotes/svn/*
         tags = tags/1.0/*:refs/remotes/svn/tags/*
         tags = tags/1.1/*:refs/remotes/svn/tags/*
         tags = tags/1.2/*:refs/remotes/svn/tags/*
         tags = tags/2.0/*:refs/remotes/svn/tags/*

I think the notation you suggest "*/*" is indeed better, since I don't 
have to specify each tag sub-directory. However, they change so rarely 
that it was only a minor issue.


>> What surprises me is that it looks like it's looping over and over,  
>> since sometimes it starts back from SVN revision 1 when it's trying to  
>> import a new tag.
> 
> Yeah, that's an unfortunate thing about the flexibility of Subversion,
> basically anything can be a "tag" or a directory and it's extremely
> hard for git svn to support any uncommon cases for tags/branches
> out-of-the box, so the manual config editing is needed.

I must admit I don't fully understand how git-svn does the import, but 
even with this manual configuration, it still tries to pull (almost) 
every revision from revision 1 for each tag, a bit as if there was:
   for each tag:
      for revision in 1 to tag.latest revision:
         pull the revision

(This isn't even for each tag, but for each modification of each tag, 
since tags aren't really tags in SVN).

What I'd like to be able to do (mainly for efficiency and more 
importantly not to hammer tigris.org) is to pull each revision at most 
once (even if it's for the directory at the top of trunk, branches and 
tags).

Best wishes,

Bruno.
