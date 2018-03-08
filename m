Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA41D1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935829AbeCHLnI (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:43:08 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41503 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935780AbeCHLnH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:43:07 -0500
Received: by mail-pf0-f195.google.com with SMTP id f80so2225137pfa.8
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3iWYieYryCFnd3i8Pvsyv9PiEta3928/f2hYzi4fn8=;
        b=jwG4Q+PP+2l8+2t3usDpWLXzxg8adYG3l0hd7b4wJEgrdltIG3mNZGB75XoxCV5fBM
         6U752oTLY6+fFlTF7ugO/TAXzDsSNbjoXgFDiMGpK2NAZw7Xi/l0zpNO+kwmHVhJKr88
         ynK+jAR0kt4e7K/KduxWYSbP/J0MK8raMY5uZOUyx2/bMLqjy1FURpNlo04zEtTWtI6N
         83keb/cLoFNfY/TGpwIQle8BDNtTvZKsketfEVDL/EmwtG3c0byZKZiqvppEqUbSHqmd
         0RmI5sA9qqzmps+TJVJzlTPORzeUU21KmDAcviNGWXV3W7sAafpaVBeD4OOfQlnFMx5d
         gdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3iWYieYryCFnd3i8Pvsyv9PiEta3928/f2hYzi4fn8=;
        b=QwXW0buNjaH0x/26Ygjzb6ZCC90ZMVo6uSqPkuDy0MUrvNEwdiU9WsLIXzeNYvH+rC
         4qpUQCh3V86udndPDZ5YgZlo/vPDLP4Zqt4efbGmHdZXP6w+SM0govx0p5JyWbNg8o+D
         CM5Gg2q7upKLA8bn0Rb5ciR27TeXB0Id6aDu0YzkXetnc6Del04gR9Vma5/GKoVmZowH
         MfdMwOs0LoIVtCz8oEl4InkZCsmukZ3qUCjPlcxXADlT4jJ+uc/R254nbP099CVaOU5v
         M7mo3rcIETnCraIVg2IMI+IHI8VuJxzTsWtJFgUBwJ1cOxzWi78+vmsPlvBbPYQB5QR6
         kZBg==
X-Gm-Message-State: APf1xPC/M0Xr9LOm7zTORYPGmjRF/QT3TRjbt13vTFg+YKMPdOQoGKfX
        SajXHZAP72r2B7bhD2qq60o=
X-Google-Smtp-Source: AG47ELt/aoITP2SPanTdqQplnp4OJ6QykV6dG7mE9W4FVjwlN99sU+lPxOMwb2wpIIyHAmy3BQX1aA==
X-Received: by 10.99.110.70 with SMTP id j67mr20926179pgc.202.1520509386554;
        Thu, 08 Mar 2018 03:43:06 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id c18sm42317246pfd.100.2018.03.08.03.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:43:06 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:43:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 04/12] pack-objects: use bitfield for object_entry::depth
Date:   Thu,  8 Mar 2018 18:42:24 +0700
Message-Id: <20180308114232.10508-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.873.g32ff258c87
In-Reply-To: <20180308114232.10508-1-pclouds@gmail.com>
References: <20180303024706.31465-1-pclouds@gmail.com>
 <20180308114232.10508-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This does not give us any saving due to padding. But we will be able
to save once we cut 4 bytes out of this struct in a subsequent patch.

Because of struct packing from now on we can only handle max depth
4095 (or even lower when new booleans are added in this struct). This
should be ok since long delta chain will cause significant slow down
anyway.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt           | 1 +
 Documentation/git-pack-objects.txt | 4 +++-
 Documentation/git-repack.txt       | 4 +++-
 builtin/pack-objects.c             | 4 ++++
 pack-objects.h                     | 8 +++-----
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57e9cf10c..9bd3f5a789 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2412,6 +2412,7 @@ pack.window::
 pack.depth::
 	The maximum delta depth used by linkgit:git-pack-objects[1] when no
 	maximum depth is given on the command line. Defaults to 50.
+	Maximum value is 4095.
 
 pack.windowMemory::
 	The maximum size of memory that is consumed by each thread
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 81bc490ac5..3503c9e3e6 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -96,7 +96,9 @@ base-name::
 	it too deep affects the performance on the unpacker
 	side, because delta data needs to be applied that many
 	times to get to the necessary object.
-	The default value for --window is 10 and --depth is 50.
++
+The default value for --window is 10 and --depth is 50. The maximum
+depth is 4095.
 
 --window-memory=<n>::
 	This option provides an additional limit on top of `--window`;
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ae750e9e11..25c83c4927 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -90,7 +90,9 @@ other objects in that pack they already have locally.
 	space. `--depth` limits the maximum delta depth; making it too deep
 	affects the performance on the unpacker side, because delta data needs
 	to be applied that many times to get to the necessary object.
-	The default value for --window is 10 and --depth is 50.
++
+The default value for --window is 10 and --depth is 50. The maximum
+depth is 4095.
 
 --threads=<n>::
 	This option is passed through to `git pack-objects`.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a4dbb40824..cfd97da7db 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3068,6 +3068,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
+	if (depth > (1 << OE_DEPTH_BITS))
+		die(_("delta chain depth %d is greater than maximum limit %d"),
+		    depth, (1 << OE_DEPTH_BITS));
+
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
diff --git a/pack-objects.h b/pack-objects.h
index 628c45871c..4b17402953 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -2,6 +2,7 @@
 #define PACK_OBJECTS_H
 
 #define OE_DFS_STATE_BITS	2
+#define OE_DEPTH_BITS		12
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -89,12 +90,9 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 	unsigned dfs_state:OE_DFS_STATE_BITS;
+	unsigned depth:OE_DEPTH_BITS;
 
-	/* XXX 20 bits hole, try to pack */
-
-	int depth;
-
-	/* size: 120 */
+	/* size: 120, bit_padding: 8 bits */
 };
 
 struct packing_data {
-- 
2.16.2.873.g32ff258c87

