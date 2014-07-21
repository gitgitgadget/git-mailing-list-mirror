From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 0/6] git_config callers rewritten with the new config cache API
Date: Mon, 21 Jul 2014 04:12:19 -0700
Message-ID: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 13:13:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9BXD-0008CE-HU
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 13:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbaGULNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 07:13:31 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:57340 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbaGULNb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 07:13:31 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so9514000pad.21
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6pSgNgVY7aMHoSk8SBc/5kK3Om+ecYiAaJ48SeuiQjI=;
        b=0j2KiBMzAhC023w/siZOWO63NTotqJy1ZwQmYMHO4zidjxJM0SSM9RPEUU4DLSrzqs
         LGrXUndlRiRX5NFyfbVyArAJWQRi+5zvWROBo+5VE2FIhFdtiqFX2NP4dv+igIb750Da
         xOlckh0YRDlX69Xi3jcpzGYASVSQmv8KcEUeLkuS80sgbVhLJJNbJ3uC9zXtNPBvfuCZ
         ewLOL3H6Bdxt7LuaFsYxDJ2t8k7NFT5173GswhIwjGAw/k3s1Sao/qh7f2Va9M2vwEV/
         +JZY8GhzgPHnxDJffgop7zJI1hRhPUd3aw1AxF9o6tXzdcaluVCazo5xuz/naro9kUWW
         EzTg==
X-Received: by 10.70.96.135 with SMTP id ds7mr24134683pdb.99.1405941206056;
        Mon, 21 Jul 2014 04:13:26 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.202])
        by mx.google.com with ESMTPSA id bl12sm2603688pac.44.2014.07.21.04.13.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 04:13:25 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253948>

[PATCH v3]: Most of Eric's suggestions has been implemented. See [2] for discussion.
	Also, new helpers introduced in v7 of the config-set API series have been used.
	See [1] for the documentation of the new functions.

This series builds on the top of 5def4132 in pu or topic[1] in the mailing list
with name "git config cache & special querying API utilizing the cache".

All patches pass every test, but there is a catch, there is slight behaviour
change in most of them where originally the callback returns
config_error_nonbool() when it sees a NULL value for a key causing a die
specified in git_parse_source in config.c.

The die also prints the file name and the line number as,

	"die("bad config file line %d in %s", cf->linenr, cf->name);"

We lose the fine grained error checking when switching to this method.
Still, I will try to correct this anomaly in my next series.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/253862
[2]: http://thread.gmane.org/gmane.comp.version-control.git/252334

Tanay Abhra (6):

 alias.c       | 27 +++++++--------------------
 branch.c      | 24 ++++--------------------
 imap-send.c   | 41 +++++++++++++++--------------------------
 notes-utils.c | 33 ++++++++++++++++-----------------
 notes.c       | 21 +++++++--------------
 pager.c       | 40 +++++++++++++---------------------------
 6 files changed, 62 insertions(+), 124 deletions(-)

-- 
1.9.0.GIT
