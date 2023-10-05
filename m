Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F417DE9271C
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjJERni (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJERnN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:43:13 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7014F1708
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:35:18 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-65d5a6230fcso6484736d6.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696527317; x=1697132117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JptqxVquyR1k5fuoK46ZLo8Yw6CwKIA7FpEisIFlaKs=;
        b=XJHUL+7THah410x0uwvj4fzYYSVKNk0YRB8Hsln3cMqG+z5AMOJeMM1XtWx8wqrtBY
         MVvObfjoO9ciq1mGPCJ7WynEDUp+8lSqjQTr+IA2GkDHbaRpPs5V5cTtx6jDsJeYQ8XB
         yvAwfeHU4EYO0jxpRs+Ilhf0KDiJVZsMlljQORZlGRvwTS8KwqkEXI9Es44mDqfgSVE2
         0tIa6JDPlWP7GAOwgpRc9SjavqIgfVMbYgAW/wES5Cbv8362Y9Om3W9tkHO80Ks9k9/s
         BtI6s9HX3NcyD5oPpt+S0DisrOuazyjTO8izNAlSI1hVlr4lyXamo02CwJ5Jx6OkKOwH
         L+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696527317; x=1697132117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JptqxVquyR1k5fuoK46ZLo8Yw6CwKIA7FpEisIFlaKs=;
        b=ZuSZoYPXbVvSxlwmIq7uZQkmjUQbbaCmRB27bjqzfSGykAIXfPlwPGnKoNRW3lMcJO
         F8ezLZBGsihml9ykMOArJ9aLL/cbOHbDFW3M5jtA7YG2BRATyBNb6K4xJ0ZbgPIoXfwV
         LtfFN3OFSqcjqLx8OsCHovRqwH3pyYtczjLSKXuCHEb3R/vULE7dqqD+Dt9vUHP9uiIX
         3CuFdrbdF43/07rAwcpgT7GmNItZKBUxPQFxCmNPCZzAbMInblksmpzDwFlnbSPxHP6E
         2w3YJ6HYps+L0IYXYv1NLCF9P0TgdrmZkb1zCJdjZ1H600BcOHglG/+R2zUaZTEMGoJN
         i4pg==
X-Gm-Message-State: AOJu0YwzAf+FmKmbQrwVgJGcC1BbsGq1e6KSKdPsU/aAueUF73z5utvl
        65ZahJ83d/A39IVBIPn8xN7D/Q==
X-Google-Smtp-Source: AGHT+IH+6m/SdUumiBf6QCR/0ky4fTvbj10vhC66w6ZjEOqTypNmv3zuU8J2XbNE6oApIlXVUGeMyA==
X-Received: by 2002:a0c:e383:0:b0:65d:31e:b80f with SMTP id a3-20020a0ce383000000b0065d031eb80fmr7117031qvl.35.1696527317396;
        Thu, 05 Oct 2023 10:35:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x17-20020a0ce251000000b00655ec7bbfd0sm660134qvl.7.2023.10.05.10.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:35:17 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:35:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] builtin/repack.c: implement support for
 `--max-cruft-size`
Message-ID: <ZR7z0/tStMSjBkFR@nand.local>
References: <cover.1694123506.git.me@ttaylorr.com>
 <cover.1696293862.git.me@ttaylorr.com>
 <e7beb2060dad648ec5c3fa8984e432ee243ae012.1696293862.git.me@ttaylorr.com>
 <ZR6nKzflu_18JnoG@tanuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZR6nKzflu_18JnoG@tanuki>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2023 at 02:08:11PM +0200, Patrick Steinhardt wrote:
> On Mon, Oct 02, 2023 at 08:44:32PM -0400, Taylor Blau wrote:
> [snip]
> > diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> > index 90806fd26a..fa0541b416 100644
> > --- a/Documentation/git-gc.txt
> > +++ b/Documentation/git-gc.txt
> > @@ -59,6 +59,13 @@ be performed as well.
> >  	cruft pack instead of storing them as loose objects. `--cruft`
> >  	is on by default.
> >
> > +--max-cruft-size=<n>::
> > +	When packing unreachable objects into a cruft pack, limit the
> > +	size of new cruft packs to be at most `<n>`. Overrides any
>
> We should probably mention the unit here, which is bytes.

