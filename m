From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: [PATCH] Add mkdtemp() workaround for Sun Solaris 10
Date: Fri, 16 Nov 2007 19:59:58 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711161954510.7139@bianca.dialin.t-online.de>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
 <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
 <Pine.LNX.4.64.0711152253430.4090@bianca.dialin.t-online.de>
 <7v640340kp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 20:00:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It6QR-0001Lx-Kq
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 20:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbXKPTAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 14:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXKPTAG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 14:00:06 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46434 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751890AbXKPTAE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 14:00:04 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 5F24847830;
	Fri, 16 Nov 2007 14:00:02 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 16 Nov 2007 14:00:02 -0500
X-Sasl-enc: BNP+qSWHzddXvAHHgILCTLcBoMWGSILf8x2tgLcr3Et0 1195239601
Received: from [192.168.2.101] (p549A35AE.dip0.t-ipconnect.de [84.154.53.174])
	by mail.messagingengine.com (Postfix) with ESMTP id 5C3A62A68F;
	Fri, 16 Nov 2007 14:00:01 -0500 (EST)
In-Reply-To: <7v640340kp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65241>

On Thu, 15 Nov 2007, Junio C Hamano wrote:
> Are there problems with the implementation in compat/ directory, we ship 
> specifically to help platforms without mkdtemp()?

I checked again and the answer is 'yes'. The reason is trivial - for 
Solaris 10 the workaround is not activated and my version of Solaris 10 
(Sparc) has no mkdtemp() in libc.so.

The following patch should fix this:

Activate mkdtemp() workaround for Solaris 10.

Signed-off-by: Guido Ostkamp <git@ostkamp.fastmail.fm>
---
  Makefile |    3 +++
  1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index e830bc7..9dc01df 100644
--- a/Makefile
+++ b/Makefile
@@ -431,6 +431,9 @@ ifeq ($(uname_S),SunOS)
  		NO_C99_FORMAT = YesPlease
  		NO_STRTOUMAX = YesPlease
  	endif
+	ifeq ($(uname_R),5.10)
+		NO_MKDTEMP = YesPlease
+	endif
  	INSTALL = ginstall
  	TAR = gtar
  	BASIC_CFLAGS += -D__EXTENSIONS__
-- 
1.5.3.5.721.g039b
