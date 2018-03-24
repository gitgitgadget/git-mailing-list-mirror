Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE8B1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbeCXHnj (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:43:39 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34273 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCXHng (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:43:36 -0400
Received: by mail-lf0-f66.google.com with SMTP id c78-v6so16712520lfh.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXzbpYdIbY9aPQofjmc5Hl4RV/CuJxOtGS2aCELbiWo=;
        b=HQPLRAJ6Xd0ubdsdI9b2Yc9LBHHZ8KJnMvsbRGl/I7evB/cp86VdkfMnTtu0TABA3c
         t9MtihkuMTBWF8A8wQh59fBfVScIZbgotuboraNwyjfqGMeaTcuuPsc60zpDNpm07Do5
         w/5DS7dEf6rSH1d7hzBGFbWUlR/N0SWJmmHt8kQMgzyQYn993w+Wu1A8MaFlvakHxF3C
         KiQn7jAttonWxjSOvk6C8ZNuFSoCCi/KAVy0jMSX1zn7kL8qys7MUV4cKlJ2W/umrcB3
         3L57RFq7QWkGwZhd8/DP4kx5v9GSczp+fdyxdMWxeRB3X44AG5Rm0dGkKhjMyzM4yTYw
         sNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXzbpYdIbY9aPQofjmc5Hl4RV/CuJxOtGS2aCELbiWo=;
        b=f1sFDy0OozX3tkWWVI/zrhAvglK7n9d5zMRMzW+ce944JGDeF4ByOZeFU+YTUGDtbI
         um4+U+a6v9v/HqBteEay4wwjJVMfhNu2mjJXdR9OgMX3ugLLN+zUXymntv9rR85wzZlz
         v9SqBpYF1vaZH44l6WLeJ9CcIbq0RALoIsg4u9YRs/lrdoHdBMpad06v0IFVY1vSEzhB
         jrbn5bSGkpW4C//DwgN86y1zMHq6nfj3L+jl+YdmC0hlRSs/xPKf+Xc1CYrZWligVeF/
         a2PPxNxOnzIK5tc61NhrLjL373pvKAdr/ZETVlD6MTFXwnJTpoUtszebyMXhiJltpZus
         vAKw==
X-Gm-Message-State: AElRT7HL93uLblHt0iS1PRO6t6xC66yZulX/EI6wFohVlzyegHqxZAxN
        /2dWS8Dsx+ZiXZ78/DqqBTU=
X-Google-Smtp-Source: AIpwx4986D/9AMcVAiMwBRG9g88iOXICtfP/f+44DKHyaCjey+cqDRo47+R9bQ+TnlkKbHUzTtBI5Q==
X-Received: by 10.46.17.23 with SMTP id f23mr6653525lje.43.1521877414809;
        Sat, 24 Mar 2018 00:43:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o132-v6sm2642867lfe.91.2018.03.24.00.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:43:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 4/7] gc: add gc.bigPackThreshold config
Date:   Sat, 24 Mar 2018 08:42:32 +0100
Message-Id: <20180324074308.18934-8-pclouds@gmail.com>
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

The --keep-largest-pack option is not very convenient to use because
you need to tell gc to do this explicitly (and probably on just a few
large repos).

Add a config key that enables this mode when packs larger than a limit
are found. Note that there's a slight behavior difference compared to
--keep-largest-pack: all packs larger than the threshold are kept, not
just the largest one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt |  8 ++++++++
 Documentation/git-gc.txt |  6 ++++--
 builtin/gc.c             | 26 ++++++++++++++++++++------
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce9102cea8..d63db3f12c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1558,6 +1558,14 @@ gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
+gc.bigPackThreshold::
+	If non-zero, all packs larger than this limit are kept when
+	`git gc` is run. This is very similar to `--keep-base-pack`
+	except that all packs that meet the threshold are kept, not
+	just the base pack. Defaults to zero. Common unit suffixes of
+	'k', 'm', or 'g' are supported.
+
+
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` won't run
 	unless that file is more than 'gc.logExpiry' old.  Default is
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index bf81b8de30..0adf381b52 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -55,7 +55,8 @@ all loose objects are combined into a single pack using
 disables automatic packing of loose objects.
 +
 If the number of packs exceeds the value of `gc.autoPackLimit`,
-then existing packs (except those marked with a `.keep` file)
+then existing packs (except those marked with a `.keep` file
+or over `gc.bigPackThreshold` limit)
 are consolidated into a single pack by using the `-A` option of
 'git repack'. Setting `gc.autoPackLimit` to 0 disables
 automatic consolidation of packs.
@@ -80,7 +81,8 @@ automatic consolidation of packs.
 
 --keep-largest-pack::
 	All packs except the largest pack and those marked with a
-	`.keep` files are consolidated into a single pack.
+	`.keep` files are consolidated into a single pack. When this
+	option is used, `gc.bigPackThreshold` is ignored.
 
 Configuration
 -------------
diff --git a/builtin/gc.c b/builtin/gc.c
index 9a09cf53b0..53a0500898 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -39,6 +39,7 @@ static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
+static unsigned long big_pack_threshold;
 
 static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
 static struct argv_array reflog = ARGV_ARRAY_INIT;
@@ -126,6 +127,8 @@ static void gc_config(void)
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
 
+	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
+
 	git_config(git_default_config, NULL);
 }
 
@@ -164,7 +167,7 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
-static void find_base_packs(struct string_list *packs)
+static void find_base_packs(struct string_list *packs, unsigned long limit)
 {
 	struct packed_git *p, *base = NULL;
 
@@ -173,7 +176,10 @@ static void find_base_packs(struct string_list *packs)
 	for (p = packed_git; p; p = p->next) {
 		if (!p->pack_local)
 			continue;
-		if (!base || base->pack_size < p->pack_size) {
+		if (limit) {
+			if (p->pack_size >= limit)
+				string_list_append(packs, p->pack_name);
+		} else if (!base || base->pack_size < p->pack_size) {
 			base = p;
 		}
 	}
@@ -245,9 +251,15 @@ static int need_to_gc(void)
 	 * we run "repack -A -d -l".  Otherwise we tell the caller
 	 * there is no need.
 	 */
-	if (too_many_packs())
-		add_repack_all_option(NULL);
-	else if (too_many_loose_objects())
+	if (too_many_packs()) {
+		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+		if (big_pack_threshold)
+			find_base_packs(&keep_pack, big_pack_threshold);
+
+		add_repack_all_option(&keep_pack);
+		string_list_clear(&keep_pack, 0);
+	} else if (too_many_loose_objects())
 		add_repack_incremental_option();
 	else
 		return 0;
@@ -462,7 +474,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 		if (keep_base_pack != -1) {
 			if (keep_base_pack)
-				find_base_packs(&keep_pack);
+				find_base_packs(&keep_pack, 0);
+		} else if (big_pack_threshold) {
+			find_base_packs(&keep_pack, big_pack_threshold);
 		}
 
 		add_repack_all_option(&keep_pack);
-- 
2.17.0.rc0.348.gd5a49e0b6f

