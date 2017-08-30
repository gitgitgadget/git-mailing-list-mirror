Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70017208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbdH3HEb (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:04:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36475 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdH3HEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:04:30 -0400
Received: by mail-pg0-f67.google.com with SMTP id 83so4477027pgb.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PjUpQAa16EQ6XNRxHxWuBTLbGsbJB30EOjivABug+i0=;
        b=g/WBNN8fAWzsCZOO5joV1O+cjPZo1LWYDXdreu0RW4wavFbn7xbtAY45X6+PiDwOdb
         cWmLf8YKQmgxEE2KFkoCfOoEIy7+XtMiwlJhxuk4lv48+1NmnBT1zfrZu2eYsOwdfyZ3
         ddknngC6X1y7JkcAJDPF35kdLikYIsNRZV8mOZTIkTg65YOwskwmh7sbPW76rBTFboxE
         GwBVQLAJpxvE0KLNQK98jKa2sw5WGrC8wiGh7pKa2yTT2wdwr1Okj7pHj4kYwYo5dDWY
         VLWCQTtj/OR9eCpRQKBkazqWkHfZgms8bNBFzWvSn1ZlgJAmjyTTfQHlTchXGTYFD+ji
         DHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PjUpQAa16EQ6XNRxHxWuBTLbGsbJB30EOjivABug+i0=;
        b=spKsKGhzyJDqB6bWMIL8XYGaPKprn6600sUtA47u0jvdv3GTd49pwDcFuEvfUdCmw2
         gRNyXcTn+jvA6/WdFGiPKXb/E+sgxfPu1vU2eQw7BxCJ9j4pXbV8/JqW//WgP+OxYFES
         dlA7vaqXT2hlTsNa2aqMCccnGhwxb1fdzbGqck7Ne4lWybI21RbqpI297M2Ri3Dbg4mt
         /NVnKG2QdlEJD+9FGyB4c2D75c6lUpFhR+fH6ZbfuLH0TAQ+xa48MomeiijWTF2IuA+O
         MkcuCDhSKju0FAiVFJm33PBSv8nSMeCx/YafQxxjn6vonUW2+hBd4bHKhGdE3Rk+vXq6
         T7JA==
X-Gm-Message-State: AHYfb5gerK7k1di6/wDHGs/z/eZ/ebppVOeoz2hvl5EoLgiL5Vm5+tib
        A+dAfulRE0Q3ApgdWyM=
X-Received: by 10.99.119.73 with SMTP id s70mr610407pgc.186.1504076670108;
        Wed, 30 Aug 2017 00:04:30 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id z83sm7739313pfd.10.2017.08.30.00.04.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:04:29 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:04:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 20/39] pack: add repository argument to prepare_packed_git_mru
Message-ID: <20170830070427.GU153983@aiede.mtv.corp.google.com>
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

Add a repository argument to allow the prepare_packed_git_mru caller
to be more specific about which repository to handle. This is a small
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
index 1d03bf48b4..6a04e4bb1b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -858,7 +858,8 @@ static void rearrange_packed_git_the_repository(void)
 		set_next_packed_git, sort_pack);
 }
 
-static void prepare_packed_git_mru(void)
+#define prepare_packed_git_mru(r) prepare_packed_git_mru_##r()
+static void prepare_packed_git_mru_the_repository(void)
 {
 	struct packed_git *p;
 
@@ -878,7 +879,7 @@ void prepare_packed_git(void)
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(the_repository, alt->path, 0);
 	rearrange_packed_git(the_repository);
-	prepare_packed_git_mru();
+	prepare_packed_git_mru(the_repository);
 	the_repository->objects.packed_git_initialized = 1;
 }
 
-- 
2.14.1.581.gf28d330327

