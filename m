Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82714C433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0AC61A3A
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354541AbhJAObQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbhJAObN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26ECC06177D
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h15so14186066wrc.3
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4kbRbk6/As74d17uhCKxB2R7ExVlYE90YOoON1Fp7VU=;
        b=abNgnSJzOg7UMkKqWgJECRecr+z5MFY8VA+oAM+jtnFZ/GhncJe5MaOEB9WIu4F5a+
         nXli9ISb4CqCIxwG1seM8BWhvsItCFrcvTI9dkRb/oE8QuKJioa+Hy4AmswEZOQTV4g9
         ah8lMwhCLRfGMBStvfrPwVJQmTD20xrqlZvsQPGr70a3Q8HfH3Bzlm+VGcEfdfEmRiKQ
         udsyAcSVrBSeBPQlnVf1Dk9a2XmC31nisCIv8ESxy57uHQVenCn/gIlekkYKG+Udy9yY
         Z+5WwZzqb7wgduQ4Xa6MuQIkag0Cddcy2HWcg0uci9LpMnhkYKndk5h5zZ3BbXAzhLlH
         0lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4kbRbk6/As74d17uhCKxB2R7ExVlYE90YOoON1Fp7VU=;
        b=5PbTB5a/JV6wi+OCfHSPoQy4lgz3X3n6+hFidVURWe4zWtz7KeWJ65RZosfLY22aLb
         FcpZmzHbszaJIg5OOliEwKJYoqeopIfOVMwdVRwy6BxRgceWYeVt4S3td9pW0MKYW6Sd
         fgsBp71I5aLNmSXf2lXbAmaBiSgWmeVT6oJv2OI1RD/OPIdd7CD8F3WyOmkeihB9OS6f
         9ttpEKUUzvAwflHurxcIrg/2oFxYVsXfj4j3+sNg6NVwACHrlzV2D686gprCwS52xv4g
         Hks4pC+bFkKz+c4+STdBx+2VEq7g6mhalnBY6fsmaTzH/ypGzmwPyEN/Qsmf8vUKB3WZ
         +mzg==
X-Gm-Message-State: AOAM530zOzXFVik+QvaPgEz3Ees1rhN4hO7lPX89TrB4DaCWux/ZRwJb
        gL4kVyj4CWIeSBOw8foQ0ItfPSZ8VQuIRQ==
X-Google-Smtp-Source: ABdhPJxAXuFgrKg2qqlbfEZaYPEVMYWWMSbRpj7wGTmynxLMChRlwscuZZkpJ51o1q3pP3VFbYLYMg==
X-Received: by 2002:a5d:6ace:: with SMTP id u14mr13245451wrw.206.1633098567032;
        Fri, 01 Oct 2021 07:29:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/11] parse-options.c: move optname() earlier in the file
Date:   Fri,  1 Oct 2021 16:29:13 +0200
Message-Id: <patch-v2-07.11-e82a4e477d5-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for making "optname" a static function move it above
its first user in parse-options.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index dedd40efec5..2cf6f4d01c1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -22,6 +22,21 @@ int optbug(const struct option *opt, const char *reason)
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
+const char *optname(const struct option *opt, int flags)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	strbuf_reset(&sb);
+	if (flags & OPT_SHORT)
+		strbuf_addf(&sb, "switch `%c'", opt->short_name);
+	else if (flags & OPT_UNSET)
+		strbuf_addf(&sb, "option `no-%s'", opt->long_name);
+	else
+		strbuf_addf(&sb, "option `%s'", opt->long_name);
+
+	return sb.buf;
+}
+
 static enum parse_opt_result get_arg(struct parse_opt_ctx_t *p,
 				     const struct option *opt,
 				     int flags, const char **arg)
@@ -1044,18 +1059,3 @@ void NORETURN usage_msg_opt(const char *msg,
 	fprintf(stderr, "fatal: %s\n\n", msg);
 	usage_with_options(usagestr, options);
 }
-
-const char *optname(const struct option *opt, int flags)
-{
-	static struct strbuf sb = STRBUF_INIT;
-
-	strbuf_reset(&sb);
-	if (flags & OPT_SHORT)
-		strbuf_addf(&sb, "switch `%c'", opt->short_name);
-	else if (flags & OPT_UNSET)
-		strbuf_addf(&sb, "option `no-%s'", opt->long_name);
-	else
-		strbuf_addf(&sb, "option `%s'", opt->long_name);
-
-	return sb.buf;
-}
-- 
2.33.0.1374.gc8f4fa74caf

