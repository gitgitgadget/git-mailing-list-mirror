From: Andreas Ericsson <ae@op5.se>
Subject: Re: Tagging stable releases
Date: Wed, 15 Apr 2009 10:33:13 +0200
Message-ID: <49E59BC9.5060906@op5.se>
References: <23045562.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Asaf <asafs2000@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 10:35:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu0aF-0000tZ-W4
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 10:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653AbZDOIdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 04:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758718AbZDOIdS
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 04:33:18 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:33394 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757417AbZDOIdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 04:33:16 -0400
Received: by fxm2 with SMTP id 2so2778986fxm.37
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 01:33:14 -0700 (PDT)
Received: by 10.86.93.19 with SMTP id q19mr4824307fgb.55.1239784394542;
        Wed, 15 Apr 2009 01:33:14 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d4sm10069425fga.8.2009.04.15.01.33.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 01:33:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <23045562.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116598>

Asaf wrote:
> Hello,
> 
> I'm creating many branches, checkout code, make changes, etc..
> At the end, I always merge these branches to the master branch and delete
> them when I finish,
> 
> 
> At the point where my local master repo seems to be stable, I push the
> changes to an origin repo that is public.
> 
> 
> I guess this is a standard cycle, right?
> 

There are many standard cycles. This is one of them :)

> 
> What I'm confused about is how to tag correctly versions that are stable,
> Should I locally just add a tag and push the tag to the public repo?
> 

Yes.

> 
> Is it enough to use a lightweight tagging for tagging a certain commit as a
> release?

That's up to you. I'd recommend against it, because the default update hooks
disallow lightweight tags from being pushed.

We use signed tags for all releases, so we know and can verify who tagged
what. I guess it's a corporate thing to desire the capability of saying
"It was *HIS* fault, not mine!", and signing a tag means you sign the tree
as it is at sign-time with all the history leading up to it.

> Is it possible later on to checkout a tag, make a change and push the change
> into the tagged version?
> 

No. Consider published tags immutable in git, please. Imagine the confusion
and headache you'd get from bug-reports if version 4.6.3 is not the same
code everywhere. What you can and should do is to:
* create a branch at the location of the old tag
* make whatever changes are necessary
* test as necessary
* cut a new release with your changes

At $dayjob, we have an update hook preventing tags without the "-beta$X"
suffix from being pushed unless it points to an already tagged commit,
so our workflow goes like this:
1 hack hack hack
2 beta-tag
3 buildbot builds beta package and sends it off to qa
4 qa responds with "ok to release"
5 we stable-tag the exact same version we shipped to qa
6 buildbot builds stable tag and copies it to "to-be-released" directory
7 release-manager pushes the release-button once changelogs and stuff
  are in place

If qa says "hey, it's broken", we repeat steps 1-4 until we get "ok".
If we accidentally tag something as stable while it's broken, we *can*
go back and re-create the tag before step 7 is done. We've found out
that it's usually more trouble than it's worth though, because there's
always a small uncertainty that qa gets the new code on all his machines,
and the bug we nearly released may not always show up on all platforms.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
