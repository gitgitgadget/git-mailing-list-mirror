From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 00/21] git remote: set-head and new show output
Date: Wed, 25 Feb 2009 03:32:07 -0500
Message-ID: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:34:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFDR-0008Sh-Gn
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757882AbZBYIcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbZBYIcd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:32:33 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:53623 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbZBYIcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:32:32 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1285047yxm.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=2ZLz/pJYGPU79WFCVtHvjDm758Dt/BadmbEvAJfAJNw=;
        b=RKmgiWUlv+fvma5ZI+jW3qKHeLEPp9nTcf+DW5xuJMTpOx75RvNTgT4vJphOKJQHlZ
         8Bu6k8EdEejjzDwM9LBY2N19LSIRNyPWDofaZ0wxwWICa0Xyt7WdBXt0SUsw4ypYZdWu
         8pHozjRoY8OQQXe41FQKDaScptRGUQ4KS1sNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=xV/U4vBFIHl/qt07wAhYvkxEyV1PAdaIk7pnoxY+LsePRFFmFv6hY2aRYrgKU0Cp84
         Qawlis1PYN0weSYBqVaeKzWPRpL0GbJg6yJXDu/Z4KXpn3RksMu+ly9SXv5Q4Ysb4Sou
         iE//gG4p4V/J2ZUZOPRi3LioZCobAJz110pDw=
Received: by 10.100.207.14 with SMTP id e14mr804965ang.128.1235550750274;
        Wed, 25 Feb 2009 00:32:30 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c23sm9254039ana.32.2009.02.25.00.32.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:32:29 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111394>

This series replaces three related topics from pu:

  js/remote-set-head
  jk/head-lookup
  js/remote-display

It is based on master. I re-ordered the original commits such that all
the refactoring outside of builtin-remote is done first, followed by
some small cleanups of builtin-remote itself, and finally ending with
the new builtin-remote functionality (set-head) and changes to its
"show" output. I think it is easier to review this way and the history
will be cleaner.

The end result is largely unchanged from what is currently in pu, but
the intermediate results obviously differ to account for the
re-ordering. I've verified that each intermediate result compiles and
passes t5505-remote.sh. I also ran the full test-suite after the first
group of refactoring, and again at the end.

I've diffed each of the changed files at the end of this series against
what is currently in pu to verify I didn't miss anything and I saw
nothing of note.

So I think this series is clean, and doesn't need an extensive
re-review, but a quick look-over would be appreciated.

I signed off on Jeff's patches; please remove my SoB from those if it is
inappropriate for me to have done so.

Thanks,

j.

Jay Soffian (17):
  move duplicated get_local_heads() to remote.c
  move duplicated ref_newer() to remote.c
  move locate_head() to remote.c
  remote: simplify guess_remote_head()
  remote: let guess_remote_head() optionally return all matches
  remote: make match_refs() copy src ref before assigning to peer_ref
  remote: make match_refs() not short-circuit
  string-list: new for_each_string_list() function
  builtin-remote: refactor duplicated cleanup code
  builtin-remote: remove unused code in get_ref_states
  builtin-remote: rename variables and eliminate redundant function call
  builtin-remote: make get_remote_ref_states() always populate states.tracked
  builtin-remote: fix two inconsistencies in the output of "show <remote>"
  builtin-remote: teach show to display remote HEAD
  builtin-remote: add set-head subcommand
  builtin-remote: new show output style
  builtin-remote: new show output style for push refspecs

Jeff King (4):
  test scripts: refactor start_httpd helper
  add basic http clone/fetch tests
  refactor find_ref_by_name() to accept const list
  remote: make guess_remote_head() use exact HEAD lookup if it is available

 Documentation/git-remote.txt           |   28 ++-
 Makefile                               |    1 +
 builtin-clone.c                        |   41 +---
 builtin-remote.c                       |  563 ++++++++++++++++++++++++++------
 builtin-send-pack.c                    |   79 +-----
 cache.h                                |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 http-push.c                            |   72 +----
 refs.c                                 |    4 +-
 remote.c                               |  136 ++++++++-
 remote.h                               |   12 +
 string-list.c                          |   10 +
 string-list.h                          |    5 +
 t/lib-httpd.sh                         |    9 +-
 t/t5505-remote.sh                      |  114 +++++--
 t/t5540-http-push.sh                   |    9 +-
 t/t5550-http-fetch.sh                  |   57 ++++
 17 files changed, 818 insertions(+), 326 deletions(-)
 create mode 100755 t/t5550-http-fetch.sh
