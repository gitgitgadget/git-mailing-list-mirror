From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 0/9] replace signal() with sigaction()
Date: Sun,  1 Jun 2014 11:10:09 -0700
Message-ID: <cover.1401645403.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:10:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrADV-0007Du-8g
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 20:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbaFASKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 14:10:41 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:64446 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbaFASKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 14:10:40 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so2678836pdj.29
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=AJyB/L1NPM7fwXXSsz0VZKZ++ei7r9z7e58twTBit04=;
        b=wZD98Wn4eKqf2bZFqXP/EA1uWrjdSHGjb7F9WqHQ/5Db6kfAW0CLLAqfsc/5LWaNXf
         +BQW7ObHtEdYJAyydmXq7DGg9fdTDH7Z6E+seKyQ3HAeASfCLpGzBJxsxatt5HEAYCw9
         cFlkkl/bkOon4feuiVueLM1nYLShYXca7rJEHoebO14u5CetmyDvozYQG+HzCFbTDkbT
         QRHorXLuVn9ASMfT+hQWpVdkpsjpU/w4RA+A+NVP+SfwN6TdWZNO5gJXBHbNb3edln3A
         D/haIKqrC5w8lD3ySPR8w3I/lf6BYDf6V3TVhi5Altfg9M8PsXwOi9VH1lTNqK8qwMH5
         lqTw==
X-Received: by 10.66.121.70 with SMTP id li6mr35055018pab.14.1401646240267;
        Sun, 01 Jun 2014 11:10:40 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id qb6sm51796539pac.12.2014.06.01.11.10.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Jun 2014 11:10:38 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 01 Jun 2014 11:10:35 -0700
X-Mailer: git-send-email 2.0.0.8.g7bf6e1f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250533>

This is version 3 of the patch set to convert signal(2) to sigaction(2)
(previous discussion [1]).

[1]: http://marc.info/?l=git&m=140148352416926&w=2

Changes in this revision include:

  - Using NULL pointers instead of 0 as per the
    Documentation/CodingGuidlines pointed out by Chris Packham.

    sigaction(SIGCHLD, &sa, NULL);

  - Conversion of all remaining files which used signal().

  - sigchain.c required the most changes.  Both the old signal handler
    was used and the return value from signal() was being checked.
    signal() would return the previous error handler which would be
    SIG_ERR if an error occurred.  sigaction() just returns -1 in this
    case.

Jeremiah Mahler (9):
  compat/mingw.c: expand MinGW support for sigaction
  connect.c: replace signal() with sigaction()
  progress.c: replace signal() with sigaction()
  write_or_die.c: replace signal() with sigaction()
  daemon.c: replace signal() with sigaction()
  builtin/log.c: replace signal() with sigaction()
  builtin/merge-index.c: replace signal() with sigaction()
  builtin/verify-tag.c: replace signal() with sigaction()
  sigchain.c: replace signal() with sigaction()

 builtin/log.c         |  6 +++++-
 builtin/merge-index.c |  5 ++++-
 builtin/verify-tag.c  |  5 ++++-
 compat/mingw.c        |  9 +++++----
 connect.c             |  5 ++++-
 daemon.c              | 16 +++++++++++++---
 progress.c            |  6 +++++-
 sigchain.c            | 14 +++++++++++---
 write_or_die.c        |  6 +++++-
 9 files changed, 56 insertions(+), 16 deletions(-)

-- 
2.0.0.8.g7bf6e1f.dirty
