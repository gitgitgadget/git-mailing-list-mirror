From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 0/3] port upload-archive to Windows
Date: Mon, 24 Oct 2011 18:02:08 +0200
Message-ID: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org, peff@peff.net,
	rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 18:02:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIMyc-0008T1-4b
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 18:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923Ab1JXQCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 12:02:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38696 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826Ab1JXQCI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 12:02:08 -0400
Received: by bkbzt19 with SMTP id zt19so8365950bkb.19
        for <git@vger.kernel.org>; Mon, 24 Oct 2011 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=qkGIiEu0XppQP0+OtVDA46WLLDPsw2KRVw5zhh/JIPg=;
        b=k1EZLbNL02CaFwdsIO16hN/67Kz0+XD91tleVM2uIBzpY1FXMUqzLpXlxwAIpoabZa
         U/toD7fqxQ05FSZd6samfgtWqPd/igcbuIDNkpQJMTyseiN4VbhzKHzMYwOGyORSc4Ax
         9/e6VsA7d1GlU3+lEUXOXCBHAoKALm4bX45FM=
Received: by 10.204.146.73 with SMTP id g9mr8393977bkv.57.1319472127319;
        Mon, 24 Oct 2011 09:02:07 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id z9sm24288449bkn.7.2011.10.24.09.02.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Oct 2011 09:02:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.msysgit.1.1.g7b316
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184177>

Here's a new iteration of this series. I delayed it until the
improved version of "enter_repo: do not modify input" hit master,
which happened recently.

The important change in this iteration (besides the patch that
already propagated upstream) is that I've moved
compat/win32/sys/poll.[ch] out of the sys-folder (as XSI suggests).
This enables us to easily upgrade the poll-emulation without
breaking the Windows build in the process.

Erik Faye-Lund (3):
  mingw: move poll out of sys-folder
  compat/win32/poll.c: upgrade from upstream
  upload-archive: use start_command instead of fork

 Makefile                 |    6 +-
 builtin/archive.c        |    6 +-
 builtin/upload-archive.c |   68 ++----
 compat/mingw.h           |    2 -
 compat/win32/poll.c      |  606 ++++++++++++++++++++++++++++++++++++++++++++++
 compat/win32/poll.h      |   53 ++++
 compat/win32/sys/poll.c  |  599 ---------------------------------------------
 compat/win32/sys/poll.h  |   53 ----
 t/t5000-tar-tree.sh      |   10 +-
 9 files changed, 694 insertions(+), 709 deletions(-)
 create mode 100644 compat/win32/poll.c
 create mode 100644 compat/win32/poll.h
 delete mode 100644 compat/win32/sys/poll.c
 delete mode 100644 compat/win32/sys/poll.h

-- 
1.7.7.msysgit.1.1.g7b316
