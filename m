From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 v2 00/20] remote-helper improvements
Date: Sun, 19 Jun 2011 17:18:25 +0200
Message-ID: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:19:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJmi-0003bU-Hd
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab1FSPTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:19:30 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43954 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab1FSPT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:29 -0400
Received: by ewy4 with SMTP id 4so981189ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Pwbi5gjgCK1Nuj67ouGwqUob3QUjMORXJyKqT3fB12g=;
        b=aerXCNh1uDib2KvZl/gjkUddUQQDX1uOWPHFCV1y40xqkEUEjT5N+aINGpwQQkjtSK
         w3ntWkKxG1C1OCOJkDMKf05PyJseENXa9WC12M2ho12kTNB4TWUlM+s1Ej9zle1X9JyE
         4CLCLSBh3P0YJSGQ/z8V8KQbMn9L8KN+/82as=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jQIxB86Xjea6JipVrxqoRw57t7UKzvE5Vuh8EMPNxtnZFMSG+SgX3k9+hV2qS6YUWg
         mX6Nxv66g/9Q8tvf2/HsJofFXjKRa2KJXvn8X9tUUjDSZkGCVqySa63oz+x6r3uaiE++
         /lsbpXSEy9bQFjcjTRkVegM1K8IaBceY8bMY8=
Received: by 10.213.9.134 with SMTP id l6mr1700674ebl.20.1308496767966;
        Sun, 19 Jun 2011 08:19:27 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176002>

This is v2 of the series, mostly minor changes.

Jeff King (6):
  transport-helper: fix minor leak in push_refs_with_export
  t5800: factor out some ref tests
  t5800: document some non-functional parts of remote helpers
  teach remote-testgit to import non-HEAD refs
  transport-helper: don't feed bogus refs to export push
  git_remote_helpers: push all refs during a non-local export

Sverre Rabbelier (14):
  t5800: use skip_all instead of prereq
  remote-curl: accept empty line as terminator
  git-remote-testgit: only push for non-local repositories
  git-remote-testgit: fix error handling
  fast-import: introduce 'done' command
  fast-export: support done feature
  transport-helper: factor out push_update_refs_status
  transport-helper: check status code of finish_command
  transport-helper: use the new done feature where possible
  transport-helper: update ref status after push with export
  transport-helper: change import semantics
  transport-helper: export is no longer always the last command
  transport-helper: Use capname for gitdir capability too
  transport-helper: implement marks location as capability

 Documentation/git-fast-export.txt   |    4 +
 Documentation/git-fast-import.txt   |   25 ++++
 builtin/fast-export.c               |    9 ++
 fast-import.c                       |    8 ++
 git-remote-testgit.py               |   57 ++++++---
 git_remote_helpers/git/exporter.py  |   15 ++-
 git_remote_helpers/git/importer.py  |   32 +++++-
 git_remote_helpers/git/non_local.py |   20 +--
 git_remote_helpers/git/repo.py      |    7 +-
 git_remote_helpers/util.py          |   66 ++++++++++
 remote-curl.c                       |    3 +
 t/t5800-remote-helpers.sh           |   93 +++++++++++---
 t/t9300-fast-import.sh              |   42 ++++++
 transport-helper.c                  |  238 ++++++++++++++++++----------------
 14 files changed, 445 insertions(+), 174 deletions(-)

-- 
1.7.5.1.292.g728120
