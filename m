X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 2/5] upload-pack: Check for NOT_SHALLOW flag before sending a shallow to the client.
Date: Fri, 24 Nov 2006 15:58:25 +0100
Message-ID: <87wt5kuc1a.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 14:59:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32223>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GncWg-0008QM-9F for gcvg-git@gmane.org; Fri, 24 Nov
 2006 15:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934637AbWKXO7d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 09:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934639AbWKXO7d
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 09:59:33 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:4069 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S934637AbWKXO7c
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 09:59:32 -0500
Received: from adsl-84-226-49-216.adslplus.ch ([84.226.49.216]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GncVX-0005Iv-Lb for
 git@vger.kernel.org; Fri, 24 Nov 2006 08:58:28 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 9390110A155; Fri,
 24 Nov 2006 15:58:25 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

A commit may have been put on the shallow list, and then reached from
another branch and marked NOT_SHALLOW without being removed from the
list.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 upload-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index d5b4750..d4a7b62 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -565,7 +565,7 @@ static void receive_needs(void)
 			SHALLOW, NOT_SHALLOW);
 		while (result) {
 			struct object *object = &result->item->object;
-			if (!(object->flags & CLIENT_SHALLOW)) {
+			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
 				packet_write(1, "shallow %s",
 						sha1_to_hex(object->sha1));
 				register_shallow(object->sha1);
-- 
1.4.4.1.ga335e

-- 
Alexandre Julliard
