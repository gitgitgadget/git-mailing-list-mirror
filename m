From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 0/4] verify-commit: verify commit signatures
Date: Fri, 27 Jun 2014 16:13:22 +0200
Message-ID: <cover.1403877430.git.git@drmicha.warpmail.net>
References: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 16:13:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0WuF-0007Nn-IC
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 16:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbaF0ONb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 10:13:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32988 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753469AbaF0ONb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2014 10:13:31 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 76EE521F60
	for <git@vger.kernel.org>; Fri, 27 Jun 2014 10:13:28 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 27 Jun 2014 10:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=Kgb3GqjJUqGcKhTu3sguX1aIq
	eU=; b=UqdwuOK8MbW1ReULMV4AXiRH955TgT6LYxlbLVhV+KLyTBosfbwvzNLNq
	8BIGeqHaiWSLzC0XuKxM6O188t1inhuPTAOkhKWyOG7ETDiQfy3EoFU3y+jii03L
	AJsS2NiVk79yNCwxqNcf/lS55I3D54MZMnjty/IoEGLwknM2z8=
X-Sasl-enc: J2QfUqJ8oAtyLj6asK0J80BkEx8uhI1NgAguWfSvfJrA 1403878407
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EDE2EC00003;
	Fri, 27 Jun 2014 10:13:27 -0400 (EDT)
X-Mailer: git-send-email 2.0.1.563.g162087b.dirty
In-Reply-To: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252552>

This is v3 rebased on current next (the %G works by Jeff & Junio).

Open questions:

- Should one of git verify-{commit,tag} learn how to verify mergetags?
(Probably no, it differs from both other cases.)

- Should we do this now or go for generic "git verify" right away?
That depends on whether signed commits need to be verified by scripts now,
or whether mergetags are more important.

For a general command which allows different verification policies,
I'm still wondering whether we may need hooks which receive all
the relevant information in the environment. Otherwise we'll have a ton of
options such as --match-committer-uid, --verify--AllParentsHaveMergeTags,
--verify--All-ParentsAreSignedCommits, --peel-to-commit, --merge-commit-only, ...

I imagine that a generic "git verify" would provide "git verify-{commit,tag}"
aliases which call "git verify" with options that reproduce the current (suggested)
behavior.

Michael J Gruber (4):
  gpg-interface: provide clear helper for struct signature_check
  gpg-interface: provide access to the payload
  verify-commit: scriptable commit signature verification
  t7510: test verify-commit

 Documentation/git-verify-commit.txt | 28 +++++++++++
 Makefile                            |  1 +
 builtin.h                           |  1 +
 builtin/merge.c                     |  5 +-
 builtin/verify-commit.c             | 93 +++++++++++++++++++++++++++++++++++++
 command-list.txt                    |  1 +
 commit.c                            |  1 +
 git.c                               |  1 +
 gpg-interface.c                     | 14 ++++++
 gpg-interface.h                     |  2 +
 pretty.c                            |  3 +-
 t/t7510-signed-commit.sh            | 20 +++++++-
 12 files changed, 163 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/git-verify-commit.txt
 create mode 100644 builtin/verify-commit.c

-- 
2.0.1.563.g162087b.dirty
