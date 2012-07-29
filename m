From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git with large files...
Date: Sun, 29 Jul 2012 14:47:44 -0400
Message-ID: <CAM9Z-n=52qeGPkFo77hvhLYEFFuZP02hckyGD3aR+py5PB7wbw@mail.gmail.com>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com>
	<86fw8mf3gp.fsf@red.stonehenge.com>
	<7vvchfple2.fsf@alter.siamese.dyndns.org>
	<CAMK1S_hO5g5p4NjoVcxYFTt_KZ-wBRJk=OCveeszwr8U2LeZbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>,
	Darek Bridges <darek.bridges@me.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 20:47:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvYWw-0005KC-03
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 20:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab2G2Srr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 14:47:47 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53273 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab2G2Srq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 14:47:46 -0400
Received: by bkwj10 with SMTP id j10so2556204bkw.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RK/10mRghwybXVMSN0N4gevT2V6zHErn+sDaEhU2KYw=;
        b=axx6RTkbjeQTesqcQ0QyGsi5irITCcjNPv+7RJBZIqZLntjov0SoBj0ZqRSXdRgneR
         Kil15sLk7WLg4PtBYQc9yrpFCp+JpbhoEtP69PyxyuzishyLYainCHaScdXIq9Y7Ag0m
         eeASfgI7UKj38BHKKhkd4eB8SLr2KllXf8PoDIywoaZRDRlLXzg16ikC2qW7HGJCaEL7
         on4LrXM3BIWaiSdG7NQUlk9IKWq9inebTCBU6LL4tbP04Uo/XMPTdXnX0U4H/Z5cYWO5
         PNv3T9NDpL/MLEpcTxWpxTP9U3gKUBB8TBvnzH5GbrHGKCSKjRamT2ooXtCaMO4ukFhQ
         F0Xg==
Received: by 10.204.128.202 with SMTP id l10mr3045145bks.127.1343587665193;
 Sun, 29 Jul 2012 11:47:45 -0700 (PDT)
Received: by 10.204.27.24 with HTTP; Sun, 29 Jul 2012 11:47:44 -0700 (PDT)
In-Reply-To: <CAMK1S_hO5g5p4NjoVcxYFTt_KZ-wBRJk=OCveeszwr8U2LeZbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202489>

On Mon, Jul 23, 2012 at 12:23 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On Mon, Jul 23, 2012 at 2:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>>
>>>>>>>> "Darek" == Darek Bridges <darek.bridges@me.com> writes:
>>>
>>> Darek> I use git for many things, but I am trying to work out the
>>> Darek> workflow to use git for deployment.
>>>
>>> Don't.
>>
>> Yeah, "don't think 'git checkout' is a way to 'deploy'".  Using Git
>> as a transport measure is probably fine.
>
> You can also try
> http://sitaramc.github.com/the-list-and-irc/deploy.html.  Whether it's
> saying you *can* use git for deploying something, or you *can* but
> *should not*, or you *cannot*, will depend on your own thoughts on the
> matter ;-)

After a couple of false starts, I think that Sitaram came closest to
what Darek was asking about.

Now, as somebody who is using Git currently to stage things to
"deployment" (I may change to SVN due to office politics--which will
double my workload on rollout of updates, but I'm not saying any more
than that in public) on production web servers, I have a few comments.

We have several WordPress instances @$work where we are using Git to
stage template changes out to our development server (where I've
contemplated putting the lessons in Sitaram's article to use) before
merging those changes back into the "Production" branch (after
suitable testing) and pulling them from a central gitolite into the
live server. It works and it respects the posix extended ACLs on the
destination host (which is what you actually want on a live web
server). Even better, it provides a safe way of tracking and merging
back in any "opportunistic" changes that were made directly in the
development or production servers so that they are not lost.

Thought must be applied to do this safely, but that's the way it
usually is on web servers. To those who say admins should be using
RPM, DEB, or any other "generic package management" software to deploy
non-system updates to in-house web servers may I kindly indicate that
it often doesn't make sense to do so unless each and every website has
its own server and IP address--and you are deploying tens of thousands
of them. Most of us can't afford that. (Yes, there is an overhead to
building packages. I've done it enough times to know about that quite
intimately.)

Packages and package management are great for system software but they
are not a good solution for installing client code into a webspace on
a shared server (yes, heresy, I know). For this common use case Git is
not a half-bad ADDITION to the toolkit of a website development and
maintenance team.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
