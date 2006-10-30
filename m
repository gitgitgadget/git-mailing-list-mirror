X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Edgar Toernig <froese@gmx.de>
Subject: Use memmove instead of memcpy for overlapping areas
Date: Mon, 30 Oct 2006 22:26:15 +0100
Message-ID: <20061030222615.1e38908b.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 21:32:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #271361
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30526>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeeeO-0001wO-43 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 22:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161504AbWJ3V0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 16:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161507AbWJ3V0Z
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 16:26:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:3984 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1161504AbWJ3V0X (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 16:26:23 -0500
Received: (qmail invoked by alias); 30 Oct 2006 21:26:22 -0000
Received: from p50903DB1.dip0.t-ipconnect.de (EHLO dialup) [80.144.61.177] by
 mail.gmx.net (mp033) with SMTP; 30 Oct 2006 22:26:22 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

There may be more - this is just the result of a quick eye-grep
for memcpy(x, x+i).

diff --git a/imap-send.c b/imap-send.c
index 16804ab..88d635f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -272,7 +272,7 @@ buffer_gets( buffer_t * b, char **s )
 				n = b->bytes - start;
 
 				if (n)
-					memcpy( b->buf, b->buf + start, n );
+					memmove( b->buf, b->buf + start, n );
 				b->offset -= start;
 				b->bytes = n;
 				start = 0;
diff --git a/index-pack.c b/index-pack.c
index e33f605..a275982 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -61,7 +61,7 @@ static void * fill(int min)
 		die("cannot fill %d bytes", min);
 	if (input_offset) {
 		SHA1_Update(&input_ctx, input_buffer, input_offset);
-		memcpy(input_buffer, input_buffer + input_offset, input_len);
+		memmove(input_buffer, input_buffer + input_offset, input_len);
 		input_offset = 0;
 	}
 	do {

