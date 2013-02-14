From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/5] gpg_interface: use the status
Date: Thu, 14 Feb 2013 17:04:41 +0100
Message-ID: <cover.1360857415.git.git@drmicha.warpmail.net>
References: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
Cc: Mariusz Gronczewski <xani666@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 17:05:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U61JC-0004kJ-Iy
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 17:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761282Ab3BNQEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 11:04:46 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41203 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758047Ab3BNQEq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2013 11:04:46 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EC4CE2046B;
	Thu, 14 Feb 2013 11:04:44 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 14 Feb 2013 11:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=nYLnnj0eFv9aU0/xF4PzaQmfP
	qU=; b=GoQ6gpHB1Gu6wBa+CVUaZjUKdMqUGxIRv8m6dDooS+JA2gZRfeOyQ3dDj
	Wzpog9uoy+SEbPEM400EdPET6EMj7lSSJc7vJAIKHoUUAwrmFT4suLRwefCoujUX
	ZsgbqZflfdiviJaYuWvAG6g9BmncbV4VTJxvHVF9xiqZfvgxbs=
X-Sasl-enc: zQKKXc83qsUK9NkVGVshflzHrKlCMW4ouaSTVUsSy+KL 1360857884
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8E77F482564;
	Thu, 14 Feb 2013 11:04:44 -0500 (EST)
X-Mailer: git-send-email 1.8.1.3.797.ge0260c7
In-Reply-To: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216311>

Currently, we look at the user facing output of gpg, which is LANG dependent as
well as insecure.

After this series, we look at the status output (--status-fd) which is designed
for that purpose. As an additional benefit, we can read off the key which was used
for the signature, which is important for assigning trust.

All existing tests pass with this.

BTW: git branch --set-upstream-to= coredumps when on a detached head.

Michael J Gruber (5):
  gpg-interface: check good signature in a reliable way
  log-tree: rely upon the check in the gpg_interface
  gpg_interface: allow to request status return
  pretty: parse the gpg status lines rather than the output
  pretty: make %GK output the signing key for signed commits

 Documentation/pretty-formats.txt |  1 +
 builtin/fmt-merge-msg.c          |  2 +-
 builtin/verify-tag.c             |  2 +-
 gpg-interface.c                  | 18 +++++++++++++++---
 gpg-interface.h                  |  2 +-
 log-tree.c                       | 27 ++++++++++++---------------
 pretty.c                         | 19 +++++++++++++++----
 7 files changed, 46 insertions(+), 25 deletions(-)

-- 
1.8.1.3.797.ge0260c7
