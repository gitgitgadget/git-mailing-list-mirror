Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C434C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 12:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE772089D
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 12:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKUMnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:43:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33187 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKUMnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 07:43:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id w9so4288979wrr.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 04:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0C+t3FL4siP4r2GPZ1FKzRfauAJnNhT6N9mvSO7Nb4=;
        b=RGR6yLMDVa04hbheD4532zIv9eN554jHDgyV3xosdgwLFdR2AIen94SC0ocrPMgOAU
         ZxRN+rzW2i5wjtjIAuK9jhtslPpxYtyZ0MgsCmIZTAS052s6l3ENrZRrk3V8BPrJMGs9
         2HQakgRfh3YPAc9rgHQaiWpR+XjHDstjsGmFCxKPCO3k5J0JRcixaaHWg7Bv7qeftTwa
         Nr1Hb0d++25+VsCwjFWztg2oTvtY93HMrOu7tBcto2UHB9ZdhE+HDhBPEx7sQGQyM2Ke
         4jcE74X4WbHh5SAdQ7yhT8zM9Cex2nF4G/3tFNvLzmAuZL7z3A0mYGHlMfVWIsREW4Wx
         9+Ow==
X-Gm-Message-State: APjAAAV9UCdAU21CmmNj6yr/A7A24u9hnlPi42+1eEMUfvz49JctAybc
        JjK2WW+G2AgsXJDEj4NIvlZQhaObfHUR/rrGyFXzGo23
X-Google-Smtp-Source: APXvYqwqWEhzJk6DDlfKKS8B5IDAG3irdu6LmMtzatWSZ6yXF51qLI3cCsl+oQAMMqzkWtMktff623T+xEmYpZV5PSU=
X-Received: by 2002:a5d:42d1:: with SMTP id t17mr10184852wrr.56.1574340209626;
 Thu, 21 Nov 2019 04:43:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574125554.git.liu.denton@gmail.com> <cover.1574207673.git.liu.denton@gmail.com>
 <0cb86b383b9c115c9c6077d47f0c124a96b30acf.1574207673.git.liu.denton@gmail.com>
 <xmqqwobvb2cj.fsf@gitster-ct.c.googlers.com> <20191120191258.GA73969@generichostname>
In-Reply-To: <20191120191258.GA73969@generichostname>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Nov 2019 07:43:18 -0500
Message-ID: <CAPig+cQ0xO2ya=3ok=GPV2Ji2HJSFvCtokiRpWJhBAR1skqKVQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] range-diff: passthrough --[no-]notes to `git log`
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 2:13 PM Denton Liu <liu.denton@gmail.com> wrote:
> On Wed, Nov 20, 2019 at 01:26:04PM +0900, Junio C Hamano wrote:
> > Denton Liu <liu.denton@gmail.com> writes:
> > > +#include "argv-array.h"
> > >
> > >  int show_range_diff(const char *range1, const char *range2,
> > >                 int creation_factor, int dual_color,
> > > -               struct diff_options *diffopt);
> > > +               struct diff_options *diffopt,
> > > +               struct argv_array *other_arg);
> >
> > I thought a mere use of "pointer to a struct" did not have to bring
> > the definition of the struct into the picture?  In other words,
> > wouldn't it be fine to leave the other_arg a pointer to an opaque
> > structure by not including "argv-array.h" in this file?
>
> Without including "argv-array.h", we get the following hdr-check error:
>
>         $ make range-diff.hco
>         In file included from range-diff.hcc:2:
>         ./range-diff.h:16:14: error: declaration of 'struct argv_array' will not be visible outside of this function [-Werror,-Wvisibility]
>                             struct argv_array *other_arg);

Did you forward-declare 'argv_array' in range-diff.h? That is, rather than:

    #include "argv-array.h"

instead say:

    struct argv_array;

which tells the compiler that the type exists, thus allowing you to
deal with pointers to the struct, as long as you don't try to access
any of the struct's members in code which has seen only the forward
declaration. You would still need to #include "argv-array.h" in
range-diff.c, though.
