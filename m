From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 00/23] builtin-remote improvments
Date: Tue, 24 Feb 2009 04:50:48 -0500
Message-ID: <cover.1235461736.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzr-0002Ej-C1
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682AbZBXJvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755554AbZBXJvT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:19 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:21822 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265AbZBXJvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:17 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1005599yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=zqqjlM+QvWb8QzU8dQL1rs6XmrAOZOypOuF3CDUpGUc=;
        b=WAD1dBwcTV5BO4ULm7YF+mmRpScW5PXBhuq5QfmqEhaxp6+7kA1IMcdcmHpqcK9zYg
         /If55XPn9vdaKseA9tXu3EMsx8e+UBQGsAI8QICjzriQMYq/BAEobyx3qRpxh+57lv9U
         /tpJe9fZL7k8XnQbO1jcwrdgSHSUNwG2H7cUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=XlxsfH4+sFDZvTHyBTATcVl0ph2CllRnsVYCI0iTckqwo4SQQdQ1bp7p1KDl1Pd6yI
         xGcKETOogoR2qzw1EMm5rsIXGsAJgI5G+Ot3JNffbQnbw709cB1KCIEg16sU7oaICq6i
         23QRu6zfaq7q4o7RuOpwIfEIBStvT5cy2Q11c=
Received: by 10.100.207.14 with SMTP id e14mr2975772ang.128.1235469074998;
        Tue, 24 Feb 2009 01:51:14 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c28sm1780950anc.45.2009.02.24.01.51.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:14 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111255>

Junio, this is a big series, so let me explain.

Patches 1-5 are js/remote-set-head, but rebased on master (2d602e9). I did
this because patch 18 in this series depends on commit cfa1ee6 which is now in
master, but was not when you originally spawned js/remote-set-head. I also
corrected two failing tests in #3.

Patches 6-18 are the 13 patch series I sent out earlier, directly on-top of
1-5, instead of on pu. I incorporated the feedback I received, and re-ordered
the patches to put all the refactoring, as well as non-builtin-remote changes,
first among the 13.

Patches 19-23 are jk/head-lookup, now based at the end of my changes.
Previously they were effectively between 1-5 and 6-18.

You might consider applying #6 (make match_refs() copy src...) independently
to master if it is obvious enough, but in any case it has to come before #18
in this series.

I wasn't sure what to do about the SOB on the rebased patches, so I kept
Jeff's, removed yours, and added my own. Please correct me if this was the
wrong thing to do.

Finally, I've and compiled and run t5505-remote.sh after each individual
commit, as well as the entire default test suite (but
w/NO_SVN_TESTS=YesPlease) after #10 and #23.

Thank you for your patience with this topic.

j.

Jay Soffian (18):
  builtin-clone: move locate_head() to remote.c so it can be re-used
  builtin-remote: move duplicated cleanup code its own function
  builtin-remote: teach show to display remote HEAD
  builtin-remote: add set-head subcommand
  builtin-remote: better handling of multiple remote HEADs

  remote.c: make match_refs() copy src ref before assigning to peer_ref
  remote.c: don't short-circuit match_refs() when error in match_explicit_refs()
  refactor duplicated get_local_heads() to remote.c
  refactor duplicated ref_newer() to remote.c
  string-list: new for_each_string_list() function
  builtin-remote: rename variable and eliminate redundant function call
  builtin-remote: name remote_refs consistently
  builtin-remote: remove unused code in get_ref_states
  builtin-remote: fix two inconsistencies in the output of "show <remote>"
  builtin-remote: make get_remote_ref_states() always populate states.tracked
  builtin-remote: refactor get_remote_ref_states()
  builtin-remote: new show output style
  builtin-remote: new show output style for push refspecs

Jeff King (5):
  test scripts: refactor start_httpd helper
  add basic http clone/fetch tests
  refactor find_refs_by_name to accept const list
  remote: refactor guess_remote_head
  remote: use exact HEAD lookup if it is available

 Documentation/git-remote.txt           |   28 ++-
 Makefile                               |    1 +
 builtin-clone.c                        |   42 +---
 builtin-remote.c                       |  562 ++++++++++++++++++++++++++------
 builtin-send-pack.c                    |   79 +-----
 cache.h                                |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 http-push.c                            |   72 +----
 refs.c                                 |    4 +-
 remote.c                               |  137 ++++++++-
 remote.h                               |   12 +
 string-list.c                          |   10 +
 string-list.h                          |    5 +
 t/lib-httpd.sh                         |    9 +-
 t/t5505-remote.sh                      |  122 +++++--
 t/t5540-http-push.sh                   |    9 +-
 t/t5550-http-fetch.sh                  |   57 ++++
 17 files changed, 817 insertions(+), 336 deletions(-)
 create mode 100755 t/t5550-http-fetch.sh
