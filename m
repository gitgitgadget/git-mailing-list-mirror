Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7505EB64D9
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 18:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGDSWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 14:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGDSWO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 14:22:14 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB5E72
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 11:22:13 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57a1f51d7a7so12241337b3.1
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688494933; x=1691086933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1Sbg+w0IPvt3TA04Q51nNs+n/NNRkE/eCvee7k4qgY=;
        b=dLV5C9h+ffNmN8jKdIHskkanXQ6tfpnLfaCWiddSlMLdOLbjdTPdA+H7Xt0CyV1ETV
         +pJudrmqyftO1HcerjfH0Ck5K18R1f6o4PE/N2YOMbGyK773J5WlK3n4r2mhNduG/dKa
         +g2hUM/7F6PH3nWTi6aHpsckBWoPTYGhDXOEXQYV/Czcc8lb1VRdiVnqNSbCDhCb1v7p
         NOH6nAUNMCBm/sqcnl4wyS8FustEzqyF1f5rJ1j3aRRZaXC8zbck8/ZswWGqUkni3WVg
         0awqDB1qFrOsWCxHXXpE81rOYtHw4KlHpWQkv9NM1DI5avOfs6ZAYlsciBcZBsogJqKO
         hmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688494933; x=1691086933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1Sbg+w0IPvt3TA04Q51nNs+n/NNRkE/eCvee7k4qgY=;
        b=On9C6zGfJg2O3v/49UfIxs+/V5KcqEdkxO83VvZd+HVfutgp1Qqb6eBkYC4f2MS43f
         I4dzL2y3aTXwRoRNEO8o4rU4pYhcq0VXpSFGlEgBBJ+y2EFNgLrOfnElOe+VHWhwjpOH
         pdpb1docHYuxkXxu40s+uX9OkWlwBhFSFxnkB5tFSERC7kexFiYoaPf7wBnclmziJVS9
         wELTx7p+BE7BWSqTbIeYGBqyxhVsiZYhm86yp+N58olugJl6EJIGu7//EFAYmHy5ARvs
         EBYoyalSw+cuEGBWTVeyMeSxTYDnbVOK7BTR46axLw3It0G3aSCv9lzkI2JoZNQNuDe8
         kzWw==
X-Gm-Message-State: ABy/qLbMal5y1572qIUowBoMzD/unvWR+qPg4U/3hrUC9NtUg/f9uxU4
        CjHr2vlLetK4K8lHWs1mnPJQ8Q==
X-Google-Smtp-Source: APBJJlHP+xJRHFMXiDUKsmAMlWob7qxfwliybPJfVt8hw4Ui3pKfJP0W8QCjY+9QSWjttClNl8ScKQ==
X-Received: by 2002:a81:ab52:0:b0:561:cb45:d7de with SMTP id d18-20020a81ab52000000b00561cb45d7demr15888936ywk.31.1688494932773;
        Tue, 04 Jul 2023 11:22:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y196-20020a81a1cd000000b005772b76cb18sm3086342ywg.4.2023.07.04.11.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 11:22:11 -0700 (PDT)
Date:   Tue, 4 Jul 2023 14:22:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 12/16] refs/packed-backend.c: ignore complicated
 hidden refs rules
Message-ID: <ZKRjUkN/ggLBeIUu@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <845904853eeae1741d681a35fdd7816ea16b939a.1687270849.git.me@ttaylorr.com>
 <20230703061839.GH3502534@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703061839.GH3502534@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 03, 2023 at 02:18:39AM -0400, Jeff King wrote:
> On Tue, Jun 20, 2023 at 10:22:02AM -0400, Taylor Blau wrote:
>
> > In subsequent commits, we'll teach `receive-pack` and `upload-pack` to
> > use the new jump list feature in the packed-refs iterator by ignoring
> > references which are mentioned via its respective hideRefs lists.
> >
> > However, the packed-ref jump lists cannot handle un-hiding rules (that
> > begin with '!'), or namespace comparisons (that begin with '^'). Detect
> > and avoid these cases by falling back to the normal enumeration without
> > a jump list when such patterns exist.
>
> I'm a fan of punting on such cases to keep things simple and
> incremental. But the location here seems weird to me:
>
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 80b877e00c..2aeec5c601 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -1008,6 +1008,25 @@ static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
> >  	if (!excluded_patterns)
> >  		return;
> >
> > +	for (pattern = excluded_patterns; *pattern; pattern++) {
> > +		/*
> > +		 * We also can't feed any excludes from hidden refs
> > +		 * config sections, since later rules may override
> > +		 * previous ones. For example, with rules "refs/foo" and
> > +		 * "!refs/foo/bar", we should show "refs/foo/bar" (and
> > +		 * everything underneath it), but the earlier exclusion
> > +		 * would cause us to skip all of "refs/foo". We likewise
> > +		 * don't implement the namespace stripping required for
> > +		 * '^' rules.
> > +		 *
> > +		 * Both are possible to do, but complicated, so avoid
> > +		 * populating the jump list at all if we see either of
> > +		 * these patterns.
> > +		 */
> > +		if (**pattern == '!' || **pattern == '^')
> > +			return;
> > +	}
> > +
>
> This is deep in the packed-refs code, but the magic of "!" and "^" are
> specific to ref_is_hidden().
>
> So if I did:
>
>   git for-each-ref --exclude='!refs/heads/foo'
>
> my understanding is that "!" would _not_ have an affect normally, but
> now it is turning off this optimization.

Yeah, that makes sense -- I agree that it is silly to have a reference
with "!" at the beginning, but since it's allowed we should absolutely
support it.

> Something along the lines of (you'd want a similar tweak for
> upload-pack):

Yep. Here's the extra tweak for upload-pack:

--- 8< ---
commit 5a8902731b91a8fc6900586968a79ebc6272e502
Author: Taylor Blau <me@ttaylorr.com>
Date:   Tue Jul 4 14:21:22 2023 -0400

    fixup! upload-pack.c: avoid enumerating hidden refs where possible

diff --git a/upload-pack.c b/upload-pack.c
index 3a176a7209..ef2ca36feb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -610,6 +610,7 @@ static int allow_hidden_refs(enum allow_uor allow_uor)
 static void for_each_namespaced_ref_1(each_ref_fn fn,
 				      struct upload_pack_data *data)
 {
+	const char **excludes = NULL;
 	/*
 	 * If `data->allow_uor` allows fetching hidden refs, we need to
 	 * mark all references (including hidden ones), to check in
@@ -619,12 +620,13 @@ static void for_each_namespaced_ref_1(each_ref_fn fn,
 	 * has the OUR_REF bit set or not, so do not need to visit
 	 * hidden references.
 	 */
-	if (allow_hidden_refs(data->allow_uor))
-		for_each_namespaced_ref(NULL, fn, data);
-	else
-		for_each_namespaced_ref(data->hidden_refs.v, fn, data);
+	if (!allow_hidden_refs(data->allow_uor))
+		excludes = hidden_refs_to_excludes(&data->hidden_refs);
+
+	for_each_namespaced_ref(excludes, fn, data);
 }

+
 static int is_our_ref(struct object *o, enum allow_uor allow_uor)
 {
 	return o->flags & ((allow_hidden_refs(allow_uor) ? HIDDEN_REF : 0) | OUR_REF);
--- >8 ---

Thanks,
Taylor
