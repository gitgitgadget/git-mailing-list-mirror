From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 00/19] Use ref transactions from most callers
Date: Fri, 25 Apr 2014 09:14:35 -0700
Message-ID: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:16:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdinq-0000OR-NW
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbaDYQPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:15:00 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:56055 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbaDYQO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:14:58 -0400
Received: by mail-ve0-f201.google.com with SMTP id jy13so632883veb.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=P6c6i6XdW9lNwtpSPlc+pfHiXDEOSBSilNdKQcMk5Yk=;
        b=TvHL2xAA2uNwcjAt9qQRY75KPlygylg7B8ie5ZGwDuC/Ok/35L+IhmAf3NXVmr0qFP
         8weX3LMG9ZvIZ4h15CB4L3gHzPAEYCGAX/IfdZG+63keCubzYB5xD2qw+Xvt+SGne/YQ
         H9GFn5+4VauyqsxEQvnCskud115TjC+Es7B92fAwlpupBwTspAuz6krdB8/Pi7TSYTX6
         ipET6YXdOZ8uLKo4dukI2sOyI0YILj6Pcx93VSnGfHudr9ESO3SwLWorUU7yfnTyRqB2
         kn7NYtCOrWJaY9e3KMlxcknSQLDlinGC61elN0sNPg03uLnRs0HTmwfiZnnnONxUxm2V
         rnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P6c6i6XdW9lNwtpSPlc+pfHiXDEOSBSilNdKQcMk5Yk=;
        b=Mr5KX9uO+oV3BwNVS4pQdeeo7lTyrad/0Eam/JrLwhfAFj77sRW8wxXR0EcAx1Zp1n
         aIjDhBihr8dSKy8L+egabXLMzgB8D90TnBkbAxZ1UjqLtGKR0RnvVBfXDtGGlhxNOq1N
         ELA6nBXEtLyfg0vDyozny9+t+mc+Oyk2rtSx2fpeCSswXElJtKb4ks804m6zNZ8vgnRT
         AgOF/ChcdU6LsNoDfY4PXozYvZuMPhO0sPLhGCRM77qVl8f6XLOqGkgGAYDfkLKGYv24
         mJDj8MvHyjBoGOuO9m4kvQhxPZ07oIwlqwn1+1b6I3/frK3t+8uN9Lowz/Z6z4jmc2S0
         dZpA==
X-Gm-Message-State: ALoCoQnJEcMvZnBor0ylgt2NpbSeGiA2zuOG7uP4BY8PMDuUT9NIaLgngeqb4/scavraKHfWulTG8wVksMALfky+0Qm9AZCKXp4ycU2oYvaf8oGaTxNJhWCx9uDnz+jhTzJCvPMw1xo3e1B4CoM82gF04AyYsRC+z3x9i453lZuhjAOBXDZL0xccGEBeajwk7Ra58Ar/wGEs
X-Received: by 10.236.32.236 with SMTP id o72mr4085956yha.42.1398442497663;
        Fri, 25 Apr 2014 09:14:57 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g21si1051049yhe.3.2014.04.25.09.14.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:14:57 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6B27E5A4211;
	Fri, 25 Apr 2014 09:14:57 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EB7D4E0855; Fri, 25 Apr 2014 09:14:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247056>

This patch series changes most of the places where the ref functions for
locking and writing refs to instead use the new ref transaction API. There
are still three more places where write_ref_sha1() is called from outside
of refs.c but those all will require more complex work and review so those
changes belong in a different patch series.

I think I have covered all issues raised on the previous reviews and also
done a bunch of cleanups and improvements to the transaction API.


Version 3:
 - Remove the walker patch for now. Walker needs more complex solution
   so defer it until the basics are done.
 - Remove the onerr argument to ref_transaction_commit(). All callers
   that need to die() on error now have to do this explicitely.
 - Pass an error string from ref_transaction_commit() back to the callers
   so that they can craft a nice error message upon failures.
 - Make ref_transaction_rollback() accept NULL as argument.
 - Change ref_transaction_commit() to take a pointer to pointer argument for
   the transaction and have it clear the callers pointer to NULL when
   invoked. This allows for much nicer handling of transaction rollback on
   failure.

Version 2:
 - Add a patch to ref_transaction_commit to make it honor onerr even if the
   error triggered in ref_Transaction_commit itself rather than in a call
   to other functions (that already honor onerr).
 - Add a patch to make the update_ref() helper function use transactions
   internally.
 - Change ref_transaction_update to die() instead of error() if we pass
   if a NULL old_sha1 but have have_old == true.
 - Change ref_transaction_create to die() instead of error() if new_sha1
   is false but we pass it a null_sha1.
 - Change ref_transaction_delete die() instead of error() if we pass
   if a NULL old_sha1 but have have_old == true.
 - Change several places to do  if(!transaction || ref_transaction_update()
   || ref_Transaction_commit()) die(generic-message) instead of checking each
   step separately and having a different message for each failure.
   Most users are likely not interested in what step of the transaction
   failed and only whether it failed or not.
 - Change commit.c to only pass a pointer to ref_transaction_update
   iff current_head is non-NULL.
   The previous patch used to compute a garbage pointer for
   current_head->object.sha1 and relied on the fact that ref_transaction_update
   would not try to dereference this pointer if !!current_head was 0.
 - Updated commit message for the walker_fetch change to try to justify why
   the change in locking semantics should not be harmful.

Ronnie Sahlberg (19):
  refs.c: constify the sha arguments for
    ref_transaction_create|delete|update
  refs.c: allow passing NULL to ref_transaction_free
  refs.c: make ref_transaction_commit return an error string
  refs.c: return error string from ref_update_reject_duplicates on
    failure
  update-ref.c: use the error string from _commit to print better
    message
  refs.c: make update_ref_write to return error string on failure
  refs.c: remove the onerr argument to ref_transaction_commit
  refs.c: change ref_transaction_update() to do error checking and
    return status
  refs.c: change ref_transaction_create to do error checking and return
    status
  refs.c: ref_transaction_delete to check for error and return status
  tag.c: use ref transactions when doing updates
  replace.c: use the ref transaction functions for updates
  commit.c: use ref transactions for updates
  sequencer.c: use ref transactions for all ref updates
  fast-import.c: change update_branch to use ref transactions
  branch.c: use ref transaction for all ref updates
  refs.c: change update_ref to use a transaction
  refs.c: free the transaction before returning when number of updates
    is 0
  refs.c: pass **transaction to commit and have it clear the pointer

 branch.c              |  39 ++++++++++------
 builtin/commit.c      |  23 +++++-----
 builtin/replace.c     |  14 +++---
 builtin/tag.c         |  14 +++---
 builtin/update-ref.c  |  30 ++++++++-----
 fast-import.c         |  18 ++++----
 refs.c                | 122 +++++++++++++++++++++++++++++++++++---------------
 refs.h                |  32 +++++++------
 sequencer.c           |  21 ++++++---
 t/t1400-update-ref.sh |  16 +++----
 10 files changed, 206 insertions(+), 123 deletions(-)

-- 
1.9.1.521.g5dc89fa
