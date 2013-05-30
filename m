From: Doug Bell <madcityzen@gmail.com>
Subject: [PATCH] show-ref: make --head always show the HEAD ref
Date: Thu, 30 May 2013 01:08:25 -0500
Message-ID: <1369894105-48434-1-git-send-email-madcityzen@gmail.com>
Cc: Doug Bell <madcityzen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 08:09:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhw2q-0005MV-7N
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 08:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967524Ab3E3GJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 02:09:00 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:42934 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967484Ab3E3GI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 02:08:58 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so27153569iee.41
        for <git@vger.kernel.org>; Wed, 29 May 2013 23:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=61Oh/IpZjsW2HeY6Y8SmPY9Gx5mZzXK2UxfTcPOIhyk=;
        b=HWAByl0jF2ys02oFkWaBMiul9Lr8WihxelxMO2d1qOZFQpHzOSOmolTnx6xOC5DZtH
         oH/nyGEKYVtqZAHVPvGkx3oCuN4O6LLTISPVqB9npJ/QYDy6lSVOszNwrHKqcxHiz0yG
         U9AE9HMfIW87hnGBdy7i/JmIj7qX5b/DJYDpCPd9Sx22r4QV6l2mkNZhGX1qZNII7Gly
         Cyr0+tlzmHafEwdrDHSFSjCTvG8GNgwtnUDOX6VtccwO6mfZfKsWQSKhyWTRZos5u7u5
         iHMBwBBZ24aTyrtu17xOf4kw4UR1LM1m7RdoC+6KS8WkRzma6IppdVzTgwaDAsie5tCR
         lJNw==
X-Received: by 10.50.106.72 with SMTP id gs8mr10915260igb.80.1369894138143;
        Wed, 29 May 2013 23:08:58 -0700 (PDT)
Received: from localhost.localdomain (c-67-162-112-255.hsd1.il.comcast.net. [67.162.112.255])
        by mx.google.com with ESMTPSA id w8sm26201341igl.9.2013.05.29.23.08.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 23:08:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.101.g727a46b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225928>

The docs seem to say that doing

	git show-ref --head --tags

would show both the HEAD ref and all the tag refs. However, doing
both --head and either of --tags or --heads would filter out the HEAD
ref.

Signed-off-by: Doug Bell <madcityzen@gmail.com>
---
I think this patch could be done better if I refactor the show_ref() sub
a bit...

This commit passes the current test suite. Where would I put new
tests for this? I can't find an existing show-ref test to append to.
I would be happy to write show-ref tests if there aren't any already.

 builtin/show-ref.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 8d9b76a..5954e9b 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -31,6 +31,9 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	const char *hex;
 	unsigned char peeled[20];
 
+	if (show_head && !strncmp(refname, "HEAD\0", 5))
+		goto match;
+
 	if (tags_only || heads_only) {
 		int match;
 
-- 
1.8.3.101.g727a46b.dirty
