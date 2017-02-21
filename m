Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37516201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 01:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbdBUBKu (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 20:10:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53387 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750923AbdBUBKt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 20:10:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25498696BC;
        Mon, 20 Feb 2017 20:10:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=2iQw
        /ENrd5ENUzN/vkjF1Olo/8A=; b=hQfqu4RZciUdOr6CCi+LuEEvP524oApBTUpF
        Nh2lfFoO6Y+DNinBPib7+gxr2h3xKcT6tmU1KkuQ6I6rspm25xeNmtZ8fTNJm0ds
        lyW85jYIojwHmTe0YqnzmeK5MZ+mRXRcM9t+OOjUMGlCBXnvXoO45NnCm1zGeBl5
        ju6XFno=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10A31696BB;
        Mon, 20 Feb 2017 20:10:47 -0500 (EST)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52F7B696B9;
        Mon, 20 Feb 2017 20:10:46 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH v2 0/4] delete_ref: support reflog messages
Date:   Mon, 20 Feb 2017 20:10:31 -0500
Message-Id: <20170221011035.847-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170217035800.13214-1-kyle@kyleam.com>
References: <20170217035800.13214-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 931D045C-F7D2-11E6-8F3E-FE3F13518317-24757444!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=2iQw/ENrd5ENUzN/vkjF1Olo/8A=;
 b=RMZ4rRWGSxKFk7O6oWvp92zbwPH7oaf+01IZGDfvH6AeqkiJswYVYDLElMbrP57+H3HeszHOuupYe8ZBw7I91TPwPk66GL46gL9zEH82iJZ72tH/TRMbWZHpQj46c9PaZ1Yf/0F9iutfAbzXLTEDuS41+WZkdCJ/eWySdxwB7yo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Junio and Peff for their feedback on v1.

  https://public-inbox.org/git/20170217035800.13214-1-kyle@kyleam.com/T/#u

Changes from v1:

 * "msg" is now positioned as the first argument to delete_ref() to
   match update_ref().

   20170217081205.zn7j6d5cffgdvfbn@sigill.intra.peff.net

 * A "delete by head" test case has been added for the update-ref
   change.

   20170217082253.kxjezkxfqkfxjhzr@sigill.intra.peff.net

 * The added tests no longer send grep's output to /dev/null.

   20170217082253.kxjezkxfqkfxjhzr@sigill.intra.peff.net

 * Renaming the current branch is represented by two entries in HEAD's
   log, both which reuse the log message passed to rename_ref().
   
   20170217083112.vn7m4udsopmlvnn5@sigill.intra.peff.net,
   20170217195549.z6uyy7hbbhj5avh7@sigill.intra.peff.net

 * Corrected a few places in the commit messages where "delete_refs"
   was written instead of "delete_ref".


Kyle Meyer (4):
  delete_ref: accept a reflog message argument
  update-ref: pass reflog message to delete_ref()
  rename_ref: replace empty message in HEAD's log
  branch: record creation of renamed branch in HEAD's log

 branch.c               |  5 +++--
 branch.h               |  3 ++-
 builtin/am.c           |  4 ++--
 builtin/branch.c       |  7 ++++---
 builtin/notes.c        |  4 ++--
 builtin/remote.c       |  4 ++--
 builtin/replace.c      |  2 +-
 builtin/reset.c        |  2 +-
 builtin/symbolic-ref.c |  2 +-
 builtin/tag.c          |  2 +-
 builtin/update-ref.c   |  2 +-
 fast-import.c          |  2 +-
 refs.c                 |  6 +++---
 refs.h                 |  7 ++++---
 refs/files-backend.c   | 10 +++++-----
 t/t1400-update-ref.sh  | 18 ++++++++++++++++++
 t/t3200-branch.sh      |  6 ++++++
 transport.c            |  2 +-
 18 files changed, 58 insertions(+), 30 deletions(-)

-- 
2.11.1

