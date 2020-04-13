Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780C3C2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 19:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444F520731
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 19:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZVtQ/Gq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbgDMTjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387935AbgDMTjh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 15:39:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F5C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 12:39:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m16so3771295pls.4
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yqrQBLwHBlPmnkS5C6tDlbqFvBagZsNLPLwY2ZUTW7c=;
        b=ZVtQ/Gq6RDQmRy260u5KCzvI9VXvQt2whI340uyUhNTyhqMsz6ejb8DEoBINx7JtbA
         Xr13nndjN+lOFEaqMtkI9phlF464X0I+tWjwxOVOXpHkzaU+dSPWw1f4oxdXnkLwNLoy
         m0vVqCPGpZOT9ki6X9h6tFo7dgp/i3OYIDpZBFXILAfXS1Rscb0ArJLesOrVw6zjBUOu
         2ZrKo+4L7QKL+jguDin66OZR+sfL8zJFGrqYe52L6dHxroUsL4ieRCckgiX1LzRZtcZe
         /fdXWBVbjVvN0MjxRA5srD1cFz0KG/9olQ8VN5zFalFWfsWl1PLzOwFADRmM20X8v/tP
         AcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yqrQBLwHBlPmnkS5C6tDlbqFvBagZsNLPLwY2ZUTW7c=;
        b=FADPRBQ8sd+QpJDLsTYEdtHHV1oGPgx7LHiZfb8tF577HWaJwl0v6YGrGUyvM72III
         MHQ3apPizhkzL7VpXauPi/FjSHiIELQvhR+tdw+jJ8dvvO8YR5G+w3QWVHHXvPCP6kIs
         uzJjTPE/t0ko+ag4bMAE02LVTefJdpz7/09b8MkFxwkiwGv3pEwTziqB7Egab9uQeKVN
         maeQ/LaQjeIWB7ZPcJCtxTaEz19nnQQLOSBTQ3z21Ufsmexx0YKJ7Rfh3/j7nycGSdvk
         tZ040XOSSVJ1bvlE7R2F6GC4QsRvRrNf/ObE7KU/6EFCcilIhwQJqx/+LpOJ77obH60m
         XOZg==
X-Gm-Message-State: AGi0PuYSFC3RdtATp7wClX/ez9Z3pyFjh4D0f7D8dfgzOtoc5wGTDEnG
        487zf2Ont2ccI3RgkSkUDtp+sQ==
X-Google-Smtp-Source: APiQypJ3ctibiSL10628X1CorBttMomhxum6CZkmWB4FguGjIj7T5i5iSnWX+cekzH4VPC/nV/Ka+Q==
X-Received: by 2002:a17:902:562:: with SMTP id 89mr19294182plf.58.1586806776251;
        Mon, 13 Apr 2020 12:39:36 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id r63sm9608591pfr.42.2020.04.13.12.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 12:39:35 -0700 (PDT)
Date:   Mon, 13 Apr 2020 13:39:34 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20200413193934.GC63249@syl.local>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
 <20200403183057.GA659224@coredump.intra.peff.net>
 <20200403184933.GA57202@syl.local>
 <20200403193842.GA7859@szeder.dev>
 <20200403195103.GA663412@coredump.intra.peff.net>
 <20200403204013.GC7859@szeder.dev>
 <20200403231021.GA672258@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403231021.GA672258@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 07:10:21PM -0400, Jeff King wrote:
> On Fri, Apr 03, 2020 at 10:40:13PM +0200, SZEDER Gábor wrote:
>
> > > Do you care about complaining about:
> > >
> > >   git rev-parse HEAD^{tree} | git commit-graph write --stdin-commits
> > >
> > > ? That's the case that's much more interesting, I think.
> >
> > Hm, are you trying to go in the direction where '--stdin-commits'
> > would keep erroring out on any non-full-hex-oid, but would accept and
> > silently ignore any hex oids that are not commits (perhaps even when
> > there is no such object, dunno)?  I think that would support the use
> > cases you mentioned, while it would still save me when I do the 'echo
> > <ref>' thing (somehow I regularly do that, remember doing it the day
> > before yesterday!).
>
> Yes, exactly. The case you care about and the case I care about are
> different ones, so there's no inherent conflict between them.

I was looking back again at this today, and I think we need something
more or less like the following on top. I'll send it out later today or
early tomorrow...

diff --git a/commit-graph.c b/commit-graph.c
index 2d436907cd..58e7890590 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1221,17 +1221,24 @@ static int fill_oids_from_commit_hex(struct write_commit_graph_context *ctx,
                                        commit_hex->nr);
        }
        for (i = 0; i < commit_hex->nr; i++) {
+               int ret;
                const char *end;
                struct object_id oid;
                struct commit *result;

                display_progress(ctx->progress, i + 1);
-               if (!parse_oid_hex(commit_hex->items[i].string, &oid, &end) &&
-                   (result = lookup_commit_reference_gently(ctx->r, &oid, 1))) {
+
+               ret = parse_oid_hex(commit_hex->items[i].string, &oid, &end);
+               if (!ret) {
+                   result = lookup_commit_reference_gently(ctx->r, &oid, 1);
+                   if (result) {
                        ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
                        oidcpy(&ctx->oids.list[ctx->oids.nr], &(result->object.oid));
                        ctx->oids.nr++;
-               } else if (ctx->check_oids) {
+                   }
+               }
+
+               if (ret || (ctx->check_oids && !result)) {
                        error(_("invalid commit object id: %s"),
                            commit_hex->items[i].string);
                        return -1;

> -Peff

Thanks,
Taylor
