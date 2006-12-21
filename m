From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Thu, 21 Dec 2006 06:53:22 -0500
Message-ID: <458A75B2.6050201@garzik.org>
References: <4589F9B1.2020405@garzik.org> <4589FD9E.2010000@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 12:53:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxMUJ-0004Im-Iy
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 12:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWLULxY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 06:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWLULxY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 06:53:24 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:41807 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030199AbWLULxY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 06:53:24 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1GxMUE-00009u-Kr; Thu, 21 Dec 2006 11:53:23 +0000
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: Jay Cliburn <jacliburn@bellsouth.net>
In-Reply-To: <4589FD9E.2010000@bellsouth.net>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35059>

Jay Cliburn wrote:
> Jeff Garzik wrote:
>> I refreshed my git intro/cookbook for kernel hackers, at 
>> http://linux.yyz.us/git-howto.html
>>
>> This describes most of the commands I use in day-to-day kernel 
>> hacking.  Let me know if there are glaring errors or missing key 
>> commands.
> 
> Thanks for doing this.  I've referred to your previous page rather often 
> as I grope around trying to learn git and hack a vendor driver for 
> submittal into the mainline kernel.
> 
> One thing that baffled me was how to use git to create a "kitchen sink" 
> diff that would produce my entire driver suitable for submittal to lkml 
> for review.  This probably isn't needed very often, but for new driver 
> submittals it's important to know how to do it.  Francois Romieu showed 
> me how (assume the new driver branch is named "driver"):
> 
> $ git diff $(git merge-base master driver)..driver
> 
> As a beginner, this command continues to be utterly non-intuitive to me, 
> but it works.  There may be other ways to do it, too.
> 
> The point is, I think you should add instructions on your cookbook that 
> address how to produce such a "kitchen sink" diff if you're submitting a 
> brand new driver to lkml.  (Obviously I don't know what such a diff is 
> actually called.)

You inflict upon yourself all sorts of pain if you keep updating 
'master', but don't merge that into 'driver'.  Typically you want to 
rebase after updating master:

	git checkout driver
	git rebase master
	# build and test
	git prune

or merge master into your current branch:

	git checkout driver
	git pull . master
	# build and test

That way, you are GUARANTEED that

	git diff master..driver

will result in a diff that you can send upstream.

One moral of this story, as (I think) Linus mentioned, don't update 
'master' too frequently.  That's one key lesson of distributed 
programming.  Unless the upstream kernel has a key API change or bug fix 
you need, just pretend the outside world does not exist, and hack away 
on your driver.

	Jeff
