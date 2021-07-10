Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C03C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14986135E
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhGJNkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhGJNkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5B6C0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d12so15872340wre.13
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=goA2z589frndjbLtysr/eL3FhfWEVNYdFiFpgdYbtig=;
        b=VYSB9fv87sefrQk3acXbtL6ywdi2s71VPIGEaGm6nv9MKJerMA+YGcto/FdFdQXjbL
         0gHssOAHtX9zOR7+XQa4mJ4sY/ZPBn8aIIi/Lm9+6VykURRYwyJ19QbafqZu4laDkT6a
         AHbmr6tX08K3khGYOtKTSO2SSGC1xLmZkYcsga2pa9DI6Yqzr+j/wEG8YbkyVASWsqJK
         XUvxNLxu8fwkjDUFTpcSQjsT0dTq0cWpp3s/IMDUaXvCZRSalwPMhSn497HVrdw3T9x4
         YhCT3H0f/Go9x75DF2VLxhs3wO46lThGtlvIWoIo0cvd8s4AvDyui5Q9vRv/bzaEQYlG
         zPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=goA2z589frndjbLtysr/eL3FhfWEVNYdFiFpgdYbtig=;
        b=o3gzF8yUmAMNvDk+S6RGSxrlm+TVfbst7q41RH7NVK/LD1Tk0tjWhnjsjwZB2Fu8G6
         RtKKsD98xsQ1zqeI9WEtP7vMH0YUgp9NlCA1yqBpU2A66qRksDW9NszOvCIGculDXaCi
         8G7qnLDEkbYEGC4x93QNKohRYIz5M63qFq1xgnRX/Fv+cYJo9Iqdt6u7SaaW8JPMtDLh
         UQ94gYYIrSZEJQ9iMakypZqHmOSZMFvwAhMFKjOHCVzMfAGTCFi+sXk59b/cBu0ZiAG4
         jQyoAAn4xrfUi5wqWoXAL6+8ID9gpG2VWNe902xLzu2kB2O0U/qziJT+qLMl5ivGKO/s
         TBFw==
X-Gm-Message-State: AOAM531XmNV7ix1ZblTtsKN0N7Y2hA1XPLgdblXytf62tN8x1Z9Ubzxo
        W7ESWLX75lk6DGD6tsXOibJ/Itx/Oqzcfw==
X-Google-Smtp-Source: ABdhPJz8dv4s5tfI26JJ35gQX5+vtmvmA7K5u0oP0V8jrcNiB5lwp4Cp1q855/UAkXjOIXDWdZyi9g==
X-Received: by 2002:a05:6000:1375:: with SMTP id q21mr15932791wrz.147.1625924258496;
        Sat, 10 Jul 2021 06:37:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 11/21] object-file.c: add missing braces to loose_object_info()
Date:   Sat, 10 Jul 2021 15:37:14 +0200
Message-Id: <patch-11.21-31eee4da0e1-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the formatting in loose_object_info() to conform with our usual
coding style:

    When there are multiple arms to a conditional and some of them
    require braces, enclose even a single line block in braces for
    consistency -- Documentation/CodingGuidelines

This formatting-only change makes a subsequent commit easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index e0ba1842272..646ca7f85d6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1450,17 +1450,20 @@ static int loose_object_info(struct repository *r,
 		if (unpack_loose_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
 			status = error(_("unable to unpack %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
-	if (status < 0)
-		; /* Do nothing */
-	else if (hdrbuf.len) {
+	}
+
+	if (status < 0) {
+		/* Do nothing */
+	} else if (hdrbuf.len) {
 		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
 			status = error(_("unable to parse %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0)
+	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0) {
 		status = error(_("unable to parse %s header"), oid_to_hex(oid));
+	}
 
 	if (status >= 0 && oi->contentp) {
 		*oi->contentp = unpack_loose_rest(&stream, hdr,
@@ -1469,8 +1472,9 @@ static int loose_object_info(struct repository *r,
 			git_inflate_end(&stream);
 			status = -1;
 		}
-	} else
+	} else {
 		git_inflate_end(&stream);
+	}
 
 	munmap(map, mapsize);
 	if (oi->sizep == &size_scratch)
-- 
2.32.0.636.g43e71d69cff

