From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH] Fixed compilation with Visual Studio by including poll.h
Date: Fri, 20 Apr 2012 22:37:19 +0200
Message-ID: <4F91C8FF.7070402@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 22:39:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLKcK-0008TF-QK
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 22:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab2DTUjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 16:39:40 -0400
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:45313 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751452Ab2DTUjj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2012 16:39:39 -0400
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id BF1FE28A4DF;
	Fri, 20 Apr 2012 22:37:15 +0200 (CEST)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id A6B0227E792;
	Fri, 20 Apr 2012 22:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:content-type
	:content-transfer-encoding; s=dkim1; bh=j6/xpkFhiAhEZuVsxny3SLe2
	n8k=; b=wTRKdwngrf3rF6bnUkduwDmx9sscikSuxKc6pDaeNpixMCoaSIJH4Ejc
	b+c8VRBNW96v+E7G7vdlkNOjgd1xYyGPah4jn7e1FZ7xZzvIgRJszHzxewlUsdp0
	YGgcBpvSC8VKT8PF4NnH8GxdvLNbjTGkw9y7d+tgKiy3a/leOcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:content-type
	:content-transfer-encoding; q=dns; s=dkim1; b=Rbvevy65ea9pTAzH0a
	ZKHM16fpdOCrCc7w3HrW2hvJvv+g3LwX/xrwE7EInb+M99IY7aYRbAtIW4m+YgBq
	ZxUoO798b+owAvyp2gV2pECnLb+9bGeK1QBaCC/1um7H6bqNu81CJ6dsWnF+qytn
	w3ybs52nd4n9H8JOhS0hkA4WA=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 43288272EDE;
	Fri, 20 Apr 2012 22:37:15 +0200 (CEST)
Received: from [91.3.185.188] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 31003671; Fri, 20 Apr 2012 22:37:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
X-Enigmail-Version: 1.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, BODY_SIZE_900_999 0, __ANY_URI 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196022>

upload-archive.c and upload-pack.c use pollfd struct and POLLIN constant
which are defined in poll.h. However, poll.h is not included.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 builtin/upload-archive.c |    1 +
 upload-pack.c            |    1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index b928beb..6226bbb 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2006 Franck Bui-Huu
  */
+#include "poll.h"
 #include "cache.h"
 #include "builtin.h"
 #include "archive.h"
diff --git a/upload-pack.c b/upload-pack.c
index bb08e2e..79f9f8f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,3 +1,4 @@
+#include "poll.h"
 #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
