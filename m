Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B86420706
	for <e@80x24.org>; Tue,  5 Jul 2016 17:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbcGERGZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 13:06:25 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35511 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbcGERGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 13:06:23 -0400
Received: by mail-lf0-f67.google.com with SMTP id w130so20264215lfd.2
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 10:06:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjRwagyjm12wp6sDnEEJkS57mSzTCNu7stRflzjP3oY=;
        b=0qiOfA4eBJs5NGxfl1+dbQK271EoGPtzVCLmFVKt1Swe8PxHIYmadeGqzXNewis/yK
         gGsqRnf1j3DUfFNYrGEw+lDWmqmSUJugAjh/NgW7wYcqWds2J3EyACOvouQjEp8nLCM7
         J8DUX/SMI+l5XPoDSyLZSoAgk7RtzG8dE6y/O1UpQ6d5oClSzm6X/KUn8wVhJ4XpRayK
         Qlt2G+2cqsDyfBQHKI7gEgWjtE3aTjZH+n9J0mBFXMjhN801DPXM0HmEElsbneMeQ3E8
         9uVuSE9c8HPklZz/+0r7UdG1GBM2+grzyIJ9urOVslrHeFA8FCdw4GQcONVmLNGwopvI
         E8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjRwagyjm12wp6sDnEEJkS57mSzTCNu7stRflzjP3oY=;
        b=TkDaR6WBPUjAbzKLquUKgK+vnRorHyV20WoxGIa9fuyQGJ+zcQT4bi+xRHybW1xNjg
         6DiJ4nNYBaeF+4eSaz/pxDYYWs1UEqERDYUtkNvSVjN+djJACXzlRawioVBWomj+6As6
         AqD+821vZGLGg+xCRUux0RvcsYxJufF7yEt8/cDP0V96MM8QR+d/PTjwGqBNcZpfFrS3
         DQOtoCMKFEdHnaZdu0So2lpeiPxkyJySYZv/fzUoR5XFRf8QZ1ItyHcKOuRtqbNjxO1j
         uMYb/gaYLe5CzNA1vSBsmleQEmq/rsDA1hj1WKIWQgJ2bmHDZ2vtJDUrsp+873Hrom8t
         bw8Q==
X-Gm-Message-State: ALyK8tInDKT1t+AVuiyh4uwgQccUfK/PBumNKuYNnKvwF5d/MfpkUswgciqcNy2vG6w2Ig==
X-Received: by 10.46.32.223 with SMTP id g92mr4645530lji.32.1467738381854;
        Tue, 05 Jul 2016 10:06:21 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 142sm5693793ljj.4.2016.07.05.10.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jul 2016 10:06:20 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] pack-objects: pass length to check_pack_crc() without truncation
Date:	Tue,  5 Jul 2016 19:05:54 +0200
Message-Id: <20160705170558.10906-2-pclouds@gmail.com>
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

On 32 bit systems with large file support, unsigned long is 32-bit
while the two offsets in the subtraction expression (pack-objects has
the exact same expression as in sha1_file.c but not shown in diff) are
in 64-bit. If an in-pack object is larger than 2^32 len/datalen is
truncated and we get a misleading "error: bad packed object CRC for
..." as a result.

Use off_t for len and datalen. check_pack_crc() already accepts this
argument as off_t and can deal with 4+ GB.

Noticed-by: Christoph Michelbach <michelbach94@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 2 +-
 sha1_file.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8f5e358..df6ecd5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -349,7 +349,7 @@ static unsigned long write_reuse_object(struct sha1file *f, struct object_entry
 	struct revindex_entry *revidx;
 	off_t offset;
 	enum object_type type = entry->type;
-	unsigned long datalen;
+	off_t datalen;
 	unsigned char header[10], dheader[10];
 	unsigned hdrlen;
 
diff --git a/sha1_file.c b/sha1_file.c
index d5e1121..cb571ac 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2281,7 +2281,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 
 		if (do_check_packed_object_crc && p->index_version > 1) {
 			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-			unsigned long len = revidx[1].offset - obj_offset;
+			off_t len = revidx[1].offset - obj_offset;
 			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
 				const unsigned char *sha1 =
 					nth_packed_object_sha1(p, revidx->nr);
-- 
2.8.2.537.g0965dd9

