From: Bernhard Reiter <ockham@raz.or.at>
Subject: [PATCH] git-imap-send: simplify tunnel construction
Date: Wed, 13 Aug 2014 19:30:43 +0200
Message-ID: <53EBA0C3.2040805@raz.or.at>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080409090805050607080808"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 19:31:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHcOK-0000gA-5a
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 19:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbaHMRbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 13:31:08 -0400
Received: from mhub.domainplanet.at ([92.43.99.119]:43746 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbaHMRbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 13:31:04 -0400
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id 8A07F9D2FA4
	for <git@vger.kernel.org>; Wed, 13 Aug 2014 19:30:58 +0200 (CEST)
Received: from [10.0.0.88] (91-113-43-166.adsl.highway.telekom.at [91.113.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id 58EFDBF4F4
	for <git@vger.kernel.org>; Wed, 13 Aug 2014 19:31:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255220>

This is a multi-part message in MIME format.
--------------080409090805050607080808
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
---
 imap-send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)



--------------080409090805050607080808
Content-Type: text/x-patch;
 name="0001-git-imap-send-simplify-tunnel-construction.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-git-imap-send-simplify-tunnel-construction.patch"

diff --git a/imap-send.c b/imap-send.c
index 524fbab..fb01a9c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -961,17 +961,16 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 	/* open connection to IMAP server */
 
 	if (srvc->tunnel) {
-		const char *argv[] = { srvc->tunnel, NULL };
 		struct child_process tunnel = {NULL};
 
 		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
 
-		tunnel.argv = argv;
+		argv_array_push(&tunnel.args, srvc->tunnel);
 		tunnel.use_shell = 1;
 		tunnel.in = -1;
 		tunnel.out = -1;
 		if (start_command(&tunnel))
-			die("cannot start proxy %s", argv[0]);
+			die("cannot start proxy %s", srvc->tunnel);
 
 		imap->buf.sock.fd[0] = tunnel.out;
 		imap->buf.sock.fd[1] = tunnel.in;


--------------080409090805050607080808--