Perhaps, though I'm OK with omitting it in the name of brevity, but only
since we link off to the relevant section in the git-repack(1)
documentation (which does include the units there).

> > +static void collapse_small_cruft_packs(FILE *in, size_t max_size,
> > +				       struct existing_packs *existing)
> > +{
> > +	struct packed_git **existing_cruft, *p;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	size_t total_size = 0;
> > +	size_t existing_cruft_nr = 0;
> > +	size_t i;
> > +
> > +	ALLOC_ARRAY(existing_cruft, existing->cruft_packs.nr);
> > +
> > +	for (p = get_all_packs(the_repository); p; p = p->next) {
> > +		if (!(p->is_cruft && p->pack_local))
> > +			continue;
> > +
> > +		strbuf_reset(&buf);
> > +		strbuf_addstr(&buf, pack_basename(p));
> > +		strbuf_strip_suffix(&buf, ".pack");
> > +
> > +		if (!string_list_has_string(&existing->cruft_packs, buf.buf))
> > +			continue;
> > +
> > +		if (existing_cruft_nr >= existing->cruft_packs.nr)
> > +			BUG("too many cruft packs (found %"PRIuMAX", but knew "
> > +			    "of %"PRIuMAX")",
> > +			    (uintmax_t)existing_cruft_nr + 1,
> > +			    (uintmax_t)existing->cruft_packs.nr);
> > +		existing_cruft[existing_cruft_nr++] = p;
> > +	}
> > +
> > +	QSORT(existing_cruft, existing_cruft_nr, existing_cruft_pack_cmp);
> > +
> > +	for (i = 0; i < existing_cruft_nr; i++) {
> > +		size_t proposed;
> > +
> > +		p = existing_cruft[i];
> > +		proposed = st_add(total_size, p->pack_size);
> > +
> > +		if (proposed <= max_size) {
> > +			total_size = proposed;
> > +			fprintf(in, "-%s\n", pack_basename(p));
> > +		} else {
> > +			retain_cruft_pack(existing, p);
> > +			fprintf(in, "%s\n", pack_basename(p));
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < existing->non_kept_packs.nr; i++)
> > +		fprintf(in, "-%s.pack\n",
> > +			existing->non_kept_packs.items[i].string);
>
> As far as I can see, the non-kept packs are passed to
> git-pack-objects(1) both in the cases where we do collapse small cruft
> packs and where we don't. Is there any particular reason why we handle
> those in both code paths separately instead of merging that logic? Is
> the ordering of packfiles important here?

No particularly good reason. The ordering isn't important, and you could do something like this:

--- 8< ---
diff --git a/builtin/repack.c b/builtin/repack.c
index 04770b15fe..6e17fc3f51 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -905,10 +905,6 @@ static void collapse_small_cruft_packs(FILE *in, size_t max_size,
 		}
 	}

-	for (i = 0; i < existing->non_kept_packs.nr; i++)
-		fprintf(in, "-%s.pack\n",
-			existing->non_kept_packs.items[i].string);
-
 	strbuf_release(&buf);
 }

@@ -959,14 +955,13 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
 		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
-	if (args->max_pack_size && !cruft_expiration) {
+	if (args->max_pack_size && !cruft_expiration)
 		collapse_small_cruft_packs(in, args->max_pack_size, existing);
-	} else {
-		for_each_string_list_item(item, &existing->non_kept_packs)
-			fprintf(in, "-%s.pack\n", item->string);
+	else
 		for_each_string_list_item(item, &existing->cruft_packs)
 			fprintf(in, "-%s.pack\n", item->string);
-	}
+	for_each_string_list_item(item, &existing->non_kept_packs)
+		fprintf(in, "-%s.pack\n", item->string);
 	for_each_string_list_item(item, &existing->kept_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
--- >8 ---

But I think that having a small amount of duplication is a fair price to
pay for being able to see the whole input given to pack-objects outlined
in a single function.

Thanks,
Taylor
