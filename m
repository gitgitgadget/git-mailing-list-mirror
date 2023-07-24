Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B317C001B0
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 08:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjGXI7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjGXI7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 04:59:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC6131
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so1109215a12.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189180; x=1690793980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGphpGKPeucRmByj89WO/k/xCxKR/i7/0c8QtIZngDQ=;
        b=YuDHuZMzZz9mz7ScZxvb1j59qYbmCZVF41OOZZ/V6UFI8SiX2pjwn2OJouUa7ykRQV
         05Veol+/UHmuCfovtrQMyQCtQswCduqxNH2Lj+IEOksfHDN52bm3v3pP0LlbtQGpvtM5
         MKrSIBD2oIUZbzKSanqOJeaUPzZzUT8XaFuRRNuCdp2t1fBxOnr6isbpCwtVgwJTc9SL
         nic/Ax+YP6tTf/8C49MNzUxOO8CGLB6nOT233y38vSO7Gix7MHUqMqDlMTnfEiUSosR8
         q7Zl4QUDxTa2pBhvKpk5IjlSgeV8ILVPoEG4XIbBxDZt2rElTXVoRsw5pVDqThjl6kGE
         0oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189180; x=1690793980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGphpGKPeucRmByj89WO/k/xCxKR/i7/0c8QtIZngDQ=;
        b=VBiPhjlFVflCRj1EY6yh0zgagloBom7OlmP5kn8u0GJLiLRZ/mIA0V2tFzT4qskf4o
         jiCdI/w2iQON7A3/APvlOo68FWVykv9uKo0XUoSHwtIiC6ffJ3OSIHxD5joZ6zMPXOgR
         V/u1krfChzve8f6c2PuJ/w+A3STnBBv7NH22wrvxvq3UUFBozQOSjiVpYBCKaiLiBVyd
         iI7orZE3UbmS/4TA7DJc/SjJLoM8LBgI48K0IrjE3geQqU0H6CcA3gnkc2Tc2AUShK0D
         AZ0xNqTCImvuN87fUJWUcI5LpZpBky3fPXyHllQhPEjirJx/BOpbHiunj1eFLo7OKMbf
         FGrQ==
X-Gm-Message-State: ABy/qLadn/GhdDE5yKfOK+cZnPtmjlJ9LVOuCX1J10PEb10mcDir4csp
        0/BVTszkMKooQjN68ZnscC/jtMUfc6U=
X-Google-Smtp-Source: APBJJlGZ1JVoFh2ztV0qqkw+o6VQhJK07cciSsTZvOslN/91YKxZmkyyLM8jw31qGy7w6L+n6GxvLw==
X-Received: by 2002:a17:906:3088:b0:967:e015:f542 with SMTP id 8-20020a170906308800b00967e015f542mr9315566ejv.44.1690189180465;
        Mon, 24 Jul 2023 01:59:40 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:11c4:4096:3d09:3950:f280:5ec1])
        by smtp.gmail.com with ESMTPSA id rv7-20020a17090710c700b00993a9a951fasm6506665ejb.11.2023.07.24.01.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:59:40 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 4/8] repack: refactor finding pack prefix
Date:   Mon, 24 Jul 2023 10:59:05 +0200
Message-ID: <20230724085909.3831831-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.384.ged66511823
In-Reply-To: <20230724085909.3831831-1-christian.couder@gmail.com>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
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
index 96af2d1caf..21e3b89f27 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -783,6 +783,17 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	return finish_pack_objects_cmd(&cmd, names, local);
 }
 
+static const char *find_pack_prefix(void)
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
+		const char *pack_prefix = find_pack_prefix();
 
 		if (!cruft_po_args.window)
 			cruft_po_args.window = po_args.window;
-- 
2.41.0.384.ged66511823

