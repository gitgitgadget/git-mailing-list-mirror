From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 0/2] Submodules: Add the new config option "ignore"
Date: Mon, 26 Jul 2010 20:26:07 +0200
Message-ID: <4C4DD33F.4020104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:26:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSNh-0002hY-MY
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743Ab0GZS0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:26:22 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:55541 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566Ab0GZS0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:26:20 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 29F6C164F51AB;
	Mon, 26 Jul 2010 20:26:19 +0200 (CEST)
Received: from [80.128.109.213] (helo=[192.168.178.29])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OdSNW-0008Jp-00; Mon, 26 Jul 2010 20:26:19 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+KW6Jmr5VIAOvSEICyizkp2/0W8/5N7FhRA0/2
	lmnAhjH5v+IHB+qBme1SyaIexSanUUTCPuXQEoTHzIZbvlZLDV
	uXCN26917gBBQ4l2dJ3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151870>

These two patches are extremly useful for those users who chose submodules
because they wanted to reduce the time it takes for "git status" and "git
diff" to recurse through the whole work tree by putting sometimes large
amounts of files into submodules, which weren't scanned in the past.

Since 1.7.0 "git status" and "git diff" recurse through submodule work
trees, which has a - sometimes drastic - performance impact when large
submodules are present. Using the "ignore=dirty" config option restores
the former behaviour.

This option can be set in the .gitmodules file or in .git/config, any
settings found in the latter override those from .gitmodules. This
enables the distribution of a default setting for this option by simply
committing a modified .gitmodules file without each developer having to
call "git submodule sync". When using "git status" or "git diff" with
"--ignore-submodules=none" option the default behavior of scanning all
submodules work trees can be restored temporarily.


Comments?


Jens Lehmann (2):
  Submodules: Add the new "ignore" config option for diff and status
  Submodules: Use "ignore" settings from .gitmodules too for diff and
    status

 Documentation/config.txt       |   13 ++++
 Documentation/diff-options.txt |    6 ++-
 Documentation/git-status.txt   |    6 ++-
 Documentation/gitmodules.txt   |   15 ++++
 builtin/commit.c               |    2 +
 builtin/diff-files.c           |    2 +
 builtin/diff-index.c           |    2 +
 builtin/diff-tree.c            |    2 +
 builtin/diff.c                 |    2 +
 diff-lib.c                     |   15 +++--
 diff.c                         |   35 ++++++++--
 diff.h                         |    1 +
 submodule.c                    |   63 ++++++++++++++++-
 submodule.h                    |    4 +
 t/t4027-diff-submodule.sh      |  139 ++++++++++++++++++++++++++++++++++++
 t/t7508-status.sh              |  154 ++++++++++++++++++++++++++++++++++++++-
 wt-status.c                    |    8 ++-
 17 files changed, 449 insertions(+), 20 deletions(-)

-- 
1.7.2.223.g830604.dirty
