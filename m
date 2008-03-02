From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH v2 00/10] More on worktree fixes
Date: Sun, 2 Mar 2008 17:33:00 +0700
Message-ID: <20080302103300.GA8867@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 11:34:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlWG-00036k-ED
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbYCBKdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 05:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbYCBKdJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:33:09 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:40776 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbYCBKdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:33:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6063513wah.23
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=ZUNgKRxIiGcaYxfyOFdTrhBKM4T0A9nECQN+G84bmGg=;
        b=BGDjP7j9tZBI1CJY88a21VZj5gJ6PTywHyigVUSNIUL2atBjTXtT4sgOW3AvRJNUw9bAf55rTyoLo+Xvl9s+GCwzj2+4NlLWwqJYrBp3WP4lsLiFYI0rvXxN4mdKOjzcu/Zh/iUV8O7OGIRJQUJH50PfAqTKgqOd+lFc8Z/LSiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=cm0/7NCdltHU+oXWPPYfO7RPwZrxN0b99M3FuyJVsAyvkIMofdw20kg4WU0Y2pzxGk/RiyvhZSVPhFFRnqT5u9QjHRPCjGiDUsVC11R1ug9BG0H+GW63PQzzbt1dDNBSYh1DSQq8+XAMt8125+Xzmc9e3r0wwkSusjbzVbKnEJY=
Received: by 10.114.175.16 with SMTP id x16mr14529817wae.116.1204453987868;
        Sun, 02 Mar 2008 02:33:07 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.2.84])
        by mx.google.com with ESMTPS id l27sm18529193waf.26.2008.03.02.02.33.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:33:06 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:33:00 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75760>

This series cleans up setup.c and makes git handle worktree better.
The series deprecates my patch "Move worktree setup out of..."

Changes from the last version: Junio's concerns are addressed, tests
are also added.

Main points:

 - get_git_dir() is now always absolute path.

 - setup_git_directory_gently() will no longer do
   any worktree setup. If you want worktree with
   setup_git_directory_gently(), call setup_work_tree().

 - setup_git_directory() will still setup worktree if found. The
   behavior is a bit more consistent as it will setup worktree no
   matter where it comes from. GIT_WORK_TREE, core.worktree or
   autodetection are treated the same.

 - Document setup api along the way.

"make test" was run on each patch. Hopefully the series won't break
anything. Tests will come later, my brain has been overheated.

Remaining problems I'm aware of:

 - prefix when running a command from outside worktree (currently NULL)
 - cmd_update_index() needs setup_work_tree()

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
      "git read-tree -m" and the like require worktree
      Make sure setup_git_directory is called before accessing reposito=
ry
      Make get_git_dir() and 'git rev-parse --git-dir' absolute path
      Make setup_work_tree() return new prefix
      http-push: Avoid calling setup_git_directory() twice
      Completely move out worktree setup from setup_git_directory_gentl=
y()
      builtin-archive: mark unused prefix "unused_prefix"
      Make setup_git_directory() auto-setup worktree if found
      Documentation: update api-builtin and api-setup
      Additional tests to capture worktree special cases

 Documentation/technical/api-builtin.txt |   10 +++
 Documentation/technical/api-setup.txt   |   91 ++++++++++++++++++++++-=
-
 builtin-apply.c                         |    7 ++-
 builtin-archive.c                       |    6 +-
 builtin-blame.c                         |    4 +-
 builtin-bundle.c                        |    9 +--
 builtin-config.c                        |   15 ++---
 builtin-diff-files.c                    |   13 ++--
 builtin-diff.c                          |   13 ++--
 builtin-ls-files.c                      |   10 ++--
 builtin-read-tree.c                     |    3 +
 builtin-rev-parse.c                     |   23 ++----
 builtin-rm.c                            |    5 +-
 builtin-upload-archive.c                |    4 +-
 cache.h                                 |    4 +-
 environment.c                           |    1 +
 fast-import.c                           |    1 +
 git.c                                   |    8 +--
 hash-object.c                           |   14 +---
 http-push.c                             |    4 +-
 index-pack.c                            |    2 +
 setup.c                                 |  114 +++++++++++------------=
-------
 t/t1300-repo-config.sh                  |    2 +-
 t/t1400-update-ref.sh                   |    4 +-
 t/t1501-worktree.sh                     |   57 +++++++++++++++-
 t/t9300-fast-import.sh                  |    2 +-
 26 files changed, 261 insertions(+), 165 deletions(-)
