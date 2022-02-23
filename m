Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4E1C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244846AbiBWXg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbiBWXg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:36:27 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E3059A7D
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:35:59 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r7so795109iot.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MHNrfI+UvgqZmi3H10mlk2jP8upSKKZ4Hl1I4HXrOYE=;
        b=V7CP61fAcavkSn6VkqIUIcTRNB/A5zgh2CyFf53Mus21iioneTo1QUmHEHjZXjwEPA
         QXJJ/RJzuYtyRq4l/KymlVScCZr3l+jo9X56tjhkdefIi4gBGhjHdJd5wboKVgKmrxH0
         ovS2NUHXc7AxNvhqC50PciRwOzL6pYKzHHRO2DrRZU74g0juUen117CJwvMjz8YtCo5J
         c4BANf8YfJHu7rJamOi4BDQVH8QMnnsS0llboOMc3fnUclBzjcQqQiyuZ4Y2mbz983c7
         T6SAAGqLhYVv691hcGHPb8G5edDvOLjWEdfNCUX3TDcdNPXn+YoZhiN2nfOQ1MMqxxBe
         9BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHNrfI+UvgqZmi3H10mlk2jP8upSKKZ4Hl1I4HXrOYE=;
        b=7b0lj1DAEL9AQ1/QxogNf3qabDlLzR8FIsW9LiZTSCXj6ZJ67WdlsLYnSf71TNl/an
         QNkAr3m3pIkNsDqQFmTWYR6uaU+qyvgTqtF4ttBRmUDXjzB0T4aeLIJlfgbN39UroWLK
         Ft1BZs3RL0ly9J2nLVU1DyOTstSb54EYQHN6XDK5JgVkHiP8jJe9YwQtQvdiFFweOSHO
         HR3JOGwVFkTsX6pZVMRiYBQ0DCFLnret0m23cLQ5vgfAUgsS+t37zeDMJYrcyCJpLbQI
         FSKpsRS9csQjksFxwtcuPxQeUIb6D1F1HCa1ZluAwhr29qr3kT/PVae8s94YECVLECNx
         zD0Q==
X-Gm-Message-State: AOAM530cvDZWa71sODF7O8cmGevNaDUWWDV2dztm8ADgWJcH+gODR4s7
        yjOTI9Fcfm0H6Ed34Y9hszvMdmSxFZhKZQ9H
X-Google-Smtp-Source: ABdhPJwd0BhRGWspHOU6acHyzERv3oUgP8C5BbuEQFEy3Tf38GxBlc5Cr45tHpwEsQgLTvVAP3fGkw==
X-Received: by 2002:a5e:9248:0:b0:640:70ff:4e28 with SMTP id z8-20020a5e9248000000b0064070ff4e28mr55724iop.44.1645659358661;
        Wed, 23 Feb 2022 15:35:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h19sm716123ila.4.2022.02.23.15.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:35:58 -0800 (PST)
Date:   Wed, 23 Feb 2022 18:35:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        peff@peff.net, tytso@mit.edu
Subject: Re: [PATCH 11/17] builtin/pack-objects.c: --cruft with expiration
Message-ID: <YhbE3YJPN+oj3LJJ@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <37fda94785f1e689c7a7c32e69c6ff16fee7da4f.1638224692.git.me@ttaylorr.com>
 <865b99dd-0b18-9a07-49c1-3959a777c685@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <865b99dd-0b18-9a07-49c1-3959a777c685@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 07, 2021 at 10:30:52AM -0500, Derrick Stolee wrote:
> On 11/29/2021 5:25 PM, Taylor Blau wrote:
>
> > +static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
> > +{
> ...
> > +	/*
> > +	 * Re-mark only the fresh packs as kept so that objects in
> > +	 * unknown packs do not halt the reachability traversal early.
> > +	 */
> > +	for (p = get_all_packs(the_repository); p; p = p->next)
> > +		p->pack_keep_in_core = 0;
> > +	mark_pack_kept_in_core(fresh_packs, 1);
>
> Are we ever going to recover this pack_keep_in_core state? Should we
> be saving it somewhere so we can return without mutating this state
> permanently?

In the same sense that we are free to modify the global
ignore_packed_keep_in_core variable (because we only stop caring about
the modified state right before the program is about to exist) we can
freely mutate these variables, too.

> > +	if (prepare_revision_walk(&revs))
> > +		die(_("revision walk setup failed"));
> > +	if (progress)
> > +		progress_state = start_progress(_("Traversing cruft objects"), 0);
> > +	nr_seen = 0;
> > +	traverse_commit_list(&revs, show_cruft_commit, show_cruft_object, NULL);
> > +
> > +	stop_progress(&progress_state);
> > +}
> > +
> >  static void read_cruft_objects(void)
> >  {
> >  	struct strbuf buf = STRBUF_INIT;
> > @@ -3515,7 +3597,7 @@ static void read_cruft_objects(void)
> >  	mark_pack_kept_in_core(&discard_packs, 0);
> >
> >  	if (cruft_expiration)
> > -		die("--cruft-expiration not yet implemented");
> > +		enumerate_and_traverse_cruft_objects(&fresh_packs);
> >  	else
> >  		enumerate_cruft_objects();
>
> >  basic_cruft_pack_tests never
> > +basic_cruft_pack_tests 2.weeks.ago
>
> I'm surprised these tests didn't require any changes to adapt to the
> new expiration date. But I suppose none of the mtimes were older than
> two weeks ago?

Exactly.

Thanks,
Taylor
