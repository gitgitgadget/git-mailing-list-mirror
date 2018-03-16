Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62BC11F404
	for <e@80x24.org>; Fri, 16 Mar 2018 19:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeCPT2c (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 15:28:32 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34679 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbeCPT2K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 15:28:10 -0400
Received: by mail-lf0-f68.google.com with SMTP id l191-v6so16970786lfe.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 12:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmMMGck09IZl56BfnkKWAK5uGYSMz89Z6tckjxZ0xuA=;
        b=YyDw7GGFrpBUbbfblbJC+tThzcTVF3ugLNM06QRTD3UBQJtti0JmUdkkpVYaBuF+Bt
         tjBncnzoAt3gU21rVJCmM3vcof3pOSbidl689cZuhxqK3NF1SZO0lzHFeRwd3fTtpN7Q
         aiWqms+AbFPTWGhfNfc2v+6UDsvyoj3DuiKhQK59Gzc5U1CX6tWcweBikaKKMQhIR8QD
         EMoNz4D81TXQHWaG6Q1kMZQwpkqg5w8GI6vkZBvygbOGdIm1uvMjtO0LsS7FbHYZQp2K
         SujiPyR26s/OCpUcHEKjFHe2trDS49c2a8YD0SnD3roVxzhGzYjbBTtkyKaa2bBdGwM8
         JVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmMMGck09IZl56BfnkKWAK5uGYSMz89Z6tckjxZ0xuA=;
        b=meRzhUr1Bzc8OAXOMXd1T4TH0CcjpdR+0x7jvyOdCWw0vsrzP98VI0q5wgutSYnGtV
         1RCPFHmRpAK8qQ0prDBuQUYuxdOrYs2mj87Tr2lhixdp4d0vJsyOM5NaPgcWemeXcSJz
         HWpGN1QzZxzdyQqaJmuxP2NMcyuHgjfyOXuUXxP949wJzfvCMXNUwEfaZgnrGjAW//bt
         wg/cOyhqK1+X1lTA7B4KgmK9dBAhzQbI1XhFTV+BCEjTFa9IvV3mWbZQ91rE+2VEmjoZ
         +9LpbybNKaNwOBCnUD6ewrNAeUw20UAsKNbW4h+hFG93Nrt+AQczJLhcv1CyXn/Q4VGA
         Jzkg==
X-Gm-Message-State: AElRT7HdLWIm3YQ5iKfBTWpYrrhxW7rZfUKvZGAFdgrdv6w/3W3Mj3EY
        hDrLHydrXBqrZnxKw41bkN8=
X-Google-Smtp-Source: AG47ELvj5cVeSUBM2LQJCnKqlxcGWqXD/jz+FLc7tMiGKfT7aRF4ocEmQto7si6nKijr9Nd6qm6bKg==
X-Received: by 2002:a19:8d93:: with SMTP id p141-v6mr2201165lfd.24.1521228489310;
        Fri, 16 Mar 2018 12:28:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm1766085lja.41.2018.03.16.12.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 12:28:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 3/7] gc: detect base packs based on gc.bigPackThreshold config
Date:   Fri, 16 Mar 2018 20:27:41 +0100
Message-Id: <20180316192745.19557-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180316192745.19557-1-pclouds@gmail.com>
References: <20180306104158.6541-1-pclouds@gmail.com>
 <20180316192745.19557-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --keep-base-pack option is not very convenient to use because you
need to tell gc to do this explicitly (and probably on just a few
large repos).

Add a config key that enables this mode when packs larger than a
limit are found.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt |  6 ++++++
 Documentation/git-gc.txt |  6 ++++--
 builtin/gc.c             | 26 ++++++++++++++++++++------
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57e9cf10c..c12c58813c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1549,6 +1549,12 @@ gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
+gc.bigPackThreshold::
+	If non-zero, all packs larger than this limit are kept when
+	`git gc` is run. This is very similar to `--keep-base-pack`
+	except that all packs that meet the threshold are kept, not
+	just the base pack. Defaults to zero.
+
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` won't run
 	unless that file is more than 'gc.logExpiry' old.  Default is
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 1717517043..89f074f924 100644
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
@@ -81,7 +82,8 @@ automatic consolidation of packs.
 --keep-base-pack::
 	All packs except the base pack and those marked with a `.keep`
 	files are consolidated into a single pack. The largest pack is
-	considered the base pack.
+	considered the base pack. When this option is used,
+	`gc.bigPackThreshold` is ignored.
 
 Configuration
 -------------
diff --git a/builtin/gc.c b/builtin/gc.c
index 362dd537a4..849f0821a9 100644
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
2.16.2.903.gd04caf5039

