From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 0/3] Make update refs more atomic
Date: Fri, 11 Apr 2014 13:39:47 -0700
Message-ID: <1397248790-10403-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 22:40:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYiF0-00049Y-3G
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 22:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbaDKUjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 16:39:55 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:34990 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605AbaDKUjx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 16:39:53 -0400
Received: by mail-ve0-f201.google.com with SMTP id jy13so847894veb.4
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/LKyjrqXJRxZrBzlhuJqTlHVnGylvr4yK/8Y7NZ/AGo=;
        b=b/tQZ13ViInFg6ChhIQ7cNQYm4rWw4RoFhAtmZNESk/MbTNi6TFj6N4GZK1dn6n1/3
         nQgGlwz19gUBm0gkOou9QiEiQf+lwhoXOC98WkKeWuYoh/8Do6IT5S61pDc0B4Mrbhr3
         RABT9L+l8L1GhBaeA1yg2lq7Sg5SB3TP8WtZfkoVA+VJw0K9bS2r94hcbJ+7Nv4b07Fj
         hgD+yKP9/OwGMrWsm6vpfjpT8PP+X6FJlxIydfTbpv2Wqq4CYCzqUN0rSG5gOsjpYdYh
         fKXpbN2EMkubZnHHMODu9BPIHQqhCdofYscMOTloL5Df9dKB6rmlc4wa+z99XwYJxA5u
         /2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/LKyjrqXJRxZrBzlhuJqTlHVnGylvr4yK/8Y7NZ/AGo=;
        b=bVJLhRjC1RVNMRusHct1zvRs0TkvEyA7eQ0f/DV1Cy4TVy/WUdUhK7Y0oE/mHDFm+p
         QQRjzu1S27+gLIfYhMm8N1eJ62OsZ1BwH5SgWEFnuU8p/BNZ0s83bxxmt+QtZeFc4ACH
         0b1yVhwMwY20NW0mLbdICqWUo69xJI/iP8qhwTWK3C75e+0gB7Kq255M1DBt6HptJfEL
         KHp9lPcDFROvg6N0x/KqeurzR6s3hG+N/vDqJssTSiFX9axl4CO0x2oRQ8xcR6C4MTMg
         xNwlE7uUXUBLoDbvNz/eNgz+DO0NoIw7yHMORRbcnpkNKnNX1sGNwOY17LsJXYH/8Cb/
         hrmg==
X-Gm-Message-State: ALoCoQnZBlp5ozrqbIUkOuqR6BiqYrrVUjWLXdlWdExzLPJFpvdElV6E+UmAdEYZ7xhJbIeygQ1gPFnllbbWAPTv5rSrg+6Nvyn1gPxqVnyn7+HDMoIz4fvGArA+UAIg4fEM+ZU/3M0bn+QeNEXIDOdyFr7uooVLhNMVPJ8jKkwTbdISYhYcRjQivqxSXq6cvmGEZ1HQ8yBU
X-Received: by 10.224.13.12 with SMTP id z12mr868459qaz.7.1397248792632;
        Fri, 11 Apr 2014 13:39:52 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id s65si1295575yhc.2.2014.04.11.13.39.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Apr 2014 13:39:52 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7B71A31C255;
	Fri, 11 Apr 2014 13:39:52 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 22B43E064B; Fri, 11 Apr 2014 13:39:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.505.g4f1e74f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246144>

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
  refs.c: change update_refs to run the commit loops once all work is
    finished

 branch.c               | 10 ++++-
 builtin/commit.c       |  5 +++
 builtin/fetch.c        |  7 +++-
 builtin/receive-pack.c |  4 ++
 builtin/replace.c      |  6 ++-
 builtin/tag.c          |  6 ++-
 fast-import.c          |  7 +++- refs.c                 | 99 ++++++++++++++++++++++++++++++++++----------------
 refs.h                 |  6 +++
 sequencer.c            |  4 ++
 walker.c               |  4 ++
 11 files changed, 120 insertions(+), 38 deletions(-)

-- 
1.9.1.505.g6fcb662
