Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2C8C001B0
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 00:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbjHLAAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 20:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbjHLAAt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 20:00:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554FF1BD9
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bcad794ad4so18772515ad.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691798446; x=1692403246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmEraCvZzOa7Xin8vFdDw5QqJGPLjtVJlBjKzAUJsa0=;
        b=FyVB7eN0PMiwyNPue4AxhJmyMG5Pa9bbzxYTe38aLW+H7QDs/1B8B/BC3mOV4o7xaq
         S6rM3xkLW4+hMX/wDKJDL/b4u4EinvAYS+GNFsNtzTgdl+ckCQZgLLdTObcah1jR5zHI
         ZWJpgiNedb3tUd+nOgMmh6hsO1B4bIYs6INMOaG71CUYqrN8tsJzcvhxwQA92ZHZabV8
         lwsWVYF1CwNRQ5V4cVL5CALsASarn59SqkDgHClvLLZhjJSXfVcWoT7hBr620guh2nuS
         C+MNMFz6huT6St3M8E0akZtjOJW+uGogLd/p9V/fzrFBAoOfQz+0nuLpl7VxwTFPhBx2
         aYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691798446; x=1692403246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmEraCvZzOa7Xin8vFdDw5QqJGPLjtVJlBjKzAUJsa0=;
        b=HZOtK9yYK9ve565/hkSJ8wOmvGG5NVFICSuAOJNOC6A1vZ6zPi/CwxkqCSCItZ4zBb
         /eoOv6OrvCIAwV1xTSLUZtPCinp1QbznIp5kry35yeyu6erMQoNMJ9tnwiqL3SI3iJBJ
         vK6/u3mXa+thZXchAO2a3Q/+fHoTCU1z3QSTnVsJr2lyBRXARC5++zr03XDNVOVOWj7M
         JHEWXdkH+vcihQBVkVZrkvwLVOnV8Hg1+6YJHZHYhBqj6hJDCCQdb/7/bUyOGp8N7Bk0
         bIVauZf+UVWEF16iQwz/T3gwPKLCWj+3PMCLEeXxeD3Ls0wHIzyUNd6ePO4aoBQHOm2B
         R3tA==
X-Gm-Message-State: AOJu0Yw5LL/11wnHOKpwPBszdLVWztq4wU/jQWEyYzw8ZQOIyzE5w8ji
        2iLzcLDkLUiNudHsWMCqM7h4pM/cxvpnhA==
X-Google-Smtp-Source: AGHT+IH+JrmROsdV+GW1wJBKmqR023hcxFxzlo6sCmm+BDetUsEZq840tO/TOTW3vRblsCBx5ohlCA==
X-Received: by 2002:a17:902:c085:b0:1b8:6850:c3c4 with SMTP id j5-20020a170902c08500b001b86850c3c4mr2876506pld.22.1691798446177;
        Fri, 11 Aug 2023 17:00:46 -0700 (PDT)
Received: from christian-Precision-5550.. ([129.126.215.52])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709028f8500b001b8a7e1b116sm4478308plo.191.2023.08.11.17.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:00:45 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 4/8] repack: refactor finding pack prefix
Date:   Sat, 12 Aug 2023 02:00:07 +0200
Message-ID: <20230812000011.1227371-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc1.8.ga52e3a71db
In-Reply-To: <20230812000011.1227371-1-christian.couder@gmail.com>
References: <20230808082608.582319-1-christian.couder@gmail.com>
 <20230812000011.1227371-1-christian.couder@gmail.com>
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
index 96af2d1caf..825da1caca 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -783,6 +783,17 @@ static int write_cruft_pack(const struct pack_objects_args *args,
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
@@ -1031,12 +1042,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
2.42.0.rc1.8.ga52e3a71db

