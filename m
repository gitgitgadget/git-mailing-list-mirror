Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4A11F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeBMBXg (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:36 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43128 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933117AbeBMBX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:27 -0500
Received: by mail-pl0-f65.google.com with SMTP id f4so5854513plr.10
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3qEwLkCoz6CRPL7Xr8cpvsVy4nak1l/iO/eIqmRAhC4=;
        b=paIp2XoHIg3SWDlZlN2Kytl42n8Vm6bkjRZMOhEx5bV90SLJryhwc/L++3Pl6ktirR
         AGJjiu0zYBOo46MdFl0vLD9FNyxF0uhaYin3/HicGYQJDRFKADeWRcoaRteTtM+4YgY1
         0ZfK9tmnpfZ9zNtaV5FiVPDrOZ67H0brr0HBpWALh7hMvLvMF1v1bQPpvMemHEyD8Vxo
         AuoHzF/8L4aLmuLrU8/oGCKo0hMy8Xnai9RCXuhSlccAOeMk51jiAslDKSqQe30rY7zR
         R9YS6h09aMcYdzF6H3OWyYk4J3HFW051y/H8Y4GDA7paQe54Z9KigU8OMxnd2q/y0t4J
         p49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3qEwLkCoz6CRPL7Xr8cpvsVy4nak1l/iO/eIqmRAhC4=;
        b=OE6G3IKKE2AOxUbWtsW2GAFBvfyc6hEp1iZrd0E4TZarDs9AopYVu59MiuMEyDScbQ
         kw9JzJHg8BYFMZoBvpyV4998B5KWxqmBjRr1hOUbI5DRcwwcjazmN846ebx2AXd9oulX
         AZqAILo/AV+8XiGwdhvRW8gV8K7jNgFdQt7tT8liwzFXmkAx6muKmx5HBEsM5lnywaYC
         QotHoS35xNOf7ZjfepXMncv705kVz9mpMlmkMwzHoYyl/RATo2V4uccudvqJyviCQDBV
         ow5kET2kJk7p3uPE1MNSt/zRwNG1dfOs1fx+WJzzz2t66XO4OZMrHpfuWzej+VtFrXEh
         /gyQ==
X-Gm-Message-State: APf1xPBwZ0lQHq7+ogKN6rRj7SSGFT6mo5zfK2XLuQbgM4U3a6VMU1HN
        i+iGHUb+ps7v+rmks/MuwgHXGwh2mis=
X-Google-Smtp-Source: AH8x225WD1ONARDs8d9uHUA7Q8iALLlFCEUzKyjiTE06vPnYiXzyF3EVp+OEhKyl9ipDjExIHusVtQ==
X-Received: by 2002:a17:902:42a3:: with SMTP id h32-v6mr12191719pld.231.1518485006911;
        Mon, 12 Feb 2018 17:23:26 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 10sm11809259pfo.69.2018.02.12.17.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 23/26] sha1_file: allow open_sha1_file to handle arbitrary repositories
Date:   Mon, 12 Feb 2018 17:22:38 -0800
Message-Id: <20180213012241.187007-24-sbeller@google.com>
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
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 21ddbff846..50202f0959 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -898,22 +898,21 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-#define open_sha1_file(r, s, p) open_sha1_file_##r(s, p)
-static int open_sha1_file_the_repository(const unsigned char *sha1,
-					 const char **path)
+static int open_sha1_file(struct repository *r,
+			  const unsigned char *sha1, const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
 	int most_interesting_errno;
 
-	*path = sha1_file_name(the_repository, sha1);
+	*path = sha1_file_name(r, sha1);
 	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	prepare_alt_odb(r);
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
-- 
2.16.1.73.ga2c3e9663f.dirty

