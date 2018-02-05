Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B451F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeBFABD (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:01:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40928 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeBFABB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:01:01 -0500
Received: by mail-pg0-f65.google.com with SMTP id g2so120730pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVyaJLivNJQqvykbg+ekuS3/s3ZNA3Yoc76zz/QvCfE=;
        b=Ra7DpIib5hGQD8y5oAcj5RoHoBJHxhBkcd+1s6c19rpfKwXpQRMQZSUqH8WkEelETr
         2CvLqWbC0e54nk2XbmKwVf/hE+BTtpUzoeBq7+vdvBp3SNJwTp+jyKhGK9ZXhRGGGn7/
         c8B4lkNCbYvZoosHvZrKVcJdY1l5XC6AGryZmOnLmb2ksZZmRGV+EfIv0FZe0HEvBaBk
         GbAQMzzu1q/posuYwDZnlF2l1hH9yPe9ojcrCnlCXp28iD7qU5zzDez/ig6EsE9x/nEZ
         tvHgtXyEtBnlzNlx3gzVD2Yq3L5VdaBnkXXIgL87zKkX9jssjR2kDcA21jd7OboLXd7P
         w77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVyaJLivNJQqvykbg+ekuS3/s3ZNA3Yoc76zz/QvCfE=;
        b=FtjXD0Y4kwree2qERjIgARJvSAY0ysbAbULMbUi5PlejRRT9RGhESr21/rrEo2Iy41
         KVsFAVOXm7OcaoXS9e8/mjVbzEpbIXI4iIQdTjGec9RLhxZqCEZTw86NI0i43TDvM/b0
         XzoAhho5MmcVZRqBhTsC4xiLnbKtnFoo1vGvY0JHMPrSaUOR69hoh+TzdGHdtG7w96g0
         TKdEfk6IomePthYj7CzYxxXRoqSa1R9xVzxIo1pLSmiRq3yjPMzLL4n+7YZYZZy7jBmY
         sNOnghsnUu1GuIMvcdiM18OuuBivssubd9h9xcxq1i6Wr/fyebvHDTZtAMaZSkb2SYt8
         kasQ==
X-Gm-Message-State: APf1xPCI/AgLEci/UAA67eF3LZMW2PTsm0QdBpNZnU4WsI7FG4SAp88U
        ZVvrHJ2qKtveXGnAnejGabcGK9VCe0Q=
X-Google-Smtp-Source: AH8x227GP/Xn6UVlYNZ7enSPiq466DpCFynNDekewdro8u1F3pUpGj+wxrLadvb/zUzID49K1xTOEw==
X-Received: by 10.99.94.194 with SMTP id s185mr379833pgb.423.1517875259514;
        Mon, 05 Feb 2018 16:00:59 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id g69sm14866487pgc.32.2018.02.05.16.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:00:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 036/194] pack: allow map_sha1_file_1 to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:57 -0800
Message-Id: <20180205235735.216710-16-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
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
index a0f438b493..590b857391 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -936,10 +936,8 @@ static int open_sha1_file(struct repository *r,
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
@@ -947,7 +945,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(the_repository, sha1, &path);
+		fd = open_sha1_file(r, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.15.1.433.g936d1b9894.dirty

