Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3431DC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FC52073B
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MvEL3IHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgEEQAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgEEQAR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:00:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB48AC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:00:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so1359165pjh.2
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NVuKvpatEW214PDc792L8tMItBSj45xSRGog11/WhzA=;
        b=MvEL3IHQzGXBiNzFt1i1dxRf2g+edhrDtl+AF9Hh7SuUL7GC+Yzj+BWiY735d0wqVv
         k4XCBBdkzjHupkdmI85te3SWO9xNq+ymXf+q9l8h7OLfF0+Z3/tDzuLmTlZ2KKCjgcKg
         2omOaK9eqP0JsN260bA/FpHN9R2HYjHhuIrbKCtUTrzFCET9eUHfsoMTbo3L4vptqBsm
         QfEmWjT22FBH0ZAGMoCVzl4ZlZncOTSQFO9Zb8/oKUHlQVJae+s4zcuVPXgIofwMqAYR
         xOnzUjfTklJz6sSnVRSEgTBlyIAccpLkCStyfRn0bz88G257hC3eDYgqdZWxb7ExxDrl
         ecJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVuKvpatEW214PDc792L8tMItBSj45xSRGog11/WhzA=;
        b=o6QagrLKhPNkLKzL7WN3r6F2WjweFkP64rhQbBCvX+Wpxmj8kX3np8lb+FWL25L80b
         /TCStSU6y1BFCB0SJR5A6d7tom7RVUOkHEDFR+i2J9VFf3+S5igFjjiBST38pLBy4iP5
         1Xx2qigMpUEZ4qWX0J3ox5G5Da9BONwcG9t4AE+/1PrBXpz48rQVitKjYnkD3wX1kmfC
         YF/Z1Pubuu/NL5tT/b0D1e5fvtWNIkaorXbyOW3wYtaTDrN3/oUQTlQkmGZEuCV9jaGw
         bC9m1L/IGeWM0vbIT5CHgHTeKr5n3n53iftW7gKdoa91KHObmd+Qy0r9YzE/ktJ+ubJr
         QvaA==
X-Gm-Message-State: AGi0PuY65zoYWzK6Ydyjg+0aoiSJhJpAluE5oV74AkgsEbylob02VSY0
        5rp7GsJYIVek3ZhY0wVi33HW8w==
X-Google-Smtp-Source: APiQypKW4HPVtGOx90Iyo6JEnsxEW6ILOgxbvSF+/5ABKtJQhRuq+KFEFfOFgWbJtzbpOfTpJ7ufWQ==
X-Received: by 2002:a17:902:dc84:: with SMTP id n4mr3569308pld.281.1588694417237;
        Tue, 05 May 2020 09:00:17 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g40sm2438084pje.38.2020.05.05.09.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:00:15 -0700 (PDT)
Date:   Tue, 5 May 2020 10:00:14 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 4/4] pack-bitmap: pass object filter to fill-in traversal
Message-ID: <20200505160014.GB69300@syl.local>
References: <cover.1588633810.git.me@ttaylorr.com>
 <f1eb194b9fdf5e385610fa3c0ddee22b89cf4f0e.1588633810.git.me@ttaylorr.com>
 <xmqq1rnzc52c.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rnzc52c.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 10:40:43PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > But now that we support tree filters, there's opportunity for savings. A
> > tree:depth=0 filter means we can avoid accessing trees entirely, since
> > we know we won't them (or any of the subtrees or blobs they point to).
>
> "we know we won't _have_ them"?

Yep, fixed. Thanks for pointing it out.

> > @@ -506,7 +506,8 @@ static int should_include(struct commit *commit, void *_data)
> >  static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
> >  				   struct rev_info *revs,
> >  				   struct object_list *roots,
> > -				   struct bitmap *seen)
> > +				   struct bitmap *seen,
> > +				   struct list_objects_filter_options *filter)
> >  {
> >  	struct bitmap *base = NULL;
> >  	int needs_walk = 0;
> > @@ -599,8 +600,9 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
> >  		show_data.bitmap_git = bitmap_git;
> >  		show_data.base = base;
> >
> > -		traverse_commit_list(revs, show_commit, show_object,
> > -				     &show_data);
> > +		traverse_commit_list_filtered(filter, revs,
> > +					      show_commit, show_object,
> > +					      &show_data, NULL);
>
> And then finally the change in step 1/4 pays off.

Woohoo!

> >  	}
> >
> >  	return base;
> > @@ -999,7 +1001,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
> >
> >  	if (haves) {
> >  		revs->ignore_missing_links = 1;
> > -		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
> > +		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL,
> > +					    filter);
> >  		reset_revision_walk();
> >  		revs->ignore_missing_links = 0;
> >
> > @@ -1007,7 +1010,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
> >  			BUG("failed to perform bitmap walk");
> >  	}
> >
> > -	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap);
> > +	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap,
> > +				    filter);
> >
> >  	if (!wants_bitmap)
> >  		BUG("failed to perform bitmap walk");
> > diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
> > index 75ccf9f4e3..b3e725f031 100755
> > --- a/t/perf/p5310-pack-bitmaps.sh
> > +++ b/t/perf/p5310-pack-bitmaps.sh
> > @@ -91,4 +91,9 @@ test_perf 'pack to file (partial bitmap)' '
> >  	git pack-objects --use-bitmap-index --all pack2b </dev/null >/dev/null
> >  '
> >
> > +test_perf 'rev-list with tree filter (partial bitmap)' '
> > +	git rev-list --use-bitmap-index --count --objects --all \
> > +		--filter=tree:0 >/dev/null
> > +'
> > +
> >  test_done

Thanks,
Taylor
