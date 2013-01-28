From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v3 03/11] t/test-lib-functions.sh: allow to specify the tag name to test_commit
Date: Sun, 27 Jan 2013 17:11:47 -0800
Message-ID: <1359335515-13818-4-git-send-email-drafnel@gmail.com>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Cc: jrnieder@gmail.com, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdHB-0006Q3-KQ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757074Ab3A1BMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 20:12:21 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36812 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998Ab3A1BMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:12:20 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so1191854pab.33
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BqeWS+VtZF58VCSpfo8mBLCmj01Rh2aOWEdogJn72Sg=;
        b=n+ZUqdNS4VkpizOLvEBPerOFciK59usdReUbnMZszBVJAbUUr2Pfp/RQQ+bswYSo2m
         /wdI/v3sXelfXFGraI1WeoEvp3LZ3zAAtk4Vf4bReldwSH4CgsJxkht/QRK9LqmWr2ug
         F0x0vw3jolaNl68MoKBFe0HnoaTsuw0JzPTFvCzIs1Q05eADNjk8OLfWtRaYyCwfvP1E
         rPyeNioJCGSE6qo5IMCG68+O4ZOAMFzO1ZKdpOH2URjoVimvRBFmRVj4qjRx6J8r2Z0Q
         N/vf1CHz4mvKmskjQS9dhru1gINHtkzOJkhbPBN0O5mKD4rooq9SWfUpKL4gds/U3XeB
         2FVw==
X-Received: by 10.68.204.103 with SMTP id kx7mr33765425pbc.33.1359335539502;
        Sun, 27 Jan 2013 17:12:19 -0800 (PST)
Received: from charliebrown.sbx10663.mountca.wayport.net (ip-64-134-226-147.public.wayport.net. [64.134.226.147])
        by mx.google.com with ESMTPS id x2sm5619521paw.8.2013.01.27.17.12.17
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:12:18 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214769>

The <message> part of test_commit() may not be appropriate for a tag name.
So let's allow test_commit to accept a fourth argument to specify the tag
name.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib-functions.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fa62d01..61d0804 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -135,12 +135,12 @@ test_pause () {
 	fi
 }
 
-# Call test_commit with the arguments "<message> [<file> [<contents>]]"
+# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
 #
 # This will commit a file with the given contents and the given commit
-# message.  It will also add a tag with <message> as name.
+# message, and tag the resulting commit with the given tag name.
 #
-# Both <file> and <contents> default to <message>.
+# <file>, <contents>, and <tag> all default to <message>.
 
 test_commit () {
 	notick= &&
@@ -168,7 +168,7 @@ test_commit () {
 		test_tick
 	fi &&
 	git commit $signoff -m "$1" &&
-	git tag "$1"
+	git tag "${4:-$1}"
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
1.8.1.1.450.g0327af3
