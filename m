From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: odd behavior with git-rebase
Date: Mon, 26 Mar 2012 10:27:57 -0500
Message-ID: <4F708AFD.4070402@gmail.com>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 17:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCBqC-0005CM-1d
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 17:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595Ab2CZP2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 11:28:03 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57684 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617Ab2CZP2A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 11:28:00 -0400
Received: by obbeh20 with SMTP id eh20so5281132obb.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=e6O87Q92FSdTOLOtp+Ln+rViuietcKkQnthxIBKympM=;
        b=gEFTMVTRJ/13cT82iajRLZW6zOLCbGHtF2cNXErrPv3WkMSVhvHUnZpuiZUZUEph+W
         iZF/ToOcEGv7U/VcNF2Jx3lf+XMEt83SvRsLT7BwLnEa/FRq7BW0+6SRwxPfjgXxEJap
         6G70KKaf+oFC3wum3k7AfNUxhYiQObWVUHUjRXBrIi4iBeY7czp6Oq4zQgT15mSZH5wh
         qdKc4CvRfmEm0RGdA8Xjp/Akka5e+ozHMemdt9V9F8PFUbjCh16T6V07Qj2WOJF09Rgk
         eD/lmjjZynW2Vu6Wc95zp3kvNc43kLz/RHx5WeNOYfGT8cpW+Tm0JrHjlMEajTb7jhSf
         G64w==
Received: by 10.182.53.106 with SMTP id a10mr27525638obp.43.1332775680085;
        Mon, 26 Mar 2012 08:28:00 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id xh3sm16644049obb.13.2012.03.26.08.27.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 08:27:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <20120323185205.GA11916@hmsreliant.think-freely.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193919>

On 3/23/2012 1:52 PM, Neil Horman wrote:
> Hey all-
> 	I hit a strange problem with git rebase and I can't quite decide if its
> a design point of the rebase command, or if its happening in error.  When doing
> upstream backports of various kernel components I occasionally run accross
> commits that, for whatever reason, I don't want/need or can't backport.  When
> that happens, I insert an empty commit in my history noting the upstream commit
> hash and the reasoning behind why I skipped it (I use git commit -c<hash>
> --allow-empty).  If I later rebase this branch, I note that all my empty commits
> fail indicating the commit cannot be applied.  I can of course do another git
> commit --allow-empty -c<hash>; git rebase --continue, and everything is fine,
> but I'd rather it just take the empty commit in the rebase if possible.
>
> I know that git cherry-pick allows for picking of empty commits, and it appears
> the rebase script uses cherry-picking significantly, so I'm not sure why this
> isn't working, or if its explicitly prevented from working for some reason.
>
> anyone have any insight?
>
FWIW, I'm not sure what you mean by "backport", but IMHO backporting a 
critical fix to an earlier version seems by nature to be a cherry-pick 
operation as opposed to a rebase operation.  A rebase implies "I want 
everything" -- that doesn't sound like a backport.  A cherry-pick 
implies "I only want certain things" -- that sounds like a backport. 
Maybe your really using rebase to cherry-pick several commits.  Using 
your technique of "empty commit placeholders", it seems you could end up 
with quite a lot of "empty" commit placeholders which doesn't seem to 
make much sense.  Why would you want a bunch of empty commit 
placeholders in your older version bugfix history saying "I didn't want 
this, but its in the newer version."  (who cares?).  Isn't having the 
stuff you do want recorded as commits enough to make it clear what you 
brought over?  You could even edit the "cherry-picked" (or rebased) 
commit messages to document the sha1 of the commit being cherry picked 
from the newer version.  That seems to make more sense to document what 
you did, as opposed to documenting what you didn't do.

I'm not a git expert or a kernel developer, but find this subject 
relevant and interesting.  Our "New" system was forked from our "old" 
system.  We bring over fixes/features from "old" system to "new" system. 
  "New" system hast limited field testing accumulated, and gets 
features/fixes from "old" system which has extensive productional 
testing ongoing.  When doing so, many "old" system changes are not 
wanted as they are irrelevent to the "new" system.  Having an empty 
commit for them makes no sense.

Food for thought.  Maybe my cooking as bad.  Maybe I'll learn a new recipe.

v/r,
neal
