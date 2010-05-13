From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/7] grep: better support for binary files
Date: Thu, 13 May 2010 22:33:21 +0200
Message-ID: <4BEC6211.2000309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Phil Lawrence <prlawrence@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 13 22:33:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCf68-0004VG-Nd
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 22:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab0EMUda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 16:33:30 -0400
Received: from india601.server4you.de ([85.25.151.105]:53151 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab0EMUd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 16:33:29 -0400
Received: from [10.0.1.100] (p57B7E766.dip.t-dialin.net [87.183.231.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 5D7962F806A;
	Thu, 13 May 2010 22:33:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147021>

This series improves support of git grep for binary files.  It tries to
pick the low hanging fruits; at the end you can search _in_ files that
contain NUL characters, but you can't search _for_ NULs, yet.

[PATCH 1/7] grep: add test script for binary file handling

	This patch adds a simple test script documenting what git grep
	can do with binary files.

[PATCH 2/7] grep: refactor handling of binary mode options
[PATCH 3/7] grep: --count over binary

	These two makes git grep handle counting in binary files like
	GNU grep does.

[PATCH 4/7] grep: use memmem() for fixed string search
[PATCH 5/7] grep: continue case insensitive fixed string search after NUL chars

	These two patches make git grep -F work on binary files.

[PATCH 6/7] grep: add regmatch(), a wrapper for REG_STARTEND handling
[PATCH 7/7] grep: use regmatch() for line matching

	The final patches make git grep work on binary files if the
	platform's regexec() supports the flag REG_STARTEND.  Our own
	version in compat/ doesn't, unfortunately.


 grep.c                 |   70 ++++++++++++++++++++++++++++-------------------
 t/t7008-grep-binary.sh |   54 +++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 28 deletions(-)
