Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B35E748FC
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 16:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbjJBQzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbjJBQzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 12:55:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537CB8
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 09:55:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so7896587a12.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696265732; x=1696870532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiKMYJQ/PaTtnPf5bQbCqy+J8QZRROkrKfTtX6YN/Z4=;
        b=cqG54nC0bh+Bi3mt4r84+9Xx4EGRmKve14iAucT3ekobXNGKjIEzuMRHZsgzOqDi0K
         No3dixHf0Ohd5Dhsf8FJn/aPdXixQrfhYvYi9LPnxYIpcfcvvN+LswWLR5Rdb8pT+R9p
         AaS8Y5kbq/pZFGit+RcP+KfETxs+tP5UaAShwDMWnoOCleZl8XvNrSr5XJOBDPnxqXyl
         SqSQWExGZPT0mS0q8FToSapBqN8t2NMB80a77aGN0/Kj1yF2AvS/yEmf859+cua8VsB7
         XTiqg9wz3NFF3xxsr9MlFiSRdqkupX5iEyCvaTPnGPJAPLZ7Pf1EBPj4Jn+VL59hQoOU
         33ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265732; x=1696870532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiKMYJQ/PaTtnPf5bQbCqy+J8QZRROkrKfTtX6YN/Z4=;
        b=CVHCqQTuPJEFPe9Zpn9LA70oBHnGY/LN666WrsosIEw0c4Ipe7IG1LZOquHuBxD64U
         vY/lxnM+eXlepN5rg5cOuaL3eXTIclS6wbObmIrTNLvx2VYLESzqXI/dqi4KFqImiDvM
         Gql8rsCCgc9ocyTV4/JQQ5K1uIGAqBnmYd3x/Vf5KooI6NkzvNZvTc2Kl7EjDB5BXVWB
         QCFOBUZsxZ7m8nQ/DuN6CotlPUiotOm03mUPerAgql7QDqlhqp9/jnyGvm+hzXsqv0Rb
         GSswY5FV5TD+wV1JC3W4ohXRTW0dHL3Pyg2rAZhrAo+f/kyktMpjDwUQsZgTMhTa9+/V
         vWvA==
X-Gm-Message-State: AOJu0YzTcUfEjqqfwErbD5YGAZMMorbyd1YDnzN6D0GKaElqDPdk/Y3c
        XcDbhCc+af8C53fjuRl7UDVEjeJjr9n18w==
X-Google-Smtp-Source: AGHT+IEfAkyfn5jLQvHPA3DDpyjJwN7en03o3OGf8tM/XeVAWlywHAZjHkfBw3ai4SEL7uaoGxJ8Mg==
X-Received: by 2002:aa7:d899:0:b0:52f:c073:9c77 with SMTP id u25-20020aa7d899000000b0052fc0739c77mr10297967edq.35.1696265731750;
        Mon, 02 Oct 2023 09:55:31 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:c027:f1d4:d825:fbf4:9197:5c9f])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b00533c844e337sm12762364edb.85.2023.10.02.09.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:55:30 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 4/9] repack: refactor finding pack prefix
Date:   Mon,  2 Oct 2023 18:54:59 +0200
Message-ID: <20231002165504.1325153-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.305.g5bfd918c90
In-Reply-To: <20231002165504.1325153-1-christian.couder@gmail.com>
References: <20230925152517.803579-1-christian.couder@gmail.com>
 <20231002165504.1325153-1-christian.couder@gmail.com>
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
2.42.0.305.g5bfd918c90

