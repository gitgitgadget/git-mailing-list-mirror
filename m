From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] Solaris portability
Date: Fri, 16 Nov 2007 16:33:38 -0800
Message-ID: <7vtznlww0t.fsf_-_@gitster.siamese.dyndns.org>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
	<1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
	<Pine.LNX.4.64.0711152253430.4090@bianca.dialin.t-online.de>
	<7v640340kp.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711161954510.7139@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn O Pearce <spearce@spearce.org>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Dennis Stosberg <dennis@stosberg.net>
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Sat Nov 17 01:34:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItBdM-00009b-IZ
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 01:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762650AbXKQAds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 19:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762006AbXKQAds
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 19:33:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45735 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761387AbXKQAdr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 19:33:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 121AA2EF;
	Fri, 16 Nov 2007 19:34:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A81296910;
	Fri, 16 Nov 2007 19:34:02 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711161954510.7139@bianca.dialin.t-online.de>
	(Guido Ostkamp's message of "Fri, 16 Nov 2007 19:59:58 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65257>

Guido Ostkamp <git@ostkamp.fastmail.fm> writes:

> On Thu, 15 Nov 2007, Junio C Hamano wrote:
>> Are there problems with the implementation in compat/ directory, we
>> ship specifically to help platforms without mkdtemp()?
>
> I checked again and the answer is 'yes'. The reason is trivial - for
> Solaris 10 the workaround is not activated and my version of Solaris
> 10 (Sparc) has no mkdtemp() in libc.so.

Thanks.

This makes me wonder if treating it just like strcasestr() might
be simpler.  Could folks with access to Solaris boxes of
different vintages please see if the attached patch makes sense?

Can we also unify UNSETENV, SETENV, C99_FORMAT and STRTOUMAX, by
the way? 


diff --git a/Makefile b/Makefile
index e830bc7..cabde81 100644
--- a/Makefile
+++ b/Makefile
@@ -412,26 +412,25 @@ endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease
 	SHELL_PATH = /bin/bash
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_HSTRERROR = YesPlease
+	NO_MKDTEMP = YesPlease
 	ifeq ($(uname_R),5.8)
 		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
-		NO_MKDTEMP = YesPlease
 		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
 	ifeq ($(uname_R),5.9)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
-		NO_MKDTEMP = YesPlease
 		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
 	INSTALL = ginstall
 	TAR = gtar
 	BASIC_CFLAGS += -D__EXTENSIONS__
 endif
