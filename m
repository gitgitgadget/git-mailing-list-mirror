From: Brett Randall <javabrett@gmail.com>
Subject: [PATCH] Improved example "To move the whole tree into a subdirectory...".
Date: Mon, 1 Jun 2015 23:04:15 +1000
Message-ID: <CALeEUB57ou3xd85wHb=KVkrHJv2XZc+oeMA3LnNrwPgH_icrkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 15:04:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzPOE-0005Gi-4q
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 15:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbbFANEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 09:04:20 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35170 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbbFANEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 09:04:16 -0400
Received: by obcnx10 with SMTP id nx10so97096978obc.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=PHaRgpXvMf2gUEPzSdguKdQmqO3oGnvtVLfPcG1sav4=;
        b=obh5/J/sRSLhrpTm5PS/m0dG+2cDrktJgjYum4ONvRBssLZoGH1R3b9BqjitP+xqoq
         WeoDajUMeO6jw052nZ96ZbA2M/rh5Pz5Xd29Mf6fKXFMcIj0eiiHT6HEIAvFV1A0mDVt
         PlffJXmHtg5PyJS9NbLxyKO+ht/ioIhgWFrDDh+Zl4PM9siNnzYxizCMtTRYzBTgDl/4
         w9CX9KisfJ1Z2kLxrZiM7mcZtGT8tFvrydJZzzuarAsh553c7a0+GmcyjMdjmpkKrxDj
         m8d+LE3SgDsXhbN4A4AaNSQxtf032q9z5JKjh7ccgdS0HucATqcYDXtdjsC1QjGtLfjd
         degw==
X-Received: by 10.182.236.5 with SMTP id uq5mr18087217obc.13.1433163855415;
 Mon, 01 Jun 2015 06:04:15 -0700 (PDT)
Received: by 10.202.218.135 with HTTP; Mon, 1 Jun 2015 06:04:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270407>

Previously this example would fail if the history contained any empty
commit, because the index would not change, and the mv would fail with:

mv: cannot stat <redacted>/index.new': No such file or directory

The updated example checks whether the index file has been created
before attempting the mv.  The empty commit is retained.

See
http://stackoverflow.com/questions/7798142/error-combining-git-repositories-into-subdirs
for an example and explanation.

Signed-off-by: Brett Randall <javabrett@gmail.com>
---
 Documentation/git-filter-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-filter-branch.txt
b/Documentation/git-filter-branch.txt
index 73fd9e8..0b9e690 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -385,7 +385,7 @@ git filter-branch --index-filter \
        'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
                GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
                        git update-index --index-info &&
-        mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"' HEAD
+        if [ -f "$GIT_INDEX_FILE.new" ]; then mv
"$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"; fi' HEAD
 ---------------------------------------------------------------


-- 
2.3.5
