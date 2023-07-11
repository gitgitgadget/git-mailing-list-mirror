Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53109EB64DD
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 17:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGKRcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGKRck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 13:32:40 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFBC9F
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:32:39 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57722942374so71584077b3.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689096758; x=1691688758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/ZTKsg88zeCnJUhYV5+8RVDAEvsDJW0aF37JsyAb28=;
        b=gxkQyVYBvI/9oBVqvLGLPVZ9kqFNPsBk9hlQkqJJtp1Le4NA0PffU/fxvxTxnHY4Or
         w+z1HthPCP98NqRT19S0Pa6Gi/4kkHRgKpQ0Egb7Vat1JME1oIz62mMBpgCCMukhYMq+
         8TC8AmjdbmYewgEcnFwfcB1OFu8J9dqzKzs+TNOAIG2wS/QY96T6wOkENATRBHN3Vwoy
         BrKg3L4T2qmzV8wJr4mNy0Yzso6An/BWUYenyKmt8qX+p5qnI6rFkCQlflcNGiLrNfP2
         /aF2/WfoFwL8Y+W8EHLB6akrIevXlzd79HhPJtrrxnZDQbFBwwqMOTvwxsosa7yiK7rv
         nbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689096758; x=1691688758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/ZTKsg88zeCnJUhYV5+8RVDAEvsDJW0aF37JsyAb28=;
        b=kNc3TlQmmRSoK/yBhrkANt3wjsSHd2zbgABBDh47BT+UsVxAIyRrD3gOhnlvNSMvDL
         Dzl6dOBCKwJ9GTBP8Q8CkCBqZSswd6EsbodFQg9W8zqmyt9zAd+xDwpVeI8vbNyAQ/K3
         C4qfh1QLW6dSMqKxocmU6o9BzVRXDM2lC3bX3POLOhi8llF5ppQLDnSNQtIODsyaY6pH
         FH/PzC9ITwSPLMqrEMRP1Ueelu+74sijZWkIkYNCEbg64XTuMagKw7Ukt0FxHFMGM6+x
         bmUmymUPtOIMGmrxp77FCBFju1DnN5fKquDkSk/VavRIVotQjAVRmgzwmHZFxTyh6v4a
         t6wQ==
X-Gm-Message-State: ABy/qLbViXSBTlkcvGGm7YK9lZqUaumqKqrgz1BhXuFol8Z2GVGPmjBs
        z/+abzATKzUIWiJ2t4d2fLPzVoSnqUoXBzn26A4qIA==
X-Google-Smtp-Source: APBJJlEnsIrHRz07xrFoo8JxPieOcWSKzpi4CUjyjCjO2CDTZRNnqnqWGgaSifq70ROrap3Nu1V2Hg==
X-Received: by 2002:a81:7dc1:0:b0:573:9751:ad15 with SMTP id y184-20020a817dc1000000b005739751ad15mr15271193ywc.17.1689096758461;
        Tue, 11 Jul 2023 10:32:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l22-20020a0de216000000b00570589c5aedsm693882ywe.7.2023.07.11.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:32:38 -0700 (PDT)
Date:   Tue, 11 Jul 2023 13:32:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] builtin/repack.c: avoid dir traversal in
 `collect_pack_filenames()`
Message-ID: <ffdf85f6d39c3fa2e7035deeaa0837cc58237896.1689096750.git.me@ttaylorr.com>
References: <cover.1689017830.git.me@ttaylorr.com>
 <cover.1689096750.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689096750.git.me@ttaylorr.com>
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
2.41.0.329.gffdf85f6d39
