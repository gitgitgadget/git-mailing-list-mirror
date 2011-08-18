From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 0/4] Refactor git-mergetool--lib.sh
Date: Thu, 18 Aug 2011 00:23:43 -0700
Message-ID: <1313652227-48545-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:24:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtwxa-0005MS-QS
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 09:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086Ab1HRHYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 03:24:06 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:33028 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab1HRHYE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 03:24:04 -0400
Received: by iye16 with SMTP id 16so3440638iye.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 00:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=BbiT8AXVj6KYAJkvXu18lPUhnm+qqSmobHSGS9lOnlQ=;
        b=PIbaNllGu35oT2aV4R298ue6xpja8lyCYGjw2JuuSHL6AytW4NOEyMufBKd97wKYJc
         uDNsx2LOyHQ/KhBBMDYFLws866f/+TuSN+T6xKzOjuAdEe4zUV08OHss22JlnUR4MCqI
         ZYgInkqDwTgvRxX0Ik+8oMXcLWuHdzbEtxUUA=
Received: by 10.42.29.196 with SMTP id s4mr456811icc.12.1313652242810;
        Thu, 18 Aug 2011 00:24:02 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id hq1sm1677692icc.14.2011.08.18.00.24.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 00:24:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.476.g57292
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179572>

This series splits the git-mergetool--lib.sh file into separate
tool scriptlets that define the commands for diff and merge.

David Aguilar (4):
  difftool--helper: Make style consistent with git
  mergetool--lib: Make style consistent with git
  mergetool--lib: Refactor tools into separate files
  mergetools/meld: Use '--output' when available

 Makefile                 |   11 ++
 git-difftool--helper.sh  |   18 ++-
 git-mergetool--lib.sh    |  394 ++++++++++------------------------------------
 mergetools/araxis        |   21 +++
 mergetools/bc3           |   20 +++
 mergetools/defaults      |   46 ++++++
 mergetools/diffuse       |   17 ++
 mergetools/ecmerge       |   16 ++
 mergetools/emerge        |   23 +++
 mergetools/kdiff3        |   24 +++
 mergetools/kompare       |    7 +
 mergetools/meld          |   40 +++++
 mergetools/opendiff      |   16 ++
 mergetools/p4merge       |   10 ++
 mergetools/tkdiff        |   12 ++
 mergetools/tortoisemerge |   17 ++
 mergetools/vim           |   44 +++++
 mergetools/xxdiff        |   25 +++
 18 files changed, 441 insertions(+), 320 deletions(-)
 create mode 100644 mergetools/araxis
 create mode 100644 mergetools/bc3
 create mode 100644 mergetools/defaults
 create mode 100644 mergetools/diffuse
 create mode 100644 mergetools/ecmerge
 create mode 100644 mergetools/emerge
 create mode 100644 mergetools/kdiff3
 create mode 100644 mergetools/kompare
 create mode 100644 mergetools/meld
 create mode 100644 mergetools/opendiff
 create mode 100644 mergetools/p4merge
 create mode 100644 mergetools/tkdiff
 create mode 100644 mergetools/tortoisemerge
 create mode 100644 mergetools/vim
 create mode 100644 mergetools/xxdiff

$ git describe --dirty
v1.7.6-476-g572925c
$ git version
git version 1.7.6.476.g57292
$ ./t7610-mergetool.sh 
ok 1 - setup
ok 2 - custom mergetool
ok 3 - mergetool crlf
ok 4 - mergetool in subdir
ok 5 - mergetool on file in parent dir
ok 6 - mergetool skips autoresolved
ok 7 - mergetool merges all from subdir
ok 8 - mergetool skips resolved paths when rerere is active
ok 9 - deleted vs modified submodule
ok 10 - file vs modified submodule
ok 11 - submodule in subdirectory
ok 12 - directory vs modified submodule
# passed all 12 test(s)
1..12
$ ./t7800-difftool.sh 
ok 1 - setup
ok 2 - custom commands
ok 3 - difftool ignores bad --tool values
ok 4 - difftool honors --gui
ok 5 - difftool --gui works without configured diff.guitool
ok 6 - GIT_DIFF_TOOL variable
ok 7 - GIT_DIFF_TOOL overrides
ok 8 - GIT_DIFFTOOL_NO_PROMPT variable
ok 9 - GIT_DIFFTOOL_PROMPT variable
ok 10 - difftool.prompt config variable is false
ok 11 - difftool merge.prompt = false
ok 12 - difftool.prompt can overridden with -y
ok 13 - difftool.prompt can overridden with --prompt
ok 14 - difftool last flag wins
ok 15 - difftool + mergetool config variables
ok 16 - difftool.<tool>.path
ok 17 - difftool --extcmd=cat
ok 18 - difftool --extcmd cat
ok 19 - difftool -x cat
ok 20 - difftool --extcmd echo arg1
ok 21 - difftool --extcmd cat arg1
ok 22 - difftool --extcmd cat arg2
# passed all 22 test(s)
1..22

-- 
1.7.6.476.g57292
