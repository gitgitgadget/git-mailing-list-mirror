Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15489C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 20:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjEIU5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 16:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjEIU5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 16:57:43 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933B71FC6
        for <git@vger.kernel.org>; Tue,  9 May 2023 13:57:08 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b99efd7c335so8207286276.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683665757; x=1686257757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uiAdtCwy7+BT4lK+xCfXThm3h3ia5zTPrcJtPuXBs/4=;
        b=Dqp1d6MErqDnL4XEwvIALbx1xHS8o7gpEKXsngsESJ9mrCdYUOKgrCCJb3HWNWRK0M
         zAIoRS75tsM7GyNuY0p37ug/+w9Tv72mr4j1VMy2OE6+PqT8Iaj1mgXRSMDtgsV65qYt
         VhDEMNaL1XSbCH9hPCX7PRoshCV+TMY7bhfxRzdt6bfDKV0+kN7w9kabPoFmp0N4riGf
         ERvWD876oxCRClsp+LS/GFR1MqkgMuVJ72Lu7uiZpDQNumM6ZR6vqps3noIohUWTrgRB
         2bZY213rN64zHt5UVYMtUmeDwZD5TsuchG9Eh9Thtzg9p1pijju1Zl1wMwsC6WWDbdEW
         PJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683665757; x=1686257757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiAdtCwy7+BT4lK+xCfXThm3h3ia5zTPrcJtPuXBs/4=;
        b=PFM1GpN8kwwTJs8eIfrKSM4X5F8a06Nd6pkmmHHPsU0kspeMLGB/+k/pcb9MAM2Wyb
         RDFehiArEjrLMg6fUt6RgfDxincJhmE59qwpkljNRrz3fxcsCea3h+3N5xW/3il/1QOj
         roN6gbGYNpVFof2cBQulmJVct23mNnYhAeiztVxNYjIqDPoVA9Fp9E7fF66bWdkGJy4N
         hr2pB+02UeFil7b9smMl6xt+/FoGz/ESxCPqzd8i0TMmBC/CHcRDHta2eKdo4u+yVO03
         8U8pCE7l+xCCDjhjtaVzC2fFtW+/w+xrH1W6p2Pt4lEuF4XBmSC3c2uHaimZDmT0nzZe
         3MpQ==
X-Gm-Message-State: AC+VfDxJizkR0QezVyKAbvVlTCewWDfrStmKgoIZUoC1J79F2xL7Gqrb
        BZcxd5BQuJ6zQf69Qp3Bef8AvA==
X-Google-Smtp-Source: ACHHUZ5tCMWCG7j2evY9NmO7gwST1/zEsEb0WtFIg/xstHwAxGyJpVgxaERyKkn2sq6hnn2Y7WK/fQ==
X-Received: by 2002:a05:6902:1245:b0:ba1:24f4:b21e with SMTP id t5-20020a056902124500b00ba124f4b21emr18558247ybu.40.1683665756826;
        Tue, 09 May 2023 13:55:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h15-20020a5b02cf000000b00b9dcfade2bbsm3214766ybp.8.2023.05.09.13.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:55:56 -0700 (PDT)
Date:   Tue, 9 May 2023 16:55:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/15] refs/packed-backend.c: implement skip lists to
 avoid excluded pattern(s)
Message-ID: <ZFqzW2vqcFJqqPXH@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
 <ZFpjn-vjP6H_v_KD@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFpjn-vjP6H_v_KD@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2023 at 05:15:43PM +0200, Patrick Steinhardt wrote:
> On Mon, May 08, 2023 at 06:00:08PM -0400, Taylor Blau wrote:
>
> > Note that this optimization is only possible when none of the excluded
> > pattern(s) have special meta-characters in them. To see why this is the
> > case, consider the exclusion pattern "refs/foo[a]". In general, in order
> > to find the location of the first record that matches this pattern, we
> > could only consider up to the first meta-character, "refs/foo". But this
> > doesn't work, since the excluded region we'd come up with would include
> > "refs/foobar", even though it is not excluded.
>
> Is this generally true though? A naive implementation would iterate
> through all references and find the first reference that matches the
> exclusion regular exepression. From thereon we continue to iterate until
> we find the first entry that doesn't match. This may cause us to end up
> with a suboptimal skip list, but the skip list would still be valid.
>
> As I said, this implementation would be naive as we're now forced to
> iterate through all references starting at the beginning. I assume that
> your implementation will instead use a binary search to locate the first
> entry that matches the exclusion pattern and the last pattern. But the
> way this paragraph is formulated makes it sound like this is a general
> fact, even though it is a fact that derives from the implementation.
>
> I of course don't propose to change the algorithm here, but instead to
> clarify where this restriction actually comes from and why the tradeoff
> makes sense.

In the example you include, it's possible. But consider something like:

    $ git for-each-ref --exclude='refs/foo[ac]'

The region that matches that expression ("refs/fooa", "refs/fooc" and
everything underneath them) does not have to appear as a continuous
single region in the packed-refs file. If you have, say, "refs/foobar",
that will appear between the two regions you want to exclude.

