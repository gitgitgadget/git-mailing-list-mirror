From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] DT_UNKNOWN: do not fully trust existence of DT_UNKNOWN
Date: Fri, 20 Jan 2006 11:10:59 -0800
Message-ID: <7vzmlqaf5o.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
	<7voe277lbe.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0601200701n76f1d912y4671c6800735cd0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christopher Faylor <me@cgf.cx>
X-From: git-owner@vger.kernel.org Fri Jan 20 20:14:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F01h6-0004m8-QC
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 20:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWATTLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 14:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWATTLG
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 14:11:06 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:50310 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932093AbWATTLB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 14:11:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060120190945.EFKC6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 Jan 2006 14:09:45 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0601200701n76f1d912y4671c6800735cd0d@mail.gmail.com>
	(Alex Riesen's message of "Fri, 20 Jan 2006 16:01:46 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14976>

Alex Riesen <raa.lkml@gmail.com> writes:

> On 1/20/06, Junio C Hamano <junkio@cox.net> wrote:
>> The recent Cygwin defines DT_UNKNOWN although it does not have d_type
>> in struct dirent.  Give an option to tell us not to use d_type on such
>> platforms.  Hopefully this problem will be transient.
>
> You still have to #undef all the DT_ macros if you have a somewhat old Cygwin
> (before Christopher removed the macros).
> -

Ah, you mean something like this?

-- >8 --
diff --git a/cache.h b/cache.h
index 8339931..6f13434 100644
--- a/cache.h
+++ b/cache.h
@@ -13,6 +13,10 @@
 #if defined(DT_UNKNOWN) && !NO_D_TYPE_IN_DIRENT
 #define DTYPE(de)	((de)->d_type)
 #else
+#undef DT_UNKNOWN
+#undef DT_DIR
+#undef DT_REG
+#undef DT_LNK
 #define DT_UNKNOWN	0
 #define DT_DIR		1
 #define DT_REG		2
