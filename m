From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a compat/strtoumax.c for Solaris 8.
Date: Mon, 19 Feb 2007 18:20:05 -0800
Message-ID: <7vfy9136zu.fsf@assigned-by-dhcp.cox.net>
References: <17777.1171930976@lotus.CS.Berkeley.EDU>
	<20070220003533.GB28314@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 03:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJKc0-0003Bb-IZ
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 03:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbXBTCUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 21:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbXBTCUI
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 21:20:08 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48482 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932781AbXBTCUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 21:20:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220022006.BRTQ1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 21:20:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ReL51W0011kojtg0000000; Mon, 19 Feb 2007 21:20:05 -0500
In-Reply-To: <20070220003533.GB28314@spearce.org> (Shawn O. Pearce's message
	of "Mon, 19 Feb 2007 19:35:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40199>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Jason Riedy <ejr@EECS.Berkeley.EDU> wrote:
>> Solaris 8 was pre-c99, and they weren't willing to commit to
>> the strtoumax definition according to /usr/include/inttypes.h.
>> 
>> This adds NO_STRTOUMAX and NO_STRTOULL for ancient systems.
>> If NO_STRTOUMAX is defined, the routine in compat/strtoumax.c
>> will be used instead.  That routine passes its arguments to
>> strtoull unless NO_STRTOULL is defined.  If NO_STRTOULL, then
>> the routine uses strtoul (unsigned long).
>
> Ack'd (this and the fast-import patch that follows).
>
> This is a better version than the patch I sent out last night,
> so Junio please drop my patch in favor of Jason's.

Yours talk about Sol 9 and Jason talks about Sol 8.  Should I
take your ack to mean you want this patch on top of Jason's?

diff --git a/Makefile b/Makefile
index 821996f..f85fb7c 100644
--- a/Makefile
+++ b/Makefile
@@ -358,16 +358,17 @@ ifeq ($(uname_S),SunOS)
 		NO_SETENV = YesPlease
 		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
 	ifeq ($(uname_R),5.9)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 		NO_C99_FORMAT = YesPlease
+		NO_STRTOUMAX = YesPlease
 	endif
 	INSTALL = ginstall
 	TAR = gtar
 	BASIC_CFLAGS += -D__EXTENSIONS__
 endif
 ifeq ($(uname_O),Cygwin)
 	NO_D_TYPE_IN_DIRENT = YesPlease
 	NO_D_INO_IN_DIRENT = YesPlease
