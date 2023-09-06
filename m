Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11162EE14C1
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 18:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243644AbjIFSEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 14:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbjIFSEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 14:04:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546DBCE4
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 11:04:31 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500a398cda5so106300e87.0
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1694023469; x=1694628269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUAEvlCKp0+8Uqu+1TtLfFLsHCHNgBQByMrKjPCKXFM=;
        b=Ch1W+pipjdkaG8h04T2OmwZTuj5gan5kEd/rxvbFpCcPWL6S3g56+iIVTp1ZtG8gLv
         avi1/O5UjTvty9zLYNgrt/1d41+O4a9T5MGxoCk8WbXtOxme+/V8JhlLzIHy+iEvll9A
         RnrS3u/7JT+r/IzKVClaYDuJNwA9laOTMfBSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694023469; x=1694628269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUAEvlCKp0+8Uqu+1TtLfFLsHCHNgBQByMrKjPCKXFM=;
        b=YrMXzavSwIJPSETKb5U8lP9YMWTsgMJpiYV0pGH9yHEuD+eVj1+ii+VJqXHokMuZjR
         vEpJSqFODWmDiEGnI2IngGzwznzDeEagSTOT0aXHJyHRwLel9M80MEumQfPyzQENignq
         14i9PtKtV4yV7UxWeJDOhisaDKCEu7bpjy1l/B5EuEE6HYbZ1yQl5gppZlN1ZXcmFrPC
         OxZQegGtu7i6xcD4HigVlWXQfrUnLIOZtow0P3klXdkWjmzTmFtWhOwdH9a9ulf+qSVk
         ohMxvvn1t1dgDNbyk2bMkcfnP1rP60pXZaPuWzHDHCKSGqEWfyqFtcbS4QCjH7GjCrl9
         hG2A==
X-Gm-Message-State: AOJu0YzCvqYZLSGQd7Z1NZodbWy8jU14hxyDTR+guu2o1q/PfpT8RTgx
        BeuUPi2ml7a5kPWAu6sEOyCAvbFznaaNABoPhdnh0+AaD7aoBRYJ3uiEMQ==
X-Google-Smtp-Source: AGHT+IFJMK8z91fOy33Le5dzBifYNdD4xMa8hWpxhOG2oD6tnwqPL8NoA9tJTuUBu+L5/OMrQHHzyZId+4bmoLERpO0=
X-Received: by 2002:a05:6512:70e:b0:4fb:8f79:631 with SMTP id
 b14-20020a056512070e00b004fb8f790631mr2645660lfs.46.1694023469257; Wed, 06
 Sep 2023 11:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com> <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
 <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com> <87edjbuugw.fsf@osv.gnss.ru>
 <c0a10738-86ba-4b3a-9e74-2568cc407621@app.fastmail.com>
In-Reply-To: <c0a10738-86ba-4b3a-9e74-2568cc407621@app.fastmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 6 Sep 2023 20:04:17 +0200
Message-ID: <CAPMMpohgkH3h1zC_Q7O-07gYw8_7mdSsyX7vu1K1u5+CxKUaUQ@mail.gmail.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap
 error in git gc.
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2023 at 8:00=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> On Wed, Sep 6, 2023, at 18:39, Sergey Organov wrote:
<SNIP>
> >
> > As I see it, in fact a repository can have zero (i.e. bare repository)
> > or one inline worktree, as well as zero or more attached worktrees.
>
> Ah, thank you. I felt like the glossary/nomenclature was missing a few
> words and these ones seem to fill things in nicely.
>

Yes, I agree!!

I like the nomenclature, I like the simple "zero (i.e. bare) or one
inline worktree, zero or more attached worktrees" explanation.
