From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: "git merge" merges too much!
Date: Mon, 30 Nov 2009 22:22:12 +0300
Message-ID: <20091130192212.GA23181@dpotapov.dyndns.org>
References: <m1NEaLp-000kn1C@most.weird.com> <20091129051427.GA6104@coredump.intra.peff.net> <m1NFAji-000kn2C@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:22:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFBpb-0002UH-J0
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 20:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbZK3TW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 14:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbZK3TW3
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 14:22:29 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:40680 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbZK3TW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 14:22:28 -0500
Received: by bwz27 with SMTP id 27so2846788bwz.21
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 11:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dhfqOkbgNpjtAl/+Z8P0JFZEKYutXROKIvndz2d8uc4=;
        b=KgR3OJijqvUqW/PXbgpkmKWNRHNTxpAoO2eRUNhSdtsAzdVppGnk70Kcj6jqjywgYl
         kQr9zQfHe0muPQ/40s8DLigPl1Ijy540u6Ar1BnaVOARJ+J+cmHtO5Q9yUoxxbfSM97D
         zcT/4YfZYxULA6R1DaQaQyKLldHE5zhR+C8zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TzcUsa4iM1oaObmYSJ5EfbbuOTHzgtF0sxnC2oIZVzloqB37PHm2jCmhzIvPnIima8
         2FnHk/DRYykogGSmmhxpMLMdbt9sIV1/9Ioj+BixVluVmNrk+k+9R86DdP2y+sIvxIHu
         SnIlWsiuLqKQ28N7/5fcETX19TZ9Bb+1J5S5o=
Received: by 10.103.125.19 with SMTP id c19mr1675666mun.59.1259608953552;
        Mon, 30 Nov 2009 11:22:33 -0800 (PST)
Received: from localhost (ppp85-140-126-192.pppoe.mtu-net.ru [85.140.126.192])
        by mx.google.com with ESMTPS id s10sm12754822muh.48.2009.11.30.11.22.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 11:22:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m1NFAji-000kn2C@most.weird.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134131>

On Mon, Nov 30, 2009 at 01:12:31PM -0500, Greg A. Woods wrote:
> 
> The way "git merge" works does concern me somewhat though as I try to
> figure out how I might use "topic" branches to develop local features
> and then merge them onto each supported release branch.

The basic idea of using topic branches is development is done on
separate branches are merged to the release branch only when they are
ready to be released. These branches are based on the oldest branch in
what they may be included. It means that fixes are normally based on the
stable branch and new feature are based on the master branch, i.e. the
branch that contains changes for the next new feature release. Not all
branches got merged immediately into master. For instance, the git
project has 'pu' (proposed updates) and 'next' branches. Only when a new
feature proved itself to be useful and reliable, it is "graduated" to
the master branch. Thus the master branch is rather stable and it is
released on regular intervals (no need for a long stabilization period).

The key difference comparing to what you may got used is that branches
are normally based on the oldest branch in what this feature may be
included. Thus normally changes are not backported to old branches,
because you can merge them directly.


> > Yes, you must cherry-pick or use rebase (which is a more featureful
> > version of the pipeline you mentioned).
> 
> "git rebase" will not work for me unless it grows a "copy" option ,
> i.e. one which does not delete the original branch (i.e. avoids the
> "reset" phase of its operation).

There is no reset phase... It is just reassigning the head of branch to
point to a different commit-id. If you want to copy a branch instead of
rebasing the old one, you create a new branch (a new name) that points
to the same commit as the branch that you want to copy, after that you
rebase this new branch. You can do that like this:

$ git branch new-foo foo

$ git rebase --onto newbase oldbase new-foo

> It likely wouldn't make sense to base this new "copy" feature directly
> on "git rebase" though, especially in light of all the warnings about
> how "git rebase" isn't friendly when applied to already published
> branches.  I think in theory this "copy" feature won't cause problems
> for already-published branches.

The "copy" does not have the problem of rebase, but it has a different
problem: You have two series of commits instead of one. If you found
a bug in one of those commits, you will have to patch each series
separately. Also, git merge may produce additional conflicts... So,
copying commits is not something that I would recommend to do often.


Dmitry
