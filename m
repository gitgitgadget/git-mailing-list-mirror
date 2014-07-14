From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 00/19] Use ref transactions
Date: Mon, 14 Jul 2014 13:58:42 -0700
Message-ID: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLi-00037o-Tg
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188AbaGNU7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:34 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:34807 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbaGNU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:07 -0400
Received: by mail-ie0-f202.google.com with SMTP id rl12so444779iec.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Cj2qLgtzYPQhOGhZKA+VUsRvzhzf47xo/Z6N2L95/5g=;
        b=awJVotYB4soOIdlxjrjlpPbHdp6/KzoJUglbGb5d+g+PYAI3bdG/M+v8QvtNB8/UnK
         LXXsSxKHFavg9BdGtrA6CCAuOFVK66Mm9TecjYoXkC3YWJZhw6m1NxdGSCF0fWW+gcSQ
         zY1jFja3i6GEgHOxbN/kLVGGP6LRhBqQxzYmaowtwGdfjVLbfP7UMuaJi531M0wQC+/u
         vV31dNf4lqnzWBQ8wZCxPu/sLvUKcbZoQPP4aUn2UxHaWRJ97DZE8qVaP0jF/J2/GvAx
         EtLegzIDs0utNoS3tZtcksVxRHbL7PQFI0KfdkzDHGvclMEh1zFpZlGry9U7x0n1OLtK
         UAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=Cj2qLgtzYPQhOGhZKA+VUsRvzhzf47xo/Z6N2L95/5g=;
        b=i1Z8v7G13ENdfcVFb6l7W45yxy3kKUlKSF5edBHQg3K0ez242lyMOk6QKnduLDCm7Z
         o8hhGZmw5eqelUea08XfrzlZvAONp6BdMj/D+i63pBLeUQ/k2927InqcbtyFGWjmpkxe
         /tRulYJhPDQ/kqSnUzOHY3RWtu4zZd6xC/GKcozuTqM5VAHBRrF0D0cklzdfV4CEsYGl
         qVCuf76qjq9uXmCtjxoGK+VGE5AhRtXNc6TItRFHVudrQrohaRsh6JpCjWnvdIcsWdnr
         AzcatJwFL7E1TFBGZ0LtcDRDxzJogWoB6q2lKVz1y3L+c89zRhkXPxAsuHSIOPlQcw8f
         kP1A==
X-Gm-Message-State: ALoCoQnhtfTTtTXVYyH95wma0K2QZNut6BOrtD0fycttasiH/mzrbXILcxkTKQ8dLpsK5ycshxpa
X-Received: by 10.42.208.72 with SMTP id gb8mr10462026icb.24.1405371545357;
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si820066yhl.7.2014.07.14.13.59.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 34A5B31C391;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CB5EBE0856; Mon, 14 Jul 2014 13:59:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253525>

List, Jun

Here is a resend of the first part of the ref transactions patches.
This new series consists of the first 19 patches in the series and
have been reviewed by mhagger.
This series should be good to go now.

I will resend the remaining part of the series separately once I have addressed
Michaels concerns.


Version 21:
 -- split the patch series in two. These are the first 19 patches that
    are now reviewed by mhagger.

Ronnie Sahlberg (19):
  refs.c: remove ref_transaction_rollback
  refs.c: ref_transaction_commit should not free the transaction
  refs.c: constify the sha arguments for
    ref_transaction_create|delete|update
  refs.c: allow passing NULL to ref_transaction_free
  refs.c: add a strbuf argument to ref_transaction_commit for error
    logging
  lockfile.c: add a new public function unable_to_lock_message
  lockfile.c: make lock_file return a meaningful errno on failure
  refs.c: add an err argument to repack_without_refs
  refs.c: make sure log_ref_setup returns a meaningful errno
  refs.c: verify_lock should set errno to something meaningful
  refs.c: make remove_empty_directories always set errno to something
    sane
  refs.c: commit_packed_refs to return a meaningful errno on failure
  refs.c: make resolve_ref_unsafe set errno to something meaningful on
    error
  refs.c: log_ref_write should try to return meaningful errno
  refs.c: make ref_update_reject_duplicates take a strbuf argument for
    errors
  refs.c: make update_ref_write update a strbuf on failure
  update-ref: use err argument to get error from ref_transaction_commit
  refs.c: remove the onerr argument to ref_transaction_commit
  refs.c: change ref_transaction_update() to do error checking and
    return status

 builtin/remote.c     |   5 +-
 builtin/update-ref.c |  20 +++---
 cache.h              |   4 +-
 lockfile.c           |  39 ++++++-----
 refs.c               | 178 ++++++++++++++++++++++++++++++++++++---------------
 refs.h               |  53 +++++++++------
 6 files changed, 199 insertions(+), 100 deletions(-)

-- 
2.0.1.546.gf603308
