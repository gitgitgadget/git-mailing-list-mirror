Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6281FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 13:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbcLFNOz (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 08:14:55 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36501 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbcLFNN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 08:13:28 -0500
Received: by mail-pf0-f193.google.com with SMTP id c4so18747794pfb.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 05:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igbwPMgQiNLo81NH8b20DMOi/Ga/E6jMaq4yBo8NOfU=;
        b=wL7FJ98dJvBkv89qZavPWpctSE9EWYg20EoCI/iU5juOQMPl6+rBRy+oufFXoKYM1q
         1LcDo13Rn1py7gS1b+fSKMlooO1gr6uN1yzYDb7iLXqMtGF8eonZedlUYFtg9tQLyJFn
         wbV16egYHwEoLghV4Q6aiMbeyhb7e7Q27c+mxPlLZLpMRzQspCFTg8NU0QCJgpZ1RCtc
         603+EE2z0ibEGavIbsO6Hlk8G+eznPRTwpTqnOL+eiZakCeeEM3rmjA9ZhMcXg67+Fkg
         4kZWA9jQj7qggCt4SKgXX9BIj6lqU5E6a3fuaTmR2k+6MMZ3SKPhNEGSPt4x8A1/SnKB
         a+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igbwPMgQiNLo81NH8b20DMOi/Ga/E6jMaq4yBo8NOfU=;
        b=AO/op6T54c7JNI25JjoSvNVEXn9MusR0pJY6oQIABZ/YcPNDecaSJZkck72+6Awmul
         5IgTyBv5rjr3QWKeKqYdzdnAy3opZ/b1L0A9xrttfgdWqPBlLDOLHN3hPV+b0plQjlTZ
         DS9TdJKhxVajAhzzoyO/vUmY2WoF92EInEv6mpfBF/AbzNFGznYl4eBvVkPpMf0rjg9A
         QYTceL1X7VUPLIsi3EFi8hHjiAUpJVH/bigkZGEXUOcFtb/iXzeEkLz+kMyZRv4ZPfwc
         ENoBnYTyahvbAm2G08HgpQf9jeJU72TymYQdnVS13zIt4vW56ITZa9xztLl7LFPKBMal
         OsmQ==
X-Gm-Message-State: AKaTC00b5rbX8Q8qfgYMzK9yWIX7Sdvvc3LfzdxrmBTtVy/zEteTYnHfzsSKT0T/l+9ZTA==
X-Received: by 10.98.3.7 with SMTP id 7mr63605324pfd.9.1481028843485;
        Tue, 06 Dec 2016 04:54:03 -0800 (PST)
Received: from ash ([115.73.166.29])
        by smtp.gmail.com with ESMTPSA id f23sm34812712pff.59.2016.12.06.04.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2016 04:54:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Dec 2016 19:53:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     rv@rasmusvillemoes.dk, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 2/6] shallow.c: stop abusing COMMIT_SLAB_SIZE for paint_info's memory pools
Date:   Tue,  6 Dec 2016 19:53:35 +0700
Message-Id: <20161206125339.16803-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161206125339.16803-1-pclouds@gmail.com>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
 <20161206125339.16803-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to allocate a "big" block of memory in paint_alloc(). The exact
size does not really matter. But the pool size has no relation with
commit-slab. Stop using that macro here.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 shallow.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/shallow.c b/shallow.c
index 8100dfd..2512ed3 100644
--- a/shallow.c
+++ b/shallow.c
@@ -431,6 +431,8 @@ void remove_nonexistent_theirs_shallow(struct shallow_info *info)
 
 define_commit_slab(ref_bitmap, uint32_t *);
 
+#define POOL_SIZE (512 * 1024)
+
 struct paint_info {
 	struct ref_bitmap ref_bitmap;
 	unsigned nr_bits;
@@ -447,9 +449,9 @@ static uint32_t *paint_alloc(struct paint_info *info)
 	if (!info->pool_count || info->free + size > info->end) {
 		info->pool_count++;
 		REALLOC_ARRAY(info->pools, info->pool_count);
-		info->free = xmalloc(COMMIT_SLAB_SIZE);
+		info->free = xmalloc(POOL_SIZE);
 		info->pools[info->pool_count - 1] = info->free;
-		info->end = info->free + COMMIT_SLAB_SIZE;
+		info->end = info->free + POOL_SIZE;
 	}
 	p = info->free;
 	info->free += size;
-- 
2.8.2.524.g6ff3d78

