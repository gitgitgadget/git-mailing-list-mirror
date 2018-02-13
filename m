Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0E21F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933164AbeBMBXp (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:45 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43117 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933161AbeBMBXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:16 -0500
Received: by mail-pl0-f66.google.com with SMTP id f4so5854358plr.10
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dzoS4xK8zztpDsqIF16rsB0Xz1Ko7u4bxRkGLpvP5CI=;
        b=wV8VtNeAioz06nRh8Kdu1zNZttgs7cf3XW2D+Bi43bNl0bV9KcCChP5PHLB87c7bua
         zSmCQv6gfkgYvVFK9YFal8vjwHxHAxmkMtHRIn5Y7xjPP7ZCfk3zZPk4Aka64U7ngcnR
         juljaZ7SV+C3layTQ8eN/LAJoUoQWRJ+QZvEqwAQB4xc1Gp43gE4WLteguCKlRN5tnAp
         eT4Co4Wh1pq0+zqZ9A6p+8OMI6Wjwil7PCs1v100MfTFzU4VrwvknMjAjzFpUQzG6n/K
         atLbk/yy51nDuMgsQOyyd2vYSZIAgs8NTFVkBOcbJDb938UZ+tJeo1VIagPhcEcaVZKH
         yXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dzoS4xK8zztpDsqIF16rsB0Xz1Ko7u4bxRkGLpvP5CI=;
        b=NvFe6s8jzduDBg0BaItS5XzDXTSXj1d0+omvo5yleXFuCRWsQ1wOdJACu02KroLuOs
         n5t+gEeLFLPdVA3+J8l72/aaEV7z7Xvm4VAzlgdLWPMHbDf60D1rbYx2dIoFaysTpWJJ
         N/MZf+q+fk7HDpfpmnLq68TwwqjpRFhHaoCeaAgFNQgK+kKIHHtq4GYALntAsLWMuO/J
         BxIsDELUjjwI4Im0egDdaJlQWOQstNIJGOSMHCLTKKRin04ow6kZWE3O7gDFVf7he8nQ
         BBbieOrMMmFx60FZA07mi0aGILq8blCFTaGpnegdFnWXSpO3bq3vNVnv9ZYm5S1yjGB7
         8Rlw==
X-Gm-Message-State: APf1xPDHP9HsIbJ9VxDRZrnL1gUCnPrsTkyzVU9q9KM8kVBymvXKmZbr
        je/xLg4Psp+B9C/GUFvcnYhJE6hNJC0=
X-Google-Smtp-Source: AH8x224W44agfgeGS2AP+es+dWYIzIHpDhAvrG4NHh1ifJjNKIIon+EGSaWrQhZj6azDVudMrkBDsg==
X-Received: by 2002:a17:902:8601:: with SMTP id f1-v6mr12550763plo.380.1518484995978;
        Mon, 12 Feb 2018 17:23:15 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w70sm30391217pfa.187.2018.02.12.17.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:15 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 18/26] sha1_file: add repository argument to map_sha1_file_1
Date:   Mon, 12 Feb 2018 17:22:33 -0800
Message-Id: <20180213012241.187007-19-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the map_sha1_file_1 caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index e9e01fb471..f706526bc2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -930,9 +930,10 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-static void *map_sha1_file_1(const char *path,
-			     const unsigned char *sha1,
-			     unsigned long *size)
+#define map_sha1_file_1(r, p, s, si) map_sha1_file_1_##r(p, s, si)
+static void *map_sha1_file_1_the_repository(const char *path,
+					    const unsigned char *sha1,
+					    unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -961,7 +962,7 @@ static void *map_sha1_file_1(const char *path,
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(NULL, sha1, size);
+	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
@@ -2173,7 +2174,7 @@ int read_loose_object(const char *path,
 
 	*contents = NULL;
 
-	map = map_sha1_file_1(path, NULL, &mapsize);
+	map = map_sha1_file_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno("unable to mmap %s", path);
 		goto out;
-- 
2.16.1.73.ga2c3e9663f.dirty

