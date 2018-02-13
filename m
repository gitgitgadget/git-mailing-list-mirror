Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2031F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933236AbeBMBXR (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:17 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38817 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933228AbeBMBXM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:12 -0500
Received: by mail-pg0-f65.google.com with SMTP id l24so2708406pgc.5
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nxRAah0tC17OT51POcqBJIE8H28qv0abkWrPSD2WXKk=;
        b=XPN47a5y9jkyytnGijufBl1KKj6wo4RkTk/6WycbtXBcgkUCQi/rp4tUAofw016lRe
         yMfj6RiZ40vphH9wc/OV57OqjNmBu+buQCVAIpZu6cCp/uImqjsP3UVBXmCm7GTS62wC
         /c+N2/+S1lepmfnr/tJjMuABmLVxoYtZxlGyrVfvoCIQcyIdZ/vbGvLleve7onA6bWq5
         4PiOxdeyaRviWu1Ydaou1suxPu4CRhfKP2gUMQg2nSlmEfrYBzSvoXAurAAc778kdvTv
         fGh/9YsGOx6INUW7KmcMppL/c/k4bMVKj/HqFXJaYHOOFgN2X+IixVilFbjI+OS2OoN2
         nkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nxRAah0tC17OT51POcqBJIE8H28qv0abkWrPSD2WXKk=;
        b=sUPptRTvY375dPa8coFK5YgMi/Kr60+Se3INneX2UAcIU8zxOEeKwMbowGp0yuzrPV
         ccSnsWzNv8I62oGfGCUXtuPA+AwjTSiLVwpuh+5lQE+oblpo6u3G+3XadARkralYDj4d
         3Qg4HngBlRCud7kMBl75hoGmf5G9PesMgfN19wqenxVyqKXeMsUctHx0KPnVVgGRx9uA
         jyh4HTXzbMAaa5quF0SckA6gwLUTiJ619JFCh0uM7eWAoIdX7Zv9QMa8eRt19i7c0uTj
         kKSUggZ0R1siNqV54tGF3FAesdugJr8RsJ2oFz/u5gvTqZUmpPRdpGu+tLUWe235llGd
         7aUw==
X-Gm-Message-State: APf1xPC2ZndU7Up+FGr+sJ0AvuV4mK+CB9Hf8qoOtFa+4jy8yYXlUeW/
        a9OZBodzfsKtI+MwxujMzW19gw==
X-Google-Smtp-Source: AH8x224nmDwQK95W6ap6nioxyHMrbg1YOMEcf6hv1IxPm3UKfNMfAkdyksWEa1pmMuQSVoY/UevHFw==
X-Received: by 10.98.163.135 with SMTP id q7mr13383188pfl.82.1518484991817;
        Mon, 12 Feb 2018 17:23:11 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v69sm29811307pfi.65.2018.02.12.17.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/26] sha1_file: add repository argument to stat_sha1_file
Date:   Mon, 12 Feb 2018 17:22:31 -0800
Message-Id: <20180213012241.187007-17-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the stat_sha1_file caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 65fefdf4ac..1d81bafe56 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -874,8 +874,9 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
-			  const char **path)
+#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
+static int stat_sha1_file_the_repository(const unsigned char *sha1,
+					 struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 
@@ -1173,7 +1174,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(sha1, &st, &path) < 0)
+		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
@@ -1372,7 +1373,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
-	if (!stat_sha1_file(repl, &st, &path))
+	if (!stat_sha1_file(the_repository, repl, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 
-- 
2.16.1.73.ga2c3e9663f.dirty

