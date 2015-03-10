From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/2] log-tree: properly reset colors
Date: Tue, 10 Mar 2015 14:53:20 +0100
Message-ID: <0b167704d88ed6b7e8f950f0a05dd51b2b9c6406.1425995310.git.git@drmicha.warpmail.net>
References: <54FEC8D0.2060304@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Julien Cretel <j.cretel@umail.ucc.ie>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 14:53:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVKbB-0000ZU-7H
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 14:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbbCJNx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 09:53:27 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57965 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751716AbbCJNxZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 09:53:25 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id BFCBA20521
	for <git@vger.kernel.org>; Tue, 10 Mar 2015 09:53:22 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 10 Mar 2015 09:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=8WyQ26q3YjvZpv/RVL2hg7xcDGw=; b=ZFqpUurYc1Kq44I939xl
	K4VeCPO7YhvPO62242PhVMGLhEsFzvOo7mrqJ5I5WuZEQEJ4+TbQqmN6CGqyzHdg
	DLasRz+ieYUsBMz57fjnT6AHToM5w1CtKQNUt4NBaNNDRJAvTCpPIJbLPMCOgPVc
	8PlLjw15Xt//XO9gmxK36Iw=
X-Sasl-enc: lTh7WEKk6u1mNLDwu+ZY/+QzRGPmt1s6hzqTtHK8yAFt 1425995603
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DA3856801DC;
	Tue, 10 Mar 2015 09:53:23 -0400 (EDT)
X-Mailer: git-send-email 2.3.2.346.gb6960c9
In-Reply-To: <54FEC8D0.2060304@drmicha.warpmail.net>
In-Reply-To: <cover.1425995310.git.git@drmicha.warpmail.net>
References: <cover.1425995310.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265235>

Except for the separator, all output items reset the color immediately.
Do the same for the separator.

This affects only cases where setting color A does not override color B,
such as when one is forground and one background.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 log-tree.c                       |  1 +
 t/t4207-log-decoration-colors.sh | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7f0890e..53bb526 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -195,6 +195,7 @@ void format_decorations_extended(struct strbuf *sb,
 	while (decoration) {
 		strbuf_addstr(sb, color_commit);
 		strbuf_addstr(sb, prefix);
+		strbuf_addstr(sb, color_reset);
 		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
 		if (decoration->type == DECORATION_REF_TAG)
 			strbuf_addstr(sb, "tag: ");
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 925f577..6b8ad4f 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -44,15 +44,15 @@ test_expect_success setup '
 '
 
 cat >expected <<EOF
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_HEAD}HEAD${c_reset}${c_commit},\
- ${c_tag}tag: v1.0${c_reset}${c_commit},\
- ${c_tag}tag: B${c_reset}${c_commit},\
- ${c_branch}master${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_tag}tag: A1${c_reset}${c_commit},\
- ${c_remoteBranch}other/master${c_reset}${c_commit})${c_reset} A1
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_stash}refs/stash${c_reset}${c_commit})${c_reset}\
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}${c_commit},\
+ ${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit},\
+ ${c_reset}${c_tag}tag: B${c_reset}${c_commit},\
+ ${c_reset}${c_branch}master${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit},\
+ ${c_reset}${c_remoteBranch}other/master${c_reset}${c_commit})${c_reset} A1
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset}\
  On master: Changes to A.t
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
 EOF
 
 # We want log to show all, but the second parent to refs/stash is irrelevant
-- 
2.3.2.346.gb6960c9
