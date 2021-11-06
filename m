Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6EC433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CFA611C4
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhKFSwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 14:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbhKFSwm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 14:52:42 -0400
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA21C061210
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 11:50:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 67A5F19F4B5;
        Sat,  6 Nov 2021 19:49:57 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/10] init doc: --shared=0xxx does not give umask but perm bits
Date:   Sat,  6 Nov 2021 19:48:58 +0100
Message-Id: <20211106184858.11500-11-jn.avila@free.fr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211106184858.11500-1-jn.avila@free.fr>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <20211106184858.11500-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The description that 0640 makes sure that the group members can read
the repository is correct, but calling that octal number a <umask>
is wrong.  Let's call it <perm>, as the value is used to set the
permission bits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-init.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index af0d2ee182..42268ada22 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -79,7 +79,7 @@ repository.  If not specified, fall back to the default name (currently
 `master`, but this is subject to change in the future; the name can be
 customized via the `init.defaultBranch` configuration variable).
 
---shared[=(false|true|umask|group|all|world|everybody|<umask>)]::
+--shared[=(false|true|umask|group|all|world|everybody|<perm>)]::
 
 Specify that the Git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
@@ -110,15 +110,16 @@ the repository permissions.
 
 Same as 'group', but make the repository readable by all users.
 
-'<umask>'::
+'<perm>'::
 
-'<umask>' is an 3-digit octal number prefixed with `0` and each file
-will have mode '<umask>'. '<umask>' will override users' umask(2)
+'<perm>' is an 3-digit octal number prefixed with `0` and each file
+will have mode '<perm>'. '<perm>' will override users' umask(2)
 value (and not only loosen permissions as 'group' and 'all'
 does). '0640' will create a repository which is group-readable, but
 not group-writable or accessible to others. '0660' will create a repo
 that is readable and writable to the current user and group, but
-inaccessible to others.
+inaccessible to others (directories and executable files get their
+`x` bit from the `r` bit for corresponding classes of uses).
 --
 
 By default, the configuration flag `receive.denyNonFastForwards` is enabled
-- 
2.33.1

