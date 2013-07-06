From: David Rothenberger <daveroth@acm.org>
Subject: Re: git-svn "Temp file with moniker 'svn_delta' already in use" and
 skelta mode
Date: Fri, 05 Jul 2013 19:02:25 -0700
Message-ID: <51D77AB1.9020708@acm.org>
References: <kr7beq$ilk$1@ger.gmane.org> <E82AC74E-3294-415D-8E59-97DDD213B11A@gmail.com> <51D75196.4030100@acm.org> <5675CCAE-F4E8-48B7-8B63-BE91AAE09DD5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kyle McKay <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 06 04:02:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvHpc-0006Tf-7E
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 04:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551Ab3GFCC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 22:02:28 -0400
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:48447 "EHLO
	qmta07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752524Ab3GFCC1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jul 2013 22:02:27 -0400
Received: from omta12.emeryville.ca.mail.comcast.net ([76.96.30.44])
	by qmta07.emeryville.ca.mail.comcast.net with comcast
	id wprM1l0030x6nqcA7q2TRF; Sat, 06 Jul 2013 02:02:27 +0000
Received: from [10.249.1.104] ([24.16.16.7])
	by omta12.emeryville.ca.mail.comcast.net with comcast
	id wq2R1l00E098amo8Yq2SWA; Sat, 06 Jul 2013 02:02:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <5675CCAE-F4E8-48B7-8B63-BE91AAE09DD5@gmail.com>
X-Enigmail-Version: 1.5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373076147;
	bh=Ph+j1DEtG9p6mHQPhRPE6jz7e40hTMUsuRKaXgUdG4w=;
	h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
	 Content-Type;
	b=hNj2TSrX3vZ77lIVsBdXR15fn/eVpVtmNtCns2bsWUszeW5mrDsYgEduT1la6EmqM
	 nd3YAbjZaCkjsdOXCvP4H90FaYusSS9cVN9QrKZjWAp6Brn9XKy4sK5+B/4mpr0G2d
	 /rDsaNVwvGOwWYSXb9nimhFNv0UIjS5F5CM8vyA5tcmBtrpR7ILguBp2liZQ7J9VpA
	 3srNo4KGQMKdl/pEpqAkx0Y0Q3UOJDy8/bwTUdRmK/dwiWuECLFr2iKx/p7G+5AJoM
	 subFmilwEs0i4zw4W0FAqCb66wblFhTIYI41NO0zXY+qzQ1TajUZs9N/QQNu4vjcJW
	 okOOH6YpZYu5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229687>

On 7/5/2013 6:01 PM, Kyle McKay wrote:
> On Jul 5, 2013, at 16:07, David Rothenberger wrote:
>> On 7/5/2013 3:58 PM, Kyle McKay wrote:
>>> On Jul 5, 2013, at 13:48, David Rothenberger wrote:
>>>> I recently upgraded my Subversion server to 1.8.0 and started
>>>> receiving the following error from "git svn fetch":
>>>>
>>>> Temp file with moniker 'svn_delta' already in use at
>>>> /usr/lib/perl5/vendor_perl/5.10/Git.pm line 1024.
>>>>
>>>> This occurs only when using an http:// URL; svn:// URLs work fine.
>>> [snip]
>>>> The client is Cygwin: svn version 1.8.0 and git version
>>>> 1.8.3.2.
>>>
>>> The subversion 1.8 release has removed the neon library, all svn client
>>> http access now always goes through the serf library.  If you put
>>> "http-library = serf" in the "[global]" section of the
>>> "~/.subversion/servers" file you will get the 'svn_delta' error with
>>> git-svn when running earlier versions of the svn client as well.
>>
>> That was not my experience. I did try this with the 1.7 perl bindings
>> and libraries and with "http-library = serf" in by servers and it worked
>> fine. I confirmed that serf was being used with a Wireshark trace.
> 
> I had it always fail right away from my home ISP (kinda slow
> connection), but when running on a host with quite a different internet
> connection it would sometimes run for a while before generating the
> error (maybe a couple hundred revisions fetched) for some sources, but
> it would *always* eventually fail.
> 
> For this reason I also believe the problem is timing sensitive.
> 
> Try doing "git svn clone --quiet
> http://dev.heuristiclab.com/svn/hl/core" with "~/.subversion/servers"
> section "[global]" including "http_library = serf".  I find this one
> always seems to fail right away for me with git-svn over serf but will
> clone fine over neon (if you can stand to wait long enough).

Yes, you're right. That one fails for me too with 1.7, although I note
that the server itself is running 1.5. Still, the reason is the same --
a non-depth-first drive of the delta editor from serf.

-- 
David Rothenberger  ----  daveroth@acm.org

"If Diet Coke did not exist it would have been necessary to invent it."
                -- Karl Lehenbauer
