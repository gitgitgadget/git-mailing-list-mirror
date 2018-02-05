Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1EAD1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeBFABB (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:01:01 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33733 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBFABA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:01:00 -0500
Received: by mail-pg0-f65.google.com with SMTP id u1so134545pgr.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ia9fjQny2tIBivin0yvijfAHcasJiQdXvUsMmFfpJnk=;
        b=PDWkIw5S1wRXM3OmtrcV4+Dwg+N98enoFmJsNIvPUtkapjjsHE8+8DNwtmV9PVBfVc
         DemCE1AFGvD6PjZtBVUVHpHE1UYp+7K9JhijQbcsG6/NdTIAJHaEwVJaF/eNzJr59kuk
         RzbHHgpQnivV6KaGvJFsV0ETuQSikrujmEm0CBSfnpdkgQIrBBEHka2UQNDRsRDpUmfG
         LSRKLKI+bPq+fGLp3g01raELQXw+bC/maU1n1kLjz+0Vsl5TfdS9zxD3MIuQCa7eBrYS
         C0DwVJ4113cPkYWo/LGOoXFukJqw0rQwbdAKTl1WXoAc9VXypM5ya3NywQ013E1jX7dQ
         qTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ia9fjQny2tIBivin0yvijfAHcasJiQdXvUsMmFfpJnk=;
        b=GWbuZnmMVRHfWond33Xgl2cSx9UWIEl9P4iwYp8JSv6oi6eovZFuD0vuR749ZPzvy2
         He63HIUvT9S3JJFVAZCSBL6UxhRyk/O4igduuU9q2uaEFyLcXCr4V1k9q1kzLrLPYZxm
         uW7pyZFvJCloc/X2ZCOWg79UJ3ftQ45czF26n7D2OPtiYN76HszMpPtN0orD1dMdBlOE
         sH/YJz1PMmPoad7wHT0Wb54cj/dlVSADXemXHB4igNfsKbGO5XwPM7/MwwqYnE6/VAkg
         P38vWTF1pF44gXnTh6JGS/B+EWYl/j684F48Y6EWJtYiixSWkdql77qvK+uAWv0mx7RF
         UMtw==
X-Gm-Message-State: APf1xPACoV1gtH7s7BOzd+1NYLlFdp6k4wCoq/o1nZggksrPYn2/o0ee
        LXDtVbRCm44Ldl8FETMPReH8s6+vqDY=
X-Google-Smtp-Source: AH8x224AgenNt4eVjKu52pZgZuIunDSC/QgrSAAbtGzX7CbTnlELOXEKVMUBQOqLu05Qz2n2Umxh1w==
X-Received: by 10.101.101.84 with SMTP id a20mr394881pgw.163.1517875257751;
        Mon, 05 Feb 2018 16:00:57 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id c29sm18244111pfd.172.2018.02.05.16.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:00:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 035/194] pack: allow open_sha1_file to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:56 -0800
Message-Id: <20180205235735.216710-15-sbeller@google.com>
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
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6887543d5e..a0f438b493 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -906,22 +906,21 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
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
2.15.1.433.g936d1b9894.dirty

