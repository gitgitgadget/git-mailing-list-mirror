From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/9] --left/right-only and --cherry-mark
Date: Mon,  7 Mar 2011 13:31:34 +0100
Message-ID: <cover.1299499429.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 13:35:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwZeh-0003M8-Gs
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 13:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab1CGMfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 07:35:12 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45958 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751049Ab1CGMfL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 07:35:11 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D00F320832;
	Mon,  7 Mar 2011 07:35:10 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 07 Mar 2011 07:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=vkLtk4ZdZnw56kcdmmGmusipDo8=; b=pLdXBuN3UJB0yq7f8PMgwbDVkDVYhMf9b2fF3s31Rl26Dy845i1H0mul1Umn2pxkjVS7pG+AUNAsikm0Cfu+Goc76OlqSIg0DNyFOWBGwjhr8Tdqo66od2r9ldCEpmjNwtATRPen9/89splUPORrOW2sTpQEJQK/c7bi4pP0SAw=
X-Sasl-enc: aa21rDhzFQ6rG6FmdWQn6Vo0R0URYqo04Pn81l9abQo/ 1299501310
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 50CEF402C64;
	Mon,  7 Mar 2011 07:35:10 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.299.g567d7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168580>

This is a replacement for mg/rev-list-one-side-only in pu.
The --left/right-only related commits (1-4/9) are unchanged.

5/9 is new and refactors the generation of commit marks (<>-) which we
currently do in 5 places, to ease maintenance and extensibility.

6,7 are new and introduce "--cherry-mark" to the revision walker which marks
those commits which "--cherry-pick" would omit.

8,9 are amended as compared to pu, introducing "--cherry" as a shortcut for
"--cherry-mark --right-only --no-merges" to produce output much like "git
cherry" with the full flexibility of rev-list/log. (We could use the previous
version instead, or with a different synonym; or introduce rev-list-option
aliases...)

The mark for patch-equivalent commits is '=' because git-cherry's '-' is used
for boundary commits already.

The mark for non-equivalent commits is '+' (following git-cherry), or '<'/'>'
with --left-right, or '*' with --graph.

This is up for bike-shed^W^Wdiscussing - we could use ' ' instead or even '*'
also without --graph, or '+' even with --graph.

I would in fact prefer ' ' without --graph and '*' with --graph, which would
make it even more different from git-cherry's output, though.
(Personally, I never liked git-cherry's output anyways.)

This is also the base for refactoring git-format-patch and git-cherry, of
course, where the latter would be helped if it's ok to change the output
format.

Junio C Hamano (1):
  rev-list: --left/right-only are mutually exclusive

Michael J Gruber (8):
  revlist.c: introduce --left/right-only for unsymmetric picking
  t6007: Make sure we test --cherry-pick
  rev-list: documentation and test for --left/right-only
  rev-list/log: factor out revision mark generation
  revision.c: introduce --cherry-mark
  rev-list: documentation and test for --cherry-mark
  log --cherry: a synonym
  t6007: test rev-list --cherry

 Documentation/git-rev-list.txt       |    3 +
 Documentation/rev-list-options.txt   |   26 ++++++++
 builtin/rev-list.c                   |   14 +----
 graph.c                              |   17 +-----
 log-tree.c                           |   28 +-------
 pretty.c                             |    6 +--
 revision.c                           |   74 +++++++++++++++++++++-
 revision.h                           |    7 ++-
 t/t6007-rev-list-cherry-pick-file.sh |  113 +++++++++++++++++++++++++++++++---
 9 files changed, 220 insertions(+), 68 deletions(-)

-- 
1.7.4.1.299.g567d7.dirty
