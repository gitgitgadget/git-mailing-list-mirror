Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE62B208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdH3HSI (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:18:08 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32786 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdH3HSI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:18:08 -0400
Received: by mail-pg0-f66.google.com with SMTP id m15so4514348pgc.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s3EKWajqIExgWpQDcSfXYhQNLWCngeRvZiTdEhk+K9A=;
        b=H7tyzW2S9yM6yLX0evS7n5Cu9taCwYiWBx9wZBf0QxA+kadU8DhZkt+4UXOaV2KszP
         rb8Zb3ivjDtazc5Bjq72Er4F88A1SkWfEFeqDQNt5Nb1Zr3zqFhsqprZvk8aqm2MtgZ7
         DmC+77NzNVnseOKnk8j0qRRk6jKIze/fGfKaEDepEzbozkpXjTP01hmq3YKjAGYPTdnL
         NJ6k06nURLxjy57KsVA2ucsmWLnc0JrYY0sdIR7my5D/C3NF4lshtHeqw/ZlR+nrj/fz
         KNentwynof6LmMRK3diC6ddSNX5fJY/pYtWc+DtiNEb8U2W1KCOY3ahUZEsCJJw4ULME
         p6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s3EKWajqIExgWpQDcSfXYhQNLWCngeRvZiTdEhk+K9A=;
        b=INOt9Y3ttLTO1zn4CP+PtXCrRCxy17Dyup1OkfBFxWhPEMVlHnYrFbPRw1a/RG+qEH
         duN7qQFHq05jqzibH+mNglF5KjkyXVbhEuSNZgSKDLWps6x+YAbUH4w1ZS/nWU8l75TH
         guUP+61S4fxdK7zpqFRGytJVwaNW302jMbZz028TpkDLKodsrnZoV3KD88YkO9GQ041q
         lbqLvtl+Xxrgb9bYPx4CMGlPHjBhhCUkWrNbvXXNq+QMx6G9m2X69GOk2ZNw/j+g3Fd1
         CyABu97RZi77ttRxwEvg8Gzg/l3p//wORL4NXxpVndMm11t4n6nRNEIPovf14K+GuzgR
         Ttfw==
X-Gm-Message-State: AHYfb5hYgf+EXAtccI8qzpMZq9bzvVDkWMVeXDL3gUkCmLXso/FHlGf2
        MIxwFiX+iy1eB1hnBrM=
X-Received: by 10.99.139.65 with SMTP id j62mr596424pge.277.1504077487420;
        Wed, 30 Aug 2017 00:18:07 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id u68sm8082433pgc.14.2017.08.30.00.18.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:18:06 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:18:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 39/39] pack: allow sha1_loose_object_info to handle arbitrary
 repositories
Message-ID: <20170830071805.GN153983@aiede.mtv.corp.google.com>
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
That's the end of the series.  Thanks for reading.

 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index dc3c0b07ea..0f302a8c48 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1096,10 +1096,9 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
-static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
-						 struct object_info *oi,
-						 int flags)
+static int sha1_loose_object_info(struct repository *r,
+				  const unsigned char *sha1,
+				  struct object_info *oi, int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1123,14 +1122,14 @@ static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
+		if (stat_sha1_file(r, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
 		return 0;
 	}
 
-	map = map_sha1_file(the_repository, sha1, &mapsize);
+	map = map_sha1_file(r, sha1, &mapsize);
 	if (!map)
 		return -1;
 
-- 
2.14.1.581.gf28d330327

