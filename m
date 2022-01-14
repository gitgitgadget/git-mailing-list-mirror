Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1ACC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 09:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiANJNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 04:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiANJNA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 04:13:00 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D64C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 01:13:00 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id i5so15793988uaq.10
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 01:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZN2WI3PoRzakjzHNo3sflH5Fv27SMKewmeVPK87kwho=;
        b=VZ1lxH9RV2uDxQ5mwLpleXPdm457y3XSalNElD2Slat4wAf4suDojpoeP05ERkN4+0
         kg8WpObjDFmTpIp8vrONtQVVwdDeEc6s3Uyx8hI47EJMLmva4cgJVVVUuERzhtGeRWuN
         eOHLc1+NOJhPbYPO7EmRIUGHZlcsHj4eHPU2Lice3aVjjNdS3md5flMdroSc8jcIpxd1
         CcrqkWJJl0P2TLPCgjOM+fW0g+9i8gymGRGwxA59tqMsQfHxRwDaKyVcFBxut7JEqUUB
         MIdyx3ErGWduW+2Rc/RbqwfK8o7r5nglPlG9tvyegWTHayuD4sus9LMVIe09pbFmQwey
         x2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZN2WI3PoRzakjzHNo3sflH5Fv27SMKewmeVPK87kwho=;
        b=esTTqfhezTFVjM6QRSceDXLIWeyNBjxLPBdX/lOb5HG/HStUytvWt2W4ZFbhrLko0G
         XpUX+4st+7sPr3heVcxclXwgHuFe8hJaBSFAtVqiHodZlLKviHSmcA4TQ/0sDDBBVLsa
         pBxOoUzW8QTKGoCBeckSkHMiyx1zAcRXCM/6TVlU75mdqURX6dN8ByWC67YYYnlObsjB
         QS2TN0FGipDidCK8Br+dr+Ex1I+tj15oFvlTk7yLr+7C5+eHxSg4yZhhMtQ76Io04bWu
         ionCUBAR+zkjmZEFMTDbavcSVx6PFX0UsEwtSjgIkrA5tZfEWHWjvdCGsLaCJU5Ciwup
         tv7Q==
X-Gm-Message-State: AOAM532kH5/KSOoLuUIZujjnkU3YeA0ydlOPivcnKCL83lGspS4jmAmg
        rhzYFJiRusONfXIKXsh46aHFVnGk32ZSPrgmOiPnxhxDbCeOv7Q1NLM=
X-Google-Smtp-Source: ABdhPJwZ0UM/QylitSObAeIwRF7mjvssGZquKRdssTMN5RjtqjUjaKFocSXiALuvHemrmFYqTRIUlN3HSITLdbmYYvo=
X-Received: by 2002:ab0:43e3:: with SMTP id l90mr3968900ual.6.1642151579620;
 Fri, 14 Jan 2022 01:12:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641978175.git.dyroneteng@gmail.com> <3ddffa10278b5814123a5bcd2fd3a531def3ecdc.1641978175.git.dyroneteng@gmail.com>
 <220113.86sftsw1ut.gmgdl@evledraar.gmail.com>
In-Reply-To: <220113.86sftsw1ut.gmgdl@evledraar.gmail.com>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Fri, 14 Jan 2022 17:12:48 +0800
Message-ID: <CADMgQSQaE4EtiNXyGKebPyPS_0YTQ=HN+dU89_jD6BgQ1C470A@mail.gmail.com>
Subject: Re: [PATCH v10 7/9] ls-tree.c: introduce struct "show_tree_data"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 3:07 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> > "show_tree_data" is a struct that packages the necessary fields for
> > "show_tree()". This commit is a pre-prepared commit for supporting
> > "--format" option and it does not affect any existing functionality.
>
> Is the only reason this is split off from 9/9 because you're injecting a
> 8/9 commit for the coccinelle rule change, and wanted to find some
> logical cut-off between the two?

I hope "show_tree()" and "the show_tree_format()" to share this structure,
so I made this a pre-prepared and non-functional commit.

After that, in the 9/9, the structure can be used directly and focus on the
functionality changes. If we merge this commit with 9/9, 9/9 will contain a=
 part
of the changes that let "show_tree()" use the new structure, which has noth=
ing
to do with "show_tree_format()" actually, because we designed them to go
through different execution logic. So, personally, I prefer not to mix them
together.

So, the commit of "show_tree_data()" originally was not for "coccinelle".
The only thing that is certain is that coccinelle also should go before 9/9
I think. With regard to 8/9 and 7/9, I think the current order is OK becaus=
e
they're not related.
>
> For both this & 9/9 this seems to mostly/substantially be code I wrote
> and submitted as part of
> https://lore.kernel.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-av=
arab@gmail.com;
>
> The convention we use in such cases is to retain the "Author" header and
> just add your own Signed-off-by to patches you're modifying/splitting
> up.

Oops. Sorry for that, I misunderstood it before and I'll be fixed in
the next path.

Thanks.