So I think you *might* be able to do it in general, but at the very
least it would involve splitting each character class and finding the
start and end of any region(s) that it matches.

Even so, you'd have to try and match each entry as you determine the
width of the excluded region, at which point you're at par with
enumerating them anyway and having the caller discard any entries it
doesn't want.

> > +	for (pattern = excluded_patterns; *pattern; pattern++) {
> > +		struct skip_list_entry *e;
> > +
> > +		/*
> > +		 * We can't feed any excludes with globs in them to the
> > +		 * refs machinery.  It only understands prefix matching.
> > +		 * We likewise can't even feed the string leading up to
> > +		 * the first meta-character, as something like "foo[a]"
> > +		 * should not exclude "foobar" (but the prefix "foo"
> > +		 * would match that and mark it for exclusion).
> > +		 */
> > +		if (has_glob_special(*pattern))
> > +			continue;
> > +
> > +		ALLOC_GROW(iter->skip, iter->skip_nr + 1, iter->skip_alloc);
> > +
> > +		e = &iter->skip[iter->skip_nr++];
> > +		e->start = find_reference_location(snapshot, *pattern, 0);
> > +		e->end = find_reference_location_end(snapshot, *pattern, 0);
>
> One thing that makes this hard to reason about is that we don't
> explicitly handle the case where the pattern doesn't match at all. So
> you require a bunch of knowledge about what exactly the functions
> `find_reference_location()` and `find_reference_location_end()` do in
> that case in order to determine whether we will end up doing the right
> thing.
>
> Explicitly handling this would give us some benefits:
>
> - It makes the code more obvious.
>
> - We can avoid an extra skip list entry for every non-matching
>   pattern.
>
> - We wouldn't have to perform binary search over the snapshot twice.
>
> Might be I'm missing something though.

We handle it implicitly via the mustexist parameter that both
find_reference_location() and find_reference_location_end() take, which
returns the position that you would find a matching entry if one does
not already exist.

You're right that it would save you a second binary search, but that is
likely to be a vanishingly small cost compared to the actual traversal,
disk I/O, etc.

I could imagine modifying the signature of both of those functions to be
something like:

    int find_reference_location(struct snapshot *, const char *pattern,
                                int mustexist, char *out)

Which would propagate the result through `out`, and the return value
would be whether or not it found a matching entry. But that only really
makes sense when `mustexist` is set to 0, and it adds some verbosity
throughout.

I think that it's totally possible to avoid the second search, but I'm
not sure that the cost of additional complexity and verbosity is worth
the benefit of avoiding one binary search (which will likely be
resident, anyway).

Note though that if e->start == e->end here we will discard the empty
skip region below.

> > +	for (i = 1, j = 1; i < iter->skip_nr; i++) {
> > +		struct skip_list_entry *ours = &iter->skip[i];
> > +		struct skip_list_entry *prev = &iter->skip[i - 1];
> > +
> > +		if (ours->start == ours->end) {
> > +			/* ignore empty regions (no matching entries) */
> > +			continue;
> > +		} else if (prev->end >= ours->start) {
> > +			/* overlapping regions extend the previous one */
> > +			prev->end = ptr_max(prev->end, ours->end);
> > +		} else {
> > +			/* otherwise, insert a new region */
> > +			iter->skip[j++] = *ours;
> > +		}
> > +	}
>
> Mh. Does this do the right thing in case we have multiple consecutive
> overlapping skip list entries? We always end up adjusting the immediate
> predecessor as we use `i - 1` to find `prev`. Shouldn't we instead start
> with `j = 0` and assign `prev = &iter->skip[j]`?

Good catch. I think applying this on top should do the trick:

--- 8< ---
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 137a4233f6..3b1337267a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1054,9 +1054,9 @@ static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
 	 * we want to combine that into a single entry jumping from A to
 	 * C.
 	 */
-	for (i = 1, j = 1; i < iter->skip_nr; i++) {
+	for (i = 0, j = 0; i < iter->skip_nr; i++) {
 		struct skip_list_entry *ours = &iter->skip[i];
-		struct skip_list_entry *prev = &iter->skip[i - 1];
+		struct skip_list_entry *prev = &iter->skip[j];

 		if (ours->start == ours->end) {
 			/* ignore empty regions (no matching entries) */
@@ -1066,7 +1066,7 @@ static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
 			prev->end = ptr_max(prev->end, ours->end);
 		} else {
 			/* otherwise, insert a new region */
-			iter->skip[j++] = *ours;
+			iter->skip[++j] = *ours;
 		}
 	}
--- >8 ---

> > +test_expect_success 'for_each_ref__exclude(refs/heads/foo/)' '
> > +	# region in middle
> > +	for_each_ref__exclude refs/heads refs/heads/foo >actual &&
> > +	for_each_ref refs/heads/bar refs/heads/baz refs/heads/quux >expect &&
> > +
> > +	test_cmp expect actual
> > +'
>
> Nit: it might be a bit more readable if we put the comment into the test
> description instead of having an opaque description that mentions ref
> names that don't have much of a meaning without reading the test itself.

Fair enough ;-).

Thanks,
Taylor
