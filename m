From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 18/20] transport-helper: export is no longer always the last command
Date: Sun, 19 Jun 2011 17:18:43 +0200
Message-ID: <1308496725-22329-19-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:20:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJnZ-00042G-Ov
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab1FSPUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:20:13 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43954 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab1FSPUL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:20:11 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981189ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=RT5tP3/Vk9nG4fxv72WfPbchjj7FrUlc87/MWHmeCEQ=;
        b=wSYrJgqXr47zuNitwW2AU37O8KDs5dN5j1Po4nEPujNdIRZLfEs51H8gw5N9YFRjOv
         uWEQX1FsHafps9mAFBA1DukyOgkfPMT9J63/ikKIyY/8AAxpNiqgfqjLML3Kyzu8KMmy
         V4DncrF5MHzxa0IOLzvYiReBwPL3/pwFj9Wvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZgtSbZs5dYtfTtqNn+HcylQfXVBtRRX9g+6FJoriAxxrZIA46BdU0kxLZLcYNCU2MZ
         apTzbPCrTiqdlVAlOAexS7BiXKT00/PVg7LozXw9+MLmrHbA4agq6FBE13oOgeIwvcXp
         ErwXoHYHKawlrNGa0TqkZHEzTWCgUGIm9aj9k=
Received: by 10.14.11.28 with SMTP id 28mr1628992eew.86.1308496811112;
        Sun, 19 Jun 2011 08:20:11 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.20.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:20:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176021>

The trailing \n in the protocol signals the helper that the
connection is about to close, allowing it to do whatever cleanup
neccesary.

Previously, the connection would already be closed by the
time the trailing \n was to be written. Now that the remote-helper
protocol uses the new done command in its fast-import streams, this
is no longer the case and we can safely write the trailing \n.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Updated commit message.

 transport-helper.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index c089928..f78b670 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -762,7 +762,6 @@ static int push_refs_with_export(struct transport *transport,
 			 export_marks, import_marks, &revlist_args))
 		die("Couldn't run fast-export");
 
-	data->no_disconnect_req = 1;
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 	push_update_refs_status(data, remote_refs);
-- 
1.7.5.1.292.g728120
