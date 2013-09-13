From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Local tag killer
Date: Fri, 13 Sep 2013 04:54:26 +0200
Message-ID: <52327E62.2040301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Carlos_Ma?= =?ISO-8859-1?Q?rt=EDn_Nieto?= 
	<cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Sep 13 05:01:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKJda-0000ZC-9u
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 05:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab3IMDBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 23:01:34 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:42507 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750968Ab3IMDBd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Sep 2013 23:01:33 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2013 23:01:33 EDT
X-AuditID: 12074412-b7f026d0000010c7-e1-52327e667e4b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A5.05.04295.66E72325; Thu, 12 Sep 2013 22:54:30 -0400 (EDT)
Received: from [192.168.69.9] (p57A24B1E.dip0.t-ipconnect.de [87.162.75.30])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r8D2sRVA009748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 Sep 2013 22:54:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqJtWZxRksPiklMX0rtUsFl1Xupkc
	mDwurXvJ5PF5k1wAUxS3TVJiSVlwZnqevl0Cd8bN023MBa8EK1bOuczYwLiOr4uRk0NCwERi
	0sfvTBC2mMSFe+vZuhi5OIQELjNKTDo6iQXCOcMkce3lChaQKl4BbYk3f/+CdbAIqEr8Obke
	zGYT0JVY1NMMZosKhEnsmD6RDaJeUOLkzCdgg0QEGhkl9hzZBZTg4BAWkJToWKILUsMsoCPx
	ru8BM4QtL7H97RzmCYy8s5C0z0JSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6
	uZkleqkppZsYISEmtINx/Um5Q4wCHIxKPLwGUUZBQqyJZcWVuYcYJTmYlER5WUqBQnxJ+SmV
	GYnFGfFFpTmpxYcYJTiYlUR4Zf4bBgnxpiRWVqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1I
	LYLJynBwKEnwHq4BGipYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPirH4YmCUgaR4
	gPZ61gK18xYXJOYCRSFaTzEac7xrmveJkeNC74JPjEIsefl5qVLivIogpQIgpRmleXCLYMnl
	FaM40N/CvHNB7uEBJia4ea+AVjEBrfruqw+yqiQRISXVwDg1jTHYvyraJCxm0fYrKfsvuv/n
	2PmXycvTpsrR7Vn65f83inbdvn5cL/b7gu8CT7Otlzhc578/dUOlvVlpTLTKCdaXp279m3au
	e2Vwwv342LnJ1j+untJsP2ErmLy1wNHrZ/7WpOWO4X8iH6Upn+IvLwoIecp2rHuR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234723>

A colleague of mine discovered, the hard way, that

    git fetch --tags --prune $REMOTE

deletes all local tags that are not present on that particular remote.
To me this seems a dangerous and poorly-documented interaction of
features and arguably a bug.

Granted, it might not be such a good idea to use local tags, as it is
all to easy to push them inadvertently and then it is difficult to
remove them permanently from a shared upstream repository because other
people might have fetched them and in turn inadvertently re-push them.

But the fact that combining two options, each of which seems safe and
reasonable for daily use, results in the death of local tags unrelated
to the remote is unexpected [1].  Also remember that the "--prune"
feature can be turned on permanently via "git config" using
"fetch.prune" or "remote.$REMOTE.prune".

Moreover, the documentation is misleading on this point:

> -p::
> --prune::
> 	After fetching, remove any remote-tracking branches which
> 	no longer exist	on the remote.

It is a stretch for references under refs/tags/ to be called
"remote-tracking branches", even if they exist as the target of the
refspec "refs/tags/*:refs/tags/*" that is implicitly added by the --tags
option.

I suggest that --prune should not touch references under refs/tags/
regardless of whether they appear on the right side of explicit or
implicit refspecs.  If pruning tags is deemed to be essential, then
there should be a specific option ("--prune-tags"?) to request it.


When looking into this, I found a test in t5510 that appears to want to
verify this very behavior:

> test_expect_success 'fetch --prune --tags does not delete the remote-tracking branches' '
> 	cd "$D" &&
> 	git clone . prune-tags &&
> 	cd prune-tags &&
> 	git fetch origin refs/heads/master:refs/tags/sometag &&
> 
> 	git fetch --prune --tags origin &&
> 	git rev-parse origin/master &&
> 	test_must_fail git rev-parse somebranch
> '

However, the last line seems to contain a copy-paste error and should
presumably have s/somebranch/sometag/.

Michael

[1] It would be as if "git clean" had two options "--ammonia" and
"--bleach" :-)

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
