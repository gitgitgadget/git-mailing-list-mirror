From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/6] grep: add option -p/--show-function, similar to diff's
Date: Thu, 02 Jul 2009 00:00:05 +0200
Message-ID: <4A4BDC65.80504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 02 00:00:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM7qm-0001ta-8O
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 00:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbZGAWAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbZGAWAH
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 18:00:07 -0400
Received: from india601.server4you.de ([85.25.151.105]:49013 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbZGAWAG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 18:00:06 -0400
Received: from [10.0.1.101] (p57B7FA76.dip.t-dialin.net [87.183.250.118])
	by india601.server4you.de (Postfix) with ESMTPSA id CAA2D2F8068;
	Thu,  2 Jul 2009 00:00:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122602>

This patch series retrofits git grep with functionality similar to the diff
option -p, which shows the function definitions for diff hunks.  git grep is
enhanced to show them as context lines before matches, if called with -p.  It
can be combined with the existing context options (-A, -B, -C).

The first patch is a cleanup.  The userdiff API is enhanced to allow freeing
of allocated memory, before it is used outside of git diff code, later in the
series:

  [PATCH 1/6] userdiff: add xdiff_clear_find_func()

The next three patches massage the context handling code to make it easier to
extend:

  [PATCH 2/6] grep: move context hunk mark handling into show_line()
  [PATCH 3/6] grep: print context hunk marks between files
  [PATCH 4/6] grep: handle pre context lines on demand

Finally, handling for the option -p is added and then enhanced to support
userdiff configuration settings:

  [PATCH 5/6] grep: add option -p/--show-function
  [PATCH 6/6] grep -p: support user defined regular expressions


 Documentation/git-grep.txt |    8 ++
 builtin-grep.c             |   22 ++++++-
 diff.c                     |    1 +
 grep.c                     |  154 ++++++++++++++++++++++++++++++++------------
 grep.h                     |    4 +
 t/t7002-grep.sh            |   71 ++++++++++++++++++++-
 xdiff-interface.c          |   15 ++++
 xdiff-interface.h          |    1 +
 8 files changed, 232 insertions(+), 44 deletions(-)
