From: David Rientjes <rientjes@google.com>
Subject: [PATCH 28/28] makes upload_pack void
Date: Mon, 14 Aug 2006 13:40:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141340060.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:41:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCjF8-00027W-2X
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbWHNUk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbWHNUk7
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:40:59 -0400
Received: from smtp-out.google.com ([216.239.45.12]:29338 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932683AbWHNUk6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:40:58 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id k7EKerlw027553
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:40:53 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=IF7MRYFQB8Bg9l/p0/b/MapLtuiK5fywFeORKvoRjL5CyyDd9v0zArVWOgA5v4JlC
	XMc/KLZNyyT9lhAkV4zDA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps35.corp.google.com with ESMTP id k7EKepbg023541
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:40:51 -0700
Received: by localhost (Postfix, from userid 24081)
	id A6E9C87D71; Mon, 14 Aug 2006 13:40:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id A421287D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:40:51 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25409>

Makes upload_pack void and removes conditional return.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 upload-pack.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index bbd6bd6..27e2abe 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -459,18 +459,17 @@ static int send_ref(const char *refname,
 	return 0;
 }
 
-static int upload_pack(void)
+static void upload_pack(void)
 {
 	reset_timeout();
 	head_ref(send_ref);
 	for_each_ref(send_ref);
 	packet_flush(1);
 	receive_needs();
-	if (!want_obj.nr)
-		return 0;
-	get_common_commits();
-	create_pack_file();
-	return 0;
+	if (want_obj.nr) {
+		get_common_commits();
+		create_pack_file();
+	}
 }
 
 int main(int argc, char **argv)
-- 
1.4.2.g89bb-dirty
