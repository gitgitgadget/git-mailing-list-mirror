From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/4] Don't warn about missing EOL for symlinks
Date: Thu,  3 Jun 2010 16:35:19 +0200
Message-ID: <cover.1275575236.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 16:35:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKBWU-0004yS-Gu
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 16:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398Ab0FCOfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 10:35:45 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:39653 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753767Ab0FCOfp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 10:35:45 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8F88EF8E69
	for <git@vger.kernel.org>; Thu,  3 Jun 2010 10:35:44 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 03 Jun 2010 10:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=5yiGGO7fTqFxMPQZ/XseyylmI8g=; b=s048dv4SHgnc1n/G1FB8dkqJlXLpTLBMeTGCnKW1tkylC34v6BvWVFPkoqSaOfrjdkgSVx63gzUMfWLvHHaqsYw1L56sH99thZ1pYgQVuxBJyXlNa1Vdy2MWmsUOTo/G6E8FDkMSz1fzYNLLphnxYKDzocsjKSLaRZo/TO3uQlE=
X-Sasl-enc: QlJgR28/g1cOqT43UZX4d9b9uHgDgIA5avZB3Z118RMB 1275575743
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EF19A4D45EE;
	Thu,  3 Jun 2010 10:35:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.351.ge2633e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148321>

"No newline at end of file" always confuses me when looking at a diff for
symlinks. "File? Huh? Didn't Git recognize my symlink?"

This mini series refactors the diff/xdiff code slightly to have the two
occurences of the warning both in diff.c, introduces a whitespace flag
WS_NO_EOL_AT_EOF to make this warning configurable, and actually changes
the default behaviour to what is described thorougly along with the
rationale in 3/4.

4/4 is a RFC - do we need to tweak this from config like other whitespace
warnings? 4/4 is lacking the Doc change for now.

Michael J Gruber (4):
  diff/xdiff: refactor EOF-EOL detection
  diff: make treatment of missing EOL at EOF configurable
  diff: Do not warn about missing EOL at EOF for symlinks
  RFC: add whitespace rule for no-eol-at-eof

 cache.h                  |    3 ++-
 diff.c                   |    7 ++++++-
 t/t4030-diff-textconv.sh |    1 -
 ws.c                     |    1 +
 xdiff/xutils.c           |    5 -----
 5 files changed, 9 insertions(+), 8 deletions(-)
