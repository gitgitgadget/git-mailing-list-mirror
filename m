From: Brent Goodrick <bgoodr@gmail.com>
Subject: "warning: no common commits" triggered due to change of remote's IP 
	address?
Date: Sun, 1 Mar 2009 10:01:47 -0800
Message-ID: <e38bce640903011001p2d705707o9f7145ab5ab68929@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 19:04:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldq1a-0006RM-P3
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 19:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632AbZCASBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 13:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756441AbZCASBu
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 13:01:50 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:16874 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbZCASBt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 13:01:49 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1320034ywh.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 10:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=2FCWX5RmC9GH512XW2pC2BIjKIbS12EmO0absSaOOv0=;
        b=A1eKfErZihIU8O4gPMVc0xEuoqXfoMs4XVMJgUagqrfpaZr4XetbeWcdbCl4jBgRKK
         9sUxNl/BGqDTA+Wp5oQx+eUrBcX4bEg0PHJ4Rpd0ixHTnp6N4vAu1OVsE7YHDxd/MUIj
         pp/SEXkSo8EgpCgJ125T/JV+a6OzS3XWa0Ya0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=da7ExW+d80pJJox7UWOQHTvfH5riUGv7oETYHmtfva/ooU4y7qND8YWUYLaAAjz6ET
         rTkfutVCBDlJQESuBP24qKDlCZJESblUrqHkfLRgZHiEtn+E++GFBNE+r+uQmBqgnbkn
         jK8IB3ou/8y4FykF5kdqJwoJnCuygdWQmkwBs=
Received: by 10.90.53.5 with SMTP id b5mr2290169aga.56.1235930507200; Sun, 01 
	Mar 2009 10:01:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111866>

Hi,

I had this setup in my .git/config on my satellite machine:

[remote "origin"]
	url = 192.168.2.3:git.repos/environ.git
	fetch = +refs/heads/home:refs/remotes/origin/home

192.168.2.3 is the IP address of the main machine and repo, and is
internal to my LAN at home. My workflow is fairly simple: At home, on
my internal LAN, I usually update via these commands:

  git fetch
  git branch # <-- verify I am on the "home" branch
  git merge origin/home  # <-- merge origin/home into home and fix conflicts

I needed to do a git fetch of that same repository while out at an
Internet cafe (via ssh). I know ahead of time that I might have had a
couple of files out of date between my satellite machines repo and my
origin repo, but certainly not megabytes of data in difference. I want
to pull those differences to the satellite machines repo to continue
to work.

On the satellite machine, I simply did the fetch manually by changing
the IP address to be the WAN internet IP address of my ssh daemon I'm
running at home:

  gitw fetch 88.99.100.101:git.repos/environ.git
+refs/heads/home:refs/remotes/origin/home

My expectation at this point is that, since I've changed only the IP
address, and kept everything else the same, git should be smart enough
to compare SHA1 values only and not download the entire remote repo
just to do that comparison.

But I was quite surprised to find that it was pulling down tons of data:

  warning: no common commits
  remote: Counting objects: 2473, done.
  remote: Compressing objects: 100% (2199/2199), done.
  Receiving objects:  83% (2077/2473), 66.58 MiB | 67 KiB/s     C-c C-c

At this point, for some reason I can't explain, the network got very
slow (network bandwidth limiting?). So, I terminated the git fetch
(the C-c C-c above), thinking that I can repair this when I get back
to my LAN.

So my questions are:

 1. Will terminating the git fetch like I did leave the satellite repo
    in an inconsistent state? If so, is my only choice to start
    a new repo from scratch on the satellite machine, or is there some
    repair mechanism?

 2. Why did git conclude that there was no common commits?

Thanks,
Brent
