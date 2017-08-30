Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555EF208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbdH3G4f (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:56:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35287 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdH3G4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:56:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id g13so3805521pfm.2
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S+/OFMQJWtzIP+EaC70m1Bg7TYM7P0DNaH8Hb+yV4fA=;
        b=ncxUPeaoC79wYfwYwYWkTnFgYvIGG4A6D0ZEHntITr0n7S1U91sx2gl9J97EsY5+GK
         Xf5cFzxYRkjZwtduAxavdK144oljFqDBatnzZh2j9eYD4vDaPZa3ttY1wSBmPmkMEPYt
         82oXEgnRNvJOr4YGN57kmHzvf5YbuuN473gwgSSiwVxV8bGGWticiqxyWkXtjBe00EcZ
         QCtJ4MZZotRwy6UFllcA6nUWupfkQVTvfCluUgpN2xYP0xUJ4P05kRyAf7a2WZE2pPac
         ZpTWvPqBD8r/qRKYtRZdK7y5SizFQEskceEN0PCQyD1QuTyuBNoKb2SKZG4DYYKpx1vd
         aR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S+/OFMQJWtzIP+EaC70m1Bg7TYM7P0DNaH8Hb+yV4fA=;
        b=HazG5vWSvyxmCGTKBuyxBeRS/qF6/lPeAkl32eU2yupqVtORFHYAkntcsOPfdRqLdV
         jkHGrLhSf7QGrf1XyhqvuhRNffOjmVTEplG6YuXl3iZNu5jjr0GxJgr9s376WDpOhVLf
         uIOh9ea6QD+HUdg2Lyzw4cABHHlNdtfNXBOXlBANmjW/oF2gkNMqL2vRsjfpp+7fl+x0
         kkq1l8bF9BBo2Y4HWZJ00kUKVaiBNHcR7WC+8nrgwVbWxJho8BxHhOM0KmlQ91OLkUeh
         nqkr8vkYmAzELojBDokmfP6EWBTwBv3LQ9gpNZsB9b/Ald0wID2WTEsEQCUNIduaB0gz
         po4Q==
X-Gm-Message-State: AHYfb5j753sxkbVi5WWJt2Q8D8uPcDzIdmlRmologPbSKrdWbyWDuH1T
        3iEY9aEYYt3zykgYtUs=
X-Received: by 10.84.229.13 with SMTP id b13mr697151plk.251.1504076194041;
        Tue, 29 Aug 2017 23:56:34 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id v68sm2170550pfv.111.2017.08.29.23.56.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:56:33 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:56:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 07/39] sha1_file: add repository argument to alt_odb_usable
Message-ID: <20170830065631.GH153983@aiede.mtv.corp.google.com>
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

Add a repository argument to allow the alt_odb_usable caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Since the implementation does not yet work with other repositories,
use a wrapper macro to enforce that the caller passes in
the_repository as the first argument. It would be more appealing to
use BUILD_ASSERT_OR_ZERO to enforce this, but that doesn't work
because it requires a compile-time constant and common compilers like
gcc 4.8.4 do not consider "r == the_repository" a compile-time
constant.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 7c6ffd205a..1c757b44a3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -280,7 +280,9 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
+#define alt_odb_usable(r, p, n) alt_odb_usable_##r(p, n)
+static int alt_odb_usable_the_repository(struct strbuf *path,
+					 const char *normalized_objdir)
 {
 	struct alternate_object_database *alt;
 
@@ -348,7 +350,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(the_repository, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
-- 
2.14.1.581.gf28d330327

