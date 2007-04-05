From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH] Avoid composing too long "References" header.
Date: Fri, 06 Apr 2007 08:50:24 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20070406.085024.18669509.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Apr 06 01:49:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZbhv-0003HQ-ME
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 01:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767447AbXDEXtc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 19:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767448AbXDEXtc
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 19:49:32 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:40353 "EHLO
	yue.st-paulia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767447AbXDEXtb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 19:49:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP id BE4E133B40;
	Fri,  6 Apr 2007 08:50:25 +0900 (JST)
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43886>

The number of characters in a line MUST be no more than 998 characters,
and SHOULD be no more than 78 characters (RFC2822).
It is much safer to fold the header by ourselves.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/git-send-email.perl b/git-send-email.perl
index ae50990..1278fcb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -595,7 +595,7 @@ foreach my $t (@files) {
 	if ($chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
-			$references .= " $message_id";
+			$references .= "\n $message_id";
 		} else {
 			$references = "$message_id";
 		}

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
