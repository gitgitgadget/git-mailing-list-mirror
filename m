From: Daniele Segato <daniele.bilug@gmail.com>
Subject: git-svn-Cloning repository with complicate nesting
Date: Thu, 27 Aug 2009 10:32:55 +0200
Message-ID: <9accb4400908270132vaccc4eegb58e2f0ee8de0797@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 27 10:33:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgaQ8-0002qd-OE
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 10:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbZH0Icz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 04:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbZH0Icz
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 04:32:55 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:35682 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbZH0Icy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 04:32:54 -0400
Received: by fxm17 with SMTP id 17so763955fxm.37
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 01:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=KiVFMF9SDO4fjE2/lcj3xtWnMcm7xmrnuWhahJA2yq0=;
        b=mkIiGOUA9W8lnFQIAVhk9ZrnP6au6CihMf7CnUoQocYprp3M0Xcb9z3KSCwmab8vHS
         rR18BV22eT5WYuGVLx/EF5q4NCh+Uavn5snxMBBpL4B5aATWSuY+xnIga2QaouozSYkh
         lUxQNBFl8l1GyWXMXM7TltAPBbZcBi6TBGRBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=J4ghyN07pWWN9UwWEHrfLGPBfSr60Qw9z/a2L/qsCXjlP/GjHwqY1htMm/NiEpoiFC
         3d8ChXqmmqqnYDlSotF3hbUMar3r+dsHBBHJL0J8GJ3R4Cm1GdOqxmfCza93gzU2sij8
         nr5Prlm+Co+E6X+Hr6trouykn/mKTCBQ4oyOs=
Received: by 10.223.20.210 with SMTP id g18mr6527946fab.9.1251361975830; Thu, 
	27 Aug 2009 01:32:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127148>

Hi, this is my first message in the list: this may be a newbie
question and my English may not be very good.

I've an SVN repository structured like this:

http://<url>/path/to/repo
    |
  HEAD
    |----- root
    |
  BRANCHES
    |----- V1.0
    |         |----- root
    |
    |----- V1.1
    |         |----- root
    |
    |----- V1.2
    |         |----- root
    |
    |----- DEV
    |         |----- FEATURE1
    |         |            |----- root
    |         |
    |         |----- FEATURE2
    |         |            |----- root
    |         |
    |         |----- FEATURE3
    |                      |----- root
    |
    |----- BUILDS
              |----- BUILD1
              |            |----- root
              |
              |----- BUILD2
              |            |----- root
              |
              |----- BUILD3
                           |----- root

the same for TAGS.

I did this:

git init
git svn init <url>
vim .git/config

[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[svn-remote "svn"]
	url = <url>
	fetch = <url>/HEAD/root:refs/remotes/trunk
	branches = <url>/BRANCHES/*/root:refs/remotes/branches/*
	branches = <url>/BRANCHES/*/*/root:refs/remotes/devel/*
	tags = <url>/TAGS/*/root:refs/remotes/tags/*


git svn fetch


It is now cloning the repo (it is a really big repo)


It is my configuration ok for the repository structure?

if from another terminal I execute "git branch -r" I get:
  tags/V1.3.0
  tags/V1.3.0@3260
  tags/V1.3.1
  tags/V1.3.1@3359
  tags/V1.3.2
  tags/V1.3.2@4256
  tags/V1.4.0-COMMUNITY-FINAL
  tags/V1.4.0-ENTERPRISE-BETA@4241
  trunk
  trunk@4475

It should have already created some branch but I don't see any...

what are those @XXXX number for some of those branches?

Is the syntax of the svn-remote configuration correct?

with this:
branches = <url>/BRANCHES/*/*/root:refs/remotes/devel/*
how does git choose the name of the branch? (
refs/remotes/devel/WHAT_GOES_HERE ? )

I would like it to use the tuple */* of the directory


If the syntax of my configuration is not correct, where can I found a
documentation about it? I couldn't find one.


Thanks
Regards,
Daniele
