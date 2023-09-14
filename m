Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBD5EEAA5D
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 18:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjINSCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjINSCA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 14:02:00 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7731FF9
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 11:01:56 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d77ad095f13so1308202276.2
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694714515; x=1695319315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7MiNNe0VQLQQM32uCF7nxMbqsKHk4VR1nrt1lq4VaA=;
        b=cNURbjqtTyofmweie/w4vTfelDbr3pEvZdf3Sq7WaxqTEaVUUVysJpJrKeSuOIvTbv
         qkBX2RUB2U3k/4ECcrs89w1j1bGyKfhnRNAPnWScqrrGDIRM+3DH2/7ILt4TRbAojuIM
         jYa1DCCPMvCFfsaVmG0UTjnbB6Fu74IMpUDGf7K2YXx0i+iOHcFCDs58YUL2EZbVFyIJ
         pYBPqqsJmeBYaZeceG0JSNMEha9/OE6KGZhoFsXwgz6P5bzAauf3lP1pTeYfxel97Nfw
         kgl7CNkl4aLnXFPcCrzgBfSVATr5OiT8AfNeynVCFBusbeQlNVVpyJTUqa68yAjtmzNe
         +GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694714515; x=1695319315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7MiNNe0VQLQQM32uCF7nxMbqsKHk4VR1nrt1lq4VaA=;
        b=mN0n1vsdrfgaBLpfm9kScjZk7Ce/GmPg0Jk2vwGeL0c6/r0KWZUrQIf0ovUHWIEhQl
         y5IW/+Q/VmBSkd+z1p+7caPhSZD0qfF1nlGjxAASKvk/8CJ8omh345EMFwsXZaiK68W7
         zTWArpEk7ejdF0TKCCTgoHZVDldu5vQy5lIjAQMXxKL1uyeeMt4lt83Mg4lsQklBbo9e
         pfW8nc4juVtx1KkFFV6BXXO/y4VkfgiJgDQ73RzAOrQX/qWVgqv/baOU0TRhDXBGNa8O
         Nuih3Uc6ut1VF8BZ3wX3pfBlcKscjAjVPzb0xxBJC7Lx9YUXDQqwzHohbdmBdgRJ7St5
         NZUQ==
X-Gm-Message-State: AOJu0YxJZXg0pGKg7HPIdTLaqjnESBVs+bUHpxwz724PtmDZZxgrzSE9
        ssXmD+SeE6dpieXtNkdKTRhvqw==
X-Google-Smtp-Source: AGHT+IEZhbujSY2B5bUrTIHGpK12/izg3eFSBKTrdavMjC1xSSZUSPzI4sHKsv2fI0lrLvwRJ7uzrg==
X-Received: by 2002:a25:900f:0:b0:d81:bad6:976b with SMTP id s15-20020a25900f000000b00d81bad6976bmr859012ybl.51.1694714515395;
        Thu, 14 Sep 2023 11:01:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y126-20020a253284000000b00d7bb3c4893fsm445129yby.8.2023.09.14.11.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 11:01:55 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:01:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/8] repack: refactor pack snapshot-ing logic
Message-ID: <ZQNKkn0YYLUyN5Ih@nand.local>
References: <cover.1693946195.git.me@ttaylorr.com>
 <cover.1694632644.git.me@ttaylorr.com>
 <xmqqa5tpluyj.fsf@gitster.g>
 <CAP8UFD1rDb-iYf4LYb7n=K4KpQ-JR-JK4TkQpGJ-TCfTNFFbnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1rDb-iYf4LYb7n=K4KpQ-JR-JK4TkQpGJ-TCfTNFFbnA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2023 at 01:10:38PM +0200, Christian Couder wrote:
> Ok, I will try to review and merge this with
> cc/repack-sift-filtered-objects-to-separate-pack soon.

I took a look at how much/little effort was going to be required, and
luckily the changes are isolated only to a single patch. It's just your
f1ffa71e8f (repack: add `--filter=<filter-spec>` option, 2023-09-11),
and in particular the `write_filtered_pack()` function.

I started messing around with it myself and generated the following
fixup! which can be applied on top of your version of f1ffa71e8f. It's
mostly straightforward, but there is a gotcha that the loop over
non-kept packs has to change to:

    for_each_string_list_item(item, &existing->non_kept_packs)
            /* ... */
    for_each_string_list_item(item, &existing->cruft_packs)
            /* ... */

, instead of just the first loop over non_kept_packs, since cruft packs
are stored in a separate list.

In any event, here's the fixup! I generated on top of that patch:

--- 8< ---
Subject: [PATCH] fixup! repack: add `--filter=<filter-spec>` option

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 120f4241c0..0d23323d05 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -834,15 +834,13 @@ static int finish_pack_objects_cmd(struct child_process *cmd,
 static int write_filtered_pack(const struct pack_objects_args *args,
 			       const char *destination,
 			       const char *pack_prefix,
-			       struct string_list *keep_pack_list,
-			       struct string_list *names,
-			       struct string_list *existing_packs,
-			       struct string_list *existing_kept_packs)
+			       struct existing_packs *existing,
+			       struct string_list *names)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	FILE *in;
-	int ret, i;
+	int ret;
 	const char *caret;
 	const char *scratch;
 	int local = skip_prefix(destination, packdir, &scratch);
@@ -853,9 +851,8 @@ static int write_filtered_pack(const struct pack_objects_args *args,

 	if (!pack_kept_objects)
 		strvec_push(&cmd.args, "--honor-pack-keep");
-	for (i = 0; i < keep_pack_list->nr; i++)
-		strvec_pushf(&cmd.args, "--keep-pack=%s",
-			     keep_pack_list->items[i].string);
+	for_each_string_list_item(item, &existing->kept_packs)
+		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);

 	cmd.in = -1;

@@ -872,10 +869,12 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
 		fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
-	for_each_string_list_item(item, existing_packs)
+	for_each_string_list_item(item, &existing->non_kept_packs)
+		fprintf(in, "%s.pack\n", item->string);
+	for_each_string_list_item(item, &existing->cruft_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	caret = pack_kept_objects ? "" : "^";
-	for_each_string_list_item(item, existing_kept_packs)
+	for_each_string_list_item(item, &existing->kept_packs)
 		fprintf(in, "%s%s.pack\n", caret, item->string);
 	fclose(in);

@@ -1261,10 +1260,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		ret = write_filtered_pack(&po_args,
 					  packtmp,
 					  find_pack_prefix(packdir, packtmp),
-					  &keep_pack_list,
-					  &names,
-					  &existing_nonkept_packs,
-					  &existing_kept_packs);
+					  &existing,
+					  &names);
 		if (ret)
 			goto cleanup;
 	}
--
2.42.0.137.g6fe1dff026
--- >8 ---

Thanks,
Taylor
