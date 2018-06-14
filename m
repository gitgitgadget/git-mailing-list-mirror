Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C936D1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 22:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965107AbeFNWyv (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 18:54:51 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:55769 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965093AbeFNWyr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 18:54:47 -0400
Received: by mail-qt0-f202.google.com with SMTP id f8-v6so5862599qtj.22
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 15:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Y18b1+w8UfPe6MC336HVeoRGpUUPowBYRydANKUDr2M=;
        b=mUUroeQCsoXw7ufwhe80HmC0FNtaxGV6FeGb9gG0DAV6ifkEBbQrxSLB+P1woMO9jK
         CIPN3p/ziMU+2zrNgAI7B9Noo/FGaPuC25eig5WcCBPXggNdeIfwwISgbh7jFgavq2z9
         hiKkf+fMO/y34bT1ehMOndntALGnk0yg1npK4/If46mUU5V7hjZy3eg0pGgkMWPCAfxx
         3Au2NDKh6f6bLKTJXMunuHBfPLIhvuaNQOawv3z1T3LznOxrqb3T7Ww5dqae37c2kOla
         uc7itFSxN7PFaM1oCHbDF4moCNM2g2RitLrQhoPF0XOjpi0W7IX6T5xC2+dgUuUrJMTe
         dc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Y18b1+w8UfPe6MC336HVeoRGpUUPowBYRydANKUDr2M=;
        b=NYQDCnytFfWwNyCU9ED2hIhZgkwAp11mbEekE1wD0Bhn7FNZw36w3zxoScPSO2rry2
         cBIMKnD2RKoq+6zmCJL0hdDmEGePQR+lcseKsb/JXN91lLZZ7y+8sPXzJRng9T0WEQ5D
         tqPty4sa7p/KD+3KfbyR+Im87Q3TtO9n+neDURdnppvXowQnxdOHbNXuQDlO/dagyoRi
         4WCz4GMiGQFKxgxni3b2B+OpcRCgN4ugcY3BIAtZuVqHQ6K4o52Pu7SN+ihy0MLoK2J2
         bbRqpUutIYIukLZAZm0x+aK6843/FwasfuUZT+GexerzyuDp9kRgbXUx6Yauv7ojXyw5
         KpXQ==
X-Gm-Message-State: APt69E1X+YHQe91eFd+8GaMgBNuHTh+I8kxYe5yQYPTePNz9Wfg3t1FL
        PMbWPbQA2jGS3xOZzIvYuhOUOi4QUxsdYgR74ogUMr0NxD3ZMFICx/XMlnagt+VASe/P/Ln8pyR
        jG/fTGdR+1E248pD+HeBJn2l8iftd2BVfPW7swAIr+AIv/cQPlhRVxN5K9/PyIhk3kqNOf1Xday
        Qh
X-Google-Smtp-Source: ADUXVKKGUt/ojbsmyI24mpanBd5olQ3PzXe4H9jbOk/uhJDtTPEiJE/mXTO9mVcS0yJoQLC0EKSRvxD5Svm7+dC/LnGQ
MIME-Version: 1.0
X-Received: by 2002:a0c:d2a2:: with SMTP id q31-v6mr2295672qvh.45.1529016886462;
 Thu, 14 Jun 2018 15:54:46 -0700 (PDT)
Date:   Thu, 14 Jun 2018 15:54:27 -0700
In-Reply-To: <cover.1529016350.git.jonathantanmy@google.com>
Message-Id: <97f9a133e409f0fa898132a6f972e564db522dbf.1529016350.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1529016350.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4
Subject: [PATCH v3 6/7] fetch-pack: move common check and marking together
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When receiving 'ACK <object-id> continue' for a common commit, check if
the commit was already known to be common and mark it as such if not up
front. This should make future refactoring of how the information about
common commits is stored more straightforward.

No visible change intended.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 473e415c5..fb76d4017 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -505,11 +505,14 @@ static int find_common(struct negotiation_state *ns,
 				case ACK_continue: {
 					struct commit *commit =
 						lookup_commit(result_oid);
+					int was_common;
 					if (!commit)
 						die(_("invalid commit %s"), oid_to_hex(result_oid));
+					was_common = commit->object.flags & COMMON;
+					mark_common(ns, commit, 0, 1);
 					if (args->stateless_rpc
 					 && ack == ACK_common
-					 && !(commit->object.flags & COMMON)) {
+					 && !was_common) {
 						/* We need to replay the have for this object
 						 * on the next RPC request so the peer knows
 						 * it is in common with us.
@@ -526,7 +529,6 @@ static int find_common(struct negotiation_state *ns,
 					} else if (!args->stateless_rpc
 						   || ack != ACK_common)
 						in_vain = 0;
-					mark_common(ns, commit, 0, 1);
 					retval = 0;
 					got_continue = 1;
 					if (ack == ACK_ready)
-- 
2.17.0.582.gccdcbd54c4

