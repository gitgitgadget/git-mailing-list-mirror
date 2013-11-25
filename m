From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/9] War on #! lines in shell libraries
Date: Mon, 25 Nov 2013 12:51:19 -0800
Message-ID: <20131125205119.GQ4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 21:51:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl37v-0007BT-Vk
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab3KYUvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:51:24 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:37337 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab3KYUvX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:51:23 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so3351926yha.31
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=p9BoSy4+PYadDrVCGMmB4yIiwCDWr8GAYfcThHJ1Uwg=;
        b=MyMCjSbQi5/8zY5bgLlakh3cbN13LJo9zF1fiHF4rygI9PQMa8qXSapuG8DFA3Hchm
         M3vOlWj45zR9gRZ1h3l0v7QtOxX776rZIUCKgzyF0GIEoM1S6qiUr6fczuOcKId6O2dx
         1oqP5hPnLtk1A/SBaor8yVbvsTDu+lRrqtU00LK8GSsdlUh6WPXQoVM9+XpU9EkYUZI9
         agXGZ/Q4VGk5pMLg1MLgez5l2bNnmhY/NQSpLdibLKQ6kx+rO3QQS0hnUYwVkNIyN74o
         R1ljvhQozPqxcPTA+cL2fWOcUUrQ5jgQm1BeUBQn9YUJohZ3oEJWuhBpAMN1gGNLlYaI
         ABwQ==
X-Received: by 10.236.124.133 with SMTP id x5mr2657698yhh.59.1385412682729;
        Mon, 25 Nov 2013 12:51:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id r64sm16785444yhc.23.2013.11.25.12.51.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 12:51:22 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238347>

Hi,

This is an old series that I just wanted to flush out of my working
directory.  It does two things:

On one hand, it replaces the line

	#!/bin/sh

at the start of shell libraries with a simple comment

	# Shell library for <etc, explaining how it is used>

to avoid confusing readers into thinking the shell library is going to
be run directly with /bin/sh.  And on the other hand, it sets the
executable bit on actual scripts that are run directly with /bin/sh.
(Likewise for some perl scripts, too.)

The heart of the series has been well tested in the context of Debian
git for a couple of years.  Thanks to list denizens for the
improvements last time I brought it up[1].  Hopefully this version is
more sensible.

Anyway, hopefully it can provide some amusement.

Thanks,
Jonathan Nieder (9):
  mark Windows build scripts executable
  mark perl test scripts executable
  mark contributed hooks executable
  contrib: remove git-p4import
  gitk: chmod +x po2msg
  git-gui: chmod +x po2msg, windows/git-gui.sh
  test: make FILEMODE a lazy prereq
  test: replace shebangs with descriptions in shell libraries
  remove #!interpreter line from shell libraries

