From: Jose de Leon <jdeleon@ensim.com>
Subject: RE: How to combine git repos with similar code and keep all
 branches and tags?
Date: Tue, 14 Apr 2015 17:31:38 +0000
Message-ID: <BBAA9EAE77388248BCAB045DA762C5A83EFE251A@EXBE01-ENSIM.ms.ensim.com>
References: <BBAA9EAE77388248BCAB045DA762C5A83EFE242F@EXBE01-ENSIM.ms.ensim.com>
 <13B30361-1BCD-4481-A33B-E5C65C8169F9@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 19:31:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi4gf-00035Y-By
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 19:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933136AbbDNRbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 13:31:46 -0400
Received: from shoul9.shouldermarketclay.com ([72.20.112.5]:58914 "EHLO
	EXBE01-ENSIM.ms.ensim.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S964847AbbDNRbk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 13:31:40 -0400
Received: from EXBE01-ENSIM.ms.ensim.com ([fe80::ddf0:e9:a641:4631]) by
 EXBE01-ENSIM.ms.ensim.com ([fe80::ddf0:e9:a641:4631%13]) with mapi id
 14.02.0247.003; Tue, 14 Apr 2015 10:31:39 -0700
Thread-Topic: How to combine git repos with similar code and keep all
 branches and tags?
Thread-Index: AdB2ztI6QJ0o6s2KSh2JuBsCGX2q2QAQlWYAAA4aGJA=
In-Reply-To: <13B30361-1BCD-4481-A33B-E5C65C8169F9@quendi.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.58.106.21]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267154>

Thank you!

-----Original Message-----
From: Max Horn [mailto:max@quendi.de] 
Sent: Tuesday, April 14, 2015 10:15 AM
To: Jose de Leon
Cc: git@vger.kernel.org
Subject: Re: How to combine git repos with similar code and keep all branches and tags?

Hi Jose,

On 14.04.2015, at 18:44, Jose de Leon <jdeleon@ensim.com> wrote:

> Hi All,
> 
> 
> I've got an interesting problem and the possible solutions I've found from searching google don't seem to work for us.  In a nutshell, I need to combine multiple git repositories into single repository and preserve all history, branches and tags from each repository.    
> 
> Does anybody have a solution for this, how do this kind of thing, is it even possible?
> 
> For some unknown reason to me, our developers started a git project, called Ver1, this was the first version.  Then sometime later, they created a new git repository called Ver2, the initial commit for Ver2 was essentially a copy of the code in Ver1 from the master.  They didn't clone it, they just copied the code at the latest point.  This wasn't done by forking.  Then they repeated this for Ver3 and Ver4, etc.  On top of all that, they have been adding new code to Ver1, Ver2, etc. that has caused each to divert from the other and each have their own branch and tag sets.  They have similar directory structure and similar file names, but there are some slight differences in structure.
> 
> Well, this has become unmanageable and now we want to combine them into one single git repository.   
> 
> Logically, these are the same project but at different versions, basically, Ver1 and Ver2, etc, should be simply branches at different times if these were combined into a single repository.

Here is one possible way to go about this using grafts (I used something similar in the past);

1) Get all the data into a single git repository.

  Since everything is already in a git repositories, you could e.g. create a
  clone of Ver1; then add remotes for Ver2 ... VerN, and fetch them all,
  along with tags. If there are conflicts between branch or tag names, deal
  with them at this point.

2) Create graft points to tie the history together.

   Identify the commit in Ver1 at which Ver2 branched off. Then, graft that
   as parent for the initial commits of Ver2. See here for some basic
   instructions <http://cp.mcafee.com/d/1jWVIq6hEi6jqb2pEVKOyUqenztPqqdNPaabzz1Jd6UVB54sepdFET7cEEKefCQQrzCkknxPVIhgY_WM1nMF9nBPvMF9nBPqa91x1dZ_HYCCMOeWZOWr8W_c3AnXYJteOaqJT6ul3PWApmU6CQjqpK_nd7bwUsMyqemnPtPpesRG9px6k-ciaOUHYouvM070bU8U4EWXcblB2pJngY52PvMgBO7CS1Ob1I5-Aq80LkMq89Rd42V2kfd416kPh17RGQd41ykOpEwF9mh-Nd45GEuq8dwwq82L-Iq8dffd412eMIj-xEwS21EwDF6x8SeudOB_GPPAJ5zzZ> or feel
   free to ask for details (or Google, or... :)

   Repeat vor Ver2+Ver3, Ver3+Ver4, etc.

3) Finally, you can get rid of the graft points, and turn everything into a "proper" history, by running "git filter-branch". Something like

  git filter-branch -- --all

ought to do it, but I might be forgetting something (I am sure somebody will correct me soon in that case, though ;-). Best to have a look at <http://cp.mcafee.com/d/2DRPowcCQm4PhPtB5MQsL6XCQQrzCkkn763qqdNPaa8UsOrjhKephhssvdFET7cEEL3DPoyxV_Rw2LxiiLbC_xiiLbCQki322rX_nVddxAtRXBQShR-o78LTVqWtAkRrKcYG7DR8OJMddFCQPt-Kqen1MVx4QsILCXCM0p6kOZbaYLy5rkMzaptShY_yn8hS5ypJngY52PvMgBO7CS1Ob1I5-Aq80LkMq89Rd42V2kfd416kPh17RGQd41ykOpEwF9mh-Nd45GEuq8dwwq82L-Iq8dffd412eMIj-xEwS21EwDF6x8SeudXyyH> for yourself, though.


This all is under the assumption that you want to stay as close to how things really were (usually a good idea). But sometimes it may be desirable to make further adjustments. E.g. you may wish to adjust committer names, rearrange some stuff (though usually git is quite good at doing the right thing automatically, etc. How to do that of course depends on what exactly you want to do, but in many cases, filter-branch is your friend.

Hope that helps!

Max
