Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7593EC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550B4613F5
	for <git@archiver.kernel.org>; Fri, 14 May 2021 15:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhENP3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbhENP3f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 11:29:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D33C0613ED
        for <git@vger.kernel.org>; Fri, 14 May 2021 08:28:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s20so16311310plr.13
        for <git@vger.kernel.org>; Fri, 14 May 2021 08:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NQaw1BpHF43tnc3X60ca8L8iu5v0Ji5V8J5WwAydlyA=;
        b=ixo5LKXzfIk2HylEk4vz6niLNOTp+7BGSszFrpBP05egs6UFML5noin4Zg/XQBPsps
         QsagijYaLT7nY/jSrx3WLqc3C2X1gCpkAUArYB2y4fXrfXGVJ4u1gDqKXnn0qZXQWPNI
         fZlqjp3/dPf0hQdVgBDmU72stNH4PedBOfgClqXUMeKrh7Ne2Z8xgn8vfat/npYZVggd
         5hzMm3XDsvnni1F8xglnWNAcPdFHeDDwtNWVLDweNMo5uW3pZ2lshpJMa+CibwUkZGHs
         f5SqGqOCvrcc/y1DQQm2w2zq/x9o4sajIRrccIMpTpoPSP2TSFPlEtJKiLUWTk5rOwnX
         5BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NQaw1BpHF43tnc3X60ca8L8iu5v0Ji5V8J5WwAydlyA=;
        b=VHSWFPTUCOKEathzleLlbuW2nWAojBWl/Qc8P0jvt70mFVdHsmF3Uho/iYqQiX+00l
         2U8N9OzxfRLqR4qs6TjzRp5wiG9OC4u8OPynDt2qqrK3Xx7QlQDgrKQLcdUkbcxnaDdi
         Z1NYeyLZBjbWBSwzJy6YhJBo3cQoqAlXEQnJjZuRkWaqy52g70UHaK50GFv5lAYEwMRx
         V4aEtJR8W75rAzVvxtmmiC9mE2MzbEMeEhPviTfS1lEtf+Jj2lF9F9e/WLJCrFZSBqx4
         ctJOwBeepxOdGYHDJntm5Ue8uZ+ljOUMotfAZqqIEgdTkluKhv5lx9dKL9HU6MxswBvs
         Rd/w==
X-Gm-Message-State: AOAM5328yDQsh2qdAs+JSje6ykgJA96sfqr5Vd3DSGCjC2BxHrMK9hTC
        iG8cG17O87v2LabA6nn8W4Ubghz2qDN3Gc+4d1AO58okDy8=
X-Google-Smtp-Source: ABdhPJzaDJP2Rmly/i6U73fZCu3C1hwhqlKiCokK9wtje/6gyRB4+jBqKBuln9JOXmX/i++7yVkZUF0kN4CzKZHo9c4=
X-Received: by 2002:a17:90a:5207:: with SMTP id v7mr11886710pjh.87.1621006102415;
 Fri, 14 May 2021 08:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620928059.git.martin.agren@gmail.com> <609dd5171e7de_19566208ca@natae.notmuch>
 <CAN0heSoK5VfP68Us2e2bwSfTzY=5FBEBjxuTHRXeA_qg5MH65w@mail.gmail.com> <609e6be4bc14d_4312720861@natae.notmuch>
In-Reply-To: <609e6be4bc14d_4312720861@natae.notmuch>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 May 2021 17:28:09 +0200
Message-ID: <CAN0heSp7JFS3j+DypQm=P-rPzyScvs+Yed75AXYBsQpbJtVytA@mail.gmail.com>
Subject: Re: [PATCH 0/6] AsciiDoc vs Asciidoctor, once again
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 May 2021 at 14:24, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Martin =C3=85gren wrote:
> > On Fri, 14 May 2021 at 03:40, Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> >
> > > We should be submitting bug reports to the asciidoctor project as wel=
l,
> > > so in the future it's less likely we find ourselves in the same
> > > scenario.
> > >
> > > Preferably the bug report should be in the commit message.
> >
> > I don't have an account with the website they use for their issue
> > tracking.
>
> GitHub? It probably takes a couple of minutes to set up an account.

Yes, it's GitHub. I'm not interested in having an account there. There's
some trade-off there with me not being able to report bugs, but that
cuts both ways, so I don't feel bad about it.

> > If you want to submit a bug report and post the link here,
> > that's fine by me and I'll include it in the reroll.
>
> If you would rather have me act as a proxy, that's fine by me.

Thanks. If you have better things to do, no worry.

> Just give me a simple example that produces the issue.

Here are three variants where AsciiDoc 8.6.10 renders the same, with
emphasis:

  single quotes that will not render literally: 'git cat-file'.

  single quotes that won't render literally: 'git cat-file'.

  single quotes that\'ll render literally: 'git cat-file'.

With Asciidoctor (2.0.15),

  asciidoctor -b docbook5 -d manpage -o test.xml test.txt

the XML contains

<simpara>single quotes that will not render literally: <emphasis>git
cat-file</emphasis>.</simpara>
<simpara>single quotes that won&#8217;t render literally:
<emphasis>git cat-file</emphasis>.</simpara>
<simpara>single quotes that&#8217;ll render literally: 'git cat-file'.</sim=
para>

That last paragraph is not as expected. I expect <emphasis>.

I realize that a good answer here is "don't do that then". But the
background is that there's some other stuff going on that means AsciiDoc
needs that backspaced apostrophe. So this is a minimal reproduction for
Asciidoctor where we've lost some of the AsciiDoc-specific background.

A fix that works with both tools is an attribute:

  :apos: '
  single quotes that won{apos}t render literally: 'git cat-file'.

Martin
