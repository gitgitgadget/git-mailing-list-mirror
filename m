From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git checkout -f: What am I missing?
Date: Thu, 28 Jan 2010 11:27:13 +0100
Message-ID: <4B616681.4080700@drmicha.warpmail.net>
References: <4B4F899C.7070800@box.net> <4B508997.8030105@drmicha.warpmail.net> <4B60B2CF.10401@box.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Soham Mehta <soham@box.net>
X-From: git-owner@vger.kernel.org Thu Jan 28 11:29:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaRcq-0000gU-CX
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 11:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab0A1K3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 05:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963Ab0A1K3S
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 05:29:18 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57010 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752915Ab0A1K3R (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 05:29:17 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 25700CE6B2;
	Thu, 28 Jan 2010 05:29:17 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 28 Jan 2010 05:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=lKeVXqj4Wm4Z1mb64A/3wMzTM9A=; b=NDcs235gW0uhZ9Rx89Siq7ZXd0A1pO5zDnQTqvWB6JH8uE2SWGbl1dBrhyIQp8dFMR1Us58uMXjNxzcgVeynaCPGfDvPnTwrB53vtZFnSz/yxc08dkty0Q1iis/M977687Ie8z8W0zujeMOtMgDmLLIYd8ab/0oV+QFVqRy5xz0=
X-Sasl-enc: LUhIWcdjqVTN8CogxcGhuNzml3Vi/ofp6uGCTuTvGTbx 1264674556
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 89A144BCF69;
	Thu, 28 Jan 2010 05:29:16 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8pre) Gecko/20100121 Lightning/1.0b2pre Shredder/3.0.2pre
In-Reply-To: <4B60B2CF.10401@box.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138244>

Soham Mehta venit, vidit, dixit 27.01.2010 22:40:
> Thanks Michael.
> 
> Is that a bug? If not, how do I understand it?
> 
> -Soham
> 
> 
> thus spake Michael J Gruber , On 1/15/2010 7:28 AM:
>> Soham Mehta venit, vidit, dixit 14.01.2010 22:16:
>>   
>>> Hi,
>>>
>>> I have a situation with git that I'm trying to understand:
>>>
>>> Description:
>>> 1) GIT_DIR is set to /path/to/repo/.git
>>> 2) Repository is /not /a bare repo, and all files are nicely checked-out 
>>> in /path/to/repo/
>>> 3) Somebody pushes to that repo using ssh (any branch, checked-out or not)
>>> 4) Default post-receive hook runs (it is the only one +x) which sends 
>>> out an email 
>>> (http://repo.or.cz/w/git.git/blob/HEAD:/contrib/hooks/post-receive-email)
>>> 5) After it is done sending the email, I put "git checkout -f", at the 
>>> end in the same file, in case someone pushes to a checked-out branch
>>>
>>> Problem:
>>> It runs "checkout -f" as if inside .git directory, instead of on the 
>>> parent. i.e. it gets all files from the parent and writes them inside 
>>> .git. Parent is left untouched.
>>>
>>> Some more info:
>>> 0) We don't have GIT_DIR set in the environment. The hook does a 
>>> rev-parse to find it.
>>> 1) echo of $GIT_DIR right before the checkout -f line gives a "." .
>>> 2) It works as expected if I do this:  cd /path/to/repo && git 
>>> --git-dir=/path/to/repo/.git/ checkout -f
>>>
>>> What I do know:
>>> 1) Pushing to a checked-out branch is not a git best-practice, and some 
>>> git behavior is undefined in that case. We already have plans to go away 
>>> from that.
>>> 2) Git tends to like full path names instead of relative ones
>>>
>>> Can someone help me understand this behavior?
>>>     
>>
>> Does the thread
>> http://permalink.gmane.org/gmane.comp.version-control.git/136267
>> help by any chance?
>> You've found the solution, "cd .. && unset GIT_DIR" does it.
>>
>> Michael
>>   

Because it messes up the reading order.

Why?

Please don't top-post.

Back to your question: The thread I pointed you to explains that git
sets "GIT_DIR=.", and given that the behaviour is exactly as expected.
It's not a bug. Changing it may break existing hooks.

One may argue for a change in behaviour in the next major release, but
not 1.7. any more.

Michael
