Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1687208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdH3HQg (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:16:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37185 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdH3HQf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:16:35 -0400
Received: by mail-pf0-f196.google.com with SMTP id a2so3817443pfj.4
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kPBP9/kB4PjlqJn2oyBOpkluU8y9+zrp9O7ZsXFhNNM=;
        b=V5Ii7VAPFTRuGJ0ox74GgdfMfMkuz3EKkL2ikZUFfQ3LBdN0cJDtrCN2vipGIaui4p
         dn0VJ/TRtuvdPdbzjLXnO+F8O4qI8UcQY+FgqnriN4TKN7ms+bzGQOzETJvOBqIQuckb
         7OrW26rzoGrvmt943j3JQzLkEg40dS98UON7XUdEZytjC11+rv8jvHxuHpPnwZGT/u2z
         kimc5DI5p8qP2odD6f/mlTGWHbGmer+/edBhIVzbpKJVF+n5H61e+o2wZqsLOyPyHw/F
         AUTwZ6ACtr6WLtjgqZj+l+fJsoqPI+cHjAE2T5IN9nt1/kLs7GdIBo865mvHmE6bkk2V
         s27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kPBP9/kB4PjlqJn2oyBOpkluU8y9+zrp9O7ZsXFhNNM=;
        b=Ui2CCr0LHSUlvkV3KKUhQEx+1eSA/gBGnqZuuq+PZjuAsgOatCFleb06rQxHiFB/cy
         I148KEKqxY7r0lFKOaWicDuXWcjjsSg7m0gEQJI6Z2LfZYODkf5grDwq0/XjJ/dT/gUB
         2J6zzkpgyuNc5j12VKGrAtau5Ell6t6x8jG6wiCePdFAjnh1xZq2Iq5xmuiHm572fpu5
         S2fKjqHChQRpnT5RnrVkuIfz65W38qGOQc6Nm2RcX6nQwTtlTDxF744pxejLv7UyZdo1
         YYIDiZNEI1EegpTliFqTEpUN1nh9YXAXMCqzy6QNyD46pYARe9Gfqzzfd4LOvyltYBSN
         s/MQ==
X-Gm-Message-State: AHYfb5gKGYYMLNNB6V3gKcBmKz1Ye5lWaNFtmJi48yFKU9a8BDtsbexy
        bDBK8Mrxg82sJ5IqCXw=
X-Received: by 10.84.224.200 with SMTP id k8mr812821pln.282.1504077394522;
        Wed, 30 Aug 2017 00:16:34 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id 20sm8269796pft.82.2017.08.30.00.16.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:16:34 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:16:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 37/39] pack: allow map_sha1_file_1 to handle arbitrary
 repositories
Message-ID: <20170830071632.GL153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 930705f59b..7fc5ebf2af 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -876,10 +876,8 @@ static int open_sha1_file(struct repository *r,
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
@@ -887,7 +885,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(the_repository, sha1, &path);
+		fd = open_sha1_file(r, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.14.1.581.gf28d330327

