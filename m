From: "Gustaf Hendeby" <hendeby@gmail.com>
Subject: Problem using git svn clone
Date: Thu, 24 May 2007 23:35:16 +0200
Message-ID: <bf7b2dda0705241435t1563008o3c47607343a34a56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 23:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrKxw-0007mr-MC
	for gcvg-git@gmane.org; Thu, 24 May 2007 23:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbXEXVfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 17:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbXEXVfS
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 17:35:18 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:36359 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbXEXVfR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 17:35:17 -0400
Received: by py-out-1112.google.com with SMTP id a73so1053647pye
        for <git@vger.kernel.org>; Thu, 24 May 2007 14:35:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Xm2NGA/A+11MX6Qhf7HcrtlBu5hSlLI4Le/mFkaypmQy4VWDHxqJzAEWIEGt/gWg2Pvm7eqF4in8QHVW3IOvbj7/LAx0xeR8AWv1V6J8pgZj1rXKxXGHN7oyTycTeQYS0X3yGjD4Wj/zhogAUWqmpBPqQrm3Z0XYAFhX8aCgcOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NrQoAs88O+uEUxX9IWM31BPvo0Fy6u/wCSr5GHRlSQe1tl3OOzny53QZ21muWakRKV99d1LE5fHfpxlM+y+4MvjkYbAgCen+JcL+rVWXNA8S8CDtqqmD62K80ymtVZ57XNRu5s2abNCyoEWSaHhyEtUHqjQpmAKXN99yRY57g9g=
Received: by 10.35.88.17 with SMTP id q17mr917160pyl.1180042516531;
        Thu, 24 May 2007 14:35:16 -0700 (PDT)
Received: by 10.35.18.2 with HTTP; Thu, 24 May 2007 14:35:16 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48309>

Hi!

I have a problem with git-svn, which I hope the list can shed some
light over.  I'm quite new to git (but so far I really like it, great
job guys!) and I never use SVN, so don't really know what information
may be needed to be able to help me on the right track.  I hope the
below problem description is appropriate.


The situation is as follows:

I plan to use git and git svn to track a module in the middle of a SVN
repository (which I have no control over) where I don't have read
access more than to this specific module and the base directory, ie
the layout is similar to this
	https://svn.foo.bar/a/b/c/trunk
	https://svn.foo.bar/a/b/c/tags
	https://svn.foo.bar/a/b/c/branches
and I have read access to https://svm.foo.bar/a,
https://svn.foo.bar/a/b/c and below, but nothing else.

What I want to do is clone the whole thing, including tags and
branches.  I expected to be able to use the following command to do
this (git v1.5.2):

$ git svn clone https://svn.foo.bar/a/b/c -T trunk -t tags -b branches

Initialized empty Git repository in .git/
Using higher level of URL: https://svn.foo.bar/a/b/c => https://svn.foo.bar/a

W: Ignoring error from SVN, path probably does not exist: (175002): RA
layer request failed: REPORT request failed on '/a/!svn/bc/100':
REPORT of '/a/!svn/bc/100': Could not read chunk size: Secure
connection truncated (https://svn.foo.bar)
r306 = 83f0c10b988a8f1e77a3f354126c52f0cfdecf76 (trunk)
[...]
Found possible branch point: https://svn.foo.bar/a/b/c/trunk =>
https://svn.foo.bar/a/b/c/tags/0.1, 314
Found branch parent: (tags/0.1) ad6a2361d0e69d6288ef226bb335bb4bf3bdd12e
Following parent with do_update
Successfully followed parent
r315 = 3b92c4885b9d6f60241533dd99fa5023eebb1c64 (tags/0.1)
r316 = 02e3b828b4f11c5fab9d10d85076a8ff209afa00 (trunk)
[...]

However, it seems I just get the info about the revisions (shows up
nicely in gitk) but no content at all.  The config file reads:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[svn-remote "svn"]
        url = https://svn.foo.bar/a/b/c/trunk
        fetch = :refs/remotes/git-svn


If I instead do:

$ git svn clone https://svn.foo.bar/a/b/c/trunk
Initialized empty Git repository in .git/
W: Ignoring error from SVN, path probably does not exist: (175007):
HTTP Path Not Found: REPORT request failed on
'/a/!svn/bc/100/b/c/trunk': '/a/!svn/bc/100/b/c/trunk' path not found
W: +empty_dir: source
W: +empty_dir: test
r306 = 83f0c10b988a8f1e77a3f354126c52f0cfdecf76 (git-svn)
        A       resources/extensions/circuitparts.drext
[...]
r309 = 3a386e9b985c419d129461acbf24978795b36b96 (git-svn)
        A       tools/source/physical.cc
[...]

I get all content in trunk and their revision history, but as expected
no tag info.  The config file reads:

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[svn-remote "svn"]
        url = https://svn.foo.bar/a
        fetch = b/c/trunk:refs/remotes/trunk
        branches = b/c/branches/*:refs/remotes/*
        tags = b/c/tags/*:refs/remotes/tags/*


Removing trunk from the URL yields all the files in trunk, tags, and
branches with a similar output.

Please, let me know if information is missing.  I'd be very thankful
for any help that I can get to sort this out.

/Gustaf
