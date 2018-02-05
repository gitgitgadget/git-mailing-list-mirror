Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB0B1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeBEX4F (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:05 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43093 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeBEXzr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:47 -0500
Received: by mail-pl0-f67.google.com with SMTP id f4so77121plr.10
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BK4+7lSRWh8hw2wAGxwcRknCSO57F3Aj+Hp5y+F1u1Y=;
        b=bZc5Ue0eJTkLkpU3hhRrljVY8Jn5zrmj/vlE72ShfuIiBcxA/ZPPa5GEhniSBmsYNK
         Dp3InUis6Ht0dyUy55dm3E7eq9icjdtiRrn2KhYkhNxAtyziJqz3HMRFMvgpSTXr/LB6
         Aijea3O0xLXnnPlsDaMv+50POnIg2As0S7xqmT+SWdb82YgoqZ+iTwZdrUhF+Jir+iBc
         eA3Xz8JxnsvLccVb9eWZGlqQOXd1Nha/xKYoe9iOivJ3ghONiSzQcHadleGfhHRRFXzb
         y67ddNMhRhQxhi4MgrnkkemX5jGYiJeHRCUJgww7lMXvJiam08Oqm4vzymK8TfpXNPFF
         RR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BK4+7lSRWh8hw2wAGxwcRknCSO57F3Aj+Hp5y+F1u1Y=;
        b=qjFCfjs8VR+qFAbomeRwSPns2xTrtn6CaQCRlNLKyTpTo+lIKfbmveuCSQl3rxp9ly
         4NjbxBRMwdqrRiKZPSx11c0kmzqjKWrYp7qah94ntP43XRTtrJ+xL8Wp/UdBtBWADS86
         rndl7wLTJzKa9V5G0vwFfpVIrmBsKpylHMGwIyRapbR9v3VhAXxlGS4DTLBMaBzTGo9y
         kj2EbAY06B3FccrzDRPz8F2rsHCM4Ph32gx7ryGySj80AMyUEzA0wzH6h7CK5CMfOzoD
         BzHh+koChy8yCkiqKWamhCgzBxa7VRFW/kKzl//ePRYwklfTHg+E8IE4DL7/4+8rY57l
         /sJA==
X-Gm-Message-State: APf1xPDyDJkBs+ekzKhAcyVizmormxQyW2Mo6Dfo1r0mZQQgc3v6b+Ml
        FP93NBZgUQhSvKbgDaw5aZEWSg5+aH0=
X-Google-Smtp-Source: AH8x2262S+4NbXuLQxIEJ61D02zq473UkldL/j+0f8IwglCOywreu9rgyl5zA701KQMKkc85QJJkhw==
X-Received: by 2002:a17:902:8f8a:: with SMTP id z10-v6mr457911plo.395.1517874946477;
        Mon, 05 Feb 2018 15:55:46 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w27sm15049011pge.54.2018.02.05.15.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 010/194] sha1_file: add repository argument to stat_sha1_file
Date:   Mon,  5 Feb 2018 15:52:04 -0800
Message-Id: <20180205235508.216277-11-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
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
index d9f9046f31..6abdb8c488 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -875,8 +875,9 @@ int git_open_cloexec(const char *name, int flags)
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
 
@@ -1174,7 +1175,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(sha1, &st, &path) < 0)
+		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
@@ -1373,7 +1374,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
-	if (!stat_sha1_file(repl, &st, &path))
+	if (!stat_sha1_file(the_repository, repl, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 
-- 
2.15.1.433.g936d1b9894.dirty

