Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCCEC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhK2W3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhK2W2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:34 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A13FC096766
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:12 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id r2so19038136ilb.10
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g+qUl+8j4UU1/bSOamK3sP34bdd/CcSboI3AppJmIVk=;
        b=sXfCYjUB0WWr5HnfKoH8jRRL1jmpDYQ0miIVo5mHnnzERWjYlXbMwjoJ01Rjn5KnMQ
         SKtGhaEWJqVL64IDvPlm47gc47QS+7ZqnAYGCvqCynCF66yYxx+rMRo19fqVD9AGrwsf
         c7yLMQBUgCZW7U6HZd4Y9kgy9NrfP/eX2xAVEGp+J3GOrfaP0mjIGVpvJueMq1upn3RJ
         B6vJA633t32vk7zyB7D6HjkZcI/mGFkS7Ul68/kOQk1ejDqzAxyLLZMTV5q/m5rfqgVO
         691Ec4aB40FSHtS5osHIvkkLJhna05rlA/6J4YlI9xDeJ/Nfaj3iKp0H4ZOh3jQlM6ev
         qQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g+qUl+8j4UU1/bSOamK3sP34bdd/CcSboI3AppJmIVk=;
        b=TJPjKTs5Nt9D3BekYOXdCNUOp/YkvG6yigv1vjPeIXll6k572rY0ta32HejhQ5ixnc
         779/PbX1dBa5f7oC0zS1aMmO6dX0CgT9Jjf2CsGAZgvISN1CD10bS4HcVu+mn+xTQuCk
         OwyUbqgSpppv01BDkc3Vd/58cNKgf/pfBlyrr7hg+PUdb/zAgSsyXkVXdKbT2LjenEs7
         eUh0z6Xc0ai56RKxH6XiAU0S1at/Wrjkp2m/xj31VMBsSCVegryXj2XEVNR32PDB7dVp
         amFD+l3KOA8VA8IihZA6SogtR2ObbIHpFsIHHdt8siknwqQFnQkCC3eG10d9N5Eh8bUY
         sbVw==
X-Gm-Message-State: AOAM532fMashzzKvRWJpvrmivI7t1n5xSilxJcxprVN1aihMuRVOLZw6
        a1Z5x6gMZ6oTQm2NmUip4Uc7ZYyoeWIdBaKr
X-Google-Smtp-Source: ABdhPJzR9wBT3tPn6aNoiVccv1B+L9S8GlXDHplc4dX37UTF2nOeymOKGzSUsbOFAMEMS4e9sFSjLw==
X-Received: by 2002:a05:6e02:17ca:: with SMTP id z10mr9045454ilu.98.1638224711421;
        Mon, 29 Nov 2021 14:25:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l18sm8797843iob.17.2021.11.29.14.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:25:11 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:25:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: [PATCH 03/17] pack-write: pass 'struct packing_data' to
 'stage_tmp_packfiles'
Message-ID: <7f4612e859dd9923014c4e8a28bf5caea84d971a.1638224692.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This structure will be used to communicate the per-object mtimes when
writing a cruft pack. Here, we need the full packing_data structure
because the mtime information is stored in an array there, not on the
individual object_entry's themselves (to avoid paying the overhead in
structure width for operations which do not generate a cruft pack).

We haven't passed this information down before because one of the two
callers (in bulk-checkin.c) does not have a packing_data structure at
all. In that case (where no cruft pack will be generated), NULL is
passed instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 3 ++-
 bulk-checkin.c         | 2 +-
 pack-write.c           | 1 +
 pack.h                 | 3 +++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1a3dd445f8..bf45ffbc57 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1254,7 +1254,8 @@ static void write_pack_file(void)
 
 			stage_tmp_packfiles(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
-					    &pack_idx_opts, hash, &idx_tmp_name);
+					    &to_pack, &pack_idx_opts, hash,
+					    &idx_tmp_name);
 
 			if (write_bitmap_index) {
 				size_t tmpname_len = tmpname.len;
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 8785b2ac80..99f7596c4e 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -33,7 +33,7 @@ static void finish_tmp_packfile(struct strbuf *basename,
 	char *idx_tmp_name = NULL;
 
 	stage_tmp_packfiles(basename, pack_tmp_name, written_list, nr_written,
-			    pack_idx_opts, hash, &idx_tmp_name);
+			    NULL, pack_idx_opts, hash, &idx_tmp_name);
 	rename_tmp_packfile_idx(basename, &idx_tmp_name);
 
 	free(idx_tmp_name);
diff --git a/pack-write.c b/pack-write.c
index a5846f3a34..d594e3008e 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -483,6 +483,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
+			 struct packing_data *to_pack,
 			 struct pack_idx_option *pack_idx_opts,
 			 unsigned char hash[],
 			 char **idx_tmp_name)
diff --git a/pack.h b/pack.h
index b22bfc4a18..fd27cfdfd7 100644
--- a/pack.h
+++ b/pack.h
@@ -109,11 +109,14 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 #define PH_ERROR_PROTOCOL	(-3)
 int read_pack_header(int fd, struct pack_header *);
 
+struct packing_data;
+
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
 void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
+			 struct packing_data *to_pack,
 			 struct pack_idx_option *pack_idx_opts,
 			 unsigned char hash[],
 			 char **idx_tmp_name);
-- 
2.34.1.25.gb3157a20e6

