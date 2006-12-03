X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document git-diff whitespace flags -b and -w
Date: Sun, 3 Dec 2006 19:25:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612031908020.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11651630814064-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 18:25:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <11651630814064-git-send-email-jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33124>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqw20-0001BA-ET for gcvg-git@gmane.org; Sun, 03 Dec
 2006 19:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758767AbWLCSZi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 13:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758805AbWLCSZi
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 13:25:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:52120 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758767AbWLCSZh (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 13:25:37 -0500
Received: (qmail invoked by alias); 03 Dec 2006 18:25:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp001) with SMTP; 03 Dec 2006 19:25:35 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 3 Dec 2006, Jakub Narebski wrote:

> +--ignore-space-change::
> +	Ignore changes in amount of white space.  This ignores white
> +	space at line end, and consider all other sequences of one or
> +	more white space characters to be equivalent.

Thank you for bringing this up. The latter part is correct, but the first 
part not yet. I asked at the time if somebody cares, but got no answer, so 
"-b" does _not_ ignore white space at the end of line ATM, but only white 
space change. So here is a patch to fix that behaviour:

-- snip --
diff -b: ignore whitespace at end of line

This is _not_ the same as "treat eol as whitespace", since that would mean 
that multiple empty lines would be treated as equal to e.g. a space.

---
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9e4bb47..1b899f3 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -230,7 +230,8 @@ unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 			while (ptr + 1 < top && isspace(ptr[1])
 					&& ptr[1] != '\n')
 				ptr++;
-			if (flags & XDF_IGNORE_WHITESPACE_CHANGE) {
+			if (flags & XDF_IGNORE_WHITESPACE_CHANGE
+					&& ptr[1] != '\n') {
 				ha += (ha << 5);
 				ha ^= (unsigned long) ' ';
 			}

