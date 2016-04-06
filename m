From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] builtin/trailers: don't always run all commands
Date: Wed, 6 Apr 2016 22:13:03 +0300
Message-ID: <1459969922-9131-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 21:13:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anstc-0008FR-Ri
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 21:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbcDFTNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 15:13:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49566 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014AbcDFTNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 15:13:09 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F242085538;
	Wed,  6 Apr 2016 19:13:07 +0000 (UTC)
Received: from redhat.com (vpn1-7-7.ams2.redhat.com [10.36.7.7])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u36JD46U004689;
	Wed, 6 Apr 2016 15:13:05 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290862>

If an explicit -t trailer is used, only parse
trailers from command line.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 trailer.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/trailer.c b/trailer.c
index 8e5be91..34654fc 100644
--- a/trailer.c
+++ b/trailer.c
@@ -676,10 +676,14 @@ static struct trailer_item *process_command_line_args(struct string_list *traile
 	struct trailer_item *item;
 
 	/* Add a trailer item for each configured trailer with a command */
-	for (item = first_conf_item; item; item = item->next) {
-		if (item->conf.command) {
-			struct trailer_item *new = new_trailer_item(item, NULL, NULL);
-			add_trailer_item(&arg_tok_first, &arg_tok_last, new);
+	if (!trailers->nr) {
+		for (item = first_conf_item; item; item = item->next) {
+			if (item->conf.command) {
+				struct trailer_item *new =
+					new_trailer_item(item, NULL, NULL);
+				add_trailer_item(&arg_tok_first,
+						 &arg_tok_last, new);
+			}
 		}
 	}
 
-- 
MST
