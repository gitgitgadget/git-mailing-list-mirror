From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: pull/push inconsistencies
Date: Wed, 16 May 2007 10:53:11 +1200
Message-ID: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 16 00:53:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho5tw-0006Jb-2H
	for gcvg-git@gmane.org; Wed, 16 May 2007 00:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760061AbXEOWxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 18:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760086AbXEOWxN
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 18:53:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:8303 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760061AbXEOWxM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 18:53:12 -0400
Received: by wr-out-0506.google.com with SMTP id 76so2370195wra
        for <git@vger.kernel.org>; Tue, 15 May 2007 15:53:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EpNM5v7/yvjBNVw2HW7rtHJ3BlNYMY9HnznQtpne+r3yyRxEwkqh6vaxk4t17OM8IBLkzqCemVeZ1velpwi/AHr+DMGVeEKkPZyUON+k+nrYA6wUgogO1hD50n5G/WTnp7cOKYNh3LFFMc738egy0gXHff5OajCo8Lzh2H6XQC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dUM8/VGgm/+VlIn0ZH/Vb/sZqGWdEtPcdZvjIlA6w1AJNOL4/ce4bLrC2JFSrpjMf+ikudGg/FR6apkHDTanUIVjxhlq7wCvRvuT71fKTumgSQ9fQFjcP25u59ihIvCywtpxcCSsxgP2NpEa2pA1KtZMcBroo0/OZqE7wNd6HS4=
Received: by 10.90.86.10 with SMTP id j10mr7100147agb.1179269591734;
        Tue, 15 May 2007 15:53:11 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Tue, 15 May 2007 15:53:11 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47383>

I am noticing some UI inconsistencies with pull/push. Not sure where
they are -- and quite busy atm -- if they are in bash I might be able
to hunt them down and fix. In case anyone else cares...

--

When tracking several branches from a repo, git-pull does a fetch (of
all the remote heads) and merges _only the tracking branch currently
checked out_. That's ok. However, if I checkout another tracking
branch and issue git-pull, the merge does not happen because git-fetch
finds nothing new on the remote side. git-pull should merge anyway if
remotes/origin/<trackinghead> is ahead of the local head.

The workaround is to call git-merge explicitly, but git-pull is
misleading the user saying "nothing to merge" instead of completing
the merge.

--

My second issue is that git-push does not update
remotes/<repo>/<headname> so if I do git-push && gitk --all it looks
as if I haven't pushed. Misleading again. :-/

--

Third issue - if I do

  # we start with a cloned repo that is in sync with
  # its "origin" repo. No local commits to speak of...
  # git-fetch brings updates to 3 remote branches - none affecting the current
  # checked out branch...
   git-fetch
   git-commit some/path
   git-push

the output of git-push will show _4_ branches being pushed. For some
reason git-push says that it's pushing remotes/origin/branchname ->
origin/branchname for all the branches fetched recently -- and not
modified! I expect only _1_ branch to be named during push - the only
one.


None of the above are showstoppers, but the user feedback of these
commands - the very core workflow for beginners - is quite confusing.
I know how to check that things are correct in spite of the messages,
and by now I trust git internals to do the right thing. But newcomers
are getting some frights over here...

cheers,



martin
