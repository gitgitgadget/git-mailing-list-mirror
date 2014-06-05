From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/4] Use transactions for renames
Date: Thu,  5 Jun 2014 16:17:10 -0700
Message-ID: <1402010234-7628-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 01:17:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsguW-0003jr-3q
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 01:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbaFEXRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 19:17:23 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:62657 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbaFEXRS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 19:17:18 -0400
Received: by mail-qg0-f74.google.com with SMTP id i50so136676qgf.3
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nSA8sFGEmroF0UX8d7QtLDzbx8wOES7zjVk3cs4U044=;
        b=mlSKcJiiAU9Um5oB8IFzF16f6/2PegtkmN/hC922OZn+hPAHPu/wXpoeEu8gS9MH+Y
         nOuzlH7yYprxGELLo7n85wrWhOzwlXW6H5LXnPk8Eun+rPEeAIqxEdL0sPVynThJx3lz
         YRwV4L4SDRg4KvpO0Af7dfJcnCIla8oiI5D8/vwXY5BZVovlU+dWSTBT8wjlM2lEsjAv
         SxKTTkxN8BF0o0p/EOab8zrPvejLhcdKcwEzO2J9qIFm+Muge9I9GrUlkIVmJYL8Ft5l
         RNCkmG1afuTJKq+EWmntljRUhtyV7MLRgkTfkppqzhSj1okoEatfAqjTl/ghFh5oGsHT
         2EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nSA8sFGEmroF0UX8d7QtLDzbx8wOES7zjVk3cs4U044=;
        b=c630e/58G2beQhMiUAemBJxsDLrtfhGegXGMPaRicmU7ZVaP+kZJMvWw5AZ7zG3MPM
         EjuR0+u0nZG6ZrTOZrSSsdnaSzvz7/u4JiuNMjyjbGvJHP8GFm6cbTPzzhL9AXJ3oEgW
         pxn3h4mFJpKgvjJ+i8hahExYQrUApRq3YFcrwXXU+XR5Dw+fwtiW4O0NZ0dQPDB60o6z
         FQwGvP0dtgEmWEIacrWnfIDTJx9OHl+D6x/PpWRshXkjqjHWi6oI9shs9P/3zITJBwni
         GOEUjqv+K6yGV+4gfaMu4+FWhtuoWxCQxiMXrTknp3izw8VoezVgy4EQ+M7SbjvH0+By
         Q3HQ==
X-Gm-Message-State: ALoCoQm2jt7eww5Kxb3I839QSiaW6ObcMRTBdTZkcPnPoqHKk0Ls0tbMM34lStlJUK0WbA3lset7
X-Received: by 10.236.197.226 with SMTP id t62mr225325yhn.50.1402010238074;
        Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si670229yhe.1.2014.06.05.16.17.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E94FF5A4755;
	Thu,  5 Jun 2014 16:17:17 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8976BE0B87; Thu,  5 Jun 2014 16:17:17 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.583.g402232d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250875>

This series is based on ref-transactions-reflog
It is also available at
https://github.com/rsahlberg/git/tree/ref-transactions-rename

This series adds support to perform rename_ref as a single transaction for
both deleting/re-creating the ref and updating the reflog.

Since we no longer use rename() for the reflog changes we can now support
renames even if the reflogs are symlinks.

In order to make the delete-then-create fully atomic and also to ensure that
at no point in time is the object unreferenced we add support to do
deletes via the packed refs file to transaction_commit. For any refs that are
to be deleted, we first copy these refs to the packed refs file.
This allows us to immediately delete the loose ref files for those refs and
still being able to cancel/rollback the transaction.
Once all the changes are successfully updated we finally commit the packed
refs file a second time at which stage all the refs-to-be-deleted all
disappear in one atomic rename().

This allows us to perform transactions that delete multiple refs and have the
delete appear as one atomic transaction to any external observer.


Ronnie Sahlberg (4):
  refs.c: allow passing raw git_committer_info as email to
    _update_reflog
  refs.c: return error instead of dying when locking fails during
    transaction
  refs.c: use packed refs when deleting refs during a transaction
  refs.c: update rename_ref to use a transaction

 refs.c            | 308 +++++++++++++++++++++++++++++++++---------------------
 refs.h            |   1 +
 t/t3200-branch.sh |   7 --
 3 files changed, 192 insertions(+), 124 deletions(-)

-- 
2.0.0.583.g402232d
