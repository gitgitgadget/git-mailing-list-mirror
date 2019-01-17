Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC54A1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 22:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfAQWN4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 17:13:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfAQWNz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 17:13:55 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5443B20855;
        Thu, 17 Jan 2019 22:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547763234;
        bh=0K4qyqnSxafTGkiVGqhdSMGAJ0mwqoBtnN4GLKcGvvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QVQe1CRskAxLuwCWG98GY26DZvuLPmqaHWQFnFiuOT/rnb7BqcAdkrHB7u0Q7SRex
         LHybu1sr7/aZEBUufoTZJESh8pd2XTUaWs4WejPwwzePF4G9gdgMawVtVvSLBpEqkM
         s0ohoMiHm4ZX19lsn5W8tmuKeTr3Sl8RqafpwX3Q=
Received: by mail-qt1-f179.google.com with SMTP id l12so13137639qtf.8;
        Thu, 17 Jan 2019 14:13:54 -0800 (PST)
X-Gm-Message-State: AJcUukdeT3/+UjO0VsiQ2B9o+/Vpl0B2Nd9O2+Hsh3U83fNetYwjOTxG
        eeg+0mWQn8FzfySh2IMv+nF/D3Bq31wK592qHQ==
X-Google-Smtp-Source: ALg8bN74+40LvmLysniMtL/2daI+b/1KDP7UgA5qfzM9vqVmKrFlR2QFqIZuRWPivV11fXQgxBaUn3KwYcmQ0epiuxc=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr12968093qta.38.1547763233563;
 Thu, 17 Jan 2019 14:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20190111215127.57356-1-sboyd@kernel.org> <16335abe-5e7e-fd7a-25f4-373f94e176e1@gmail.com>
In-Reply-To: <16335abe-5e7e-fd7a-25f4-373f94e176e1@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 17 Jan 2019 16:13:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLKQDfK=_M=od2_G6Y4mbdkMn3hLvL+BuSZBEOZKB--pQ@mail.gmail.com>
Message-ID: <CAL_JsqLKQDfK=_M=od2_G6Y4mbdkMn3hLvL+BuSZBEOZKB--pQ@mail.gmail.com>
Subject: Re: [PATCH] userdiff: Add a builtin pattern for dts files
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, git@vger.kernel.org,
        Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 13, 2019 at 3:26 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> Hi Stephen,
>
> thank you for your patch.  I left a few comments below.
>
> Le 11/01/2019 =C3=A0 22:51, Stephen Boyd a =C3=A9crit :
> > The Linux kernel receives many patches to the devicetree files each
> > release. The hunk header for those patches typically show nothing,
> > making it difficult to figure out what node is being modified without
> > applying the patch or opening the file and seeking to the context. Let'=
s
> > add a builtin 'dts' pattern to git so that users can get better diff
> > output on dts files when they use the diff=3Ddts driver.
> >
> > The regex has been constructed based on the spec at devicetree.org[1]
> >
> > [1] https://github.com/devicetree-org/devicetree-specification/releases=
/latest
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  Documentation/gitattributes.txt |  2 ++
> >  t/t4018-diff-funcname.sh        |  1 +
> >  t/t4018/dts-labels              |  8 +++++++
> >  t/t4018/dts-node-unitless       |  8 +++++++
> >  t/t4018/dts-nodes               |  8 +++++++
> >  t/t4018/dts-reference           |  8 +++++++
> >  t/t4034-diff-words.sh           |  1 +
> >  t/t4034/dts/expect              | 37 +++++++++++++++++++++++++++++++++
> >  t/t4034/dts/post                | 32 ++++++++++++++++++++++++++++
> >  t/t4034/dts/pre                 | 32 ++++++++++++++++++++++++++++
> >  userdiff.c                      |  9 ++++++++
> >  11 files changed, 146 insertions(+)
> >  create mode 100644 t/t4018/dts-labels
> >  create mode 100644 t/t4018/dts-node-unitless
> >  create mode 100644 t/t4018/dts-nodes
> >  create mode 100644 t/t4018/dts-reference
> >  create mode 100644 t/t4034/dts/expect
> >  create mode 100644 t/t4034/dts/post
> >  create mode 100644 t/t4034/dts/pre
> >
> > -%<-
> > diff --git a/userdiff.c b/userdiff.c
> > index 97007abe5b16..2bc964e11089 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -23,6 +23,15 @@ IPATTERN("ada",
> >        "[a-zA-Z][a-zA-Z0-9_]*"
> >        "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
> >        "|=3D>|\\.\\.|\\*\\*|:=3D|/=3D|>=3D|<=3D|<<|>>|<>"),
> > +PATTERNS("dts",
> > +      /* Node name (with optional label and unit address) */
> > +      "^[ \t]*((([a-zA-Z_][a-zA-Z0-9_]*: )?[a-zA-Z][a-zA-Z0-9,._+-]*(@=
[a-zA-Z0-9,._+-]+)?"
>
> From the spec, label and node names =E2=80=9Cshall be [between] 1 to 31
> characters in length=E2=80=9D.  It=E2=80=99s not enforced here, and I gue=
ss it=E2=80=99s not
> really git=E2=80=99s job to check for this kind of rule.  Others may disa=
gree
> with me, though.

The spec does say 31 characters, but that's never been enforced. So,
of course, there are occurrences in the wild (though maybe they were
just property names, not node names). In any case, we plan to change
the spec to increase the size. To what, I don't know.

Rob
