Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-0.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 17426 invoked by uid 107); 12 Jan 2009 23:09:45 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 12 Jan 2009 18:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbZALXJj (ORCPT <rfc822;peff@peff.net>);
	Mon, 12 Jan 2009 18:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbZALXJj
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 18:09:39 -0500
Received: from pan.madism.org ([88.191.52.104]:55812 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034AbZALXJi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 18:09:38 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 82F2E3F135;
	Tue, 13 Jan 2009 00:09:37 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0779E37498; Tue, 13 Jan 2009 00:09:36 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	git@vger.kernel.org
Cc:	Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Avoid spurious error messages on error mistakes.
Date:	Tue, 13 Jan 2009 00:09:36 +0100
Message-Id: <1231801776-20724-1-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.6.1.161.g5e07b.dirty
In-Reply-To: <20090112230228.GA28545@chistera.yi.org>
References: <20090112230228.GA28545@chistera.yi.org>
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Prior to that, if the user chose "squash" as a first action, the stderr
looked like:

    grep: /home/madcoder/dev/scm/git/.git/rebase-merge/done: No such file or directory
    Cannot 'squash' without a previous commit

Now the first line is gone.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c8b0861..8ed2244 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -349,7 +349,7 @@ do_next () {
 	squash|s)
 		comment_for_reflog squash
 
-		has_action "$DONE" ||
+		test -f "$DONE" && has_action "$DONE" ||
 			die "Cannot 'squash' without a previous commit"
 
 		mark_action_done
-- 
1.6.1.161.g5e07b.dirty

