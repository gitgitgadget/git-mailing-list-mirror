From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 0/3] Make update refs more atomic
Date: Mon, 14 Apr 2014 11:29:20 -0700
Message-ID: <1397500163-7617-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 20:37:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZlkz-0000Ck-Fx
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 20:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbaDNShT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 14:37:19 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:44307 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaDNShS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 14:37:18 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so1237570qab.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2014 11:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=62g+AuUT8GmNewK9Ti0hC/fIhWzJ1pBKmggiRStyTAA=;
        b=gD0AXRXXz9O/16u99TneaKMi8CAKVyip0xXsZOEh3UCJ707MLYA3JjHoIZNG9rnKcO
         6PW6ih2bRvMaXg/v6O9ppvIctKZw2x0gOYRd0C1rJNM9VSeAdh2Yp+3u1URYSwatvemg
         auH8lC0FsHTUN6IPpjPSRNa5s6dKEZT9WJKxdvvNEFU/4KJjRAC0hcCdVtcNZMFQfgSm
         ORHgetkkhU6qoR/mbAhkeyMU7jLYze7dPiBkS/j56Cj9F5n0N675JAhQYxjtH36IZy/o
         U81At34ANtDmQKczS9/Hs2rd3rfjxcURudXO0k03H8nLod936nLkQj0aqIm/l/cde5Fg
         rA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=62g+AuUT8GmNewK9Ti0hC/fIhWzJ1pBKmggiRStyTAA=;
        b=DcWrm8OCPewSQKw6hL+zleqxP9cARUtuY+5KUKZNDO7XPNz2+E+XiomLajXaeZjJAy
         dp8lzXMG9MAq0zvy5LhTNpxVpjNMB6yW7GRwORhRpzMBG9i6GvQgRZzpv/W1PTVX6vd3
         lmN7bVD3W1NhqHG/hS0Iq6iHw7Das9P5ObOGqgF3Sojm31cL8gf8KQ92AkFEnySbY0Tb
         g5DuAErTQ1Q7NkM/F7Fs9xeJQsMqzrKGuvG+iz4EYPimqgStu7BWrG/T3pGwExFQQw9f
         k84nlPWc5sakmHzmXp6uw9TuyoFHh1/1DXU5bagETpfoE7XtrKOsibfPZvaqAMnXsInj
         X4oA==
X-Gm-Message-State: ALoCoQnVjcpRnYDHCcLuyfWmj1V5AW8okvPXDgMQwXynfvBB6ovAiOQipJ9QvTZSxpJwuGmdR/19+AoUCynCITulybKNGQTlGwiI65iuLkGXl3iXZUnXN6METxe2AJCFbWA77g1IBriECr7afJ9YAL/8r8A02PrXgn3ZXuvQrD/gwmZnvlkm8x4kDdFvTZTfmSP03EPU2t7R
X-Received: by 10.236.199.108 with SMTP id w72mr17483398yhn.10.1397500175266;
        Mon, 14 Apr 2014 11:29:35 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r61si2364773yhf.1.2014.04.14.11.29.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Apr 2014 11:29:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 228EA31C230;
	Mon, 14 Apr 2014 11:29:35 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BBC0EE08C1; Mon, 14 Apr 2014 11:29:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.505.gd05696d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246255>

refs.c:ref_transaction_commit() intermingles doing updates and checks with
actually applying changes to the refs in loops that abort on error.
This is done one ref at a time and means that if an error is detected that
will fail the operation partway through the list of refs to update we
will end up with some changes applied to disk and others not.

Without having transaction support from the filesystem, it is hard to
make an update that involves multiple refs to guarantee atomicity, but we
can do a somewhat better than we currently do.

These patches change the update and delete functions to use a three
call pattern of

1, lock
2, update, or flag for deletion
3, apply on disk  (rename() or unlink())

When a transaction is commited we first do all the locking, preparations
and most of the error checking before we actually start applying any changes
to the filesystem store.

This means that more of the error cases that will fail the commit
will trigger before we start doing any changes to the actual files.


This should make the changes of refs in refs_transaction_commit slightly
more atomic.


Version 4:
* Fix a bug in fast-import.c:dump_tags and make sure no tests fail

Version 3:
* Rebased onto mhagger/ref-transactions.
* Removed the patch to do update/delete from a single loop.

Version 2:
Updates and fixes based on Junio's feedback.
* Fix the subject line for patches so they comply with the project standard.
* Redo the update/delete loops so that we maintain the correct order of
  operations. Perform all updates first, then perform the deletes.
* Add an additional patch that allows us to do the update/delete in the correct
  order from within a single loop by first sorting the refs so that deletes
  are after all non-deletes.


Ronnie Sahlberg (3):
  refs.c: split writing and commiting a ref into two separate functions
  refs.c: split delete_ref_loose() into a separate flag-for-deletion and
    commit phase
  refs.c: change ref_transaction_commit to run the commit loops once all
    work is finished

 branch.c               | 10 ++++--
 builtin/commit.c       |  5 +++
 builtin/fetch.c        |  7 +++-
 builtin/receive-pack.c |  4 +++
 builtin/replace.c      |  6 +++-
 builtin/tag.c          |  6 +++-
 fast-import.c          | 18 ++++++++--
 refs.c                 | 98 +++++++++++++++++++++++++++++++++-----------------
 refs.h                 |  6 ++++
 sequencer.c            |  4 +++
 walker.c               |  4 +++
 11 files changed, 129 insertions(+), 39 deletions(-)

-- 
1.9.1.505.gd05696d
