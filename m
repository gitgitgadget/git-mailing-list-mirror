Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98352C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3DD20776
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh5pEAA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCUQOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:14:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36429 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgCUQOC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 12:14:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so5201635wrs.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aC02Sl/m3KWl9+ff6g/7BAoajVhcCWSThhkZyC54V0I=;
        b=Zh5pEAA/ku6K5Yt+FgkBKwtiCeL9RObhrbYbxOgX8Kc04fDyTtrIzgsqnWUtolYeSP
         PYYf42GXZbBpICTHy3AV4i6gtczIgGBGjzB8Ax/g4iETSFinm1JVk1YamDWjZp+dtwPW
         t++McE/ugETMwzsSqHMvxJxIqtYrEHk8OExQLgzUffIY2TnDBqHuSehJrMvBnQS6C4fs
         eQY+P21avl0fc1UTCja7qn8KN1qgfcvncc8PwUOt8BqSrpZ29LBjkIjsGT84ILVHfBAI
         SsguVyfOd3Yq9xqUK6CbfmgNOTum55s+Dkm0jTAyqO7ZmHdpRqE0vDiOrAATFSx3qdGj
         SU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aC02Sl/m3KWl9+ff6g/7BAoajVhcCWSThhkZyC54V0I=;
        b=OoJhyzstMfyb1CrSqFpSHYGxA8zRKUjcDr5ht43Nu4z+htASQZQSuqgV49EXbs4Jx4
         GlA9Wi/Tvs2/9svLWdSHrYO3RwDCGQyua8jITGOMFJrix+ceKlEaCil4qgUvFw2V3aV2
         mBw90tk0UtjYzcFG36hEOQhN6ZJaP1wAJlCsRXRC8FU+zWP+LH2vBGQChSf+scPs1br3
         fdo4ADOM9j8rgIEz/Z3AJxrRNSP/oLk0W/zMnTj8D7AP3WaLAhFK6GOT8e5ok10tgi7o
         STyhqAe8MxyjGiXH4O/H396OIZTZ5XP6HiyfXwPWPAWWpGTtokiSMMVUeDbCHktgOJtj
         pf6g==
X-Gm-Message-State: ANhLgQ2EGSlhXpwl5OGT4MR0Yz5RDUNvt/p9HW53d/rx3uOw6G+ipy/w
        rNCRlDxL3N19obaBVX/DzS8ShSv+TCg=
X-Google-Smtp-Source: ADFU+vvIdOzFFByVSOkKvl4lAu3V4Vz71/HuuDAoZ/ZDAbI91AVN3pcIyzFuFx1FhYzsmJw+Sasaag==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr19357338wrp.55.1584807240367;
        Sat, 21 Mar 2020 09:14:00 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id f22sm13992285wmf.2.2020.03.21.09.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 09:13:59 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 09/11] bisect--helper: retire `--check-expected-revs` subcommand
Date:   Sat, 21 Mar 2020 17:10:18 +0100
Message-Id: <20200321161020.22817-10-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200321161020.22817-1-mirucam@gmail.com>
References: <20200321161020.22817-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--check-expected-revs` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`check_expected_revs()` is called from the C implementation of
`bisect-next()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 6364bd82c0..2b1d918497 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -896,7 +896,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		WRITE_TERMS = 1,
-		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
@@ -912,8 +911,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -954,9 +951,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
-	case CHECK_EXPECTED_REVS:
-		check_expected_revs(argv, argc);
-		return 0;
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-- 
2.25.0

