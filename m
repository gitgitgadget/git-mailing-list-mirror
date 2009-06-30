From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] attr: plug minor memory leak
Date: Wed, 01 Jul 2009 00:30:00 +0200
Message-ID: <4A4A91E8.6060604@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 01 00:41:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward1.uio.no ([129.240.10.70])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLm0a-0007Th-8Y
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 00:41:00 +0200
Received: from exim by mail-out1.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLlqD-0000Ew-Uy
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 00:30:17 +0200
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out1.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLlqD-0000Et-Tv
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 00:30:17 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx3.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLlqD-00034m-1u
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 00:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbZF3WaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbZF3WaF
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 18:30:05 -0400
Received: from india601.server4you.de ([85.25.151.105]:43954 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbZF3WaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 18:30:04 -0400
Received: from [10.0.1.101] (p57B7D23C.dip.t-dialin.net [87.183.210.60])
	by india601.server4you.de (Postfix) with ESMTPSA id 98C302F8068;
	Wed,  1 Jul 2009 00:30:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: 647597FF86CC386D8F11353CC7CB7E108F6FAFD1
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 112 total 2549203 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122549>

Free the memory allocated for struct strbuf pathbuf when we're done.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 attr.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/attr.c b/attr.c
index f8f6faa..55bdb7c 100644
--- a/attr.c
+++ b/attr.c
@@ -555,6 +555,8 @@ static void prepare_attr_stack(const char *path, int dirlen)
 		}
 	}
 
+	strbuf_release(&pathbuf);
+
 	/*
 	 * Finally push the "info" one at the top of the stack.
 	 */
-- 
1.6.3.3
