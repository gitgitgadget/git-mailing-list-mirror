From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 00/17] ref-transaction-rename
Date: Mon,  3 Nov 2014 11:02:02 -0800
Message-ID: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:02:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMtZ-0001PP-Re
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbaKCTCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:25 -0500
Received: from mail-ob0-f202.google.com ([209.85.214.202]:49566 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbaKCTCY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:24 -0500
Received: by mail-ob0-f202.google.com with SMTP id uz6so804616obc.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Bqay7+yjfMH1P/eWe0jSr8ERKFvwyCuVAej3w7sCIFw=;
        b=aJIg3N5+CoQU8aylSRB10wPcBN7DuCXqgnygUmh8CIQbV63553Ut2G9EVTjcStCgKo
         QE2rtGusmFOBwBI+PkZXSux3aBirBSxhXmtX77C9Dn2trs4hCoqTrBJ+uhjbN2hcedIB
         L6wxKMrvLr5PGGpVwc5Pmm6Oi+G+nCiV4lWGoCE6lnYb00laM1elSgVdZHwNNTrnxfK5
         HShNqjW6ngkv5WJxihgJoSTuWLlHukwRgB6Tt0i/52swBmNaI8I958Uw4SJhj7b1r/7U
         FYQNdMGmnXXiLgHPPL4CURJvoyneAI+PvMot6QddxGv0zy7mrKpKW2pcBvfP0kgpYBrE
         xmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bqay7+yjfMH1P/eWe0jSr8ERKFvwyCuVAej3w7sCIFw=;
        b=gDr2NIbgAPYL2nKdfExYxqwQUhUCPdHPwugZF72xEt6LdzyH27u3ClcHMTAvcgX4qv
         DLPtYOT1i/fgFxe5Lzs/EwM10KzAfPwZbMKg9TO/aVxG4afZbGXX+2Ot440bViuUUpkp
         AWsA5L7BjoHuWp02KcxDxiWc+HQWK8H+XBXwsohUccU+hXS3CfXNBkIE54bFjS70OT0z
         fNAVB08jGe79hqvnAwyA10aVrFS6f+8xYQ2BzdOasy/p2/fztokJc9wrFk/yRmwE9b2j
         w10yE0dLGLKL/Dxmx8Q72cEwsubAcYRu86KtrCzvKvli2Qok6zO1el/rRdtYgh9e7zbP
         CBig==
X-Gm-Message-State: ALoCoQkcm4FRNwuk/ronQ7J5FmfXILjceQA02hhHvnl1EnigugtaiyzKjSozNCRMsqsOqRh++00c
X-Received: by 10.42.245.5 with SMTP id ls5mr33789570icb.7.1415041343322;
        Mon, 03 Nov 2014 11:02:23 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 5si167257yhd.6.2014.11.03.11.02.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:23 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id WEEXFm37.1; Mon, 03 Nov 2014 11:02:23 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 811BEE0F37; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

List,

Thsi series builds on the previous series : ref-transaction-reflog
as applied to next. This series has been sent to the list before
but is now rebased to current git next.

This series can also be found at :
https://github.com/rsahlberg/git/tree/ref-transactions-rename

This series converts ref rename to use a transaction. This addesses several
issues in the old implementation, such as colliding renames might overwrite
someone elses reflog, and it makes the rename atomic.

As part of the series we also move changes that cover multiple refs to happen
as an atomic transaction/rename to the pacekd refs file. This makes it possible
to have both the rename case (one deleted ref + one created ref) as well
as any operation that updates multiple refs to become one atomic rename()
applied to the packed refs file. Thus all such changes are now also atomic
to all external observers.

Version 2:
- Changed to not use potentially iterators to copy the reflog entries one
  by one. Instead adding two new functions. One to read an existing reflog
  as one big blob, and a second function to, in a transaction, write a new
  complete reflog from said blob.
  The idea is that each future reflog backend will provide optimized
  versions for these "read whole reflog" "write whole reflog" functions.

Ronnie Sahlberg (17):
  refs.c: allow passing raw git_committer_info as email to
    _update_reflog
  refs.c: return error instead of dying when locking fails during
    transaction
  refs.c: use packed refs when deleting refs during a transaction
  refs.c: use a stringlist for repack_without_refs
  refs.c: add transaction support for replacing a reflog
  refs.c: add new function copy_reflog_into_strbuf
  refs.c: update rename_ref to use a transaction
  refs.c: rollback the lockfile before we die() in repack_without_refs
  refs.c: move reflog updates into its own function
  refs.c: write updates to packed refs when a transaction has more than
    one ref
  remote.c: use a transaction for deleting refs
  refs.c: make repack_without_refs static
  refs.c: make the *_packed_refs functions static
  refs.c: replace the onerr argument in update_ref with a strbuf err
  refs.c: make add_packed_ref return an error instead of calling die
  refs.c: make lock_packed_refs take an err argument
  refs.c: add an err argument to pack_refs

 builtin/checkout.c    |   7 +-
 builtin/clone.c       |  36 ++-
 builtin/merge.c       |  20 +-
 builtin/notes.c       |  24 +-
 builtin/pack-refs.c   |   8 +-
 builtin/reflog.c      |  19 +-
 builtin/remote.c      |  69 +++---
 builtin/reset.c       |  12 +-
 builtin/update-ref.c  |   7 +-
 notes-cache.c         |   2 +-
 notes-utils.c         |   5 +-
 refs.c                | 618 ++++++++++++++++++++++++++++++--------------------
 refs.h                |  87 ++++---
 t/t3200-branch.sh     |   7 -
 t/t5516-fetch-push.sh |   2 +-
 transport-helper.c    |   7 +-
 transport.c           |   9 +-
 17 files changed, 562 insertions(+), 377 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5
