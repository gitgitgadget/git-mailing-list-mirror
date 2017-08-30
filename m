Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D04208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbdH3HMA (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:12:00 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36940 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdH3HL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:11:59 -0400
Received: by mail-pg0-f67.google.com with SMTP id t193so4490135pgc.4
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9KNbHQUeCWcCcDNE7JuLn8zmIOW4rsvQR/NfF3BN/oI=;
        b=N2zKrNTnMZFxQes6LWjrnnnoLOSdblGq5jgBDFbnclwHQAguTIPeA/aFTrkYC9hjKl
         6q9tC/xbG38HqTEX7ih0JNwrt9bgOtzb+Q1BAwl5VTI9z0+Df3zSpTLemHpbQYSor0ah
         Bg2A6UjfP1mKiX+O8JkUVynaf04/07gg9FSxBMCXkOAvvDb7QmkpJR4a38IazpjcCj3D
         nXLU5p4FoFqHzeQRu+hn7Hk32LHaJnyhzI+ubAFI/npvnrutX0GprxwF0Qkxjkialdwr
         46e2WbV+aZkil8eTzcWCCupCrts71FWw4R5BEbF24qYim72L3qOXvWYwWuSTraeALE3E
         MCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9KNbHQUeCWcCcDNE7JuLn8zmIOW4rsvQR/NfF3BN/oI=;
        b=Upsk487cO+tykqpABET9G6Uk2k1m7tMsEiFYHBwQI7/6kEebFHPqR0ZpdmVp2YniCz
         BSxZQ/mYtqwnhTn/1ir17a7kqylLro6OQ4e9IKoes/LeYyGGygV1OKdXbdsBTjdh4DeM
         RDEEQ5GARN2iD2fU34MSxcQ+h8UdeCYBR0HNAh5cA3rY6wIUL1NxuRB68+bvXYeNq1J1
         TqD5dqAvzxeX7G05ETa1ejvLSvkFfPFTvgLYxWWJsJ3SFw5xlXw21KcypA082YwnuK+M
         w/y8dIgAvcg/FrdOOVvo4Kwnem07ERirT9aYiEvk4PfIv4PEzYasZjxh738shDhWDBc7
         sDrw==
X-Gm-Message-State: AHYfb5j26/ubqtlWUKxhk7g9c9Jk2NRZ5WB/afnUhVAmc1EkDjpcC1VI
        PNEwtuXnSBuIi/MBEFg=
X-Received: by 10.84.231.1 with SMTP id f1mr771219plk.344.1504077118666;
        Wed, 30 Aug 2017 00:11:58 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id s73sm8954129pfe.65.2017.08.30.00.11.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:11:58 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:11:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 28/39] pack: allow install_packed_git to handle arbitrary
 repositories
Message-ID: <20170830071156.GC153983@aiede.mtv.corp.google.com>
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
 packfile.c | 6 +++---
 packfile.h | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 86c3964018..51af035965 100644
--- a/packfile.c
+++ b/packfile.c
@@ -664,13 +664,13 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	return p;
 }
 
-void install_packed_git_the_repository(struct packed_git *pack)
+void install_packed_git(struct repository *r, struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	pack->next = the_repository->objects.packed_git;
-	the_repository->objects.packed_git = pack;
+	pack->next = r->objects.packed_git;
+	r->objects.packed_git = pack;
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
diff --git a/packfile.h b/packfile.h
index 74f293c439..ba6f08be99 100644
--- a/packfile.h
+++ b/packfile.h
@@ -36,8 +36,7 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 extern void prepare_packed_git_the_repository(void);
 #define reprepare_packed_git(r) reprepare_packed_git_##r()
 extern void reprepare_packed_git_the_repository(void);
-#define install_packed_git(r, p) install_packed_git_##r(p)
-extern void install_packed_git_the_repository(struct packed_git *pack);
+extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
-- 
2.14.1.581.gf28d330327

