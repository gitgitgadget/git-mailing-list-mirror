Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A89EB64DC
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 19:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjGJTh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 15:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjGJThX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 15:37:23 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A9D9E
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 12:37:20 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1b3ca17f2a6so3945127fac.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 12:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689017840; x=1691609840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/M6n9OX/CmEGWtMplHLCYXjBee9wOfbN9C6Ix6xUqTs=;
        b=cZY6ASrcnbXMfTEZNBf7WahPkU9IuxkHLUWj30bcHRsDer+hKOHzWZe8GK1aeOA545
         d7StMhE05m89FQE+gUy88BicyxajhA+Un3ulsaRxvVUUW8eTDYyUtGEmZHNzDfa74TtQ
         LdydcnkkR2gJFu7MQOuOvRRFmtkS9SKA98Jfej1N1hfvR2JfeJi5CrMz2agyaZxjAoMo
         sqtelOmdd2DxVihs40e2v+gTpa6Nl7GvYXIzx4RX+di9mAvBxab8gnWLOuYE7e6GzXXQ
         8MfL5pEKi6OzwTdOqAgzopdnooKtXGheVdtthLeaNo6vDaa0csYVsJRwhoJO3uOnDU2y
         WmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689017840; x=1691609840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M6n9OX/CmEGWtMplHLCYXjBee9wOfbN9C6Ix6xUqTs=;
        b=a8P1b7Nn1rCOKIqSKFeRxmJ2yMui8svx6F19ibRUjOghyzNBlH4xgrV8bmy2JAuOQE
         XOPFm+AfgpU3XOc1XtkP/obMsPniIZHmliCT9PB2piDpnJacQplCFNkgEttqX6JNMUcm
         hnpNh9enCj1pyKSCRm5FN6DooMxzfhBKSZQ1moQGbL5wMkilKPFPIuzQr9Y3G0MY8rXY
         kNEkywsdgIrZCeNpDceGJNPYzH804MZsA+xai6Bu4c/M7OnYczBq7ZMFp17hpb5wwaC7
         yzhA8/yamjmSWKkbGNWNWe5TpknwDqGw9rLFcADqgxKtevJzsFGcFYlgi8seKvsM995h
         h3jQ==
X-Gm-Message-State: ABy/qLZghtUw0vhlLPK429N/AYkAHvRJuYtxji+tXtQIj+3dSnnCEzZC
        jloYdKhuKlxQ33p6AYbTiuLBsjt154GXNPqzDWevUQ==
X-Google-Smtp-Source: APBJJlGTCN+L5MJ8cXt7rvdL31MUbYJEjzRWW0DBBfsIctzfer5ZrY2oyI3n645ujP7jTZFa0Ybsfw==
X-Received: by 2002:a05:6870:79e:b0:1b7:4616:eae7 with SMTP id en30-20020a056870079e00b001b74616eae7mr1970235oab.5.1689017839833;
        Mon, 10 Jul 2023 12:37:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a6-20020a816606000000b005463e45458bsm134069ywc.123.2023.07.10.12.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:37:19 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:37:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 2/2] builtin/repack.c: avoid dir traversal in
 `collect_pack_filenames()`
Message-ID: <b3d0d9308ef1a0aab8dd5a65354044568c65388b.1689017830.git.me@ttaylorr.com>
References: <cover.1689017830.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689017830.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When repacking, the function `collect_pack_filenames()` is responsible
for collecting the set of existing packs in the repository, and
partitioning them into "kept" (if the pack has a ".keep" file or was
given via `--keep-pack`) and "nonkept" (otherwise) lists.

This function comes from the original C port of git-repack.sh from back
in a1bbc6c0176 (repack: rewrite the shell script in C, 2013-09-15),
where it first appears as `get_non_kept_pack_filenames()`. At the time,
the implementation was a fairly direct translation from the relevant
portion of git-repack.sh, which looped over the results of

    find "$PACKDIR" -type f -name '*.pack'

either ignoring the pack as kept, or adding it to the list of existing
packs.

So the choice to directly translate this function in terms of
`readdir()` in a1bbc6c0176 made sense. At the time, it was possible to
refine the C version in terms of packed_git structs, but was never done.

However, manually enumerating a repository's packs via `readdir()` is
confusing and error-prone. It leads to frustrating inconsistencies
between which packs Git considers to be part of a repository (i.e.,
could be found in the list of packs from `get_all_packs()`), and which
packs `collect_pack_filenames()` considers to meet the same criteria.

This bit us in 73320e49ad (builtin/repack.c: only collect fully-formed
packs, 2023-06-07), and again in the previous commit.

Prevent these issues from biting us in the future by implementing the
`collect_pack_filenames()` function by looping over an array of pointers
to `packed_git` structs, ensuring that we use the same criteria to
determine the set of available packs.

One gotcha here is that we have to ignore non-local packs, since the
original version of `collect_pack_filenames()` only looks at the local
pack directory to collect existing packs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 724e09536e..ac9fc61d2e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -106,49 +106,38 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 				   struct string_list *fname_kept_list,
 				   const struct string_list *extra_keep)
 {
-	DIR *dir;
-	struct dirent *e;
-	char *fname;
+	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!(dir = opendir(packdir)))
-		return;
-
-	while ((e = readdir(dir)) != NULL) {
-		size_t len;
+	for (p = get_all_packs(the_repository); p; p = p->next) {
 		int i;
+		const char *base;
 
-		if (!strip_suffix(e->d_name, ".idx", &len))
+		if (!p->pack_local)
 			continue;
 
-		strbuf_reset(&buf);
-		strbuf_add(&buf, e->d_name, len);
-		strbuf_addstr(&buf, ".pack");
-
-		if (!file_exists(mkpath("%s/%s", packdir, buf.buf)))
-			continue;
+		base = pack_basename(p);
 
 		for (i = 0; i < extra_keep->nr; i++)
-			if (!fspathcmp(buf.buf, extra_keep->items[i].string))
+			if (!fspathcmp(base, extra_keep->items[i].string))
 				break;
 
-		fname = xmemdupz(e->d_name, len);
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, base);
+		strbuf_strip_suffix(&buf, ".pack");
 
-		if ((extra_keep->nr > 0 && i < extra_keep->nr) ||
-		    (file_exists(mkpath("%s/%s.keep", packdir, fname)))) {
-			string_list_append_nodup(fname_kept_list, fname);
-		} else {
+		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep)
+			string_list_append(fname_kept_list, buf.buf);
+		else {
 			struct string_list_item *item;
-			item = string_list_append_nodup(fname_nonkept_list,
-							fname);
-			if (file_exists(mkpath("%s/%s.mtimes", packdir, fname)))
+			item = string_list_append(fname_nonkept_list, buf.buf);
+			if (p->is_cruft)
 				item->util = (void*)(uintptr_t)CRUFT_PACK;
 		}
 	}
-	closedir(dir);
-	strbuf_release(&buf);
 
 	string_list_sort(fname_kept_list);
+	strbuf_release(&buf);
 }
 
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
-- 
2.41.0.320.gb3d0d9308ef
