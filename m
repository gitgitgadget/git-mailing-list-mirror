From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 4/5] Correctly initialize buffer in start_put() in http-push.c
Date: Mon, 10 Dec 2007 22:36:10 +0100
Message-ID: <1197322571-25023-4-git-send-email-mh@glandium.org>
References: <1197322571-25023-1-git-send-email-mh@glandium.org>
 <1197322571-25023-2-git-send-email-mh@glandium.org>
 <1197322571-25023-3-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 22:36:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1qIp-0003Jj-Ic
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 22:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbXLJVgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 16:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbXLJVgP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 16:36:15 -0500
Received: from smtp2b.orange.fr ([80.12.242.144]:59773 "EHLO smtp2b.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506AbXLJVgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 16:36:14 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2b02.orange.fr (SMTP Server) with ESMTP id 7C53B7000094
	for <git@vger.kernel.org>; Mon, 10 Dec 2007 22:36:12 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2b02.orange.fr (SMTP Server) with ESMTP id 62D817000084;
	Mon, 10 Dec 2007 22:36:12 +0100 (CET)
X-ME-UUID: 20071210213612404.62D817000084@mwinf2b02.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1qIO-0006W0-1f; Mon, 10 Dec 2007 22:36:12 +0100
X-Mailer: git-send-email 1.5.3.7.1159.gdd4a4-dirty
In-Reply-To: <1197322571-25023-3-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67757>

Brown paper bag fix to avoid random misbehaviour.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

 This is a brown paper bag fix for my strbuf patch for the http code.

 http-push.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index 2ef764c..ad8167e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -495,6 +495,7 @@ static void start_put(struct transfer_request *request)
 	deflateInit(&stream, zlib_compression_level);
 	size = deflateBound(&stream, len + hdrlen);
 	strbuf_init(&request->buffer.buf, size);
+	request->buffer.posn = 0;
 
 	/* Compress it */
 	stream.next_out = (unsigned char *)request->buffer.buf.buf;
-- 
1.5.3.7.1159.gdd4a4
