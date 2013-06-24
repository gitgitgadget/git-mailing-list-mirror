From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v14 00/16] Interactive git-clean
Date: Mon, 24 Jun 2013 23:21:24 +0800
Message-ID: <cover.1372087065.git.worldhello.net@gmail.com>
References: <CANYiYbHQ307TroSd6Lk=5zg68jdKxGeA4N=hWGfaz1W29NhNVw@mail.gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:22:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8af-0006AL-Uo
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab3FXPV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:21:58 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52605 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab3FXPV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:21:57 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so11037836pbb.22
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aW/J3RtgPlKYZG0B5osC3K4GjvMsKgcMXE0nwgwN0rU=;
        b=UZUtUUBbNbk4xAJ6W2Smj1VmwYVLPxYvfgMIeFlCkZaqEmwdlGAO7ulDwgK683gDQX
         7fpFb7+O3GXGyOqUwOXdztcgKUQynXExjilrzHrW8J8COPd7todcG8LCyokpEIU7Mz5u
         XuwBMK+4G3cf2Zfueeg2dtFOlOOk+W30rqi5LRSyEIYhQ2LqDETAbxY95Df5CV74D9ee
         Kk0CDuZLlWY/ZeMiluszJZHHVLCxHp5ePn+6fYh/23ML4qhiRTNqey7zIi3V4cpo7z+n
         VEx5QZRN2zpV79steo0OyMaedJ87QQbik5ge2B/CcaevMQRN4PjIGmDpBPGxTcTEHkuS
         8byA==
X-Received: by 10.68.243.40 with SMTP id wv8mr24254477pbc.34.1372087316980;
        Mon, 24 Jun 2013 08:21:56 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id ix3sm18576807pbc.37.2013.06.24.08.21.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 08:21:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g41beab0
In-Reply-To: <CANYiYbHQ307TroSd6Lk=5zg68jdKxGeA4N=hWGfaz1W29NhNVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228822>

Johannes found that some relative_path tests should be skipped on Windows.
See this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/227706

In this reroll,

 * I squash Johannes's patch into patch 01/16, and seven relative_path
   test cases are skipped by marking with POSIX.
 
 * In patch 02/16, 4 test cases can run correctly as the refactor of
   relative_path.
 
 * In patch 16/16, most of the previous skiped test cases can run with
   the help of the new utiliy "test-path-utils mingw_path /abs/path/".

Jiang Xin (16):
  test: add test cases for relative_path
  path.c: refactor relative_path(), not only strip prefix
  quote.c: remove path_relative, use relative_path instead
  Refactor quote_path_relative, remove unused params
  Refactor write_name_quoted_relative, remove unused params
  git-clean: refactor git-clean into two phases
  git-clean: add support for -i/--interactive
  git-clean: show items of del_list in columns
  git-clean: add colors to interactive git-clean
  git-clean: use a git-add-interactive compatible UI
  git-clean: add filter by pattern interactive action
  git-clean: add select by numbers interactive action
  git-clean: add ask each interactive action
  git-clean: add documentation for interactive git-clean
  test: add t7301 for git-clean--interactive
  test: run testcases with POSIX absolute paths on Windows

 Documentation/config.txt     |  21 +-
 Documentation/git-clean.txt  |  71 +++-
 builtin/clean.c              | 778 +++++++++++++++++++++++++++++++++++++++++--
 builtin/grep.c               |   5 +-
 builtin/ls-files.c           |  16 +-
 cache.h                      |   2 +-
 path.c                       | 112 +++++--
 quote.c                      |  65 +---
 quote.h                      |   7 +-
 setup.c                      |   5 +-
 t/t0060-path-utils.sh        |  88 +++--
 t/t7301-clean-interactive.sh | 439 ++++++++++++++++++++++++
 test-path-utils.c            |  32 ++
 wt-status.c                  |  17 +-
 14 files changed, 1487 insertions(+), 171 deletions(-)
 create mode 100755 t/t7301-clean-interactive.sh

-- 
1.8.3.1.756.g41beab0
