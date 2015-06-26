From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] p5310: Fix broken && chain in performance test
Date: Fri, 26 Jun 2015 14:27:00 -0700
Message-ID: <1435354020-11675-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Fri Jun 26 23:27:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8b9T-0000Sw-Bs
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 23:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbbFZV1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 17:27:07 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35624 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbbFZV1F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 17:27:05 -0400
Received: by igblr2 with SMTP id lr2so21501015igb.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 14:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BKAvrW3cgtaXbUXBfhTd/iyKFZ6ZiXmVf9DBIUpLfZg=;
        b=nmFhpyZ+wTwB125ent0O512Ql0spIPc32DoP2LQ551r07qv/8JXBNfRkXR0nZn1WSC
         +7K2mWTdWSKKgohop0/9L7QVhOwsuLIceJaoLXX0SIaZ1sOkqxM4sp5KPYIt1Mid4AGK
         kHzP4s3hekWbEaA/rQgAIkpzjMl1944lQXVvatRx/FqJvVY5XW6VcHRwnS2RWt/GlhPK
         BUKlfC4oa2oBIHujL0jqN4BJ7htANwoeDOwpI6tRwCrcInLWXhPzZ7ERXxF207UivnOM
         pqJGbQyUoqBfPk69HqyZFvqJwKixzjK3Ed0ChteZB1L49rU5Bx1XE+Fdk4YFA5xNgYHF
         4Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BKAvrW3cgtaXbUXBfhTd/iyKFZ6ZiXmVf9DBIUpLfZg=;
        b=fuBp1wafOPRE2wMHl/atoonaBWDhSNBZ9aKcDmReCCkSYFlkBWpjxyBMeXiEnn9aMa
         GY8AM57NPUUmvKyqZBo6No8LKS85xO7VvhcvuvBWUDDWpHbHT4jEPUZzGn0oioYbCP+p
         ZgxcWaeZVDOqbjVFdQWKMqVfNw1ZVbS+UE+85h7vPm6ohSrpLIBT/ad3nykkfGELHg7M
         5rIfkUubTd4jZZq9u4Q/JVgc5JKoxkEsQgcXwZSWylFSUOKeYLj/qweZ+0YpOrJ+dM2/
         ShxKCbi1DU26GULegZ0vUmECx+9pkbGg01S/iZ017+FcNwaADJuEuht7b1DTJUAAbWEz
         JJTw==
X-Gm-Message-State: ALoCoQnjgOVcXsJv9jgMauRsB+OlCalOerh0hTIaU2JKgpFM6utAVjw/eeBUCyHY6lLxKpguNRA+
X-Received: by 10.50.142.67 with SMTP id ru3mr259992igb.16.1435354024326;
        Fri, 26 Jun 2015 14:27:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5cb3:17a8:2ff6:7709])
        by mx.google.com with ESMTPSA id h2sm321713igv.2.2015.06.26.14.27.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 14:27:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272828>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/perf/p5310-pack-bitmaps.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index f8ed857..de2a224 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -39,14 +39,14 @@ test_expect_success 'create partial bitmap state' '
 
 	# now kill off all of the refs and pretend we had
 	# just the one tip
-	rm -rf .git/logs .git/refs/* .git/packed-refs
-	git update-ref HEAD $cutoff
+	rm -rf .git/logs .git/refs/* .git/packed-refs &&
+	git update-ref HEAD $cutoff &&
 
 	# and then repack, which will leave us with a nice
 	# big bitmap pack of the "old" history, and all of
 	# the new history will be loose, as if it had been pushed
 	# up incrementally and exploded via unpack-objects
-	git repack -Ad
+	git repack -Ad &&
 
 	# and now restore our original tip, as if the pushes
 	# had happened
-- 
2.4.1.345.gab207b6.dirty