[1] http://thread.gmane.org/gmane.comp.version-control.git/192582

 compat/vcbuild/scripts/clink.pl        |   0
 compat/vcbuild/scripts/lib.pl          |   0
 contrib/buildsystems/engine.pl         |   0
 contrib/buildsystems/generate          |   0
 contrib/buildsystems/parse.pl          |   0
 contrib/completion/git-completion.bash |   2 -
 contrib/completion/git-completion.tcsh |   2 -
 contrib/hooks/post-receive-email       |   1 -
 contrib/hooks/pre-auto-gc-battery      |   1 -
 contrib/hooks/setgitperms.perl         |   0
 contrib/hooks/update-paranoid          |   0
 contrib/p4import/README                |   1 -
 contrib/p4import/git-p4import.py       | 365 ---------------------------------
 contrib/p4import/git-p4import.txt      | 167 ---------------
 git-gui/po/po2msg.sh                   |   0
 git-gui/windows/git-gui.sh             |   0
 git-mergetool--lib.sh                  |   3 +-
 git-parse-remote.sh                    |   4 +-
 git-rebase--am.sh                      |   3 +-
 git-rebase--interactive.sh             |   9 +-
 git-rebase--merge.sh                   |   4 +-
 git-sh-i18n.sh                         |   5 +-
 git-sh-setup.sh                        |   9 +-
 gitk-git/po/po2msg.sh                  |   0
 t/Git-SVN/00compile.t                  |   0
 t/Git-SVN/Utils/add_path_to_url.t      |   0
 t/Git-SVN/Utils/can_compress.t         |   0
 t/Git-SVN/Utils/canonicalize_url.t     |   0
 t/Git-SVN/Utils/collapse_dotdot.t      |   0
 t/Git-SVN/Utils/fatal.t                |   0
 t/Git-SVN/Utils/join_paths.t           |   0
 t/gitweb-lib.sh                        |   3 +-
 t/lib-bash.sh                          |   7 +-
 t/lib-cvs.sh                           |   2 +-
 t/lib-diff-alternative.sh              |   3 +-
 t/lib-gettext.sh                       |   3 +-
 t/lib-git-daemon.sh                    |  18 +-
 t/lib-httpd.sh                         |  29 ++-
 t/lib-pack.sh                          |   2 -
 t/lib-pager.sh                         |   2 +-
 t/lib-prereq-FILEMODE.sh               |  11 -
 t/lib-read-tree.sh                     |   2 -
 t/lib-rebase.sh                        |   2 +-
 t/lib-terminal.sh                      |   2 +-
 t/perf/perf-lib.sh                     |   4 +-
 t/t0202/test.pl                        |   0
 t/t3701-add-interactive.sh             |   1 -
 t/t4102-apply-rename.sh                |   1 -
 t/t4120-apply-popt.sh                  |   1 -
 t/t4129-apply-samemode.sh              |   1 -
 t/t6031-merge-recursive.sh             |   1 -
 t/t9150/make-svk-dump                  |   0
 t/t9151/make-svnmerge-dump             |   0
 t/t9200-git-cvsexportcommit.sh         |   1 -
 t/test-lib-functions.sh                |   3 +-
 t/test-lib.sh                          |  12 +-
 56 files changed, 87 insertions(+), 600 deletions(-)
 mode change 100644 => 100755 compat/vcbuild/scripts/clink.pl
 mode change 100644 => 100755 compat/vcbuild/scripts/lib.pl
 mode change 100644 => 100755 contrib/buildsystems/engine.pl
 mode change 100644 => 100755 contrib/buildsystems/generate
 mode change 100644 => 100755 contrib/buildsystems/parse.pl
 mode change 100644 => 100755 contrib/hooks/pre-auto-gc-battery
 mode change 100644 => 100755 contrib/hooks/setgitperms.perl
 mode change 100644 => 100755 contrib/hooks/update-paranoid
 delete mode 100644 contrib/p4import/README
 delete mode 100644 contrib/p4import/git-p4import.py
 delete mode 100644 contrib/p4import/git-p4import.txt
 mode change 100644 => 100755 git-gui/po/po2msg.sh
 mode change 100644 => 100755 git-gui/windows/git-gui.sh
 mode change 100644 => 100755 gitk-git/po/po2msg.sh
 mode change 100644 => 100755 t/Git-SVN/00compile.t
 mode change 100644 => 100755 t/Git-SVN/Utils/add_path_to_url.t
 mode change 100644 => 100755 t/Git-SVN/Utils/can_compress.t
 mode change 100644 => 100755 t/Git-SVN/Utils/canonicalize_url.t
 mode change 100644 => 100755 t/Git-SVN/Utils/collapse_dotdot.t
 mode change 100644 => 100755 t/Git-SVN/Utils/fatal.t
 mode change 100644 => 100755 t/Git-SVN/Utils/join_paths.t
 delete mode 100644 t/lib-prereq-FILEMODE.sh
 mode change 100644 => 100755 t/t0202/test.pl
 mode change 100644 => 100755 t/t9150/make-svk-dump
 mode change 100644 => 100755 t/t9151/make-svnmerge-dump

-- 
1.8.4.1
