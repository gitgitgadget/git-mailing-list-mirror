From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t3700 (add): add failing test for add with submodules
Date: Mon,  8 Apr 2013 15:56:49 +0530
Message-ID: <1365416809-4396-1-git-send-email-artagnon@gmail.com>
References: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:26:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEuC-0003oz-8P
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936706Ab3DHKZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 06:25:50 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:41842 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936431Ab3DHKZb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 06:25:31 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so3174492pab.21
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9eYcq50Ghz1s7H+b9XKFaLap8RO22a7YB8gUN3xLWBY=;
        b=rzW/Czw65eSqN8U3nc18cy7NP3poX/77xi5dut9J2x7NPqs+Be1hgZCTv55B6oNu14
         ItrFVD0G5lzqnii61nrCBiegOK/qZh+XZAV6FsCCuSzz9dSKaSLgnX2nX/SpKRyYyE63
         JGUbTf3w8EvgLAjAV1AU2Izn9vOIgX33PibZKFbOrdmHEx9HpLYux9GgfeMDvrYXzaaX
         8brd5pJHgwnpOMHosE96OHHrTWjSOr/d4zBf9fqlkDsybTszr6H3P3kiNsFNTadxD39m
         a4s9eIkOEGYKx3Ce3AAZruCFb/JtOpwuf2/wIa+myjMBkCBUaRlL2s1ZYerQjgbe5/7Z
         VkuQ==
X-Received: by 10.67.1.39 with SMTP id bd7mr34696146pad.194.1365416731268;
        Mon, 08 Apr 2013 03:25:31 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id hp1sm38500551pac.3.2013.04.08.03.25.27
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 03:25:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.373.g961c512
In-Reply-To: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220415>

git add currently goes past submodule boundaries.  Document this bug.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3700-add.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 874b3a6..a1ea050 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -310,4 +310,18 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_failure 'git add should not go past submodule boundaries' '
+	mkdir submodule_dir &&
+	(
+		cd submodule_dir &&
+		git init &&
+		cat >foo <<-\EOF &&
+		Some content
+		EOF
+		git add foo &&
+		git commit -a -m "Add foo"
+	) &&
+	git add submodule_dir/foo
+'
+
 test_done
-- 
1.8.2.373.g961c512
