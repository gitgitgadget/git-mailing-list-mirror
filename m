Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C4F208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdH3G7a (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:59:30 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35828 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdH3G73 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:59:29 -0400
Received: by mail-pf0-f194.google.com with SMTP id g13so3808945pfm.2
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/yv375abJMDxh8/XPUzWQppc9xswjBM9nxhJJhdq9E=;
        b=qqRNmBkLxpDU1xSExLO78TM/530Pe7+/ESfT3MO3F2Sb9YBbBKuT7Jg6q27AVvSOJ8
         5YH7S06Zl25gnEEflPR/3e5UxaTb3aGLlTfs4idhNeudhpEGlcLNV7psGGaPEBsrzSpc
         Sf/uQJYOh/VVRjlWpixJnw3BsfpAE9JhcpsZqOO8kPuSwxHZakZcucMNaKW2uKkFiYOr
         W5f7tmRq1iv/TzDdLFSPv06Sti9dhUQDYlAa6cc3vvljmQTIjn/K1ZDupRx2XWtAfxNh
         DgYqlHQgjq9nuh+ygxmwfTlp7GDfqtAfv3zb0rNIbvuUsAZBJ8fWQDN/27LWkHJI7joo
         IPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/yv375abJMDxh8/XPUzWQppc9xswjBM9nxhJJhdq9E=;
        b=sO6Qv9RcZgOBN7augXs5pBN+WRlWM7GFWpxBUyncZ+XxJIwuON5NRxgWz7Oz5twe5/
         XokuE+VpOscbgMWF6VroxbNsBTXN5/Ffj2vm/eauZf3tgmk3FCZHJ6ML9NSQlEtvQo48
         Mc9eAfj7TB5mq2qk7n9Vpu1VknWin7i4dR0DHwHz9M5UbmwecRAKdmJiW3ojoojkCZvz
         gGb7lLKLrxVy3WBxuloCu/qWQuyhVfG56rmLjjAyqVDC9Dkw9mZTjdrv/VDkDsihEBV0
         81Z4x++dp6utTnlfdMzyANhIXFirqMigS1p7iIA/laK+1C9D7WV5rWI/tkJNoq1VRD4r
         mSBA==
X-Gm-Message-State: AHYfb5i+mEv1/8rH8miewpiM6VD02P4uobHMLVTV8rae8t+87b8Xupyf
        21Wa9RXIO3SD8cjkOgI=
X-Received: by 10.99.42.209 with SMTP id q200mr589483pgq.376.1504076368918;
        Tue, 29 Aug 2017 23:59:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id d63sm7814182pfc.40.2017.08.29.23.59.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:59:28 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:59:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 11/39] sha1_file: add repository argument to stat_sha1_file
Message-ID: <20170830065926.GL153983@aiede.mtv.corp.google.com>
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

From: Stefan Beller <sbeller@google.com>

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
index 7938bd2a6f..d3573cec62 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -815,8 +815,9 @@ int git_open_cloexec(const char *name, int flags)
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
 
@@ -1114,7 +1115,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(sha1, &st, &path) < 0)
+		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
@@ -1306,7 +1307,7 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
-	if (!stat_sha1_file(repl, &st, &path))
+	if (!stat_sha1_file(the_repository, repl, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 
-- 
2.14.1.581.gf28d330327

