Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3F1C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D624821582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqRvmovJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfLRL0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:21 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:37480 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfLRL0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:17 -0500
Received: by mail-wm1-f42.google.com with SMTP id f129so1482898wmf.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WiHLNDiBzU2tElAJNWa4G3aQ14D40sJWpcuGm33EBgE=;
        b=LqRvmovJ0ATUayGlBQTj9cTRt/GwiXivn1Zihy5glO3536Zi0pOLuSmj3jc4ix9M1q
         ZWqtbl4z4kTieLo+cfdvAXIty1AGcIhmlY1EAcfv3AlpbeXb4DKFeHTnAfn4hgU4DoiG
         gGP0HWUS5f6yUf8UzXhZE2WQzCi9GIQWdx6x8WWz5/TTU/Z3IfV9nVXNjKyVF+O72fLr
         R5J1eHTvgqcY7KZLBfNnHZMfFANhIEXA9tAncQNght/drrG1DE6NYoulV3p0pjT43HAr
         wAnZYhxuFVie5q1YtKe2+fk8mipybP1ql7VUEc//Odov+Rvpan99+yTXlgPKe0O09eTK
         Momw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WiHLNDiBzU2tElAJNWa4G3aQ14D40sJWpcuGm33EBgE=;
        b=SOklMLE2RBxOCkRDdOtnEcfQZsIE5rndv0TvrY95cf6yGDzancs9pDs8MpuRmu7aYT
         rytefTUgGz45kc+ZQFNZf4EyelgXwsNoJQAOrTP7a8r+L96Pp6XPokOUMFcMmbQIgyp4
         TbZeombnfZFX0HvOUSpNN/y3Lb6pIiM8USBmci9dv7XC51fgq+ChdlRqie6J5NLRcJ8w
         AfXtVspf4USUwuvDEbLaJwl1KufFsWLQhfO/NWRAkCV3UN6+A1KCrPVRsbB3EOxLdIxa
         27MB4w6S9g7nD/L+hJn7oxQmKdUPYMJQfUUh0wZ7sXY5IbDsJTxFz98mPz52FYc4UAB0
         5DDQ==
X-Gm-Message-State: APjAAAVT7XHclLp1Vi4BcEEADhpnFhBRWRatO06TlSaITN1lsB0S/QlB
        tDMQXFd1ZtYP6YZc6SXxnwvGkZx7
X-Google-Smtp-Source: APXvYqzFhSYvZ0GV/gDNdFkumai3U5Jq2mSJT1XJdIf/ZxndbfOwQONHL8DY/6k8BeL2zlMvSbST0Q==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr2667021wmf.113.1576668375195;
        Wed, 18 Dec 2019 03:26:15 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:14 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4 08/12] pack-objects: introduce pack.allowPackReuse
Date:   Wed, 18 Dec 2019 12:25:43 +0100
Message-Id: <20191218112547.4974-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.1.498.g561400140f
In-Reply-To: <20191218112547.4974-1-chriscool@tuxfamily.org>
References: <20191218112547.4974-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Let's make it possible to configure if we want pack reuse or not.

The main reason it might not be wanted is probably debugging and
performance testing, though pack reuse _might_ cause larger packs,
because we wouldn't consider the reused objects as bases for
finding new deltas.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/pack.txt | 7 +++++++
 builtin/pack-objects.c        | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 1d66f0c992..0dac580581 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -27,6 +27,13 @@ Note that changing the compression level will not automatically recompress
 all existing objects. You can force recompression by passing the -F option
 to linkgit:git-repack[1].
 
+pack.allowPackReuse::
+	When true, and when reachability bitmaps are enabled,
+	pack-objects will try to send parts of the bitmapped packfile
+	verbatim. This can reduce memory and CPU usage to serve fetches,
+	but might result in sending a slightly larger pack. Defaults to
+	true.
+
 pack.island::
 	An extended regular expression configuring a set of delta
 	islands. See "DELTA ISLANDS" in linkgit:git-pack-objects[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 369f46fbc5..801e23dfe7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -96,6 +96,7 @@ static off_t reuse_packfile_offset;
 
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
+static int allow_pack_reuse = 1;
 static enum {
 	WRITE_BITMAP_FALSE = 0,
 	WRITE_BITMAP_QUIET,
@@ -2699,6 +2700,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.allowpackreuse")) {
+		allow_pack_reuse = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
 		if (delta_search_threads < 0)
@@ -3030,7 +3035,8 @@ static void loosen_unused_packed_objects(void)
  */
 static int pack_options_allow_reuse(void)
 {
-	return pack_to_stdout &&
+	return allow_pack_reuse &&
+	       pack_to_stdout &&
 	       allow_ofs_delta &&
 	       !ignore_packed_keep_on_disk &&
 	       !ignore_packed_keep_in_core &&
-- 
2.24.1.498.g561400140f

