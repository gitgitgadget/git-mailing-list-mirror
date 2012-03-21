From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v3 0/9] difftool: teach command to perform directory diffs
Date: Wed, 21 Mar 2012 15:35:55 -0400
Message-ID: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 21 20:36:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SARKY-0008W9-33
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 20:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944Ab2CUTgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 15:36:18 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:44144 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab2CUTgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 15:36:16 -0400
Received: by qadc11 with SMTP id c11so800804qad.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=b745BUW0w4mfmlm1cojoSJGmkDLTGahSRpuF8G61KoA=;
        b=Co/71YhXAjezGiRIh+E2EznZ91ZNuIu94cZT5CrGw7voMwT3KU4jW2dDsfxY5MnjSY
         UW4kihSkCSoNZ7VULopBdNgn4gBawu4KHtINlU7PfNFx6mkzc/1DrURnf0mdjtQoxcka
         KT0MVFD48nl3ha/Jthmktvw2AKC9GTGLnXO2ZhqbgUy+AdB5JuFY/IyO0nJlCgoXJ0W8
         +RCmIpAmJmK18mR8FwzoV9fBev7Pkx9r33MX/v27v1d6AEEEdUkCt0kGEuyY2xbBP6az
         4E0uiuKUeVhY189RNjMKLieyMmBJKthPTkt73rsFyCQfufTqmzaItLBK94NinzFoAvrA
         nhow==
Received: by 10.224.116.6 with SMTP id k6mr7628571qaq.91.1332358576116;
        Wed, 21 Mar 2012 12:36:16 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id hr2sm4403879qab.8.2012.03.21.12.36.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 12:36:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.39.g6e141f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193601>

Changes in v3:
  - Removed unused shell variable (SUBDIRECTORY_OK) from patch 7.
  - Changed patches 7 and 8 to support calling 'difftool --dir-diff' from
    a subdirectory of the repo.
  - Changed patch 8 to support 
  - Added patch 10, which makes mixing --prompt and --no-prompt and error.
  - Added tests for new difftool options in patches 11 and 12.

  - Patches 1-6 and 9 did not change and have not been resent.
  

Series Overview:

'git difftool' is a very useful command that allows git diffs to be opened
in an external tool. Currently, difftool opens a separate instance of the
external tool for each file that changed.  This can be tedious when many
files have changed.

This series teaches difftool to perform directory diffs, so that all file
changes can be opened/reviewed in a single instance of the external tool.

This is the second phase of development for this feature.  The first phase
was added as a separate command (git diffall) in 1252bbe (contrib: add
git-diffall script).  During review of that script on the Git developers
list, an informal development roadmap was suggested [1]. The next phase
of that plan is to integrate the 'git-diffall' feature into 'difftool'.
This series gets that done.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/191297/focus=191383


Tim Henigan (12):
  difftool: parse options using Getopt::Long
  difftool: exit(0) when usage is printed
  difftool: remove explicit change of PATH
  difftool: stop appending '.exe' to git
  difftool: eliminate setup_environment function
  difftool: replace system call with Git::command_noisy
  difftool: teach difftool to handle directory diffs
  difftool: teach dir-diff to copy modified files back to working tree
  difftool: print list of valid tools with '--tool-help'
  difftool: do not allow mix of '--prompt' with '--no-prompt'
  t7800: add test for difftool --tool-help
  t7800: add tests for difftool --dir-diff

 Documentation/git-difftool.txt |   17 ++-
 git-difftool--helper.sh        |   19 ++-
 git-difftool.perl              |  264 +++++++++++++++++++++++++++-------------
 t/t7800-difftool.sh            |   59 +++++++--
 4 files changed, 254 insertions(+), 105 deletions(-)

-- 
1.7.10.rc1.39.g6e141f
