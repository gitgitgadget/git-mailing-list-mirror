Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D531F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeBMBXb (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:31 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46952 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933198AbeBMBX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:29 -0500
Received: by mail-pl0-f65.google.com with SMTP id x2so1873775plr.13
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eWj/gIurJhVVIj5B75yQD6a1sHzyAjnx2MG7VI/BRGM=;
        b=tDwpaaB5E/8hC2eln+805Tyhg4KHotyB1BSSRVO4zM+jqVQUFNf1wjGZM72appH1JD
         f4sa6IJTLQJXCvx/NeRYr8CfOVScu9fpHfLqXhtVngf4RsFF22NHrUovntSEo7T31E0m
         HD4Nplp43BvOdkfFWqZB4cijdVVf1M0fzJ6F5tC5yN9jfuifgVr8+zP34hMpBq7BO0U9
         3KmGk90LP2jAKvHoNXBFo/UgzwKfI80spx+N7RGJzlJ0s36gx+1RqHLYuDskBk9ANyAD
         Ik8qzeHAc84b/22LVfk+q8j0efE5WfW3tc9JehDMBaDqkRuHg2l4jvAjpc6TnIcm4RUA
         /xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eWj/gIurJhVVIj5B75yQD6a1sHzyAjnx2MG7VI/BRGM=;
        b=nXs1rBqFJ1tm43pVXGYZu0fdMQRv6mf6wSx8eO+LTEMUNbHR7vceMm58DaNHHgL5RI
         JutOLs5Of9ovZ1ifvglhcMN0vgaaTlGhuPzgx10/M9ILT/nwydEOEkhSFs9N8tXSMz9q
         BYW+d0ljAmnotxvCUtLWlnoecLFrsp+rdZ00AIgcGnNFDaShJ4EirJBZ+vAhW6kxTwi+
         YOtGitx2dGdl6qBqYVaSrsmKNwjnkL1SuwrOS01kxjsLLu/8azeRU4+sknNl+7NaXDlh
         ah/7J+cZBVGYLuFbPTfar8hptFkdjW6NhmfWgNgCthhMGS133Pvt3P4Tew97ZUjUeqeJ
         v3hQ==
X-Gm-Message-State: APf1xPDE8d9lak17bm4sXlCCdXdWPjuDm4VkQ5WNkGtspvADOkTNCEgq
        zwmJGuR44fBjRG94EbMvrjJlko0A1FE=
X-Google-Smtp-Source: AH8x224N6O4cgvxCTesl4cov3QJ/jFtx1oE1ExtayAGGgylu2Zf/7yJ1kn5qsKJ5EnUqOoB1qmbZCQ==
X-Received: by 2002:a17:902:149:: with SMTP id 67-v6mr111400plb.73.1518485008407;
        Mon, 12 Feb 2018 17:23:28 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w27sm25821459pge.54.2018.02.12.17.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 24/26] sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
Date:   Mon, 12 Feb 2018 17:22:39 -0800
Message-Id: <20180213012241.187007-25-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 50202f0959..86b0ca7089 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -928,10 +928,8 @@ static int open_sha1_file(struct repository *r,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-#define map_sha1_file_1(r, p, s, si) map_sha1_file_1_##r(p, s, si)
-static void *map_sha1_file_1_the_repository(const char *path,
-					    const unsigned char *sha1,
-					    unsigned long *size)
+static void *map_sha1_file_1(struct repository *r, const char *path,
+			     const unsigned char *sha1, unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -939,7 +937,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(the_repository, sha1, &path);
+		fd = open_sha1_file(r, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.16.1.73.ga2c3e9663f.dirty

