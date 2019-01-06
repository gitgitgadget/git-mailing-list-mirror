Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3129F211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 16:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfAFQpv (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 11:45:51 -0500
Received: from mout.web.de ([217.72.192.78]:40017 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfAFQpu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 11:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546793143;
        bh=sehSlELMZnzQ77WDbHA5lcmtATsZ55HkGypDIAiUe/U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h497JqI6ClAuHGMkr1qmqwhEVqjR95AHesgQp5+5jduXmUDeUoK7NBN/6dNOOaIWJ
         5tgYzlcDi5hTjCQNCflA3StXnyt88DH41DtVLwJsTgC4p19nKMReYCaZHWbfc5S86d
         yWfvwG0zwR2ucWGZCRGVTUzHq9unYzIGt0tgdntk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([91.20.59.41]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5Oct-1hVoOv3s4d-00zVdI; Sun, 06
 Jan 2019 17:45:43 +0100
Subject: [PATCH 2/3] object-store: factor out odb_clear_loose_cache()
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6e8c3e47-4f11-e26f-64a6-ea4cfd8e2942@web.de>
Date:   Sun, 6 Jan 2019 17:45:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/i84EemPjfioFtJ3PdjpaWd097C/FjvMUq3H5M+rHBwXY2z12WD
 vYYnrqxJyQzIx6KLzR55Fw9JQGXxPLWxOJIW+9QZ6pfdaYQGZyi4BPuWSazf7q67/hXhwNm
 yvf00HZ+h9yAD8L2vJuNyGeU+tPgHIozJvrsf2yI4DjUhw38tJ/Dblv00MeOWxK5zbH9ny7
 gkOcV6N93UsVh7IIwWj0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FT94YgP5Tl0=:hWM3wvZFe4AwcU7t1vAQlt
 kGHMtfX5AXdNDiQINNOl4JJdv48oqP2yWq3WXonDdjCA4La2rM3t9kZMTjcXi5JyIQGLmd8yL
 EZo9p+zLO9v0nSYd9gcmqIw4IqgItBtgktiyJIpxxzaH/NM7FjF6OSxuPYRVbzvzNfyB7jgig
 ldTiiCtrutFU5tB9fIiDhuuzJyZVXnr08wbSGQbAiZcrienGQGTQ3Ysc0NUwJWW4FJCCxPAwt
 OKun2MnEPfD2j/kksaJwkFG18OXlL6XEdMZ+2pM2b9RvEfole6XBGCOHCv3nRHYqAmleGezWS
 MdK8iXWd7Zey3YBDXUG7xKQ9TeI7OUgHX3l75JF2YXlEcfm45S3FKBTCWBnKgMDfFP7smjmUZ
 pVgnBIKbDgqQrDsov3Nt0GHM6sP4jGVq4QqE/6h86IkuKt9XpmrCmWJKhMVNDLJed5Vch03w8
 5HUqVe8eDGGW8OXlIV4xyouo/SlXgno76xIcXnKJB2tfILo6KPdXBQjcOB4WuU6N1YMEbKbx4
 CbrRlaYpUhFsi0aYsRi/w5Tzxh5XC9+NM5GvrOCki2Iw79uAft6L8Nls/s/+uAsWaBGstKoqE
 HFR27lNRnU5DEFTDvxuV8JUZ79deTiC7RHE+vJvtAsjDjq7JCQdJ7WK+/H7lTuAb2c9lHa3nt
 pIQpgin164r3RWyTwiqUXlzGLrR3gG5Q3bSaEnS+WY7EGPh43veHgbDEcdP+2KOHmwHxBbJuM
 iX4DQFHU2OTgehKcXraWrfeiv5eMzIj91AyEFiDHCR+4iUsdSs1+49eZqPLY31yig+Pouaj7H
 unbP2THnJL5FQHVmJpSQcz96UcW4GxyqC6dF79bTcMeKYCAjQJ6e2GhDkorZB4hGE8yYj6eb0
 rzaHOB+i0hObg7/tGMRPSbylkAnm1T+EHAN7KJLsSec7BESnQVNoQrh6htIiHv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and use a function for emptying the loose object cache, so callers
don't have to know any of its implementation details.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 object-store.h | 3 +++
 object.c       | 2 +-
 packfile.c     | 7 ++-----
 sha1-file.c    | 7 +++++++
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/object-store.h b/object-store.h
index 7236c571c0..709bf856b6 100644
--- a/object-store.h
+++ b/object-store.h
@@ -61,6 +61,9 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr);
 struct oid_array *odb_loose_cache(struct object_directory *odb,
 				  const struct object_id *oid);
 
+/* Empty the loose object cache for the specified object directory. */
+void odb_clear_loose_cache(struct object_directory *odb);
+
 struct packed_git {
 	struct packed_git *next;
 	struct list_head mru;
diff --git a/object.c b/object.c
index 79d636091c..a5c5cf830f 100644
--- a/object.c
+++ b/object.c
@@ -485,7 +485,7 @@ struct raw_object_store *raw_object_store_new(void)
 static void free_object_directory(struct object_directory *odb)
 {
 	free(odb->path);
-	oid_array_clear(&odb->loose_objects_cache);
+	odb_clear_loose_cache(odb);
 	free(odb);
 }
 
diff --git a/packfile.c b/packfile.c
index 8c6b47cc77..0fe9c21bf1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -994,11 +994,8 @@ void reprepare_packed_git(struct repository *r)
 {
 	struct object_directory *odb;
 
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		oid_array_clear(&odb->loose_objects_cache);
-		memset(&odb->loose_objects_subdir_seen, 0,
-		       sizeof(odb->loose_objects_subdir_seen));
-	}
+	for (odb = r->objects->odb; odb; odb = odb->next)
+		odb_clear_loose_cache(odb);
 
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packed_git_initialized = 0;
diff --git a/sha1-file.c b/sha1-file.c
index cb8583b634..2f965b2688 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2178,6 +2178,13 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
 	strbuf_release(&buf);
 }
 
+void odb_clear_loose_cache(struct object_directory *odb)
+{
+	oid_array_clear(&odb->loose_objects_cache);
+	memset(&odb->loose_objects_subdir_seen, 0,
+	       sizeof(odb->loose_objects_subdir_seen));
+}
+
 static int check_stream_sha1(git_zstream *stream,
 			     const char *hdr,
 			     unsigned long size,
-- 
2.20.1
