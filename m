Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD9C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjDYSxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjDYSw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:52:59 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1797117A16
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:52:40 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54fc6949475so69818567b3.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682448707; x=1685040707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gb9shQuKezW+KBS/gU9x0lEnJv1ykElMPVDUOJbF7jo=;
        b=lGoPo3bj8jM1V9aAO8DhwdiqxjAGORFrY7qU60Tvxquel5QmfwUBvcsxv4rSbii2Nj
         MO1Eqyf7uoSzPcLovpolvrkcjKFCX0hcY3UscBXZ8UMYAMlseoUAlCJMLe/JOEuFGgrk
         H6DL6dao0aBiYUjJ4W6aErgALdXD0vWsvNwarThhjJYA72OmfGIgJwWdcSXNYsR1iYFm
         oL2n+PDVVkcnJHTRDlwBfi7g1+JzOpi7tA2ftBakdEq76Hiob7HhcUieIT1FxIhkC3Xd
         nYwv7dp1jR4At26IwhWHXzqN1Lx42gTVIDBFzyGAY0vfKdmQGLR/3s6WCoY6WC455e9K
         /89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448707; x=1685040707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb9shQuKezW+KBS/gU9x0lEnJv1ykElMPVDUOJbF7jo=;
        b=TOz8ZwOYqrg5ANkyG2IDlQkoIZ+wrBSDaFdPqNsSl4dwVVvswEgMJHlLRKxVT+7nFI
         fjEKzIve4STA80z3Umlf699FcBjGxDTCGdy73OvzMIAH60BQlKJdccnXtsCalRVfFoi6
         Y2MfgbrhVUE5ij/tD5xaFjzR0AyWPcvm2tYZU0MIxNIZ8ZH39p760YQ3nvsTvv8UaoIv
         9fmLPxDATCBX4LjZ9RTbZPLnJVSrgCRZRioQD8wvF7xTI1lGzEUWcnHxdH06K6Ba6LMB
         p8l3mRcyOHASsV6jIxFbgyx3vaELGLkmP6z6S0OzXu8ZnkIFIehWCMeBUJhuzbE9XAm9
         JYlw==
X-Gm-Message-State: AAQBX9ceHKQiGVY6kALawyPJogmdWdshXavuLDsR7oLODv+WX74AQfpe
        1oLPguf3lueaaleZRiMx/g2ya+V+dLHkLJtKRWLdrw==
X-Google-Smtp-Source: AKy350amjBpWjycmW4EqwmxqM6idux54PLNEMtVcXmwzFfWb8muv1iK2MntBjLbVcJzsWnLlMcbvsg==
X-Received: by 2002:a81:a156:0:b0:550:9d9f:5fb6 with SMTP id y83-20020a81a156000000b005509d9f5fb6mr12146822ywg.1.1682448707178;
        Tue, 25 Apr 2023 11:51:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u142-20020a818494000000b0054f6f65f258sm3737503ywf.16.2023.04.25.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:51:46 -0700 (PDT)
Date:   Tue, 25 Apr 2023 14:51:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/3] pack-bitmap.c: extract `fill_in_bitmap()`t
Message-ID: <ZEghQRZWZIlZcIed@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <7624d3b5ba0415588a924aad2b855088e3d2028b.1682380788.git.me@ttaylorr.com>
 <xmqqmt2vzubq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt2vzubq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 11:32:25AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > To prepare for the boundary-based bitmap walk to perform a fill-in
> > traversal using the boundary of either side as the tips, extract routine
> > used to perform fill-in traversal by `find_objects()` so that it can be
> > used in both places.
>
> What is done is not a literal "extract", though.  Worth mentioning here?

Oops. It is supposed to be a literal extraction, but this patch was
originally written before 3e0370a8d2 (list-objects: consolidate
traverse_commit_list[_filtered], 2022-03-09).

> > ---
> >  pack-bitmap.c | 66 +++++++++++++++++++++++++++++----------------------
> >  1 file changed, 37 insertions(+), 29 deletions(-)
> >
> > +	if (base == NULL)
> > +		base = bitmap_new();
>
> Style?

...It was also written before afe8a9070b (tree-wide: apply
equals-null.cocci, 2022-05-02), which is where this "if (base == NULL)"
thing comes from. I fixed both to be a clean extraction with no
functional changes.

Thanks,
Taylor
