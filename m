From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Install builtins with the user and group of the installing
 personality
Date: Mon, 23 Feb 2009 18:00:52 +0100
Message-ID: <49A2D644.6040106@viscovery.net>
References: <20090223155042.14806.qmail@518da7eef5d9e4.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 18:02:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbeCI-0007Ih-Op
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 18:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbZBWRA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 12:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253AbZBWRA7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 12:00:59 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19818 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbZBWRA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 12:00:58 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LbeAm-0005fd-SN; Mon, 23 Feb 2009 18:00:53 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9AADB6EF; Mon, 23 Feb 2009 18:00:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20090223155042.14806.qmail@518da7eef5d9e4.315fe32.mid.smarden.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111157>

Gerrit Pape schrieb:
> If 'make install' was run with sufficient privileges, then the installed
> builtins in gitexecdir, which are either hardlinked, symlinked, or copied,
> would receive the user and group of whoever built git.  With this commit the
> git-add program is installed using $(INSTALL), and subsequently linked or
> copied to the other builtins.
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>  Makefile |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index b040a96..7401603 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1467,9 +1467,7 @@ ifneq (,$X)
>  endif
>  	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
>  	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
> -	{ $(RM) "$$execdir/git-add$X" && \
> -		ln git-add$X "$$execdir/git-add$X" 2>/dev/null || \
> -		cp git-add$X "$$execdir/git-add$X"; } && \
> +	$(INSTALL) git-add$X "$$execdir" && \
>  	{ for p in $(filter-out git-add$X,$(BUILT_INS)); do \
>  		$(RM) "$$execdir/$$p" && \
>  		ln "$$execdir/git-add$X" "$$execdir/$$p" 2>/dev/null || \

I think the intent of the lines that you removed was actually this:

diff --git a/Makefile b/Makefile
index 27b9569..97087c3 100644
--- a/Makefile
+++ b/Makefile
@@ -1471,8 +1471,8 @@ endif
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 	{ $(RM) "$$execdir/git-add$X" && \
-		ln git-add$X "$$execdir/git-add$X" 2>/dev/null || \
-		cp git-add$X "$$execdir/git-add$X"; } && \
+		ln "$$bindir/git$X" "$$execdir/git-add$X" 2>/dev/null || \
+		cp "$$bindir/git$X" "$$execdir/git-add$X"; } && \
 	{ for p in $(filter-out git-add$X,$(BUILT_INS)); do \
 		$(RM) "$$execdir/$$p" && \
 		ln "$$execdir/git-add$X" "$$execdir/$$p" 2>/dev/null || \

-- Hannes
