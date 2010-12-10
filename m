From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 07/18] gitweb: Revert back to $cache_enable vs. $caching_enabled
Date: Thu, 09 Dec 2010 18:38:00 -0800
Message-ID: <4D019288.9060503@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>	<1291931844-28454-8-git-send-email-warthog9@eaglescrag.net> <m3y67y1psd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 03:36:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQsqM-0005bO-Ml
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 03:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab0LJCgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 21:36:16 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:57319 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab0LJCgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 21:36:16 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA2aDiA020435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 9 Dec 2010 18:36:13 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <m3y67y1psd.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 18:36:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163382>

> Formally, there is no backward compatibility with any released code.
> Using out-of-tree patches is on one's own risk.

I will have to beg to differ with you on this, the entirety of the
existing caching engine has been released code for a number of years,
there are rpm packages available for it, at the very least, in Fedora
and in EPEL.

The caching engine *IS* released code, and this patchset is as much a
new feature as an attempt to merge a fork.  Kernel.org isn't the only
one running this code, and that has been the case for several years now
already.

Claiming that this isn't released code is doing me a disservice to me,
and those who have submitted patches to it independent of git and the
mainline gitweb.

Thinking about the patch series outside of that context will lead to me
putting my foot down and arguing on those other users behalf.  I'm not
keen on breaking them for no good reason, and I'm not seeing your change
here as one that's particularly worthwhile, while causing external
breakage for no reason.

> But even discarding that, I'd rather use the same solution as in
> 
>   [PATCHv6/RFC 22/24] gitweb: Support legacy options used by kernel.org caching engine
>   http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163058
>   http://repo.or.cz/w/git/jnareb-git.git/commitdiff/27ec67ad90ecd56ac3d05f6a9ea49b6faabf7d0a
> 
> i.e.
> 
>   our $cache_enable;
> 
>   [...]
> 
>   # somewhere just before call to cache_fetch()
>   $caching_enabled = !!$cache_enable if defined $cache_enable;
> 
>>
>> This reverts back to the previous variable to enable / disable caching

Is there really any point in changing the name at all?  The intention of
cache_enable, at one point, was to allow for other caching engines and
while there aren't any other caching engines that use it, it's already
treated identically to cache_enable.

If it really adds enough to the readability to the code, then I'm fine
with adding:

	$caching_enabled = $cache_enable if defined $cache_enable;

But now you are setting up two variables that control the same thing,
adding the possibility for conflicts and confusion to end users.

I just want that stated.

Also, why the double negative in your original snippet - that doesn't
entirely make sense....

          |  cache_enable     |    caching_enabled
----------+-------------------+---------------------
enabled:  |        1          |            1
disabled: |        0          |            0

doing a double negative like that doesn't really buy you much except
turning 0 into NULL or '' which is equivalent to 0...

- John 'Warthog9' Hawley
