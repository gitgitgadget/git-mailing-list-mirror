From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 2/4] t5304: Add test for .bitmap garbage files
Date: Wed, 13 Jan 2016 11:07:10 -0600
Message-ID: <543776a2a3e5d9f920280d06363a85f30a279d94.1452704305.git.dougk.ff7@gmail.com>
References: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
 <cover.1452704305.git.dougk.ff7@gmail.com>
Cc: peff@peff.net, sbeller@google.com, Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 18:07:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOtp-0005NW-JC
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbcAMRHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:07:40 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33437 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbcAMRH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:07:29 -0500
Received: by mail-oi0-f68.google.com with SMTP id j3so5854265oig.0
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 09:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fUF77s+7NAUr7NQHNhzM6XLvmAsx66e9VXghceJq3LQ=;
        b=RhCNOw5sxvkUk683kFrBvR9xbHuiaJgYg8sInVTsPG98v9DwGoeYbNlIzeYmPmL841
         1khzI/aY9Z1ksmFlUt3dMpyKdWgBSmzBlzZDgJ/VlJfw1e+NUN+kPRrq+H7yhHhAg3U5
         SlA2C18iCUE+lZL0FD7CnuFaj0zcV4hAJCbDgGgG+122Tc3Axo4xvkihM9CKR2HiIr/m
         DFyWzErm0APcpEtxu/Pu0qBSaJbrRcZF9foTWjJr/wvqdRqu4UvdXaP9cj6zkKnW7lo2
         4MOY59pQ4wEMECy7mSmmenmMrs8pF5cXydhGc7Wald2gBw5y2Aoe4CsDMpTIBmsh7Op2
         InCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fUF77s+7NAUr7NQHNhzM6XLvmAsx66e9VXghceJq3LQ=;
        b=Ng/A+bJdT3lnvhTSriGFHACa5qk8U+rDQsQzmZ9JNglhceWIzIL5elqSx/MBCU4Dts
         1CkNFYuFs3MDvPiziAyPgjjxDyqqW3d4pQnj4kXdvdv9REZ2G6Nf3CWxy2h6xluVWRVq
         womBgKZKKh9nFDwcl+3snhkEilsoVhg4iy4pIFKzweYHHB8bqFNSHMCCqKzPRoXXhh9U
         mxlCVrYMLAqIlHr0UdLWVQdA5dJKnqPBI+4ty1QJ33Qetg2SFc+c9T4PJBYlFb+wrCAH
         wSR7hsU0xdcK7CLyX+5LAhS8KcCPQVJSTEd+uNSnYTmZq8p3UyQ/n4G+N8g63AyRCFvB
         EXZg==
X-Gm-Message-State: ALoCoQltdUlSS6HkTBGDlwLXOG8ZwcJGNPjZPYeGtaNPZgu/m0fN2CbmYQ1oPCWx4g0HekkFZ2u6bkxp6VwjpTudH9YckZocOA==
X-Received: by 10.202.196.10 with SMTP id u10mr98955343oif.91.1452704848814;
        Wed, 13 Jan 2016 09:07:28 -0800 (PST)
Received: from localhost.localdomain ([204.77.163.41])
        by smtp.gmail.com with ESMTPSA id dh8sm996371obb.2.2016.01.13.09.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 09:07:28 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <cover.1452704305.git.dougk.ff7@gmail.com>
In-Reply-To: <cover.1452704305.git.dougk.ff7@gmail.com>
References: <cover.1452704305.git.dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283941>

When checking for pack garbage, .bitmap files are now detected as
garbage when not associated with another .pack/.idx file.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 t/t5304-prune.sh | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 1ea8279..4fa6e7a 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -230,6 +230,12 @@ test_expect_success 'garbage report in count-objects -v' '
 	: >.git/objects/pack/fake.idx &&
 	: >.git/objects/pack/fake2.keep &&
 	: >.git/objects/pack/fake3.idx &&
+	: >.git/objects/pack/fake4.bitmap &&
+	: >.git/objects/pack/fake5.bitmap &&
+	: >.git/objects/pack/fake5.idx &&
+	: >.git/objects/pack/fake6.keep &&
+	: >.git/objects/pack/fake6.bitmap &&
+	: >.git/objects/pack/fake6.idx &&
 	git count-objects -v 2>stderr &&
 	grep "index file .git/objects/pack/fake.idx is too small" stderr &&
 	grep "^warning:" stderr | sort >actual &&
@@ -238,14 +244,20 @@ warning: garbage found: .git/objects/pack/fake.bar
 warning: garbage found: .git/objects/pack/foo
 warning: garbage found: .git/objects/pack/foo.bar
 warning: no corresponding .idx or .pack: .git/objects/pack/fake2.keep
+warning: no corresponding .idx or .pack: .git/objects/pack/fake4.bitmap
 warning: no corresponding .idx: .git/objects/pack/foo.keep
 warning: no corresponding .idx: .git/objects/pack/foo.pack
 warning: no corresponding .pack: .git/objects/pack/fake3.idx
+warning: no corresponding .pack: .git/objects/pack/fake5.bitmap
+warning: no corresponding .pack: .git/objects/pack/fake5.idx
+warning: no corresponding .pack: .git/objects/pack/fake6.bitmap
+warning: no corresponding .pack: .git/objects/pack/fake6.idx
+warning: no corresponding .pack: .git/objects/pack/fake6.keep
 EOF
 	test_cmp expected actual
 '
 
-test_expect_success 'clean pack garbage with gc' '
+test_expect_failure 'clean pack garbage with gc' '
 	test_when_finished "rm -f .git/objects/pack/fake*" &&
 	test_when_finished "rm -f .git/objects/pack/foo*" &&
 	: >.git/objects/pack/foo.keep &&
@@ -254,15 +266,21 @@ test_expect_success 'clean pack garbage with gc' '
 	: >.git/objects/pack/fake2.keep &&
 	: >.git/objects/pack/fake2.idx &&
 	: >.git/objects/pack/fake3.keep &&
+	: >.git/objects/pack/fake4.bitmap &&
+	: >.git/objects/pack/fake5.bitmap &&
+	: >.git/objects/pack/fake5.idx &&
+	: >.git/objects/pack/fake6.keep &&
+	: >.git/objects/pack/fake6.bitmap &&
+	: >.git/objects/pack/fake6.idx &&
 	git gc &&
 	git count-objects -v 2>stderr &&
 	grep "^warning:" stderr | sort >actual &&
 	cat >expected <<\EOF &&
+warning: no corresponding .idx or .pack: .git/objects/pack/fake2.keep
 warning: no corresponding .idx or .pack: .git/objects/pack/fake3.keep
+warning: no corresponding .idx or .pack: .git/objects/pack/fake6.keep
 warning: no corresponding .idx: .git/objects/pack/foo.keep
 warning: no corresponding .idx: .git/objects/pack/foo.pack
-warning: no corresponding .pack: .git/objects/pack/fake2.idx
-warning: no corresponding .pack: .git/objects/pack/fake2.keep
 EOF
 	test_cmp expected actual
 '
-- 
2.6.1
