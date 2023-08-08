Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20D3C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 17:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjHHRjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjHHRjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 13:39:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3009FE40
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:17:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-997c4107d62so815573966b.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691511376; x=1692116176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9t6C32HznlUUgTno0LonkMIkFpgkhi67juLyYVen+s=;
        b=VAxUuBypOYkl96g52DLUIRsi7+71FUAEUR43beDUxktvY20E/IO5NloC2jQsKH4/UQ
         HQJR58fqcGfrRNKCMu1LWUOiBdDxrnvw6OZQ+g/tt5V7OtfqyDBNYD0eGUUZEVQSspdZ
         svNVNcI2896TwEGEZU9wDo0g++/ayPqWRwSu34sGBKOcP53Io3J8ObvcR/6DpmWBqD/n
         yxy8AYAqqgofGuBkUTIH6XbUm9Vh5IXpZwtuMpzStGLJpZjFG0Lc6fN5PAkuJvFUPRbj
         0fIIdovEEUtoH30BE8Bjz+/RzwewObRAOn8B1ZXs2zRnE+6CzUFQvXXVL0agcnPpLFd1
         nj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511376; x=1692116176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9t6C32HznlUUgTno0LonkMIkFpgkhi67juLyYVen+s=;
        b=FfF1+hSgRuyA+n39Z4T3Wiqm9sDSxXo9vFdKENbzwR+MJuXwHxrW66/5ceqPF0TZXO
         srDq4Ssiq0iX/FSEjQaTfuJRcp/Pfv1cyKXag5WDBKAtSZp3BvElgrdoZUM2FjrRJm5F
         zoyecsFckdUrBr6ZrPBnrg6gOPa43LvNrSwn6d/w4iGPG59Zb/lW3k4zZRBzF4aqIfNH
         exw0/QVIj+8+aLX03CiW3MZCyjbgt/QVtzEnt5xqlHRUQJfKgDIBIdQQITNkrg+GpMlp
         a0ij2wUPrU8Yb/Wp45jG0wQFbmyK1sEh/0m7Tixxw6xLv4KrtSPb24bcB5jKrl3/7mzL
         hgbw==
X-Gm-Message-State: AOJu0Yz7z5q1ovQINjEjlz3JIl81N4tWsHbIb+Q2vCuJkrMrCuKr7ZYZ
        FKqf6KpWBfbhidLeLtSYqUWonNwwk78=
X-Google-Smtp-Source: AGHT+IGhC02LSXhgkAFQVrXzUjcdPp9kVv3qfeRAOQy/5S1dll8hQQAJ1y+FKF0HFk9+kEO24dNbyw==
X-Received: by 2002:a5d:560d:0:b0:317:6470:3271 with SMTP id l13-20020a5d560d000000b0031764703271mr7931611wrv.45.1691483192308;
        Tue, 08 Aug 2023 01:26:32 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:9200:db98:c1c8:97d0])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003140fff4f75sm12845707wrz.17.2023.08.08.01.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:31 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 4/8] repack: refactor finding pack prefix
Date:   Tue,  8 Aug 2023 10:26:04 +0200
Message-ID: <20230808082608.582319-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc0.8.g76fac86b0e
In-Reply-To: <20230808082608.582319-1-christian.couder@gmail.com>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com>
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
index 96af2d1caf..4e40f4c04e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -783,6 +783,17 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	return finish_pack_objects_cmd(&cmd, names, local);
 }
 
+static const char *find_pack_prefix(char *packdir, char *packtmp)
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
2.42.0.rc0.8.g76fac86b0e

