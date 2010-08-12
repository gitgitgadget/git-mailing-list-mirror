From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [Q] `git fetch tag NAME' into mirror repo does not update HEAD,
 what to do?
Date: Thu, 12 Aug 2010 12:02:49 -0500
Message-ID: <Xp6r8yG_6tK_gooNBRqAKdsGRTcXgRo-b1bJv3J7ckxs2iD_-UXlPw@cipher.nrlssc.navy.mil>
References: <201008120954.27648.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 19:03:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjbBE-0005Jz-Rt
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 19:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab0HLRCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 13:02:55 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43896 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886Ab0HLRCy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 13:02:54 -0400
Received: by mail.nrlssc.navy.mil id o7CH2omb014293; Thu, 12 Aug 2010 12:02:50 -0500
In-Reply-To: <201008120954.27648.brian.foster@innova-card.com>
X-OriginalArrivalTime: 12 Aug 2010 17:02:49.0541 (UTC) FILETIME=[31A50F50:01CB3A40]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153388>

Brian Foster wrote:
>  Bare repository ORIG's master looks like this:
> 
>    o--o--o--o--v1--o--v2--o--o--o HEAD
> 
>  where v1 and v2 are (annotated) tagged commits.
> 
>  Repository SLAVE is a mirror clone of ORIG which
>  (very deliberately!) lags behind (i.e., its HEAD
>  is one of the earlier (and usually tagged) commits
>  on ORIG).  SLAVE's master was like this:
> 
>    o--o--o--o--v1 HEAD
> 
>  We wanted to update its HEAD to v2, so did:
> 
>    git fetch ORIG tag v2
> 
>  This gave us:
> 
>    o--o--o--o--v1 HEAD
>                  \ 
>                   o--v2
> 
>  It did not update SLAVE's HEAD to v2, which we wanted.

Are you using --mirror only so that the branch pointer in
the mirror repository will be updated when you fetch?

If you are not really interested in having a "real" mirror,
then maybe you should set your mirror up to track a
specific branch (or branches) in the mirrored repository.

You could have a branch named for example "for_mirror/master",
in the mirrored repository (ORIG) that you would prepare.
You could update the for_mirror/master branch when you were
ready using 'git branch' like this:

   git branch -f for_mirror/master v2

In the mirror repository (SLAVE), you would update the
fetchspec so that the mirror mirrored the branches below
the "for_mirror" namespace in the remote repository
like this:

   fetch = +refs/heads/for_mirror/*:refs/heads/*

Then, a simple 'git fetch' would fetch the updates (including
tags) and update the branch pointer in the mirror like you want
it to do.  Tracking multiple branches this way is possible just
by creating another branch in the ORIG repository with the proper
name.

-Brandon
