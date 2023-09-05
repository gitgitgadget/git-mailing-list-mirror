Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED45CA0FFB
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjIEQAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354909AbjIEPs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 11:48:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3766EE6
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 08:48:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52c9f1bd05dso3899811a12.3
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1693928901; x=1694533701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI8Q3dIRGByvAGHGi/3cJSPEOgwVMkxf94is4oFVbyg=;
        b=cEyrMyk4GV5TSq19zWS+vXvYc+q5IbMhhsJbA7onBDj8Zn8879UQACfmPY0PdyRd+i
         MDZxqoty75TWCCek4Hc9ilrMO+9xrGlSEukvCs8gjRLNCkmsLaDdvkPwPsPNlKqMAOxl
         +PZiaQ2+vid5ZXQ9i5m219hMVQzq5a7yMc+No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693928901; x=1694533701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI8Q3dIRGByvAGHGi/3cJSPEOgwVMkxf94is4oFVbyg=;
        b=CJ/fkC0st2erRFIYD6wvhODhjACGYCqq8Y5/FdRDGRfSuDbTYdY3Agi+8uzhhDxlJM
         t+P7be/eheMs3uKOoe/8bw+Eg3gApOoWcmZ6+8ZxTv5hd/xbjdaIOmac9EzZ28NXN25k
         of6jBmqn3quLtFPJRtxr+6tSKwqHSxkhl+sWEZrT4xRZwpVYK9G5MNgGPK6V9dshOpOR
         gMp7/ZIYz6sdTZqodtr3demjOmTXaVcc34pqgtoLQd45DuKHDIAgP+93vo4i+GC2lXsQ
         VRowNSOBykqy4gkHx8/RjqS1KEQ8m1AUvHEaGL3SbgPnHVrTKssPtdM9FOJH4n8cgJMO
         G1Eg==
X-Gm-Message-State: AOJu0Yz1QUHQXSI28y6jd7wfTEBa/cBcy/yJmKp4UXif3bsiiFUw85Jd
        WBrW9zSPWMiFpbm1SorNlvEu+wBMdKRWkGuHGC6bZWkFKNBAn0rLb48=
X-Google-Smtp-Source: AGHT+IFochj3RdZDgeBIrn1+oJx+UVQDkjO6h1g8RWxCXzBDnlhXwh+XGXx0C7kjgRCw3tTvOxeD+qe5e6anpOrFN/Q=
X-Received: by 2002:aa7:c6c7:0:b0:52a:250e:a052 with SMTP id
 b7-20020aa7c6c7000000b0052a250ea052mr171178eds.7.1693928900516; Tue, 05 Sep
 2023 08:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
In-Reply-To: <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 5 Sep 2023 17:48:09 +0200
Message-ID: <CAPMMpohc-pOD33NE_wSwYnMYKQYEtAQ64B2qwKZmUM38Euk9mw@mail.gmail.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap
 error in git gc.
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 4, 2023 at 7:57=E2=80=AFPM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
>
> And then from that vantage point it might feel wasteful to dedicate an
> unused main worktree=E2=80=94with its own working tree=E2=80=94to just si=
t somewhere for
> its `.git` directory, essentially.

Yep, especially in my case where a worktree contains 200,000 files and
5GB; especially on Windows, that's a high tax to pay pointlessly.

>
> The glossary says under =E2=80=9Cworktree=E2=80=9D (on Git 2.42):
>
> > A repository can have zero (i.e. bare repository) or one or more
> > worktrees attached to it.
>
> And as someone who never has needed to use a bare repository + worktrees
> I've just left it at that.
>

Thank you for this reference - given Eric's later answers I'll aim to
change the text rather than respect its current implication, but
knowing what needs to change is hugely helpful :)

(not that I know what to change the text *to*, but I guess there's
time to think about that)
