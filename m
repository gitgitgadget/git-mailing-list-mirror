From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/2] technical-docs: document hash API
Date: Thu, 17 Dec 2009 16:05:29 -0800
Message-ID: <1261094729-24128-2-git-send-email-bebarino@gmail.com>
References: <1261094729-24128-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 01:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLQM2-0007zL-1E
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 01:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbZLRAFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 19:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbZLRAFk
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 19:05:40 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:46546 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbZLRAFh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 19:05:37 -0500
Received: by mail-gx0-f211.google.com with SMTP id 3so1606121gxk.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 16:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=A6Jxo7Z7P213pGdoF+AUPDgmLS2qDvHqPNKS3/iB4o0=;
        b=Fw71JWqyuqCGmUamDMoLZRbmdwL8fGtBSR+lHj679fvW7uoGvtrx8pQkY7TBRhMLLx
         IeOo6obtfNYlZD69Ojo98UZ/mEo+hPunLv+/qDGSGu2gTEf4AOwK8ACJHHaeFP/wkNKv
         vTMsXZ1F9L65mdomm8IGJwZlQTKJKsmiVloBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZPzSaKRKGDwQkdO5bUfJh7Sq7HBX/CQA9BG0k2vLI0pORqKtU1Y4y6GGXNx/0MuvS/
         QkystK7kqhP9VDZbw4EM5B1HwRc2vFT3BsfayK/u3nnuXrKX3d7NhMxAIy6x/r515MVX
         cWPW+eB2KBx9j7o4Dz2Q8uqTKChhi7p/tjYKk=
Received: by 10.150.47.16 with SMTP id u16mr5158821ybu.149.1261094735417;
        Thu, 17 Dec 2009 16:05:35 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 5sm927766ywd.23.2009.12.17.16.05.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Dec 2009 16:05:34 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc3.1.g8df51
In-Reply-To: <1261094729-24128-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135388>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/technical/api-hash.txt |   50 ++++++++++++++++++++++++++++++++-
 1 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-hash.txt b/Documentation/technical/api-hash.txt
index c784d3e..e5061e0 100644
--- a/Documentation/technical/api-hash.txt
+++ b/Documentation/technical/api-hash.txt
@@ -1,6 +1,52 @@
 hash API
 ========
 
-Talk about <hash.h>
+The hash API is a collection of simple hash table functions. Users are expected
+to implement their own hashing.
 
-(Linus)
+Data Structures
+---------------
+
+`struct hash_table`::
+
+	The hash table structure. The `array` member points to the hash table
+	entries. The `size` member counts the total number of valid and invalid
+	entries in the table. The `nr` member keeps track of the number of
+	valid entries.
+
+`struct hash_table_entry`::
+
+	An opaque structure representing an entry in the hash table. The `hash`
+	member is the entry's hash key and the `ptr` member is the entry's
+	value.
+
+Functions
+---------
+
+`init_hash`::
+
+	Initialize the hash table.
+
+`free_hash`::
+
+	Release memory associated with the hash table.
+
+`insert_hash`::
+
+	Insert a pointer into the hash table. If an entry with that hash
+	already exists, a pointer to the existing entry's value is returned.
+	Otherwise NULL is returned.  This allows callers to implement
+	chaining, etc.
+
+`lookup_hash`::
+
+	Lookup an entry in the hash table. If an entry with that hash exists
+	the entry's value is returned. Otherwise NULL is returned.
+
+`for_each_hash`::
+
+	Call a function for each entry in the hash table. The function is
+	expected to take the entry's value as its only argument and return an
+	int. If the function returns a negative int the loop is aborted
+	immediately.  Otherwise, the return value is accumulated and the sum
+	returned upon completion of the loop.
-- 
1.6.6.rc3.1.g8df51
