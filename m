Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56345C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiKBWtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiKBWsz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:48:55 -0400
Received: from smtp-out-2.talktalk.net (smtp-out-2.talktalk.net [62.24.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933C6594
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:48:53 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id qMXSo68vDLVi2qMXTojVpQ; Wed, 02 Nov 2022 22:48:52 +0000
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=H8GlPNQi c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=UGu2BK_MLbi3Vnk0iJUA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [RFC/PoC 3/5] test-lib: add GIT_BUNDLE_DIR setup
Date:   Wed,  2 Nov 2022 22:48:41 +0000
Message-Id: <20221102224843.2104-4-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.281.g83ef3ded8d
In-Reply-To: <20221102224843.2104-1-philipoakley@iee.email>
References: <20221102224843.2104-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJAoomSHHEJArNnDNwgT61RA5NAOxdzeff1ytLl5cTL8EyLlOk/x5WfMU2WWGq2cxPJok4rzyCiVrKcb6AEPzNRAMYXYmgjM90/jsDG42u2V09z3AFFz
 O8aIJCypsTgB+JFx+D9DTcEUWHwXRYEVRxn5fDyTOY3nVQ2L51MAkZhJYallx+owDkpe5C2lYCvlfE7XrjLEsA/i+JRhURHgX1h5gfRMPK3I9XyuWyqvwtfn
 Yuequh3LziH08vc6bzxDO+0nLAi9bYQ9IX86cMAxAKY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test system may output a number of documentation bundles containing
test repositories of interest to users, including those explicitly
documented.

Provide a default location for holding those bundles.
As build artefact's this location, along with `.bndl` files, was
ignored in an earlier commit.

This may need further refinement.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 t/test-lib.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4e45bc7c4f..b18cd8a34e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -56,6 +56,20 @@ then
 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
 	exit 1
 fi
+if test -z "$GIT_BUNDLE_DIR"
+then
+	# Similarly, override this to store the documentation bundles subdir
+	# elsewhere
+	GIT_BUNDLE_DIR=$TEST_DIRECTORY/GIT_BUNDLE_DIR
+	if test ! -d "$GIT_BUNDLE_DIR"
+	then
+		mkdir -p "$GIT_BUNDLE_DIR"
+	fi
+elif test ! -d "$GIT_BUNDLE_DIR"
+then
+	echo "PANIC: Your "$GIT_BUNDLE_DIR" doesn't exist!" >&2
+	exit 1
+fi
 
 # Prepend a string to a VAR using an arbitrary ":" delimiter, not
 # adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
-- 
2.38.1.281.g83ef3ded8d

