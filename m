Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F319208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750980AbdH3HMv (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:12:51 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38460 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbdH3HMu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:12:50 -0400
Received: by mail-pg0-f65.google.com with SMTP id t3so4476742pgt.5
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vdE+rac4m6ZQO+S7iXo5aPUP63IvJsyQsAcCj7mGm7c=;
        b=rxYktuFYp2OTivZCN1mIqmEcbVgceN8MXv5jxjLmTorV7Vhbw8jUqh04WiV1UpzARs
         u3arm13dkG2G7kVlY5rk+ndtmbYGBSniuFazUeoGDO5syAtO+Xi9JLSvkDlTrcDQ6aTi
         tIgrJQe3dqX0fqHcVT+7sY76Gi7LIoaPzSGJ3i3S4LrlnnzZYyOMjAjuSA1OFIPBI6ho
         tvbWbwHmNgjMdSxVMRH1e6ubKxCB/gz76D90NZsoBwvelLbAL0p7ijDYqHh3e6uA+4Cg
         KYfeOpL9X6r2QYTNkPG4CopuEKmytmaQErIidmqAaq+xwkc38FhJtvUSEKkdV7JVhRlc
         NjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vdE+rac4m6ZQO+S7iXo5aPUP63IvJsyQsAcCj7mGm7c=;
        b=C3pPm1EUi3B3BDsFsREckookA3RKjMjfI4gUw5a/WAQnNDau6d+pdrbGkewWO4OAIM
         hfpfWHvflQCgC8f36QfxXUoqo3vCmL6VN5YYCikLRJON3SOdySVBS3fsHG9Oczgj46J6
         vfCqTUSQ4aXX3Chmwobpy2GpzyXpfXaKy5vumCCqvLLtW2mrTLGwo9lVq7yanSDKRPuK
         TTZ64zRvO6YIoSG67fGYDW34gex8m3Xi/hXbD73b70C6PiTU7hvpTniQHPX+rOt0rBvA
         kRrTNy7cNkS8tCDPDlQd/2IlvEDyyz38JecB7gsegU62unS+EIMtIOJm4qZx3J+KXigO
         95rA==
X-Gm-Message-State: AHYfb5hSFKxI4ISossWS+5/ezz+W79CQgNj4HWjYBYHM48x3+lRt3GBd
        tJFYV77RqDY709Onzhw=
X-Received: by 10.98.224.132 with SMTP id d4mr667864pfm.200.1504077169771;
        Wed, 30 Aug 2017 00:12:49 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id u29sm8371224pfa.72.2017.08.30.00.12.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:12:49 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:12:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 30/39] pack: allow prepare_packed_git_mru to handle arbitrary
 repositories
Message-ID: <20170830071247.GE153983@aiede.mtv.corp.google.com>
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
 packfile.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 977e714d9a..9bb93ce256 100644
--- a/packfile.c
+++ b/packfile.c
@@ -857,14 +857,13 @@ static void rearrange_packed_git(struct repository *r)
 		set_next_packed_git, sort_pack);
 }
 
-#define prepare_packed_git_mru(r) prepare_packed_git_mru_##r()
-static void prepare_packed_git_mru_the_repository(void)
+static void prepare_packed_git_mru(struct repository *r)
 {
 	struct packed_git *p;
 
-	mru_clear(&the_repository->objects.packed_git_mru);
-	for (p = the_repository->objects.packed_git; p; p = p->next)
-		mru_append(&the_repository->objects.packed_git_mru, p);
+	mru_clear(&r->objects.packed_git_mru);
+	for (p = r->objects.packed_git; p; p = p->next)
+		mru_append(&r->objects.packed_git_mru, p);
 }
 
 void prepare_packed_git_the_repository(void)
-- 
2.14.1.581.gf28d330327

