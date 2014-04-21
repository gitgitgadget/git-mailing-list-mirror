From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 00/13] Use ref transactions from most callers
Date: Mon, 21 Apr 2014 15:53:18 -0700
Message-ID: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6B-0007ra-9M
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbaDUWxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:53:37 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:60293 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbaDUWxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:35 -0400
Received: by mail-ob0-f201.google.com with SMTP id vb8so524579obc.2
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OtcGVnJXb9JZnEhgBpbtmL5mJO2a/R8zAridcytCWzY=;
        b=bmsyQYpdRrlEZFGvs7qHK1mMs6mVLC9uMMTJPA9ZvYE/EwiysiCtoVihbq1Pits/2x
         I2U5FeAXEZ8hdKHRKYOZB8PPInXt2/ucK+q4L6sniD9LYeyfGxKthq4Ty5f+tNhxt3I7
         ns4AG5HChm8QtOCcJRq0cPRwgJoC7IYtRRA1MS7t6diGJ6bnvafrVhWWKLSoysdkqsMj
         vM9TGrY2ShqGh0RonNAA5GQ83LMeKkSH02fGYvTaJk9UAIAMNkOiSSSfuvQUMFGlKis/
         /I5qXlVXxlG8vPmiAsUr2oL3GEKLbuyXH8GcYowiJf52fHLY/UXgI5Me80a56oaZ9/UQ
         qH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OtcGVnJXb9JZnEhgBpbtmL5mJO2a/R8zAridcytCWzY=;
        b=FxaFPO79BR3L2l8MrxzHJmit/9VT51YYIwY51aKSf3ra+WtDlYLWVt63yOzwcFgyvr
         j9gI3Ak/ena3tSyNwYfIFRg/O318us7uRJ4rB3QDgnTuWUt1a0gpUbmnJtDCnI0T8RFQ
         5oAZ+z6zUKNZ13y218haXQj/J/0EI05Z71fUhJMl92eE2wNNC54PHlsREMOq9u4iSYpo
         4Ap/mQuibbgNoHHzeoWId5RsFVWwfKvwHA1x8t2G5spvUNl2nK1UW7mnd856rjsf3dLR
         cVC9quB6af5e9ZLkTsXYu6OdETE/p96zAJxqbea3TgtxAbY/7WjX/FNIXX2axuB1UWNE
         E5HA==
X-Gm-Message-State: ALoCoQlkc/lW5u8B8autFaOyNT4giFjYxGFnmGhY/U5yxRvXxZeuZC/9bI5DEtWMXmDK+npAfCM7cjOJFN9UJAU0ZSggLMc/q2n6ZKgLCuPm+o3KV4HF8bYrc5kzgeaUYxmG1+dsNsPaHX/f8bik8pZAPdLb5v2/k/hUfDY1EtEB5g33sbXtQwv7m6J3XrY1GZqmoI5hBELX
X-Received: by 10.182.128.166 with SMTP id np6mr4967670obb.16.1398120815171;
        Mon, 21 Apr 2014 15:53:35 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g21si5368243yhe.3.2014.04.21.15.53.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 071615A4207;
	Mon, 21 Apr 2014 15:53:35 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 96598E06AA; Mon, 21 Apr 2014 15:53:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246662>

This patch series changes most of the places where the ref functions for
locking and writing refs to instead use the new ref transaction API. There
are still three more places where write_ref_sha1() is called from outside
of refs.c but those all will require more complex work and review so those
changes belong in a different patch series.

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


Ronnie Sahlberg (13):
  refs.c: constify the sha arguments for
    ref_transaction_create|delete|update
  refs.c: use a single exit path from transaction commit and handle
    onerr
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
  walker.c: use ref transaction for ref updates
  refs.c: change update_ref to use a transaction

 branch.c             | 16 ++++++----
 builtin/commit.c     | 23 +++++++-------
 builtin/replace.c    | 13 ++++----
 builtin/tag.c        | 11 +++----
 builtin/update-ref.c | 19 +++++++-----
 fast-import.c        | 23 +++++++++-----
 refs.c               | 84 +++++++++++++++++++++++++++++++++++++++-------------
 refs.h               | 25 ++++++++--------
 sequencer.c          | 17 ++++++++---
 walker.c             | 45 +++++++++++++---------------
 10 files changed, 172 insertions(+), 104 deletions(-)

-- 
1.9.1.515.g3b87021
