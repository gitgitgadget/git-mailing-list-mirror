Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58283208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbdH3HNR (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:13:17 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33747 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdH3HNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:13:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id m15so4507213pgc.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cvB3q6Ge3cPH2KWVmcXD2MwItILl8sxocp9czilQmHs=;
        b=qXOK2JoZZrqYchV0y/8BEdMYsuTjZT0qBtCf9IrzAsMROR52IeL68h0mzJCu2toDHL
         YJOS60VtEL/IwLOSCOcTgJWdfRZQbsoEztx+tpX+okzCxjqbTv2Kt88pu95AMNBstB0S
         2xL0nWTCiOVLKdPhnuVqu4uteF16OgwkidejnFLR0NtvM+t6/opU/a9y7WaSkwKiyIpe
         C9H74Yzm1bGCzpUz/uCCpO6XSXVAfF8K5aUv9AIIFrvTMG0LzoxpIvgAJ4aoMfXob0Xv
         UyMVQzNXXQvyNBO445TlqXRfvseAbUTxl7TFIeqYTxfBAdl0xjWRp1RkKpEvNV7kzL/T
         V1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cvB3q6Ge3cPH2KWVmcXD2MwItILl8sxocp9czilQmHs=;
        b=oJ6g4KkTXDhTRDOfptAvjUFhnQOQj57n6QKL/p8mkGTDPykSS+yAdQy7+I9JtF+dgg
         01+gHXPWVwqAzjnYsh66pAEE2twDgo5EnGg1n6/hI7fINUCMtm8zTALXzI8wGaGy/KQW
         46azG1j/UemufWg4las5nJhkRRUQ6Hxoi6zGohOdKhcPlUj0fntw8f7pWp81awCpmOwE
         Wht0AeLMdqK/Rd58CnkxGit2cKCvxrCClVVtO+J2aS2nSztDWBjI29R6BH+bw/b3zw6r
         0WKJnXoQegkQRrzc3hKFVzPtJYKOKcMFoevExOsuW0WdbPE5NJxcuDQllhB5yjLQfj4a
         103g==
X-Gm-Message-State: AHYfb5glvVjP0edk5bzBdG0C2uLrNXMgxzGiKyFe1vPKEdCTeHPKR6l6
        GiPIKlE+d+4YdqVcEMU=
X-Received: by 10.98.236.155 with SMTP id e27mr648367pfm.163.1504077195992;
        Wed, 30 Aug 2017 00:13:15 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id d69sm6988063pgc.82.2017.08.30.00.13.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:13:15 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:13:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 31/39] pack: allow prepare_packed_git_one to handle arbitrary
 repositories
Message-ID: <20170830071313.GF153983@aiede.mtv.corp.google.com>
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
index 9bb93ce256..4652be0b6e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -719,8 +719,8 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-#define prepare_packed_git_one(r, o, l) prepare_packed_git_one_##r(o, l)
-static void prepare_packed_git_one_the_repository(char *objdir, int local)
+static void prepare_packed_git_one(struct repository *r,
+				   char *objdir, int local)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -753,8 +753,7 @@ static void prepare_packed_git_one_the_repository(char *objdir, int local)
 		base_len = path.len;
 		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
 			/* Don't reopen a pack we already have. */
-			for (p = the_repository->objects.packed_git; p;
-			     p = p->next) {
+			for (p = r->objects.packed_git; p; p = p->next) {
 				size_t len;
 				if (strip_suffix(p->pack_name, ".pack", &len) &&
 				    len == base_len &&
@@ -767,7 +766,7 @@ static void prepare_packed_git_one_the_repository(char *objdir, int local)
 			     * corresponding .pack file that we can map.
 			     */
 			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(the_repository, p);
+				install_packed_git(r, p);
 		}
 
 		if (!report_garbage)
-- 
2.14.1.581.gf28d330327

