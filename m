Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30E5CA100E
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbjIEUg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbjIEUg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 16:36:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D01197
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 13:36:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d66f105634eso2209995276.1
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1693946212; x=1694551012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6IlrSxUII3vDULyN+O9gyrIKxMgvND139bZuetSHgFk=;
        b=Qp/RtoBPNngT9gzFch8xHjdvFHLQ0H/0AvXEcPc/LMgZ3POFuuTgWzrd0vUG+nQyzE
         CAriGQ284q6Rm9bdTFuBaDXCLECH8MVFFI4Zcg2pwxJ09o881o59F/82yLILwIdhCIpg
         ihW+f63EanTOaXrB3C4irjzJz7vG3e9Y9MAoE1sLewDdGqIwz+Ecow2wHLyKNd4HkEah
         qzLHagCdpv9u78amytT3bZHjm6d8+X3YOK94kc3CfSQYjRQ1bR/d997drZMhGuNr/dJF
         FAEu0ZIMvBE1ptRHlhMj3YRu6ojRcRHFxTWQSkR3p1WTtreJG7APzDLDaBdGUSjp9zOb
         d60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946212; x=1694551012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IlrSxUII3vDULyN+O9gyrIKxMgvND139bZuetSHgFk=;
        b=PPff+F2WNgM50CBliZ9DavfbwjsexampAsyGedWhi8f/JszOS/5bZPmBLMZO4gIr09
         GG8TQB4adqHRmnvyz7CWkaOSx7TzAoeeX3YntAqOPIFwrQx2/3bUA4bheRNgM0I8GKwA
         bvNHDmeR7iVyVDKgf7ifTHSF1Vu6nBy8jZx8QCYW9bELZBWsbLbpXLo6Z/J48YPRjpdA
         zbCWiRRv4urB5647lI8EeiW8hxPK9mma7dy07bgz1dPTbj6kgp1YarxkyMtCRGmETSjH
         /VBmImn0swpz6DsnsBhBmAlLuiN/NhKz6DmFg/XVcIFm+ucy7FrfwDrSSzspYb/rlUxt
         nooQ==
X-Gm-Message-State: AOJu0YzHrb7Fvb1VHoN1n5EPq/jGYLAGG0d7VIqKXH5I+42Sdjs/3D+s
        d/Adbk1uYfnZUPJ9vcyHI0+Li+s1WV9/gOchUVhLUA==
X-Google-Smtp-Source: AGHT+IH6erNmy2/2+yEx/TalcV/0hQFEqT6WoMG5scJ5HacErBXgG6in2wg33RyrDLnjPxeuFpaypA==
X-Received: by 2002:a25:bcc6:0:b0:d7b:985b:278f with SMTP id l6-20020a25bcc6000000b00d7b985b278fmr14670164ybm.16.1693946212557;
        Tue, 05 Sep 2023 13:36:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u15-20020a258f8f000000b00d7823cc7d62sm2861521ybl.19.2023.09.05.13.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:36:52 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:36:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 5/8] builtin/repack.c: extract `has_existing_non_kept_packs()`
Message-ID: <e2cf87bb94da1a777f6b87ae3f32e036832839a6.1693946195.git.me@ttaylorr.com>
References: <cover.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there is:

  - at least one pre-existing packfile (which is not marked as kept),
  - repacking with the `-d` flag, and
  - not doing a cruft repack

, then we pass a handful of additional options to the inner
`pack-objects` process, like `--unpack-unreachable`,
`--keep-unreachable`, and `--pack-loose-unreachable`, in addition to
marking any packs we just wrote for promisor remotes as kept in-core
(with `--keep-pack`, as opposed to the presence of a ".keep" file on
disk).

Because we store both cruft and non-cruft packs together in the same
`existing.non_kept_packs` list, it suffices to check its `nr` member to
see if it is zero or not.

But a following change will store cruft- and non-cruft packs separately,
meaning this check would break as a result. Prepare for this by
extracting this part of the check into a new helper function called
`has_existing_non_kept_packs()`.

This patch does not introduce any functional changes, but prepares us to
make a more isolated change in a subsequent patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f6717e334c..3f0789ff89 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -105,6 +105,11 @@ struct existing_packs {
 	.non_kept_packs = STRING_LIST_INIT_DUP, \
 }
 
+static int has_existing_non_kept_packs(const struct existing_packs *existing)
+{
+	return existing->non_kept_packs.nr;
+}
+
 static void mark_packs_for_deletion_1(struct string_list *names,
 				      struct string_list *list)
 {
@@ -1048,7 +1053,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(&po_args, &names);
 
-		if (existing.non_kept_packs.nr && delete_redundant &&
+		if (has_existing_non_kept_packs(&existing) &&
+		    delete_redundant &&
 		    !(pack_everything & PACK_CRUFT)) {
 			for_each_string_list_item(item, &names) {
 				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
-- 
2.42.0.119.gca7d13e7bf

