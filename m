From: Bernhard Reiter <ockham@raz.or.at>
Subject: Re: [PATCH] git-imap-send: simplify tunnel construction
Date: Mon, 18 Aug 2014 19:15:17 +0200
Message-ID: <53F234A5.7010704@raz.or.at>
References: <53EBA0C3.2040805@raz.or.at> <xmqq1tsdybq8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 19:15:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJQWn-0005GG-2d
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 19:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbaHRRPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 13:15:24 -0400
Received: from mhub.domainplanet.at ([92.43.99.119]:50515 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbaHRRPX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 13:15:23 -0400
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id 09B019D35AE;
	Mon, 18 Aug 2014 19:15:19 +0200 (CEST)
Received: from [90.0.0.2] (91-114-138-253.adsl.highway.telekom.at [91.114.138.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id 0A4A9BFB8D;
	Mon, 18 Aug 2014 19:15:27 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq1tsdybq8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255403>

Am 2014-08-18 um 19:00 schrieb Junio C Hamano:
> Bernhard Reiter <ockham@raz.or.at> writes:
> 
>> Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
>> ---
>>  imap-send.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Oy.  Where is the patch?
> 
> Please avoid multipart/mixed on this list.
> 
> Thanks.

D'oh. Sorry about that. Strangely, that's what I'm getting from a
message created with git-imap-send. Maybe Thunderbird is messing it up
afterwards. Anyway:

diff --git a/imap-send.c b/imap-send.c
index 524fbab..fb01a9c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -961,17 +961,16 @@ static struct imap_store *imap_open_store(struct
imap_server_conf *srvc)
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
