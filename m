From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Resolving a merge conflict with git-svn
Date: Sat, 14 Nov 2009 01:58:10 +0100
Message-ID: <1258160291.6082.42.camel@localhost>
References: <76ee5f990911131630k41a91f70n5e717befb7693463@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Kubieziel <kubieziel@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 01:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N96yG-0001WB-Sh
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 01:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbZKNA6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 19:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752816AbZKNA6W
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 19:58:22 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:27112 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbZKNA6V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 19:58:21 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1114955eyd.19
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 16:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=UuJtA2soOsky526t1NYdMhYUGJuYXJgRRSE4tftp/9o=;
        b=XC/+hMa2/WKXHlREcLKdgA1iYhxr3SQ7FFx9DzYCnmND67tkgd/Ulk19ulnKSOTygR
         uZBhvQc2UmnL6pYCrRa7ZlxSVjO+iMw1EZhme7dhfuUp/2VrM+8FR7xkFeWKXYBwh5H2
         m1w1KwUR8vZFA9PF62ZgDi1P/q96xHRYI/6Fc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=q2IUlIRcNvAlVPgcq0B4PQHiM5N4+FNmXxaac530IesT/APeR60REB1O7HwQnY9UsH
         vyyzpYbZlkaI+IeKWv65+mJBi/2PyV3Y8PXZ95Detwe5+xRTSfbmxyw+MDP3u4WKQosN
         9Tg9Pbkbwggg3N8OHKUusS2nBJGC2LFvlhl+s=
Received: by 10.213.1.25 with SMTP id 25mr508029ebd.65.1258160305514;
        Fri, 13 Nov 2009 16:58:25 -0800 (PST)
Received: from ?192.168.1.2? (host128-0-dynamic.60-82-r.retail.telecomitalia.it [82.60.0.128])
        by mx.google.com with ESMTPS id 10sm2255548eyd.39.2009.11.13.16.58.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 16:58:25 -0800 (PST)
In-Reply-To: <76ee5f990911131630k41a91f70n5e717befb7693463@mail.gmail.com>
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132854>

Il giorno sab, 14/11/2009 alle 01.30 +0100, Jens Kubieziel ha scritto:
> Hi,
> 
> I recently came across a big conflict. Someone used Subversion and
> made a complete wrong commit. I did a 'git svn rebase' at some point
> and ran into the conflict. My goal at this point was to remove the
> wrong commit, but I found no way how to do it (git-revert needs a
> clean tree; git stash brought [fatal: git-write-tree: error building
> trees,Cannot save the current state]). What way would suggest to
> remove that wrong made commit and continue with the rebase?

I don't know if this could help but I tell you what I would do.

I would abort the conflicting rebase

"backing up" my branch by:

git checkout mybranch
git checkout -b mybranchBackup

then I would do a git reset --hard <last-committed-svn-commit>

at this point a:
git svn rebase

shouldn't give conflict since it should be a fast forward.

Then you should have two branch:

mybranch: which is SVN-up-to-date but has no one of your modification
mybranchBackup: which has an old SVN before the wrong commit but with
all your modifications...

at this point you can use git revert to revert the wrong commit into
your "mybranch".

and then you can cherry-pick all your modification from mybranchBackup

may be you could also been able to rebase upon it....
but I would do an interactive rebase to "see" what's going to do and
being able to control it

like:

git checkout mybranchBackup
git rebase -i mybranch
