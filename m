Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D05B20706
	for <e@80x24.org>; Tue,  5 Jul 2016 17:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbcGERGb (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 13:06:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35521 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333AbcGERG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 13:06:27 -0400
Received: by mail-lf0-f66.google.com with SMTP id w130so20264300lfd.2
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 10:06:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFMl5yE8orP8XLCO4iID/X6gCYkTQ3+8cFAWb28F9Qs=;
        b=JkNBRxbYUD4VhSMsnL7AXH1lVgs/STdj9e79vZCJltWmM7ip1p77S2XdER6wOdXs7e
         5iJXblTe11Rn2emC4ma/eZigXYdOqXhJp8SQdyhZ+6WHdJGxE/VMNntUfhU6b/sgKKKI
         B9itN2OVNpIfkTAf093ahqWl4+68OOJTE8DmhAVWmINddJjqIce7hMKXLSUvsl4rFVuN
         Dx1u+gEjV56dzrwRSIMyHeGYA/FWSUw0NcspYT6esk9igxGuHwytG3C5t7GLy1I5zVmh
         0YWT76JZCKyQzg6NPUnzd5OiZGF50Y7jMO282+EeBRZVfagTpx7IEOLOtz3NbJiVlf8I
         NNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFMl5yE8orP8XLCO4iID/X6gCYkTQ3+8cFAWb28F9Qs=;
        b=bJrRTcAoUJxqnem6flU/qsRLszIEoinEicnPpgw7kfL3PCkcEEUrdQ9TPRrpt3kT/s
         fR/53MPckGahLLz2D6nlX38ZaSkNv2n/A6rpv3sSrhz67bBUXxo/aap2ZF7cJg7kkwgN
         fQygEwLMUWdVAkq4IPJVROAb7fmvKS2rzZqPMMeVy0nqC7svIWEVwvPTRleuQA36n4kq
         S3F1Px6fgXUqjIYjaDRzq5f2d+lrjdb6ViszPw0UUYIVqgZQKvPQGbXNeDvc/xfJF70u
         6piTgXMDyKR/I5ZNrTCXhlZ1GiMKGZkXe8+vppY7sfNyGrZDRZJaE/LScSPVE9goPeM+
         Kmaw==
X-Gm-Message-State: ALyK8tIvFbmMcKoYNFNrP0EMxlqTMYCqw0QbfPGtAkxEguun6Ly/fpc6kUpOHhGegjmE9Q==
X-Received: by 10.25.210.20 with SMTP id j20mr4437737lfg.139.1467738385630;
        Tue, 05 Jul 2016 10:06:25 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 142sm5693793ljj.4.2016.07.05.10.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jul 2016 10:06:24 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] index-pack: correct "offset" type in unpack_entry_data()
Date:	Tue,  5 Jul 2016 19:05:58 +0200
Message-Id: <20160705170558.10906-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <20160705170558.10906-1-pclouds@gmail.com>
References: <1466807902.28869.8.camel@gmail.com>
 <20160705170558.10906-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

unpack_entry_data() receives an off_t value from unpack_raw_entry(),
which could be larger than unsigned long on 32-bit systems with large
file support. Correct the type so truncation does not happen. This
only affects bad object reporting though.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 73f7cd2..f35a9dc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -430,7 +430,7 @@ static int is_delta_type(enum object_type type)
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
 }
 
-static void *unpack_entry_data(unsigned long offset, unsigned long size,
+static void *unpack_entry_data(off_t offset, unsigned long size,
 			       enum object_type type, unsigned char *sha1)
 {
 	static char fixed_buf[8192];
-- 
2.8.2.537.g0965dd9

