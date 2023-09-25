Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB5FCE7A8C
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjIYP0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjIYPZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:25:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC011F
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405361bba99so62128875e9.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695655544; x=1696260344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8ghgTHs/eKVmRgMp1W2op64pNScf7ZgN2SJ4Kn1efg=;
        b=nB6hh/IO2Z/j0MGV8lCvF1O4ZhJHFgavXu9VEp0u5T/M51ZHZgn15MAY/O7ObfO8mA
         STddXIEKmr3DNPw1bp/gZDRHD5I31PXLZ5cB41v8tWueaHbpLXfPcytd+DMUezZINeXN
         S8ZUORqKcmiJQmA1Fm5RdPIDDeYRadRtXw4DCIY0IuL14obM8G/lwheS8jc8xlm2ZlKO
         a/8xhKjYtvxYTRffWfhjVAc14Nl3yciKS9RGZkpyTwBcYiedL+6dzuH2fjF+5FTJl9yP
         6KwxMbi3HEn2hVNgCYWy7ozsYdJou1IP+Tq7pDxZi1oK+rjb02dOwT9uI92DQqvcn1UF
         /XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655544; x=1696260344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8ghgTHs/eKVmRgMp1W2op64pNScf7ZgN2SJ4Kn1efg=;
        b=pX9p/PitVNkOmZ92PDupRk8a2hcCFTRI14hZGL+1RyUIkVBrDzd1lCfaILWnr6muYx
         Oc7M/t5IoVWhJq/vZEw9hGRhvQgawuTsKwb5hrju9DBbqVvMDwBOnyFfwydf9OeljyxV
         hPJ3bQAyojRmI8MCzwHBlb4HIDppvvC6+I2Ev27RGWUSQGsRggsQ7grla1jGjzNHp5XB
         4cOn/kXo3idfiaSE8rQL6YBrcYWyPqsEcy4vdw5rKi3qg+h0Z2NS0ddwqBkS/iB7Q2th
         aPz9weyZZRF6h1UDc0urbLeVojoowug4aClKIeGgxjPT+DG976r20qw/WrBc+UctuHEP
         W3TA==
X-Gm-Message-State: AOJu0YwjYOpXmGYohWIBMXo/PaudxMLo+uvHpqObU6RbqarnhTdR16Mb
        lKvcFAvrwXFF52CCZICjaRK1UT9COwAEVg==
X-Google-Smtp-Source: AGHT+IFPbHWxQWTJ0CY8vdHn3VeGmpk1tFQeSG3513BYF3BMhqYtTgYmA+/Piw1uPWbcbJB7/qgMBA==
X-Received: by 2002:adf:fe85:0:b0:319:f9d6:a769 with SMTP id l5-20020adffe85000000b00319f9d6a769mr5669359wrr.45.1695655543871;
        Mon, 25 Sep 2023 08:25:43 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:105a:e25e:7421:a01e:ee4a:ba03])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090624c100b009ae3e6c342asm6432045ejb.111.2023.09.25.08.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:25:43 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 4/9] repack: refactor finding pack prefix
Date:   Mon, 25 Sep 2023 17:25:12 +0200
Message-ID: <20230925152517.803579-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.279.g57b2ba444c
In-Reply-To: <20230925152517.803579-1-christian.couder@gmail.com>
References: <20230911150618.129737-1-christian.couder@gmail.com>
 <20230925152517.803579-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new find_pack_prefix() to refactor code that handles finding
the pack prefix from the packtmp and packdir global variables, as we are
going to need this feature again in following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org
---
 builtin/repack.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d0ab55c0d9..9ef0044384 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -893,6 +893,17 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	return finish_pack_objects_cmd(&cmd, names, local);
 }
 
+static const char *find_pack_prefix(const char *packdir, const char *packtmp)
+{
+	const char *pack_prefix;
+	if (!skip_prefix(packtmp, packdir, &pack_prefix))
+		die(_("pack prefix %s does not begin with objdir %s"),
+		    packtmp, packdir);
+	if (*pack_prefix == '/')
+		pack_prefix++;
+	return pack_prefix;
+}
+
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1139,12 +1150,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		printf_ln(_("Nothing new to pack."));
 
 	if (pack_everything & PACK_CRUFT) {
-		const char *pack_prefix;
-		if (!skip_prefix(packtmp, packdir, &pack_prefix))
-			die(_("pack prefix %s does not begin with objdir %s"),
-			    packtmp, packdir);
-		if (*pack_prefix == '/')
-			pack_prefix++;
+		const char *pack_prefix = find_pack_prefix(packdir, packtmp);
 
 		if (!cruft_po_args.window)
 			cruft_po_args.window = po_args.window;
-- 
2.42.0.279.g57b2ba444c

