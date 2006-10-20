From: David Lang <dlang@digitalinsight.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 10:23:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0610201012550.5248@qynat.qvtvafvgr.pbz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com><Pi
 ne.LNX.4.64.0610171605440.3962@g5.osdl.org> 
 <45357411.20500@utoronto.ca><200610180246.18758.jnareb@gmail.com> 
 <45357CC3.4040507@utoronto.ca><Pine.LNX.4.64.0610172014250.3962@g5.osdl.org
 > <4536EC93.9050305@utoronto.ca><87lkncev90.wl%cworth@cworth.org> 
 <453792A8.1010700@utoronto.ca><878xjc2qeb.wl%cworth@cworth.org> 
 <453803E6.2060309@utoronto.ca><87ods727pn.wl%cworth@cworth.org> 
 <45382120.9060702@utoronto.ca><Pine.LNX.4.64.0610192202340.3962@g5.osdl.org
 >  <45387F04.5010101@research.canon.com.au><Pine.LNX.4.63.0610201034170.14200@
 wbgn013.biozentrum.uni-wuerzburg.de><ehaapb$5t7$3@sea.gmane.org>
 <Pine.LNX.4.63.0610201335420.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Fri Oct 20 19:24:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gay69-000125-6h
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 19:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWJTRXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 13:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWJTRXy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 13:23:54 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:42690 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S964810AbWJTRXx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 13:23:53 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 20 Oct 2006 10:23:53 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Fri, 20 Oct 2006 10:23:44 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610201335420.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29508>

On Fri, 20 Oct 2006, Johannes Schindelin wrote:

> On Fri, 20 Oct 2006, Jakub Narebski wrote:
>
>> Johannes Schindelin wrote:
>>
>>> On Fri, 20 Oct 2006, Lachlan Patrick wrote:
>>>
>>>> How does git disambiguate SHA1 hash collisions?
>>>
>>> It does not. You can fully expect the universe to go down before that
>>> happens.
>>
>> Or you can compile git with COLLISION_CHECK
>>
>>> From Makefile:
>> # Define COLLISION_CHECK below if you believe that SHA1's
>> # 1461501637330902918203684832716283019655932542976 hashes do not give you
>> # sufficient guarantee that no collisions between objects will ever happen.
>
> You can document your disbelief.
>
> But it does not change a thing. Since v0.99~653, we do not have any
> collision check, even if compiled with COLLISION_CHECK.

I had the same disbelief as you about this, however the last time this came up 
Linus pointed out something that satisfied me.

any action in git that could create or or recreate an object will not overwrite 
an object that it thinks that it already has.

so

if you create a new local file that would conflict and save it, git will accept 
your save and throw away the new file.

if you pull from a remote repository and there is a file there that conflicts 
with a file you already have it will throw away the new file.

if you pull from a remote repository and someone has hacked it to replace a file 
with a bad one, if you already have the good one git will throw away the bad 
one.

as a result the worst case is that a new file being checked in doesn't really 
get in and when someone checks it out and trys to use it they get the old 
contents. In the case of code, it's extremely unlikly that the wrong code will 
even compile, let alone do anything remotely close to working correctly. At this 
point the fix is to go back to the origional developer to get the correct 
version while additional changes are made to git (and remember, that unless this 
is a brand new file the prior version is readily available so only the latest 
diff needs to be recovered)

so the odds are extremely low and the concequeces of a collision are fairly 
minor.

git has (or had) an option to actually check the full contents before throwing 
away the new copy instead of just checking the hash (and throwing an error if 
the contents don't match), but the performance cost of this is pretty high.

David Lang
