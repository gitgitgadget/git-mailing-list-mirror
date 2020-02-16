Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2B8C2BA83
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CFC206E2
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWoLNItA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBPNsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 08:48:46 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:37495 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgBPNsp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 08:48:45 -0500
Received: by mail-pg1-f182.google.com with SMTP id z12so7654094pgl.4
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 05:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kgmcPIYOLU7HcOM1eLDSxVJiwU8V4U8bCUaWbdYepWI=;
        b=DWoLNItA+44DJt/ZQFVilISoPfoPHHcdl/8dRr6rITp/4XtfuzRS7YX7k8Jl8Mo7I5
         DtWri7wtWtjViF+YEL7S9SbHSFl4Uk2zuSS//I0yh/b5B+y9alBrmfif5edEIZX6GGTZ
         ZhE4ghx/UOQS+duLjQbZ9tDliHiN67WZaBIRSPSeNOi7DzFzyHcS0UB6GG1CGIAZCqX9
         JCdsr8jBCczPsstkAPY3pn2XaS/5ebE+bDNllLbJEeWt1ij7QsLmBDLA4rPBO5cRUOZ0
         gxVk12O4e0m2697W6zkIBn1n7sz2ZU0cEcfwjf2qfkZoYCKjfrOb1DiFXcFHquZH5hxC
         bnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kgmcPIYOLU7HcOM1eLDSxVJiwU8V4U8bCUaWbdYepWI=;
        b=hdrJV3ZiqFMJl0J6Pn8axuc07agTS5oBmey4YbLPhV+xk3atMl6ieADFa4m/tLljyy
         mAlRo54auPul9mx/uOrzcr0VybTxJ5T/OsLRErHkoIHEfJuJzxcixU9sokpGsxaFrn9q
         lwpRi/lCAitqoye3E7aSr0Gc1e/FNyBi7MCT3zSAnUUc63Nfq6WX5vsMBz5pyxr/Er5K
         +9yWCroyCa6LPwjk5T9RBYCr9XrCjChR8WcdwTkPkrAq/OBcSSQ8PYmFwP1UlbrNEU9O
         FVugaIzUNKEjunRetjrOSdz9B8fRfNbhlP8ahCUaiKZGspKlPjf5t3jObzHBSSKRWux1
         iOCQ==
X-Gm-Message-State: APjAAAWoPSE/uteoDsl5LWGXx7XUKN4O5kt7I9zGUC8QXRHON5+VDBiQ
        3JeNj75koYylLGHSBvXj5V20/FofyM0=
X-Google-Smtp-Source: APXvYqzqS7MBzQ7oHg/2zEqPSO8NjGoyyRW7zXayj6+q8aq2L/rhH5Kt1d4M3efEVZYbTlFA2I/rXg==
X-Received: by 2002:a63:34b:: with SMTP id 72mr12588243pgd.278.1581860923217;
        Sun, 16 Feb 2020 05:48:43 -0800 (PST)
Received: from Abhishek-Arch.nitk.ac.in ([218.248.46.83])
        by smtp.gmail.com with ESMTPSA id m12sm13302006pjf.25.2020.02.16.05.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 05:48:42 -0800 (PST)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [GSoC Patch 1/5] lib-log-graph.sh: consolidate test_cmp_graph logic
Date:   Sun, 16 Feb 2020 19:17:46 +0530
Message-Id: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Logic for comparing log graphs is duplicated across test scripts.

This patchset consolidates such logic into lib-log-graph.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
1. I don't think this patchset requires a cover letter or extended
commit descriptions - Fairly simple, straightforward changes.
2. This patchset closes issue #471 from gitgitgadget.

 t/lib-log-graph.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 t/lib-log-graph.sh

diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
new file mode 100644
index 0000000000..999f2600de
--- /dev/null
+++ b/t/lib-log-graph.sh
@@ -0,0 +1,39 @@
+# Helpers shared by the test scripts for comparing log graphs.
+
+sanitize_output() {
+	sed -e 's/ *$//' \
+	    -e 's/commit [0-9a-f]*$/commit COMMIT_OBJECT_NAME/' \
+	    -e 's/Merge: [ 0-9a-f]*$/Merge: MERGE_PARENTS/' \
+	    -e 's/Merge tag.*/Merge HEADS DESCRIPTION/' \
+	    -e 's/Merge commit.*/Merge HEADS DESCRIPTION/' \
+	    -e 's/, 0 deletions(-)//' \
+	    -e 's/, 0 insertions(+)//' \
+	    -e 's/ 1 files changed, / 1 file changed, /' \
+	    -e 's/, 1 deletions(-)/, 1 deletion(-)/' \
+	    -e 's/, 1 insertions(+)/, 1 insertion(+)/' \
+	    -e 's/index [0-9a-f]*\.\.[0-9a-f]*/index BEFORE..AFTER/'
+}
+
+# Assume expected graph is in file `expect`
+test_cmp_graph_file() {
+	git log --graph "$@" >output &&
+	sanitize_output >output.trimmed <output &&
+	test_i18ncmp expect output.trimmed
+}
+
+test_cmp_graph() {
+	cat >expect &&
+	test_cmp_graph_file "$@"
+}
+
+# Assume expected graph is in file `expect.colors`
+test_cmp_colored_graph_file() {
+	git log --graph --color=always "$@" >output.colors.raw &&
+	test_decode_color <output.colors.raw | sed "s/ *\$//" >output.colors &&
+	test_cmp expect.colors output.colors
+}
+
+test_cmp_colored_graph() {
+	cat >expect.colors &&
+	test_cmp_colored_graph_file "$@"
+}
-- 
2.25.0

