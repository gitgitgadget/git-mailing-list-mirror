From: Stephen Robin <stephen.robin@gmail.com>
Subject: [PATCH 0/6] Make pull a builtin
Date: Wed,  6 May 2015 01:00:47 +0100
Message-ID: <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
References: <CACRoPnQ5_r-26J4gBHc27KZt3X9KAU7eFkA3vz_GE6_dP-Uyug@mail.gmail.com>
Cc: git@vger.kernel.org
To: pyokagan@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 02:00:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypmlm-0004RZ-3E
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 02:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbbEFAAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 20:00:53 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35006 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbEFAAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 20:00:52 -0400
Received: by widdi4 with SMTP id di4so181557076wid.0
        for <git@vger.kernel.org>; Tue, 05 May 2015 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G8M9uk1iO2Icxwq0ZLOvcjrtN+NXlaWej/b1JYaCvyQ=;
        b=OAW3npgpQZJ6Diu4KhiPexAA1ebDDEFIZAmzPfo3g65vnmWt4vFaz3DTt5U1R2O+2n
         g4jbLB1mnMNkP7tZ/cITEo+xTDoP7urSqax9FAfhXLQkC1LCPKXt/Y2pw8CgN2kqTOEU
         fL12LhsJGyYHCADp8UATe68VQoehmvXecgBQl34W/EZjoFvFrl/qRi5Pi/169bd79946
         3ePFYTRjC9TmaZ7v/71fSK84avjkVr8pUo7q46UgOgxG29kCxnJ5AJMTa7kMqmwPyYnE
         q7PcG9SwpQEdelU/ICUNncC5t4pbXLv/cHu+CbohGxvmgB1M+rfd7hfLkkVMS+khg7OS
         Eg4w==
X-Received: by 10.194.176.225 with SMTP id cl1mr13507767wjc.45.1430870450863;
        Tue, 05 May 2015 17:00:50 -0700 (PDT)
Received: from localhost ([141.0.152.225])
        by mx.google.com with ESMTPSA id go4sm439854wib.1.2015.05.05.17.00.50
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 May 2015 17:00:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.7.gf20f26f
In-Reply-To: <CACRoPnQ5_r-26J4gBHc27KZt3X9KAU7eFkA3vz_GE6_dP-Uyug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268433>

Hi Paul,

Congratulations on getting your project accepted for GSOC. Here's my
attempt at implementing pull as a builtin, maybe it will be of some use
as you look to progress your version.

It's fairly complete in the sense that all the features of git-pull.sh
should be implemented, the test suite passes, and I've been using it
myself without issue. At the same time it's some way from finished as
I've never had time to test it fully and there are parts of the code I'm
not happy with.

Apologies for not sharing this with you earlier.  I have been too busy
with paid work to look at any open source projects for some months.

Good luck with your project!

Regards
Stephen


Stephen Robin (6):
  merge: tidy up options
  merge: move error message given when a merge needs committing to
    advice.c
  merge-base: split handle_fork_point to make reuse easier
  pull: reimplement as a builtin in C
  pull: allow interactive rebase
  parse-remote: dismantle git-parse-remote.sh

 .gitignore                           |    2 -
 Documentation/config.txt             |    1 +
 Documentation/git-parse-remote.txt   |   23 -
 Documentation/git-pull.txt           |    4 +-
 Makefile                             |    3 +-
 advice.c                             |    9 +
 advice.h                             |    1 +
 builtin.h                            |    3 +
 builtin/merge-base.c                 |   64 ++-
 builtin/merge.c                      |   16 +-
 builtin/pull.c                       | 1006 ++++++++++++++++++++++++++++++++++
 builtin/remote.c                     |    8 +-
 command-list.txt                     |    1 -
 contrib/examples/git-parse-remote.sh |   89 +++
 contrib/examples/git-pull.sh         |  340 ++++++++++++
 git-parse-remote.sh                  |   89 ---
 git-pull.sh                          |  340 ------------
 git-rebase.sh                        |   36 +-
 git-submodule.sh                     |    8 +-
 git.c                                |    1 +
 20 files changed, 1547 insertions(+), 497 deletions(-)
 delete mode 100644 Documentation/git-parse-remote.txt
 create mode 100644 builtin/pull.c
 create mode 100644 contrib/examples/git-parse-remote.sh
 create mode 100755 contrib/examples/git-pull.sh
 delete mode 100644 git-parse-remote.sh
 delete mode 100755 git-pull.sh

-- 
2.4.0.7.gf20f26f
