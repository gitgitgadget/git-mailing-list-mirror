Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD0E2023D
	for <e@80x24.org>; Wed, 17 May 2017 05:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbdEQFkJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 01:40:09 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35232 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdEQFkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 01:40:06 -0400
Received: by mail-pg0-f67.google.com with SMTP id i63so443425pgd.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 22:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JMv+nPg1DFScgLumsiIdzsAxqHbgQ8lwcfmnxKCCDk4=;
        b=RjbsTQQkgQnwE70jQpdYPOivwdsKHaPqMovwchvOZufRomVEXeIScMZjvsWM7aJnLS
         Sr8G0P+i5hCMqXAnv7h37yDvXMyldwFgyM81/uaarEfRG7AsNBejShZ0zdUelRJ8q62k
         7XUlMBMTvMSZsSGFTRCe0asyOalknU0wVn8UXPqL7hUTJ3Qv9ZL1RgJZ6G58XF/0HU0W
         FIs+KJrSq0gj/P1ma4v29C5RIGJFeM7rJe9/yvqGwP7mCmdaEKVYtgmwLTBScsKPzX3T
         7Td+q+C1elXVKyh6zR/OqoMSUMg+D5Fe54ZGfLy+7RcoSz1N5UvtyLOU+MMZ1AzCQ1Ar
         iO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JMv+nPg1DFScgLumsiIdzsAxqHbgQ8lwcfmnxKCCDk4=;
        b=g3MSEy00ABJt/yH+apIRNoCE855YOQAviYaO/0ekP4r0niPQi+KB3PSOQxuE5Anrcw
         LYP+YZdIJLc4W1JIGHsAyvqwMtiTkIlcciObjnMOT9uFy7J+KGdrBQvg2rnkoZ3YSTkk
         kfl6xKNW7XhzR809KapkSp3WiX0giEzscrxVLfbQ0s3l1jmCZl8asp2yusUs8mlsbjHj
         f0KbxEWMO6OTXubZBsicMBGIfi1Rfym53SI2FY7/EO1HTWrMMLIvgECL+dEtmPiOjbPo
         yyILXv1RAhs2ILnIAJZyDVHFqUFMB6Ss2jMmdRKT8of2H2cWlbi1AoklXi2rq1SvOaqY
         eegg==
X-Gm-Message-State: AODbwcB14ZrUq4jyBaPhyOqwA3yTLbMirMYS1dHuryWzl3s456pJKEbP
        6nVggEPIVV9Eig==
X-Received: by 10.84.132.98 with SMTP id 89mr2159267ple.29.1494999600581;
        Tue, 16 May 2017 22:40:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id d83sm1367337pfe.40.2017.05.16.22.39.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 22:39:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Stevens <marc@marc-stevens.nl>
Cc:     Michael Kebe <michael.kebe@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] sha1dc: fix issues with a big endian platform
References: <CACBZZX6nmKK8af0-UpjCKWV4R+hV-uk2xWXVA5U+_UQ3VXU03g@mail.gmail.com>
        <006301d2cd83$663b5520$32b1ff60$@marc-stevens.nl>
        <CACBZZX5Q9paMbYWH47fdK9GuNrE=F=FwR__E1yZ32EOAMw_w6w@mail.gmail.com>
        <CAKKM46vwM9pxyMxTc4jA0z_8vGKdDGCGg9ziKkFAsqr5ULYJxA@mail.gmail.com>
        <007001d2cd88$2b916180$82b42480$@marc-stevens.nl>
        <CAKKM46sS_5bVe5a6wNN7SdVoGvwmVxnLAZTxJ+tSftXfZKeGWg@mail.gmail.com>
Date:   Wed, 17 May 2017 14:39:57 +0900
In-Reply-To: <CAKKM46sS_5bVe5a6wNN7SdVoGvwmVxnLAZTxJ+tSftXfZKeGWg@mail.gmail.com>
        (Michael Kebe's message of "Tue, 16 May 2017 07:43:17 +0200")
Message-ID: <xmqq37c4xcr6.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc Stevens <marc@marc-stevens.nl>

Some big-endian platforms define _BIG_ENDIAN, which the test at the
beginning of file has missed.  Also, when the input is not aligned,
some platforms trigger SIGBUS.

This change corresponds to 33a694a9 ("Fix issues with a big endian
platform", 2017-05-15) in the history of the upstream repository
https://github.com/cr-marcstevens/sha1collisiondetection

---

 * So here is my attempt to clarify the log message (I left the
   title as-is, but this change deals both with endianness and
   alignment requirement).

   Please look it over, and then sign-off your patch ;-)

   Thanks.

   P.S. I wonder how often "buf" is not aligned---could we somehow
   optimize out memcpy when it is not necessary, or is it not worth
   it?

 sha1dc/sha1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 35e9dd5bf4..ae25318c47 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -20,7 +20,7 @@
  */
 #if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) || \
-    defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
+    defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
     defined(_MIPSEB) || defined(__MIPSEB) || defined(__MIPSEB__)
 
 #define SHA1DC_BIGENDIAN	1
@@ -1728,7 +1728,8 @@ void SHA1DCUpdate(SHA1_CTX* ctx, const char* buf, size_t len)
 	while (len >= 64)
 	{
 		ctx->total += 64;
-		sha1_process(ctx, (uint32_t*)(buf));
+		memcpy(ctx->buffer, buf, 64);
+		sha1_process(ctx, (uint32_t*)(ctx->buffer));
 		buf += 64;
 		len -= 64;
 	}
-- 
2.13.0-416-g4c6b804423

