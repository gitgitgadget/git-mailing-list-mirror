Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821BA208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbdH3HD5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:03:57 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37143 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdH3HD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:03:57 -0400
Received: by mail-pg0-f66.google.com with SMTP id t193so4477844pgc.4
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OXz2s97PDWaNp9skbpHQ4D+FFE6I95Q0Cmt9AzM9Tao=;
        b=YGFximJASfuvC01yjoJr8DD8tqTr5SQ4UT42AAHH0LWbfe1hajAVwN0xV2Uxu59Czi
         gFe4YNvqCBxaFVsBKTorSSJWQF+hxvrUXZZhbDaIje3Od+l8CK5pzRUqx/Ez7BYTNUzz
         qKRRLfQgnR6IS/Zt/d/7KExXFTk/DV60SKaiaSlT14WqdIilddjmp2pjreACd0x6dX8K
         C8NN4avxuxoLa+lGUCzPqfbn/M4UjyDZ3EWH5YiOy7jnaBdD2jOj9G4T2mm2qyD/uNbD
         HrtUaHvM9J30Gkf77WMQm47hk3MmmQ0DRH8suqAUtjDItpJXn2c6qA3WyrHnm3t2seCk
         CfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OXz2s97PDWaNp9skbpHQ4D+FFE6I95Q0Cmt9AzM9Tao=;
        b=OUo41IoIIlmMVkZseu9iFnnFgdqE+0WPJ++a2i5wCFa/v2CkBD0khfWryx4IRmeKJ/
         l0x7DiSXLAJ3NCnwx6lARAEz/tGHlDGb3c6Ljc2kjRDzgcJ5Pf0jjhjD3bQVqfecliX+
         TXYWD9/+X2sSWHupbOx0vU9kkBLahnrZqwhPskkvRqa5nGZt2IzXTOIqYz1EP3O7qCPC
         XphwHrZxpywxjc9Va42hhwhUMSoAfjlC7FbJ6ohlE3me9Z4H5f4OBKZerlSreOfZsUZm
         SbIw4mzT31CKdLbaPrpScictO072FkM1UwJ1y46QqnqWfGc6mNKQmFSRlsIZUDjqkkq5
         6c6w==
X-Gm-Message-State: AHYfb5i5rsjkzuUZBB9luIYcyamFY+3cNkbpnFH8lbEksGfXk8iUzcfN
        ZrTwUe3gwDbUb0aWB/0=
X-Received: by 10.84.224.199 with SMTP id k7mr762928pln.180.1504076636295;
        Wed, 30 Aug 2017 00:03:56 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id x70sm8159010pfe.70.2017.08.30.00.03.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:03:55 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:03:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 19/39] pack: add repository argument to rearrange_packed_git
Message-ID: <20170830070354.GT153983@aiede.mtv.corp.google.com>
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

Add a repository argument to allow the rearrange_packed_git caller to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 3a841c0f69..1d03bf48b4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -850,7 +850,8 @@ static int sort_pack(const void *a_, const void *b_)
 	return -1;
 }
 
-static void rearrange_packed_git(void)
+#define rearrange_packed_git(r) rearrange_packed_git_##r()
+static void rearrange_packed_git_the_repository(void)
 {
 	the_repository->objects.packed_git = llist_mergesort(
 		the_repository->objects.packed_git, get_next_packed_git,
@@ -876,7 +877,7 @@ void prepare_packed_git(void)
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(the_repository, alt->path, 0);
-	rearrange_packed_git();
+	rearrange_packed_git(the_repository);
 	prepare_packed_git_mru();
 	the_repository->objects.packed_git_initialized = 1;
 }
-- 
2.14.1.581.gf28d330327

