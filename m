Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 425171F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeBXAsw (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:52 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41741 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752649AbeBXAsc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:32 -0500
Received: by mail-pl0-f65.google.com with SMTP id k8so5843505pli.8
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c2AydxjqpbkI61TU6F6LuHCOMGydNIu1A0QTu3J7SiI=;
        b=WU27N8h33I53XsRPGTgk3lj3pQalU5kjy6bZZnAGdsQFXbCyFaqHezQEhNI9ex+OX2
         zCsXYnNsr39TL3JdqPAzkn+xReJekgUXMvqv6DMw4iGgmFNRvui4iRUIQu5Xo01zi8b6
         KB0Vkt+jLWxOfPnWV/Xzn9DvDLD+J99aFdDd7EriIyGq/oeT9R3ze0tq5/vxcls9YHLM
         mE3CJM1q/+RqKhyr0f+RBDeaJfxankOgeJJdXfkmYNhnr1AfI0iS8GLOuGNE+JH8lLSQ
         UF21K8j/cg2FQnH/PGNY4zzoHN0G9pbZkkZ3CwDT1sHAAvH1TSvvfPR5H4g6t1/52lI7
         WAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c2AydxjqpbkI61TU6F6LuHCOMGydNIu1A0QTu3J7SiI=;
        b=JXJtkkEoKLkYkE8Offx8tLxj1MyfFePp5UXtphGv+uBJv77fv0rt3NZzCvZOux9/x7
         bA6T+17BdPAoQjLigOmQbKXAQk7R2HOXTcagQ8oKZj8sRbj7WNWWquEnvFYSBCvXTuj4
         v3zT9xc44rrbzwGrP1mRiHGOsaHVTrWoLp59U9bXGs/4VuIFOTcqWjXGUvyQgG4Ss7hy
         IWOACBi6iSpWKPsvmuETApZTT5ndcJ2VnZo5gjn6C1xYdImiRa5e4E5Lr99+UgmYLPBa
         wkCJ9ZPXn6hQ7+GMfRevHobRHlgU2Bvcl6OskMlqTjYthaMllkVM33XlP4nnh0tbEDid
         ouvQ==
X-Gm-Message-State: APf1xPDJ4qmwRufLLpsaOjSGz76C21jvLE1Jn3Q6pgiGey+vAPbpZ4U9
        rzbkZ6Z9zyFccBBHddjyKHqoj2kXU24=
X-Google-Smtp-Source: AH8x226Q79wsV/3vK40Os43Rcs36H7loVcsquG7zGmeVU6MvSMSAVau0qgIOLrZWNaNF4aWq189cnQ==
X-Received: by 2002:a17:902:5a88:: with SMTP id r8-v6mr3464038pli.426.1519433311240;
        Fri, 23 Feb 2018 16:48:31 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z79sm7904135pfa.139.2018.02.23.16.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 24/27] sha1_file: allow open_sha1_file to handle arbitrary repositories
Date:   Fri, 23 Feb 2018 16:47:51 -0800
Message-Id: <20180224004754.129721-25-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 952deb02195..73bbe3a3e88 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -897,9 +897,8 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
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
@@ -907,7 +906,7 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(the_repository, &buf, sha1);
+	sha1_file_name(r, &buf, sha1);
 	*path = buf.buf;
 
 	fd = git_open(*path);
@@ -915,8 +914,8 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
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
2.16.1.291.g4437f3f132-goog

