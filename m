Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8DBC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 00:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbiFOAh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 20:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbiFOAhx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 20:37:53 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9701A80F
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:37:51 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id v12so1052106qvh.9
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VkTlDyAFltz950AV+Oif+2d5cp9E98993KiQdeybKRc=;
        b=nXOTIQ//aQIxaq/tCJz+WEOSvUYzXUQOTnL2rPvlpHjsZIUeuU/p+TzEx+MiMu4n0V
         KdJm0dgsTZZl3hyvws9G22Y9cfcRjrh47FPWOqVu+EDbHR2lJSHyo8VDiUii6ENLhLuh
         KWYyyLPa5cJ2rYI+yDh/1BZNCDVHX4ClT6rbnFQYUIu8CU4boM0LahQYdZIdDYqRD2Cs
         mpBkqY9FXiKEnZIJKhbGssbh0ZFkGJT/qeFvUyxFxAeu9XdNBZDLdRs8HY7fa77LnpZL
         6IBMEPGiqHJ5P7mlczxfRl927/WN9CGiQxU1GcnTlNNh1THOLwu+ZpTCLJTVsHLTZGWm
         cPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VkTlDyAFltz950AV+Oif+2d5cp9E98993KiQdeybKRc=;
        b=Yrg7qrsBR1yNSMmUH8rCA2UrCW7gLOdnypQ6KhBi2s8WNe6lZ0CsIpDh70AoEiOCA6
         v73NU/ymhUmKVf/sjJyskltLP19pyjIp3ldsyHSMfSsq0ZeThxvqzXcKB+3UFOqRJRLb
         TkIpg12m07WW5ueq+rRdynVoPZemNuZ2ER/Yf8+7ShloV7t3YPRjD5JoZ9U2HDHV7x53
         4ubjc0lWDJdvW6q6FXuSzhAkLJ2NK2I627tYcsmfxo34iP441mTEu5HyeRVySk4nyNBr
         CX6MVGnnCWOBNYpdTJlERwQ53AwLrXSLc3PrljNFOU10qN3hLipc8VsvufZmMw6JRzP6
         opIA==
X-Gm-Message-State: AJIora9Cs4uFnW2oMGSE/gEQNIuElrhHiO1G+WC4Uu8irpiCXyMPa/Ah
        7uqs3Sag4L8oCpCnXvBhzaQWh/KaVqv0AnHs
X-Google-Smtp-Source: AGRyM1tb1W4prC2KwR2sY6XkdD8nHOrwzsVympr2n9l0jWWb+l5iWRJVLw6Ajg3/qR9nfzlqcPO8BA==
X-Received: by 2002:a0c:e808:0:b0:464:543e:4c85 with SMTP id y8-20020a0ce808000000b00464543e4c85mr6300584qvn.14.1655253470894;
        Tue, 14 Jun 2022 17:37:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a400500b006a6d4261f40sm8648756qko.111.2022.06.14.17.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 17:37:49 -0700 (PDT)
Date:   Tue, 14 Jun 2022 20:37:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
Subject: [PATCH] pack-write.c: remove unused `mtimes_name` parameter
Message-ID: <f5bf68702d55b601ebd13bc4a6f1a34dc35abae5.1655253465.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`write_mtimes_file()` takes an optional parameter `mtimes_name`, which
specifies where to write the mtimes file. If it is NULL, a location is
generated with `odb_mkstemp()`.

This imitates the pattern in `write_idx_file()`, and `write_rev_file()`,
both of which have callers from the `index-pack` builtin which specify
an exact location instead of generating one.

But `write_mtimes_file()` has no such caller, and always ends up calling
odb_mkstemp(). To avoid confusion, remove the `mtimes_name` parameter
which the lone caller of `write_mtimes_file()` always fills in with
NULL.

Noticed-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-write.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 23c0342018..6a78e0fad7 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -310,26 +310,21 @@ static void write_mtimes_trailer(struct hashfile *f, const unsigned char *hash)
 	hashwrite(f, hash, the_hash_algo->rawsz);
 }
 
-static const char *write_mtimes_file(const char *mtimes_name,
-				     struct packing_data *to_pack,
+static const char *write_mtimes_file(struct packing_data *to_pack,
 				     struct pack_idx_entry **objects,
 				     uint32_t nr_objects,
 				     const unsigned char *hash)
 {
+	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
+	const char *mtimes_name;
 	int fd;
 
 	if (!to_pack)
 		BUG("cannot call write_mtimes_file with NULL packing_data");
 
-	if (!mtimes_name) {
-		struct strbuf tmp_file = STRBUF_INIT;
-		fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
-		mtimes_name = strbuf_detach(&tmp_file, NULL);
-	} else {
-		unlink(mtimes_name);
-		fd = xopen(mtimes_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
-	}
+	fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
+	mtimes_name = strbuf_detach(&tmp_file, NULL);
 	f = hashfd(fd, mtimes_name);
 
 	write_mtimes_header(f);
@@ -561,7 +556,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 				      pack_idx_opts->flags);
 
 	if (pack_idx_opts->flags & WRITE_MTIMES) {
-		mtimes_tmp_name = write_mtimes_file(NULL, to_pack, written_list,
+		mtimes_tmp_name = write_mtimes_file(to_pack, written_list,
 						    nr_written,
 						    hash);
 	}
-- 
2.35.1
