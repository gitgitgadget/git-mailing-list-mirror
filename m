From: Chris Packham <judge.packham@gmail.com>
Subject: Triangular workflows and some anecdotes from the trenches
Date: Tue, 5 Apr 2016 23:06:06 +1200
Message-ID: <CAFOYHZARoEXkT6kVy7+wMSqUxSVVHHMV5KfhU6FON3tB6XEuMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 13:06:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anOoT-0004iw-0L
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 13:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757761AbcDELGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 07:06:11 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34691 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757676AbcDELGH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 07:06:07 -0400
Received: by mail-io0-f182.google.com with SMTP id 2so14387884ioy.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=OssryVTGwFZhZkBNFD+1QfQ5OTClxrI0XjgzfUJ0ySk=;
        b=ah/G2XXXqYr62cgCNVH5ge8/GWAGf2eoSwr8Y67L60EKJSNYrqaDdPyPWJNTWDDOM3
         BPZxi0XPunWpfdtWufTvUyR2r3nlnW/XHrLXk41UG6uyb5FPTfEw2AP1Mz+a1bFPyxC6
         Sz90tftZ5nYzdO+E/uFtlhknEqdsi5XU1g0VMtIrXc05myzpHIIijbPtk6UPrY6NwTrG
         0rewC9hIafQqybRlVvqDoF+Pyv54+E//7ky1F/K87L6kAzGb3bBUfjk/AzwiVNqrC8cu
         qtMhZ03AfVe+RGejsTN9YKoJC8B6/nUyFQQ0DlccGm0hZn/ZCqr9PvkHnW5phzhAgVPU
         d/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OssryVTGwFZhZkBNFD+1QfQ5OTClxrI0XjgzfUJ0ySk=;
        b=nInZlADndjGz/nISpuVgeSWRvUr1s7FMysugreeZOjjXg5/yvsnHx6dLPvGmU/uo2A
         tlwff+ZEUXlYajFsk1BTOg+Iy145hz0UVgOBLJ1WLpXBLhUE4aD4ScOZ9dOujskKsH27
         oc055LDnKSP7u0cUUtXm7ChKKqqcFnshDhcUDHA36Nzl/Fst8UkSxHEePRoHWTK6fkRw
         grKAmfXn3U1pi8VufvuU+vlb5zSD8tudPTcKuROrCDjrBPRsRcQxoHt9ILziTBshV4Kk
         dNedo1T+h0wfxq1Xo5QiYjvMN9UalM2K1lDWSVv1PmQ3KLp6uAIFS2O6PiDjwwGUSLRJ
         MY4g==
X-Gm-Message-State: AD7BkJLK0bnSGQlwdOV5lZV820nOPtvFgGMHHaZhMB6Zfpb75qkZ7meM568bwTB8O3B50PGmBkE6n/ZhSviD/g==
X-Received: by 10.107.135.74 with SMTP id j71mr14976474iod.133.1459854366954;
 Tue, 05 Apr 2016 04:06:06 -0700 (PDT)
Received: by 10.79.110.87 with HTTP; Tue, 5 Apr 2016 04:06:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290774>

Hi,

We ran into something at $dayjob the other day. The actual problem was
a developer ended up amending a commit that had already been pushed.
It happens occasionally and is usually recoverable with a simple
rebase and is generally a learning experience. In this particular case
however things were a bit more complicated.

We had (attempted to) setup a triangular workflow. The developers
would fetch from a server that was closer to them but push to the
central server that was at the other end of a WAN link. Our build
system would update the local server after a successful build for all
configurations. The problem was instead of setting
branch.<name>.pushdefault we were setting remote.origin.pushurl. So
now the warning in git-remote(1) comes back to bite us and a lot of
head scratching ensues.

It appears that the triangular workflow support is under-documented
(mentioned in a couple of release notes and gitrevisions). I'm not
suggesting we would have done the right thing if the documentation
existed but we would have had a chance. Once we get our setup sorted
I'll try and send an update for gitworkflows.txt (unless someone else
beats me to it). There are a few blog post around the Internet that I
might be able to draw upon.

The subject of preventing modifying published history has come up on
this list before. And in-fact it's relatively simple to implement as
an alias

  git config alias.amend '!git merge-base --is-ancestor HEAD
@{upstream} || git commit --amend'

I'm just wondering if something more official can be added to git
commit --amend (and probably git rebase).

Finally I was wondering if there is any way of detecting if
remote.*.pushurl and remote.*.url point to the same repo, although I'm
not sure when you'd do such verification.

Thanks,
Chris
