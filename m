From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 0/5] Teach mv to move submodules
Date: Tue, 30 Jul 2013 21:48:15 +0200
Message-ID: <51F8187F.7040603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 21:48:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4FuA-0006VY-2N
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 21:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757081Ab3G3TsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 15:48:18 -0400
Received: from mout.web.de ([212.227.15.3]:58687 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755523Ab3G3TsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 15:48:17 -0400
Received: from [192.168.178.41] ([79.193.94.161]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0LmxtE-1UPfsp1gKa-00h8zE for <git@vger.kernel.org>;
 Tue, 30 Jul 2013 21:48:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:Ybtll37EKhDbtumoTslGrFYw2Qf1fdPYVq69hEnOuPD+rk+SjBT
 LA/El4ABBdWeGDJU1ysw6AQgPPoxXZXVYEhKchaLfZ7788WLsqVWMgXUWpzk7jQ4pT9ECyV
 9dvV2kIEujq/5dis+KYrBTkd161xHWm+WQgBftVEQjCN2QoEX2EfGjYVOOE2hQ9PZvD3G9u
 DvPxsOYrHDUmg632bAJRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231382>

Here is my third iteration of this series.

Changes to v2 are:

- I resolved the conflict with Duy's pathspec series by replacing the
  use of common_prefix() with relative_path().

- I separated the functions checking for modified unstaged .gitmodules
  and staging the changes to that file into another commit, as they
  are used by both mv and rm.

- mv and rm now die with the message "Please, stage your changes to
  .gitmodules or stash them to proceed" instead of changing and
  staging a .gitmodules file containing other unstaged modifications.

- Man pages for mv and rm are updated to tell the user what they do
  with the gitlink and the .gitmodules file in case of submodules.

- Minor changes according to the last review (typos and a bit more
  efficient coding).

This series applies cleanly on current pu (and I also ran t3600 and
t7001 manually to make sure I don't hit the silent breakage my last
series showed when I ran the whole test suite).

Jens Lehmann (5):
  Teach mv to move submodules together with their work trees
  Teach mv to move submodules using a gitfile
  submodule.c: add .gitmodules staging helper functions
  Teach mv to update the path entry in .gitmodules for moved submodules
  rm: delete .gitmodules entry of submodules removed from the work tree

 Documentation/git-mv.txt   |  10 ++-
 Documentation/git-rm.txt   |   8 ++-
 builtin/mv.c               | 126 ++++++++++++++++++++++----------------
 builtin/rm.c               |  19 +++++-
 submodule.c                | 147 +++++++++++++++++++++++++++++++++++++++++++++
 submodule.h                |   5 ++
 t/t3600-rm.sh              |  98 ++++++++++++++++++++++++++++--
 t/t7001-mv.sh              | 128 +++++++++++++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh |  14 ++---
 t/t7610-mergetool.sh       |   6 +-
 10 files changed, 484 insertions(+), 77 deletions(-)

-- 
1.8.4.rc0.199.g7079aac
