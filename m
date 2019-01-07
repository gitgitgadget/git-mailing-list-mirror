Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D541F803
	for <e@80x24.org>; Mon,  7 Jan 2019 17:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfAGR3c (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 12:29:32 -0500
Received: from mout.web.de ([212.227.17.11]:52479 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbfAGR3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 12:29:32 -0500
X-Greylist: delayed 89008 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2019 12:29:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546882158;
        bh=M9IMDCCVg2aFgCOLyTFoZd8TjdQLkoH6wae7VaJ6/Dc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=G+riCAGC/tjoVOXy+XjMZV9s6VMFn7xBvTd28ZuiZAZKKw/YRCUmQtDL4AD0kLfYK
         4BO+vimzO3w3ifhGwp7NleQlOi3cuxi/R+IAzEx9PHElNJW95M3yXYUfuK9yg5rXK+
         7vgVpHlvOK1MKqwOSxnh/GLRV2rQA0Bf/1liwj5Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([91.20.59.41]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7bYJ-1hTB7p0ckR-00xIZp; Mon, 07
 Jan 2019 18:29:18 +0100
Subject: [PATCH 4/3] object-store: retire odb_load_loose_cache()
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a836870b-c803-5ff4-0019-58012773efb7@web.de>
Date:   Mon, 7 Jan 2019 18:29:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:V0Z97OkjCT2jc1RXGoQ4Ed8p4eE6zptHydh43hBcRCcXJaCaSgb
 Ir+zz06zo6mQpJqsGawLGtdEfqKxIRJVcf3YO0MS0CDX5Q3b0acN7GQrIGGMT8I4ruUmNOl
 pSTy7CguGiXEtqUa9/2nbVPZBYd99ayPSK2juMbviWIkBNiNIgkJ8ztm+9IH+q0QHMlUBk4
 P7kz2uSLxMtcWFLoyXzLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5OXrhE5XZNA=:C0UVtxruo89tdKgPxRXOJp
 lzC4M9z+foiEr5nLNlNbJaFnXjfZw8Cl8DDya0S428ZHaPPQ0K0zm4E+2hCPdaaMV7dS/3Qiv
 UDPNvqhmlvAr9m3bM4QmL7jbPkYZJr6DOpeBcBm0Co4j+FwT+jh8MOIe9uVuXHDgg4vpaLaOI
 qftOjHFrsk60DPdDRF+jqfzzS/vkfKt28O1N0OnftqIFgvcU/796THnjFZEGSqlfpZRtKLCe/
 QZCySRko38DVIROM8TAz21OY5y27KsPOhad0ijW6YkjQMuHNHCmtBF9HgfyKF2qFXYDxBtu7x
 zYTkNbzumWDqBmuZ++I6XRxZCHwydTabrLdCNiElMCDWk21GfPsuwFMKmMjnZ7Hq7sXdGdFXK
 ym5iRv3KN/+7yRAkaYNojvFeyN0UK5JhYDOaXV4760PhP83xDQv7vbFkYVDFrI4NDeIXSVHDZ
 BhbKrYzG/LppPQ3aDwp64gHRfYyxbCZ7Sdin37LPFYjAgZ2uRzKgKzfoBKjDsp05GHiSUy0B6
 QI3XDFRCiiFba7P4+R5kFFKPl+opwZP0qh7JVYqyQAx2taA+5TTDqUTows4mtx+qJ6NUqJQSf
 6ru2oIPsY2BfwepwwbaEVdJ0x680z6dAmg7q6mn8eP3ih6lE00OdoeaUqPGOYxj8ebppeBEIg
 qLYBO9pV4azvdy91kh/vcbWfR33/bM4Kbjw2cY1fsMqKzxY13ymd1sfxRyaDP9EFe8MAThjnd
 M2kyXSe7bXn2XuQ/qwvUCgZC1udOql5iNYf5ESnLZzF0uX8Zhfby1JQ1W5OIJ26VpRsrbXOI3
 Vh5IWSlIvBmd2uqLNt5r/hjvu0YBnbps43+7JmKZwBzdZozJpX9OIOS/o7DDSizs3c9IYoD8C
 ZHrz3XfI0DbeKtKjB+IG2iCdauynkm9d2oaG3Sxj+AGjBc5Vvyzsgers2aksld
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Inline odb_load_loose_cache() into its only remaining caller,
odb_loose_cache().  The latter offers a nicer interface for loading the
cache, as it doesn't require callers to deal with fanout directory
numbers directly.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 object-store.h | 7 -------
 sha1-file.c    | 9 ++-------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/object-store.h b/object-store.h
index 2fb6c0e4db..e16aa38cae 100644
--- a/object-store.h
+++ b/object-store.h
@@ -47,13 +47,6 @@ void add_to_alternates_file(const char *dir);
  */
 void add_to_alternates_memory(const char *dir);
 
-/*
- * Populate an odb's loose object cache for one particular subdirectory (i.e.,
- * the one that corresponds to the first byte of objects you're interested in,
- * from 0 to 255 inclusive).
- */
-void odb_load_loose_cache(struct object_directory *odb, int subdir_nr);
-
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
diff --git a/sha1-file.c b/sha1-file.c
index c3c6e50704..efcb2cbe74 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2154,12 +2154,6 @@ struct oid_array *odb_loose_cache(struct object_directory *odb,
 				  const struct object_id *oid)
 {
 	int subdir_nr = oid->hash[0];
-	odb_load_loose_cache(odb, subdir_nr);
-	return &odb->loose_objects_cache[subdir_nr];
-}
-
-void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
-{
 	struct strbuf buf = STRBUF_INIT;
 
 	if (subdir_nr < 0 ||
@@ -2167,7 +2161,7 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
 		BUG("subdir_nr out of range");
 
 	if (odb->loose_objects_subdir_seen[subdir_nr])
-		return;
+		return &odb->loose_objects_cache[subdir_nr];
 
 	strbuf_addstr(&buf, odb->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
@@ -2176,6 +2170,7 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
 				    &odb->loose_objects_cache[subdir_nr]);
 	odb->loose_objects_subdir_seen[subdir_nr] = 1;
 	strbuf_release(&buf);
+	return &odb->loose_objects_cache[subdir_nr];
 }
 
 void odb_clear_loose_cache(struct object_directory *odb)
-- 
2.20.1
