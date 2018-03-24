Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494241F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeCXHnr (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:43:47 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34907 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeCXHnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:43:45 -0400
Received: by mail-lf0-f65.google.com with SMTP id t132-v6so21406155lfe.2
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iprsEwFyfVjBL3yMRv+v9HREafV/iImHLegB/iosrRg=;
        b=Ns5hL3uDulD5tKnwr8h/awSs66usSuXt1qar8F/LkMvL6+Q178rjYAQzBDFdZLrSnO
         vipJ08/bHluS3c4bbO/KzEuNuMuCXL9ZEfDqe1K8OOzJYuWcxyBb0so4WN8H2eMcICFW
         lKvKYKFMmVXIPJLJn6g+3rJueqPDmGuGo2vrszMgwHMM8ngWWPpCpRtEQiojUqaED+A5
         MTdCrf6qgGQ4NvLhkkjR+kvQXLdentWmTHtkQArow48qTJJXpeve0ybPOpbJWkovcJMg
         KRlMpT07RSuG++F+fgguHlxGbOMl70F1YzVoWjURAOCdI7sUElo+dJ0h563kg2a1yJqz
         vcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iprsEwFyfVjBL3yMRv+v9HREafV/iImHLegB/iosrRg=;
        b=P16Eryd0q94eNnnJ7W8FNj5TNKULViPKuTCapt/YmR5RNFb5PK2MD+yLVdC8TFFBI4
         CFQ53xXGYl5WEFZUyG4GlZLuMJwGfHsVMH96jcOtxzIA64z2+vto5s4eizsRURfGFjM9
         ZOEud4IjLdSy2W1bRnos3DzpSRSDHpzDPFXRy4HMRNBOcWPf2xykesqYa0G+A+FebkIO
         0yR57p11NB+IT0eMHbknE2HT+4NQNlmlxAj6L9TfH6YkUOSjXMQ66lS+AxQx9aj1mpoQ
         IjPCFOYn6DpE8Qft9Z57iIeDWImysYLQfietH4ZtLfNa3041G8yr6Jaov2M4XSgxqjmo
         IpuQ==
X-Gm-Message-State: AElRT7FxbAynRZKJTKQ8hPHJIbM3Tkzj8P/zXJvCtLg564kMrSMeRPEp
        6/5BqWD64G9tfjRBb7gnbyc=
X-Google-Smtp-Source: AG47ELueVpDb/NCgCxQsw4P05nJKv+DkBF7tFt24Impaj4a00SIaattAHMAwa/HSkAD2dpLpzEBqBA==
X-Received: by 10.46.152.88 with SMTP id e24mr6187957ljj.7.1521877423794;
        Sat, 24 Mar 2018 00:43:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o132-v6sm2642867lfe.91.2018.03.24.00.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:43:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 7/7] pack-objects: show some progress when counting kept objects
Date:   Sat, 24 Mar 2018 08:42:38 +0100
Message-Id: <20180324074308.18934-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074308.18934-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074308.18934-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only show progress when there are new objects to be packed. But
when --keep-pack is specified on the base pack, we will exclude most
of objects. This makes 'pack-objects' stay silent for a long time
while the counting phase is going.

Let's show some progress whenever we visit an object instead. The old
"Counting objects" is renamed to "Enumerating objects" and a new
progress "Counting objects" line is added.

This new "Counting objects" line should progress pretty quick when the
system is beefy. But when the system is under pressure, the reading
object header done in this phase could be slow and showing progress is
an improvement over staying silent in the current code.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8b2f8b72bf..1379b4cb92 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -44,7 +44,7 @@ static const char *pack_usage[] = {
 static struct packing_data to_pack;
 
 static struct pack_idx_entry **written_list;
-static uint32_t nr_result, nr_written;
+static uint32_t nr_result, nr_written, nr_seen;
 
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
@@ -1096,6 +1096,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	off_t found_offset = 0;
 	uint32_t index_pos;
 
+	display_progress(progress_state, ++nr_seen);
+
 	if (have_duplicate_entry(oid, exclude, &index_pos))
 		return 0;
 
@@ -1111,8 +1113,6 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	create_object_entry(oid, type, pack_name_hash(name),
 			    exclude, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
-
-	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -1123,6 +1123,8 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 {
 	uint32_t index_pos;
 
+	display_progress(progress_state, ++nr_seen);
+
 	if (have_duplicate_entry(oid, 0, &index_pos))
 		return 0;
 
@@ -1130,8 +1132,6 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, index_pos, pack, offset);
-
-	display_progress(progress_state, nr_result);
 	return 1;
 }
 
@@ -1717,6 +1717,10 @@ static void get_object_details(void)
 	uint32_t i;
 	struct object_entry **sorted_by_offset;
 
+	if (progress)
+		progress_state = start_progress(_("Counting objects"),
+						to_pack.nr_objects);
+
 	sorted_by_offset = xcalloc(to_pack.nr_objects, sizeof(struct object_entry *));
 	for (i = 0; i < to_pack.nr_objects; i++)
 		sorted_by_offset[i] = to_pack.objects + i;
@@ -1727,7 +1731,9 @@ static void get_object_details(void)
 		check_object(entry);
 		if (big_file_threshold < entry->size)
 			entry->no_try_delta = 1;
+		display_progress(progress_state, i + 1);
 	}
+	stop_progress(&progress_state);
 
 	/*
 	 * This must happen in a second pass, since we rely on the delta
@@ -3212,7 +3218,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 
 	if (progress)
-		progress_state = start_progress(_("Counting objects"), 0);
+		progress_state = start_progress(_("Enumerating objects"), 0);
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
-- 
2.17.0.rc0.348.gd5a49e0b6f

