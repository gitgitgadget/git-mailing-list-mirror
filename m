Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045D5C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E080B61458
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 17:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhJDR3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbhJDR3H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 13:29:07 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217D9C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 10:27:18 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id w13so2482986vsa.2
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JR6ZHCC5xTiuBiA95EXSnG4KORUzgIABA/wRtZcGr9w=;
        b=Q8V4bsg0Fuz/f8upBVi9bDmIAy2W83w0aTA25AjrREwnHY3yDv5W/INPbEvvBDzupL
         Pqk5kpVcFEmkvp7CslM5z2KxY8wDyTqAkILfOITjirjfvC18YA8MylxMSMJWeNsnyG/F
         +4Kj2dP3uHozU2ejs7J9JJE72HGLQZnb1t3zVA9WsFl3MTH2TGElgBjLrBIc/m6i/aYD
         4Bjr0kkbdWMVqCeeuuCKQmXrZgzdsaZcKhz3kvqMrCrODjMA+AywIiDy3DMkJvSMg+XJ
         Gvnkn0UZcnTDHc/CXOqs/n2MKUF5028TRImLe8cbG8jPoYcpGHfey1QJmcb9UU0DqilB
         w2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JR6ZHCC5xTiuBiA95EXSnG4KORUzgIABA/wRtZcGr9w=;
        b=m3SPmUtJnetE+qnwS8W5D9MhagNGcoYJfYNYBEbBoM41hr9SSulMW43PMY+nHSg39h
         DQwJr+biuoTPZgre+zjw7A9sjQNKD7oUPOo0tiPg1F4y/VcT96pGKNwPPf4cgKPXS79P
         pMG99AQ8U6JbtosUv9QXISkYKec3NGHiViTMKYCbac7KO7pQ7Oe4pXPukPLnd5TDVdst
         0Orxowaj1Z5EKXx3y4oAa88s75uuO5jMJOf9/w8DtWoBLJLWlnG1JqkhHKrn8YxWJfL8
         /nVSBF14weiIuUQiOQpE6XsZs/qnuwvK7OLw7Ey0w8fU+5uTMw9Y0Xn8AkI+deIDGKhc
         L70g==
X-Gm-Message-State: AOAM530k/qRc1JG+Jze4nODHoH4QDPcFRZS5GY23zCRI6qLvukF37nsU
        TbIQbHj36NLaZXZ64U+DPufjBraj7B/g9d01mCI=
X-Google-Smtp-Source: ABdhPJzLedEaLX8KI5Rt7E7rpgi5ePAWz8YknY5e9n+sS1Htf/IV+Zzylz8AmzkwTOtOeZdu4amXqNcTLeobZNLEJio=
X-Received: by 2002:a67:fa41:: with SMTP id j1mr14161392vsq.11.1633368437226;
 Mon, 04 Oct 2021 10:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211002153654.52443-1-carenas@gmail.com> <20211004072600.74241-1-carenas@gmail.com>
 <20211004072600.74241-2-carenas@gmail.com> <xmqq1r50ycgf.fsf@gitster.g>
In-Reply-To: <xmqq1r50ycgf.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 4 Oct 2021 10:27:06 -0700
Message-ID: <CAPUEsph_Aqaveur4qZ+Z+85gw1z2CvPOkzbkqW9zt56RoHhUJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] terminal: teach git how to save/restore its terminal settings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 4, 2021 at 9:36 AM Junio C Hamano <gitster@pobox.com> wrote:
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
> > diff --git a/compat/terminal.c b/compat/terminal.c
> > index 43b73ddc75..1fadbfd6b6 100644
> > --- a/compat/terminal.c
> > +++ b/compat/terminal.c
> > @@ -8,7 +8,7 @@
> >
> >  #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
> >
> > -static void restore_term(void);
> > +void restore_term(void);
>
> Curious why you need this because (1) we do not have the same for
> save_term() here, and (2) we include compat/terminal.h where these
> two are declared next to each other.

It is in preparation for the next patch where we will call these newly
public functions from editor.c
I'll be reusing restore_term(), while save_term() is new, hence why
only one had this change.

Carlo
