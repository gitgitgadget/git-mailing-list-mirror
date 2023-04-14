Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23775C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 18:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDNS0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNS0R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 14:26:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069D510F1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 11:26:16 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso16543337ott.4
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681496775; x=1684088775;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw8b6Cv03jH/Lm3WLMagHJ5YiSuN5ulVpIRsxq/e8s4=;
        b=gMRg0tVtbGVCVaGmT91T0ZTTchXJKlR9e4Z4iZ8pzHRMgARGajj9t7riiWxBwoYezl
         gMUzEcIGr4r9c7aieo7mTnbPy0pR+jtSSNdKnqW5RVhNDOsxPu+iYD6Iue6ZdJnWOp0w
         vSeML7KF5ApIROzYl7vsGkKhVAF1FvmaqNU8Gwprsio9YeuIRdTtNANbR60YGimv4GkA
         hL1QnABsfud6J9yLWamaF0J8XdTtoF+tb0orS1cerMuzYUW9Ucn1VaPB6YzFB5U7xGxh
         GGyI8tKQTG8ICc8bYiI73ybx+ENB7yqU1QnN9pPxVxtS4TePKgKifctQBIeyH/2o1ete
         dItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681496775; x=1684088775;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fw8b6Cv03jH/Lm3WLMagHJ5YiSuN5ulVpIRsxq/e8s4=;
        b=U+Kzc+AHdjY5WrM3eUfv+yvkSdEIUPGAvvJaIfxgbvov1z6dgvGdpSqRT/dZdYoCWX
         ELx5XoV7BnIVwYlJoEk/w4WUYyOwzaEQNHExuZvMPBlALYEKAkGID6YufrOUJVPaF6LM
         CzjJbYz9UbiNj4zDP8uHL8mL+Xzd3GJW2cJy2FVaTHRwWQWFP+8rPHFtfO/wq7XS3kVA
         JvIPjXjsHDTi3fcyzhpBrFI0cyO3PNPDKjM1NAnh05CjnhFp+2iIupUmctXNowT2NLog
         Kosn1u+mg/4SvItm+uh0s5Q9M1BMAU7oHyxQtPIUBsCp9hNBlg8AOzQyl31j5XOZp67o
         2IUw==
X-Gm-Message-State: AAQBX9cINBURdVqvAgmvzzkxTnZG1jBaJZyBKaldL4jD7/EgIhneFaVc
        zm6ehNiIXLOxBGWS6SboJm4=
X-Google-Smtp-Source: AKy350aSVJmU772h/wGLbRZFeY1jA/Eyp6CVhe0plTx3LIG3fimUXDPvk2aPsrLFoAXV9xlYQAOX+A==
X-Received: by 2002:a9d:6e97:0:b0:69f:77b1:fb52 with SMTP id a23-20020a9d6e97000000b0069f77b1fb52mr3601282otr.17.1681496775182;
        Fri, 14 Apr 2023 11:26:15 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id p9-20020a056830130900b006a154373578sm639837otq.39.2023.04.14.11.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:26:14 -0700 (PDT)
Date:   Fri, 14 Apr 2023 12:26:13 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Message-ID: <64399ac5685a4_5f77329495@chronos.notmuch>
In-Reply-To: <xmqqildys97o.fsf@gitster.g>
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
 <20230414070449.GA540206@coredump.intra.peff.net>
 <643949a57396c_5b7e62948d@chronos.notmuch>
 <xmqqildys97o.fsf@gitster.g>
Subject: Re: [PATCH] doc: set actual revdate for manpages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> >> > index 3133ea3182..b629176d7d 100644
> >> > --- a/Documentation/Makefile
> >> > +++ b/Documentation/Makefile
> >> > @@ -144,13 +144,16 @@ man5dir = $(mandir)/man5
> >> >  man7dir = $(mandir)/man7
> >> >  # DESTDIR =
> >> >  
> >> > +GIT_DATE := $(shell git show --quiet --pretty='%as')
> >> 
> >> What will/should this do in a distribution tarball, where we won't have
> >> a Git repository at all? I think we'll just end up with a blank date in
> >> the xml file, though it looks like docbook turns that into today's date
> >> in the result.
> >> 
> >> That's not _too_ bad, but feels a bit inconsistent (and it uses the
> >> format you're trying to get rid of!).
> >> 
> >> It would be nicer to populate the date variable in that case, like we do
> >> for GIT_VERSION. I think that could look something like this:
> >
> > Indeed, that would be better, but that totally can be done in a separate patch,
> > or a separate series even.
> 
> Seeing Peff's change, it sounds so small a thing that it feels a bit
> unnatural not to do that in the same series, at least to me.

It should be a small thing, but the GIT-VERSION-GEN script has not been
updated since 2008 and has a lot of issues (from my point of view).

I think it should be cleaned up first (I already sent a patch series for
that), *then* it would be trivial to add another field.

But that would add another (unncessary) dependency to this series.

> Having said that, I think that "we make progress one step at a time"
> is perfectly acceptable and may even be preferred, as long as the
> formatted manpages from the tarball would not change between with
> and without this patch.  That way, we make the output from a
> repository better while keeping the output from a tarball extract
> intact, and make the latter match the former in a later effort.
> 
> So, I "wasted" (not really---this was a fruitful validation that is
> a part of a review process) some time to play with this on top of
> 'seen' to see how well the tarball extract fares.  We get an error
> message from "git show" complaining about "not a git repository" but
> that is to be expected ("sh GIT-VERSION-GEN" does not share the
> problem, though).
> 
> At least with the versions of toolchain picked by default in my
> environment, I seem to be getting identical "04/14/2023" in a
> directory extracted out of a tarball taken from 'seen' (with and
> without this patch) in the formatted manpages, because we do not
> have any record in the input either way.
> 
> Formatted output from a repository working tree changes from
> "04/14/2023" to "2023-04-13".  The value change may be intended, but
> I am not sure if the format change was intended or even welcome.

I live in the vast majority of countries where MM/DD/YYYY makes
absolutely no sense, so I think it's a plus if any man pages have a sane
date.

I'm pretty sure I'm not alone on this, but some might disagree.

> If we want to correct the date format, it can totally be done in a
> separate patch, or a separate series even, with some justification in
> the proposed log message, I think.

Sure, but in order to do that we would need a way to convert the sane
standard git dates to USA-centric dates, and I'm not so sure the
tidyness of having both dates wrong is worth it.

Would you consider something like this more welcome?

  GIT_DATE := $(shell git show --quiet --pretty='%as' | sed -e 's|^\(.\+\)-\(.\+\)-\(.\+\)$|\2/\3/\1|'

-- 
Felipe Contreras
