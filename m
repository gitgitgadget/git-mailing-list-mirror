Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5102DC77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 00:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjECAG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 20:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjECAG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 20:06:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE4F198D
        for <git@vger.kernel.org>; Tue,  2 May 2023 17:06:54 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9d8e8898eeso6510585276.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683072414; x=1685664414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8ZNT1rANMlfiR/FaHOv76MNdD18J/Izx568bEswGKg=;
        b=mRMryhqFcKCMvy0l3GqpiWbrUY8Ca7KiHfXOQ1M5D+CTHn4X9WGszf0ohx8UY5zgao
         +nrW7d33ccuRKEFvG7wlI5gXZEowMbq1+qc09P4b42CKiehi+RzmS0tcQuJ/XfpW8E3Y
         y4DkRFmywfK/PWGAs20k3wRkwYBueA+GlyQ4OsNpxLsvC0CudyWQ8oUBrNWOdVuV8B+B
         yOZEGBXWP4cxToinFm+9hUDxhj5e0I4gt/7oBY7qakgTF6P6UjveeSU2iMzp7yFdPY+t
         mtiVtm6AYAXsqcGVnw9Uop7N4eIzsOzXKagNOjJsroVT2uTqg2i2vjsmfpQCuqURpd/f
         iOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683072414; x=1685664414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8ZNT1rANMlfiR/FaHOv76MNdD18J/Izx568bEswGKg=;
        b=BooRv7muKi+pKYJSV3b+MQ+EH+iYI0lRqXrXrA7fC8NkLXNcTQboY+5U9H4nHVXY4e
         zLNoNFW2QNRnoe8cQyGGf2uGvvN5aCy60f5DvklKh/SgWD+KJ1TfdaSLTvQMn9Snc7ez
         i+7hgX1Xw75J/AMfW8Ktea8mk43bxTuf6ChJY+RpqeSAnkSTukLRZrlMNmmRAo4jcaVw
         UtN/bprTeDMR9v8FzvvZf3gy4nmCDL/DCfAvEwUawWNuMLEcCzqjctAG3iIqeZFzCjGv
         lv12WbBRS2D6oM54bWEPcP4DB+FjuiQ5iVMVkwcjztPq4G8Fb6CenFtY6F0kLCIioJjU
         yeLg==
X-Gm-Message-State: AC+VfDwetqmKNQahRLV7BfoGXpG+jw2FpA/oeM31eEC+WG14+KQ7JKEe
        A5XxwY7kHu/AOH8U2GycKVd/wquTnzXL7mhqX9cvrA==
X-Google-Smtp-Source: ACHHUZ4qqB/eAmvPL2t7F5y1sUzpodOJDQg3qiH91f9nmL0S1Ni4kE4WUAy+dvMjFL2D/bORE3BEjw==
X-Received: by 2002:a25:1954:0:b0:b9a:6349:f0eb with SMTP id 81-20020a251954000000b00b9a6349f0ebmr10088623ybz.24.1683072414010;
        Tue, 02 May 2023 17:06:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d15-20020a25eb0f000000b00b8f52b11de6sm7638290ybs.42.2023.05.02.17.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 17:06:53 -0700 (PDT)
Date:   Tue, 2 May 2023 20:06:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/pack-objects.c: introduce `pack.extraCruftTips`
Message-ID: <ZFGlnB5foNSRFmmw@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <4ba5eec2-dfbb-b918-147a-d6e03c2748b2@github.com>
 <ZEhFScCoAgGGM/th@nand.local>
 <97d84abc-9b25-9d43-503e-264b33c223d4@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97d84abc-9b25-9d43-503e-264b33c223d4@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 06:52:26AM -0400, Derrick Stolee wrote:
> You corrected me that we _are_ updating mtimes, so my understanding was
> incorrect and this follow-up is incorrect. Thanks.
>
> Is it possible to demonstrate this mtime-updating in a test?

It is, though I think that this might be out of scope for the
`pack.extraCruftTips` feature, and instead is more directly related to
the core machinery behind cruft packs. We have fairly thorough tests
throughout t5329 that cover this behavior implicitly, but let me know if
you think there is anything missing there.

> >>> +	if (progress)
> >>> +		progress_state = start_progress(_("Enumerating extra cruft tips"), 0);
> >>
> >> Should we be including two progress counts? or would it be sufficient
> >> to say "traversing extra cruft objects" and include both of these steps
> >> in that one progress mode?
> >
> > I may be missing something, but there are already two progress meters
> > here: one (above) for enumerating the list of extra cruft tips, which
> > increments each time we read a new line that refers to an extant object,
> > and another (below) for the number of objects that we visit along the
> > second walk.
>
> I meant: why two counts? Should we instead only have one?

Ah, thanks for helping my understanding. We have two counts to match the
behavior when generating cruft packs with pruning, where one counter
tracks the number of tips we add to the traversal, and the second
counter tracks the number of objects that we actually visit along the
traversal (and thus end up in the cruft pack).

Since we have to do an identical traversal here to ensure reachability
closure (where possible) over the extra cruft tips, I added a second
counter to track that progress.

> >> Could we store this commit to make sure it is removed from the
> >> repository later?
> >
> > Possibly, though I think we already have good coverage of this in other
> > tests. So I'd be equally happy to assert on the exact contents of the
> > cruft pack (which wouldn't include the above commit), but I'm happy to
> > assert on it more directly if you feel strongly.
>
> This is a case of me thinking "can we test the test?" to make sure
> the test is doing everything we think it is doing...

Good call, and doing so isn't too bad, either:

--- 8< ---
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 0ac2f515b8..3ad16a9fca 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -814,8 +814,16 @@ test_expect_success 'additional cruft tips may be specified via pack.extraCruftT
 		cut -d" " -f2 cruft | sort >cruft.actual &&

 		git rev-list --objects --no-object-names $cruft_new >cruft.raw &&
+		cp cruft.expect cruft.old &&
 		sort cruft.raw >cruft.expect &&
-		test_cmp cruft.expect cruft.actual
+		test_cmp cruft.expect cruft.actual &&
+
+		# ensure objects which are no longer in the cruft pack were
+		# removed from the repository
+		for object in $(comm -13 cruft.expect cruft.old)
+		do
+			test_must_fail git cat-file -t $object || return 1
+		done
 	)
 '
--- >8 ---

> > +		# Ensure that the "old" objects are removed after
> > +		# dropping the pack.extraCruftTips hook.
> > +		git config --unset pack.extraCruftTips &&
> > +		git repack --cruft --cruft-expiration=now -d &&
> > +
> > +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
> > +		git show-index <${mtimes%.mtimes}.idx >cruft &&
> > +		cut -d" " -f2 cruft | sort >cruft.actual &&
> > +
> > +		git rev-list --objects --no-object-names $cruft_new >cruft.raw &&
>
> I like how $cruft_new is still kept because its mtime is still
> "later than now".

Thanks. I added this object to make sure that we weren't testing trivial
behavior, such as removing all objects regardless of whether or not they
appear as extra cruft tips.

Thanks,
Taylor
