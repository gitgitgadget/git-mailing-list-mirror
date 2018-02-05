Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBDD1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeBFAAd (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:00:33 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45285 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBFAAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:00:32 -0500
Received: by mail-pg0-f66.google.com with SMTP id m136so105810pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oS5PH//AXyG9HPtMFPvuR2gtCI923L/lHsPuigvoGDA=;
        b=hb8B7q62pvsL2gNT/96lMexjhWkVW4VDFoFGlW7kFy+HWV5Y8FAMMylyb14kQDaZLj
         SFcHiD4G2n0tE6g/o3prZ4FMRx1r/KRZ1igb2Otchg4B6Qen7FaCKeLagE3NfSQAlGbb
         aaPiLPtUbMAfnCqIHkwDWFIwspZN8aMLErDzavejNobwyAWmcn36+c4yp+mwxY44b4+b
         LxWKkAZnDGuCd1Za8YoawrV6qPC9l37cubuZSN7wTol0qE44++O8a84+ZZvv4yfvgegB
         bLxbJG0v9AccwbnKULB6N7itQpBWVTs4koiAEydxBIuFFnLkYfgkxKLLEWvs2As/EHPh
         vKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oS5PH//AXyG9HPtMFPvuR2gtCI923L/lHsPuigvoGDA=;
        b=HLN9GIAG6Xp72b1C3TlyyQVmVCMytoZD/ESAzXEqduGk+xJp9u/OXN3Si7qBAew/f/
         NiS9lnNXFNMvbhzTKobInTUSjtSoNtvHzxwrnmtSuJfUpFCriRC5yeKNGLicL49D4sSa
         s+0cMr5ZM+ep3x0tDyBWJR8Ps7YEra+QxbLvT3sqFp155Q0QbVVunf66QVFEgcZ9qHUN
         Uwib2DB40q45k10J3agCcMeKUM5/TFhTh+Dr5z6ihcianDEAIaoQjupOLu9xH+m92aWu
         EIo1KJ+akgOC0MUyYy4ube93fP0qQyEfFRK2jvS9X5THTAmKK2dnt8+Pi7h1ROZprloE
         DT2g==
X-Gm-Message-State: APf1xPC9t9sZ4+1QVpJwQ8YrwcM8D5hCCiuYfuZtoUA1iP5BaS0pW123
        Cg32j0dehGrQjUj+1KXzZqMIo/ZoZJ0=
X-Google-Smtp-Source: AH8x224/txvxoqcalNTLXbHeMb0HJ9fQp78TCGxcEWNY3TQrc1Nn+Qehgkmeio9otJV4bj5GejRoWw==
X-Received: by 10.98.103.131 with SMTP id t3mr492363pfj.53.1517875231271;
        Mon, 05 Feb 2018 16:00:31 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i14sm14734154pgv.40.2018.02.05.16.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:00:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 034/194] pack: allow stat_sha1_file to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:55 -0800
Message-Id: <20180205235735.216710-14-sbeller@google.com>
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
index 5d4c39bd45..6887543d5e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -882,19 +882,18 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
-static int stat_sha1_file_the_repository(const unsigned char *sha1,
-					 struct stat *st, const char **path)
+static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
+			  struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 
-	*path = sha1_file_name(the_repository, sha1);
+	*path = sha1_file_name(r, sha1);
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb(the_repository);
+	prepare_alt_odb(r);
 	errno = ENOENT;
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
-- 
2.15.1.433.g936d1b9894.dirty

