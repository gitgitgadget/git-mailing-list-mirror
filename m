Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2F9C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjARMqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjARMpa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:45:30 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97482BF19
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:37 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w14so32007867edi.5
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HgRUV8vc+1/isXemg17KC16Xl/Kcpdk3WdYy0RAdlM=;
        b=RicZseMnmYKhAG2XqpPgK6ILZ1eICwrLil3oPlol8TfzSHb3V2LIUxPDz+sh+j9hv6
         kg21NuVeyf4Wf8xYq+n351o2ZeGhaNg9BdPvLgvcNwwOVUxjRhQsjWkgggPwtnxupY6g
         2ST20dkuaYpfIAtiNI2+LVbUBtkBre6i+PLwCy/hVphw0BrGLRdlImIXg/Xn6e65O93n
         Uo42gnJj0AV0ZG4hkjhx7QGR30SF8XoEnfRz5oOm+iFazQMZomGTDKQL/nVud9JF00SX
         uNP0Ij5j4ykRtvzEnomiVfrQsapOFWvlIOYc2Bg9CLYKC2UzQ3V5ufqyz8QVuqfCBli4
         JAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HgRUV8vc+1/isXemg17KC16Xl/Kcpdk3WdYy0RAdlM=;
        b=PCn/1tM56fXZhj5u/9YRTLBMosaQBsbMKvRo+8Hxw7c3ptcLEBdoHBEFUMvahPUqbH
         a3VBireZ+eCUj73vIeGTS6kuX3tMbuCcNeH0s3ajPQ5DDTw1XRFrI4L++hr/z3Ly9BEe
         p8j+e4O1eWbSzi7x9XdQ/1gKimb65IlFDX5voRKSEFZXjEEc6Xfpvq4D39LTBhHlkgWo
         jix7ni8QBTp75APugnh+Csl2jzNQnsI4tyIyo8bPZXQX4PuaC9W3P1rxJ5yOLU2S8DUH
         AACMzE239/QACFkhNbc0wOYA2oyToXfNUKS4a9vExkXhxqBQXF+1WKrhoW34K1Tdikyh
         1cmQ==
X-Gm-Message-State: AFqh2krOZUL+s8y5DYAVjh/ERwkQGkBaIVTCY3B6FSBD4aK/QPIuZ+pc
        bKzPakrSAX9HRLEb3HEVN6MD3hideKHEdg==
X-Google-Smtp-Source: AMrXdXvA93z17jeb+cTWUQ3c2gU+ZlSXg3p4wFMq4PvCpieRHP1pnXfnZdIFpbxH0UPjfNNEYnfpJA==
X-Received: by 2002:aa7:cacd:0:b0:49e:20f9:4ade with SMTP id l13-20020aa7cacd000000b0049e20f94ademr6606642edt.10.1674043716020;
        Wed, 18 Jan 2023 04:08:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/19] bundle.c: don't leak the "args" in the "struct child_process"
Date:   Wed, 18 Jan 2023 13:08:15 +0100
Message-Id: <patch-v5-02.19-9eb758117dc-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak that's been here since 7366096de9d (bundle API: change
"flags" to be "extra_index_pack_args", 2021-09-05), if can't verify
the bundle we didn't call child_process_clear() to clear the "args".

But rather than doing that let's verify the bundle before we start
preparing the process we're going to spawn, if we get an error we
don't need to push anything to the "args".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4ef7256aa11..9ebb10a8f72 100644
--- a/bundle.c
+++ b/bundle.c
@@ -627,6 +627,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     enum verify_bundle_flags flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+
+	if (verify_bundle(r, header, flags))
+		return -1;
+
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
 	/* If there is a filter, then we need to create the promisor pack. */
@@ -638,8 +642,6 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		strvec_clear(extra_index_pack_args);
 	}
 
-	if (verify_bundle(r, header, flags))
-		return -1;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
-- 
2.39.0.1225.g30a3d88132d

