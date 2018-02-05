Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B177A1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBEX42 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:28 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33845 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeBEXz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:57 -0500
Received: by mail-pg0-f67.google.com with SMTP id s73so125469pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RIjqRdw+YcNvRJVbSRM4tzOMF7Jn1jWlexyio9+axtQ=;
        b=C73v/+fM5WTNnQdrnBv482F7pnZqBWwo/NjFP0tVekfc+UrqBi6wwDO/uqDXpKpKoY
         7JO8KQdzY8niZXdapSIpZ9AkFZo1ucvefDZjZZ7aDii5tY7gJmydBdSAwVgfN+DkBZF6
         B+CGLabJX5N+k/rhZnEUGjuMiq8fvi5vi0DqyNilmzq50ICg6tC4dGDgaYNg9paYYESi
         6uOqCmWZZlr47x17nD3dsc2vLWs1iytzsHKVQ4AoBGjJbWCkTvkVLHrwKIiyHxFbDrLT
         FGiYuzRf/cT1bExGCLh5U+N35neX5JCg71hnrqHi4YbVX4N+lfmn++rlOYc9y0ytH1EC
         juSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RIjqRdw+YcNvRJVbSRM4tzOMF7Jn1jWlexyio9+axtQ=;
        b=LnNelJbnuG1su0YTPch+6jM6dXssMwSvR146UgRZxMgiEUVK68Sh8K39AzWhpdy009
         2PmVx0BuLZnpToW1zMUmcvvMP8ZDiicnYt+8r4goVbr2A5NFKa6dkgaMXbyGtDEtOoft
         tQHCkLBDgafjaeqsH+rI+w4puiDxPF36OChzySC56vMvpCpYixEKUY31JXeQmeZLbHy+
         GaYNOp4I8zwJ/rAAFiXG9IRIyT026cT5jjfnNLWt+U5TWxI3ZcUUSB17SGHKkXpSe48w
         3YJETZXV3GKiy57zRelaumQoTmln9hYQ3vnJbWoKdcQHIDTKbbQXV5CpeqPS9Q06noff
         Pd1A==
X-Gm-Message-State: APf1xPA9jCZRxlnYCP0ETplt83MPd5Iqb3++vZ0vLwtScTRWO7+Zgl7k
        2UKaab2gsVAruPMkwH4u9SrcKkTzaHQ=
X-Google-Smtp-Source: AH8x225dVWNln3FR8c4UURNzQpdlUIItI5uZz+hCKCklrhCUU/FLrCfMPIQpB8a5YEQ1viKAKFs3Tg==
X-Received: by 10.101.81.13 with SMTP id f13mr400956pgq.242.1517874955939;
        Mon, 05 Feb 2018 15:55:55 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t69sm21128998pfa.180.2018.02.05.15.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 017/194] pack: add repository argument to prepare_packed_git_one
Date:   Mon,  5 Feb 2018 15:52:11 -0800
Message-Id: <20180205235508.216277-18-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow the prepare_packed_git_one caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 0f63ec79c8..58473660cd 100644
--- a/packfile.c
+++ b/packfile.c
@@ -726,7 +726,8 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-static void prepare_packed_git_one(char *objdir, int local)
+#define prepare_packed_git_one(r, o, l) prepare_packed_git_one_##r(o, l)
+static void prepare_packed_git_one_the_repository(char *objdir, int local)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -878,10 +879,10 @@ void prepare_packed_git(void)
 
 	if (the_repository->objects.packed_git_initialized)
 		return;
-	prepare_packed_git_one(get_object_directory(), 1);
+	prepare_packed_git_one(the_repository, get_object_directory(), 1);
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(alt->path, 0);
+		prepare_packed_git_one(the_repository, alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
 	the_repository->objects.packed_git_initialized = 1;
-- 
2.15.1.433.g936d1b9894.dirty

