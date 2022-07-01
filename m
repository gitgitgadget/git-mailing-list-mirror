Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4AAC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiGAKn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiGAKnN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:43:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531221133
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:43:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i25so2566015wrc.13
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aipVFBZZwqqk2DvQ8WW4Ay5P4lonhg1i0pFRd5DEEBI=;
        b=oJe7DU1BwURGF3yMDwzXB/scxBhIFVgSzz/2CWCjqjeW2z7ZWmTo/s6CDuWPrPnim3
         9aERImU6YcIZ3iYDfvqDKW10M7U4OuFbEP6uMDP912RPsUgu+mkjXta3Mj263cUzQYPM
         mQ42/rWWRkX6lkmJOc39voIXDG6duywJZHPiGj+R8OpcLE07CnOsrITQJOqnmr3fDMz1
         UyNL/Y5k4dyii7XSuIyQCwkn+5JdvgHbXins+/XYmhxRzMhM8sqjLp4UPXk9zuznWD+3
         surxvanxlsQ9xZAsPxJ89zxEJ2OqKtk2SheeyOrizvEWgKf3X95s/rGsQanqP2WeE+4A
         6Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aipVFBZZwqqk2DvQ8WW4Ay5P4lonhg1i0pFRd5DEEBI=;
        b=7tWX2VzvCOQfOejlve35Y8cNvXjHETk9aaSzrleK4U3ktq3pN8gPJYvZIoBczMPnpL
         3cbXypAktCMHOJQtyFF0AyObaqDwrBkydoKJeEY7vgE/1lqz9Lv8kbu4cqW/vKp6cTkF
         /XC+I7hlzNvtuqlcsteYbX8Fjxl++C0ZuxVXPMlFabMbTLr9I5bb9MgHtARi8Lis7lJF
         oOZUqT0W25oeQUtm4EuabYc+Ih6u/Kz4c1JAnBMTUvGuQPdK+9aaM4a0eB4BOcbE2Tx7
         xD6xJVHIdMic+vSGxZP6ZyXBWaE5TDS7NqVUFn0BO1/jPjm7YIY+KGlbyArQtZeCgUJF
         6fmA==
X-Gm-Message-State: AJIora8PEI1ChA8lCYr7xPB56AhETKZgYJmAEWGNJp/OibGNst8LCoSU
        OXHTTmNEtj7wom1FYCNOyt3nkiPhO9t71A==
X-Google-Smtp-Source: AGRyM1t21N8HAGmcNH9eJnMpHCfbie7VcWLvCXHKPCYAxY4x2bZM+BqaSctpshIHuA2/GP/E52kdOQ==
X-Received: by 2002:a05:6000:2c8:b0:21d:1660:e32 with SMTP id o8-20020a05600002c800b0021d16600e32mr12929656wry.99.1656672188566;
        Fri, 01 Jul 2022 03:43:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm6257674wma.1.2022.07.01.03.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:43:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/11] merge-file: refactor for subsequent memory leak fix
Date:   Fri,  1 Jul 2022 12:42:55 +0200
Message-Id: <patch-v2-06.11-d894e97b5ae-20220701T104017Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the code in builtin/merge-file.c to:

 * Use the initializer to zero out "mmfs", and use modern C syntax for
   the rest.

 * Refactor the the inner loop to use a variable and "if/else if"
   pattern followed by "return". This will make a change to change it to
   a "goto cleanup" pattern smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-file.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index e695867ee54..793817f3cb9 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -25,10 +25,10 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
 
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
-	const char *names[3] = { NULL, NULL, NULL };
-	mmfile_t mmfs[3];
-	mmbuffer_t result = {NULL, 0};
-	xmparam_t xmp = {{0}};
+	const char *names[3] = { 0 };
+	mmfile_t mmfs[3] = { 0 };
+	mmbuffer_t result = { 0 };
+	xmparam_t xmp = { 0 };
 	int ret = 0, i = 0, to_stdout = 0;
 	int quiet = 0;
 	struct option options[] = {
@@ -71,21 +71,23 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < 3; i++) {
 		char *fname;
-		int ret;
+		mmfile_t *mmf = mmfs + i;
 
 		if (!names[i])
 			names[i] = argv[i];
 
 		fname = prefix_filename(prefix, argv[i]);
-		ret = read_mmfile(mmfs + i, fname);
+
+		if (read_mmfile(mmf, fname))
+			ret = -1;
+		else if (mmf->size > MAX_XDIFF_SIZE ||
+			 buffer_is_binary(mmf->ptr, mmf->size))
+			ret = error("Cannot merge binary files: %s",
+				    argv[i]);
+
 		free(fname);
 		if (ret)
-			return -1;
-
-		if (mmfs[i].size > MAX_XDIFF_SIZE ||
-		    buffer_is_binary(mmfs[i].ptr, mmfs[i].size))
-			return error("Cannot merge binary files: %s",
-					argv[i]);
+			return ret;
 	}
 
 	xmp.ancestor = names[1];
-- 
2.37.0.900.g4d0de1cceb2

