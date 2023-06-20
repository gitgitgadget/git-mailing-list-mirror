Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0AFEB64DC
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 11:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjFTLxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 07:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjFTLw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 07:52:59 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF0718C
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 04:52:58 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so4630619276.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 04:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687261978; x=1689853978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7aklSuxAufNQPoRj1/KohtW9VPjUe9DmfKS4oIxKch8=;
        b=oHdHLNlzyahnQItPDTGdr31knXNE3yOb4N3rMcQ7tYvto3fGCVpjwQrBogxXvc7n/I
         C/CWbzI5KdhPfMkqP41sv6ZdEraguFnGhPLLqRny0IOwyUMjWRNfVHApJ9V7ZkIPw/ul
         slpCXiUvWIkU11eQU2rWwtqo/ynIRdjKWyPDHLFhX1iDKwlGWZkoQ0XxyjtobO9ah9Zj
         HFGB8bYGngRzaOsMl8y2FBr7AL/Y0+U9dnY7a4P3IrtKbt+befQAqtl8/0VrpCuKGzYh
         9x+GN+X7HC4uYsSaHRgm+S4hZenGv/fIhFvQ7SE6MctsJ4WGijjgQZqIhJYfVToM3/Ra
         H34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261978; x=1689853978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aklSuxAufNQPoRj1/KohtW9VPjUe9DmfKS4oIxKch8=;
        b=T5qhBFjTLX6/EA5z6z6/TIVpNgAWWiiFfXe/1en1Etkg/fYwTdxEmAvLu2oxYyc1ig
         MP3WtoXzUGSsapNKCACHPur9UN0qpZn4MqWY9ZizgUInmpUy36px1hrThCn7HKu6Z0M2
         EjKKpDxtj1EYgsowOJSSefRnv1rO3fW/MqgwbNSHNx37KRfmT7OblkyFW7oHNCDH9Lov
         T8+WqqGZC7O+v/s7xNA4CsgxKFMjk/bgZzTabqHXKt1HrDj+pI0Sy2X4EiITq/VGLF5V
         lPG8inbxKxKBty2NpOinxY9LWpwKyPLSdi+RYDwRSlPMKtw8R/bwrYTNLUERQIAeVHC0
         7ikw==
X-Gm-Message-State: AC+VfDz485w/D4RjaQX/XdpQSUTDHKeK/Ub/0mtsu65Uaj3TFYgkhWUU
        HM+ibdmj9jTrRUgKAqFHCAORLA==
X-Google-Smtp-Source: ACHHUZ4PXx6rXC1dCLShawXQ+L4+9Uqu9qtg9iFD41F8uIb7Q8wJDIcmZHIvaIwynIlKoP0El9i1NA==
X-Received: by 2002:a25:d8c:0:b0:bca:f2b2:cbf5 with SMTP id 134-20020a250d8c000000b00bcaf2b2cbf5mr9345317ybn.38.1687261977531;
        Tue, 20 Jun 2023 04:52:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3-20020a250103000000b00bf4d24fd976sm333880ybb.10.2023.06.20.04.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:52:56 -0700 (PDT)
Date:   Tue, 20 Jun 2023 07:52:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 07/16] refs: plumb `exclude_patterns` argument
 throughout
Message-ID: <ZJGTFcYf7G05KHad@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
 <c4fe9a1893c15c5aae4d3f305b248d0c3ac55222.1686134440.git.me@ttaylorr.com>
 <xmqqsfav2alu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfav2alu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2023 at 04:42:05PM -0700, Junio C Hamano wrote:
> > diff --git a/ref-filter.c b/ref-filter.c
> > index d44418efb7..717c3c4bcf 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -2209,12 +2209,13 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
> >
> >  	if (!filter->name_patterns[0]) {
> >  		/* no patterns; we have to look at everything */
> > -		return for_each_fullref_in("", cb, cb_data);
> > +		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
> > +						 "", NULL, cb, cb_data);
> >  	}
>
> Is this merely "while at it", or was there a reason why refs_*
> variant must be used here?

Good question. This changes later in the series (via
"refs/packed-backend.c: implement jump lists to avoid excluded
pattern(s)") to pass the excluded patterns from the ref_filter.

There's no need to change it in this patch, since the functionality at
this point is equivalent in the pre- and post-image. I think this
staging is a consequence of having written much of this series before
committing anything, and then trying to segment it out into meaningful
patches after the fact.

> It is curious that we do not teach the exclude_patterns to some
> functions like for_each_fullref_in() while adding exclude_patterns to
> others, making the API surface uneven.

We could plumb it through in more places, but my preference would be to
modify the API if/as new callers need to pass a list of excluded
patterns. The API has an enormous amount of surface area (and many
functions which take a ton of arguments), so I'd rather keep it small as
long as possible, even at the expense of some unevenness in its
interface.

Thanks,
Taylor
