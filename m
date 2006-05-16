From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix silly typo in new builtin grep
Date: Mon, 15 May 2006 17:54:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605151743360.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue May 16 02:54:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfnpC-0006U8-Kl
	for gcvg-git@gmane.org; Tue, 16 May 2006 02:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWEPAyH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 20:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWEPAyH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 20:54:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750904AbWEPAyG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 20:54:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4G0s2tH004068
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 17:54:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4G0s1hH023409;
	Mon, 15 May 2006 17:54:01 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20090>


The "-F" flag apparently got mis-translated due to some over-eager 
copy-paste work into a duplicate "-H" when using the external grep.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Me likee the new built-in grep. The ability to say

	git grep __make_request v2.6.13 -- '*.c'

to grep for it in a specific version is well worth the fact that it 
obviously ends up being slower than grepping in the currently checked-out 
tree. It's doing a hell of a lot more, but despite that it's not at all 
that slow.

(In fact, I would say that doing the above command in just 4 seconds is 
damn impressive - it's a large code-base, and v2.6.13 is several months, 
and over 20 _thousand_ revisions ago).

And now it doesn't have any performance downsides, so it's all upside. 

Good job. Pls merge into mainline, I think the "grep per revision" is a 
killer feature.

diff --git a/builtin-grep.c b/builtin-grep.c
index 3d6e515..66111de 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -455,7 +455,7 @@ static int external_grep(struct grep_opt
 	push_arg("grep");
 	push_arg("-H");
 	if (opt->fixed)
-		push_arg("-H");
+		push_arg("-F");
 	if (opt->linenum)
 		push_arg("-n");
 	if (opt->regflags & REG_EXTENDED)
