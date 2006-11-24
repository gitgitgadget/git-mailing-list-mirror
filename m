X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Increase length of function name buffer
Date: Thu, 23 Nov 2006 22:47:44 -0800
Message-ID: <7vk61le3xr.fsf@assigned-by-dhcp.cox.net>
References: <200611231005.17859.andyparkins@gmail.com>
	<7vbqmxkhpk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 06:48:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vbqmxkhpk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 23 Nov 2006 12:53:43 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32190>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnUr0-0001mv-Nh for gcvg-git@gmane.org; Fri, 24 Nov
 2006 07:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934447AbWKXGrx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 01:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934450AbWKXGrx
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 01:47:53 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:43460 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S934447AbWKXGrw
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 01:47:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124064745.FIZM5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 01:47:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qWnt1V0011kojtg0000000; Fri, 24 Nov 2006
 01:47:53 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Andy Parkins <andyparkins@gmail.com> writes:
>
>> In xemit.c:xdl_emit_diff() a buffer for showing the function name as
>> commentary is allocated; this buffer was 40 characters.  This is a bit
>> small;...
 >...
> I wonder however which is easier to read, a loooong heading line
> as you do in this patch, or "...TailOfVeryLongClassName::method"
> that still fits on a single line without terminal line-wrapping.

Nah, I was stupid again.

It would give something silly like the attached patch if we do
what I suggested (notice the function header line which does not
give us anything useful).

Will apply your version as is.

---

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 07995ec..30d3df1 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -87,8 +87,10 @@ long i, char *buf, long sz, long *ll) {
 		    (isalpha((unsigned char)*rec) || /* identifier? */
 		     *rec == '_' ||	/* also identifier? */
 		     *rec == '$')) {	/* mysterious GNU diff's invention */
-			if (len > sz)
+			if (len > sz) {
+				rec += len - sz;
 				len = sz;
+			}
 			while (0 < len && isspace((unsigned char)rec[len - 1]))
 				len--;
 			memcpy(buf, rec, len);
