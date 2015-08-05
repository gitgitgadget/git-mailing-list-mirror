From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/3] fix repo name when cloning a server's root
Date: Wed,  5 Aug 2015 12:06:16 +0200
Message-ID: <1438769179-5943-1-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
Cc: sunshine@sunshineco.com, ps@pks.im, peff@peff.net,
	pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 12:06:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMvag-0003jI-5g
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 12:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbbHEKGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 06:06:25 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52777 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751073AbbHEKGY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 06:06:24 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 48CAB207D4
	for <git@vger.kernel.org>; Wed,  5 Aug 2015 06:06:24 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 05 Aug 2015 06:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Er0l
	mjvlY90G0gzZCoJhfcki2OQ=; b=mbW15zdM06gnKzE/T10wowIXMq0D2rhX3xEo
	jmKW9+d5Z7hyVrfNHj/iC327+8GQno0uOJZj9YGwB6f3vsJW5GqMv7fAD6B7TvHl
	fl3OS7Ozv8yhAO6wwae4kBGMSHZRBOhXUhMWuqYkIALF4/7WEjTTK2Jf1YDwU6SB
	hJ2Q4jk=
X-Sasl-enc: +7yNUahTHglLI6fIEFCjDbB1ajixcsOOk9ykvirnx0LK 1438769183
Received: from localhost (x5ce10e86.dyn.telefonica.de [92.225.14.134])
	by mail.messagingengine.com (Postfix) with ESMTPA id DC7E7C00012;
	Wed,  5 Aug 2015 06:06:23 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1437997708-10732-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275363>

This is version 4 of my patch series, which aims to improve
guessed directory names when we clone a server's root, that is we
have empty path components.

This version is still preliminary as it is based upon the patches
by Peff ([PATCH 0/2] fix clone guess_dir_name regression in
v2.4.8) which have not been merged yet.

As his patches include newly added tests that allow for cloning
from a server's root without using chroot, the patches regarding
t1509 have been dropped. I've posted the fixes to them as a
separate patch series instead.

Previously I've included a guard such that we only try to find
the last component if we've got a '/' or ':' in the path. This is
not really required, though, as in the case where we ain't got
one of those characters we'll simply skip to the beginning again,
causing this to be a no-op, due to the port already being
stripped. So I've simply dropped the guard to minimize code
churn.

Patrick Steinhardt (3):
  clone: do not include authentication data in guessed dir
  clone: do not use port number as dir name
  clone: abort if no dir name could be guessed

 builtin/clone.c          | 61 ++++++++++++++++++++++++++++++++++++++++--------
 t/t5603-clone-dirname.sh | 10 ++++++--
 2 files changed, 59 insertions(+), 12 deletions(-)

-- 
2.5.0
