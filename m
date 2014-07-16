From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 00/12] Use ref transactions part 3
Date: Wed, 16 Jul 2014 15:23:00 -0700
Message-ID: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:23:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Xbe-0004B9-De
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbaGPWXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:23:19 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:47105 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbaGPWXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:23:16 -0400
Received: by mail-ig0-f201.google.com with SMTP id h3so174159igd.2
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yttNxZlUea7B0vnrsKZEO7VZguFdrvc02ffftRoa3RM=;
        b=VZrV0kvyp6VyJDF/VLsOVQkqghpjDU52d1VzHM3LW9FWT37kCFP3eW8nOJoo+DQr9H
         Gi8gRG4UuELzjFUGIqUC7ttsB8F6HCuxQ+4hquSgcTmhhYRihS1zNNCZNkUz+tC7NlSd
         7SkJxcsKt2KMraW5kV0s3O/9sZf+oA1dbCmItStSzVjnjMYyM3BnDgfyWgLsM3ypmqUD
         cuwwf57mPZ1msKZ8j9mOTu3BQoVuk1izm/zgCPI8kb1QELTGwY+fo88MWULnG/LGj7bi
         +W8fg3uVzMYHobEFPHq/IJyHDLrGPsewKbPiWEe8jRpaXDdbJwzchL3bSObxf3rrrMch
         mhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yttNxZlUea7B0vnrsKZEO7VZguFdrvc02ffftRoa3RM=;
        b=RJX7j7txPE8mDyvT4Wk59nS2WH920ouau/z1oewSipyXs+/wpNx+4fGDwqRY95QuUF
         yl4+TNpV1gd/swUw0Os5pEL+fgwVT/eDmM4hNAc4nO6/t8srJQ8BT/ACQVeD2hMktjrT
         qAWLku+5H/ZpS8YB2W6Ayr0qtRZXt4arfNpvRzk3ZFoEkQovx2y3ah7PsmsXdAUOs9/1
         T/E7qqKW6Xz0AqExUwzxXRONL730k21XuaGE1pJz/tPyU6AXxJzPz/aGW2W/rhTkrrOE
         ZqZvcw1HMvcG7zaYDZm0Njl5BlY5+AK8l4axL3H9Plwk3uvczj3zjJ/wJ999WCZsqPxy
         Ofnw==
X-Gm-Message-State: ALoCoQnzPWuPfqN5DX+eDzXBONAAjzJAhgD8pYGSO1+ETH33p0mSDjXJ8gdOryCCkjJDFxlxTSmL
X-Received: by 10.50.171.233 with SMTP id ax9mr7565420igc.6.1405549395665;
        Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si73325yhh.5.2014.07.16.15.23.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8060531C04E;
	Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 22C69E0856; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.527.gc6b782e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253702>

This is the third and final part of the original 48 patch series for
basic transaction support.

It is used ontop of the previous two series :
* rs/ref-transaction-0 (2014-07-14) 19 commits
* rs/ref-transaction-1 (2014-07-16) 20 commits

This version implements some changes suggested by mhagger for the
warn_if_removable changes.
It also adds a new patch "fix handling of badly named refs" that repairs
the handling of badly named refs.


Ronnie Sahlberg (12):
  wrapper.c: simplify warn_if_unremovable
  wrapper.c: add a new function unlink_or_msg
  refs.c: add an err argument to delete_ref_loose
  refs.c: pass the ref log message to _create/delete/update instead of
    _commit
  refs.c: pass NULL as *flags to read_ref_full
  refs.c: move the check for valid refname to lock_ref_sha1_basic
  refs.c: call lock_ref_sha1_basic directly from commit
  refs.c: pass a skip list to name_conflict_fn
  refs.c: propagate any errno==ENOTDIR from _commit back to the callers
  fetch.c: change s_update_ref to use a ref transaction
  refs.c: make write_ref_sha1 static
  refs.c: fix handling of badly named refs

 branch.c                |   4 +-
 builtin/blame.c         |   2 +-
 builtin/branch.c        |   6 +-
 builtin/clone.c         |   2 +-
 builtin/commit.c        |   4 +-
 builtin/fetch.c         |  36 ++++---
 builtin/fmt-merge-msg.c |   2 +-
 builtin/for-each-ref.c  |   6 +-
 builtin/log.c           |   3 +-
 builtin/receive-pack.c  |   5 +-
 builtin/remote.c        |   5 +-
 builtin/replace.c       |   4 +-
 builtin/show-branch.c   |   6 +-
 builtin/tag.c           |   4 +-
 builtin/update-ref.c    |  13 +--
 bundle.c                |   2 +-
 cache.h                 |  18 ++--
 fast-import.c           |   8 +-
 git-compat-util.h       |   6 ++
 http-backend.c          |   3 +-
 reflog-walk.c           |   3 +-
 refs.c                  | 247 +++++++++++++++++++++++++++++++-----------------
 refs.h                  |  17 ++--
 remote.c                |   6 +-
 sequencer.c             |   6 +-
 transport-helper.c      |   2 +-
 transport.c             |   5 +-
 walker.c                |   5 +-
 wrapper.c               |  30 ++++--
 29 files changed, 291 insertions(+), 169 deletions(-)

-- 
2.0.1.527.gc6b782e
