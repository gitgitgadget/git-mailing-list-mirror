From: Junio C Hamano <junkio@cox.net>
Subject: Re: git sometimes stripping one path component in commit mails
Date: Fri, 29 Sep 2006 02:08:42 -0700
Message-ID: <7v64f7nip1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0609291034020.28814@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 11:09:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTEMa-0001fb-Nl
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 11:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161192AbWI2JIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 05:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWI2JIo
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 05:08:44 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:36844 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030447AbWI2JIn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 05:08:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929090843.KXIZ12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 05:08:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U98e1V01F1kojtg0000000
	Fri, 29 Sep 2006 05:08:39 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.62.0609291034020.28814@pademelon.sonytel.be> (Geert
	Uytterhoeven's message of "Fri, 29 Sep 2006 10:41:26 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28106>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Is this a current git bug, or a bug in the version used for those mailing
> lists?
>
> | commit 94c12cc7d196bab34aaa98d38521549fa1e5ef76
>...
> | diff --git a/include/asm-s390/irqflags.h b/include/asm-s390/irqflags.h
> | dissimilarity index 65%
> | index 3b566a5..3f26131 100644
> | --- include/asm-s390/irqflags.h
> | +++ include/asm-s390/irqflags.h
>       ^^
>       woops

This is a current git bug (and git bug ever since it started to
say "dissimilarity index").  Thanks for noticing, and very sorry
for the trouble.  It seems that a complete rewrite diff never
worked and nobody seriously looked at them.

This should fix it.

-- >8 --
[PATCH] git-diff -B output fix.

Geert noticed that complete rewrite diff missed the usual a/ and b/
leading paths.  Pickaxe says it never worked, ever.

Embarrassing.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 2464238..17f5a91 100644
--- a/diff.c
+++ b/diff.c
@@ -208,7 +208,7 @@ static void emit_rewrite_diff(const char
 	diff_populate_filespec(two, 0);
 	lc_a = count_lines(one->data, one->size);
 	lc_b = count_lines(two->data, two->size);
-	printf("--- %s\n+++ %s\n@@ -", name_a, name_b);
+	printf("--- a/%s\n+++ b/%s\n@@ -", name_a, name_b);
 	print_line_count(lc_a);
 	printf(" +");
 	print_line_count(lc_b);
-- 
1.4.2.1.gce47b
