From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 2/2] setup.c: Check that the pathspec magic ends with ")"
Date: Sat,  9 Mar 2013 18:46:00 -0500
Message-ID: <1362872760-25803-2-git-send-email-andrew.kw.w@gmail.com>
References: <7vk3pik6aq.fsf@alter.siamese.dyndns.org>
 <1362872760-25803-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 10 00:47:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UETTf-0005gH-Cz
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 00:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229Ab3CIXqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 18:46:33 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46262 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab3CIXqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 18:46:33 -0500
Received: by mail-ie0-f176.google.com with SMTP id k13so3427409iea.21
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 15:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=lciaatZ2Hl3Mk70u1jQm8Wwhfk0bv1AQ36WfBpNKTnU=;
        b=0fXh+y2F+8dG7ZBQg2Hn4epVScoVBC1gmxGvsg4TiuWm9nPnKtQCrDZXwzPSM9YUJ8
         pAAc8mgCeM0tgJcDmRBgSHXwKyXSwxUgrgPrkU9W8OMKMfz4z74hI8l7Zry0QLGzAmAr
         KPNMvgmsSqji1jdU9RW7Y6KEhRGe8cAPM28xECX2cV/DaZ4eCad5YjezsAvjx5beqf5B
         TqsxwJaBIsZonM8fW43R9aQoFqr673sVtaW4SGOMdnScEPzIf5yMFwqaktm5nqhmdJJA
         FbaBzU+H/O44JDSMj4+oYzUzRCl6DYEtsIf6UjTNqK/v4c9D4LeqZAioaWMQIYbKHZqm
         iYTQ==
X-Received: by 10.50.213.97 with SMTP id nr1mr3517106igc.36.1362872792791;
        Sat, 09 Mar 2013 15:46:32 -0800 (PST)
Received: from localhost.localdomain ([69.165.234.69])
        by mx.google.com with ESMTPS id l2sm5747376igb.1.2013.03.09.15.46.31
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 15:46:32 -0800 (PST)
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1362872760-25803-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217773>

The previous code allowed the ")" to be optional.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 setup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index f4c4e73..5ed2b93 100644
--- a/setup.c
+++ b/setup.c
@@ -225,8 +225,9 @@ static const char *prefix_pathspec(const char *prefix, int prefixlen, const char
 				die("Invalid pathspec magic '%.*s' in '%s'",
 				    (int) len, copyfrom, elt);
 		}
-		if (*copyfrom == ')')
-			copyfrom++;
+		if (*copyfrom != ')')
+			die("Missing ')' at the end of pathspec magic in '%s'", elt);
+		copyfrom++;
 	} else {
 		/* shorthand */
 		for (copyfrom = elt + 1;
-- 
1.7.12.4
