From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git and announcing GIT v1.5.0-rc1
Date: Mon, 15 Jan 2007 13:56:07 -0800
Message-ID: <7vtzys0xag.fsf@assigned-by-dhcp.cox.net>
References: <200701150221.l0F2LlwJ016982@laptop13.inf.utfsm.cl>
	<45ABE9FD.4050601@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Mon Jan 15 22:56:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6ZoX-0006Gy-1Z
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 22:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbXAOV4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 16:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXAOV4L
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 16:56:11 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34085 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbXAOV4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 16:56:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070115215607.HTE25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Mon, 15 Jan 2007 16:56:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id BZvE1W00T1kojtg0000000; Mon, 15 Jan 2007 16:55:15 -0500
To: lamikr@cc.jyu.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36888>

lamikr <lamikr@cc.jyu.fi> writes:

>> Be careful, this gives you a old-fashioned repository, the repositories
>> created by 1.5.0-rc are different, and 1.4.4.4 doesn't grok them:
>>
>>    * refusing to create funny ref 'remotes/origin/*' locally
>>   
> So that would also not work if one uses git-1.4.4 client for fetching
> from the git-1.5.x repository?

That is untrue.  You do not care (nor you would not generally be
even to tell) which version the repository at the remote end was
prepared with when cloning or fetching from a remote git
repository.

A new repository created by 'git-clone' in 1.5.0 will create the
repository with default configuration that uses a new feature to
allow all (present or future) remote branches tracked.  

The feature is
"refspec wildcard" and looks like this:

	[remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*

1.4.4 and older do not understand this new feature used in the
configuration, so if you create a new repository by running
1.5.0 clone, you would need to futz with the configuration file
if we want to use that repository with 1.4.4; you would need to
specify the branches you would want individually:

	[remote "origin"]
        fetch = +refs/heads/master:refs/remotes/origin/master
        fetch = +refs/heads/next:refs/remotes/origin/next

Even if you are updating to 1.5.0, if you will never be
interested in some of the remote branches, the above to exclude
unwanted ones is a good trick to know.
