Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18765C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 19:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjEBT3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 15:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEBT3T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 15:29:19 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197842133
        for <git@vger.kernel.org>; Tue,  2 May 2023 12:29:18 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-546615d6f47so2507171eaf.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683055757; x=1685647757;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/lYjAEpR94suEoFMeq13dtp/OQOiYfWrLAHt20/YtA=;
        b=APZ/xNcdOEF8lE2KZrgpiCBj+rzl2+/d5BwOM7sl/A63SwtdaW86eRaSw5YXvnMqap
         N05PVQqiVGXP0JM2cxAd+0XDvyspXH/5GhX+jt2wb+zzz+qfFcUCb0DEVe7j8a4TrJ1l
         zcESTEE+9dyTYClnOHO2QU1FGNNX/TkSRX8Sb7pAR3t9wenbsMCLK/GhQhEAYOgPJnNt
         vDl308oawzDgtTaHW5P+tgg0anW3+XzhUwvmMqqOsUiBZZMOGSXe3QxlM1gWg908nNRg
         Dci7M56LENiQyFoXViGTuiWD0AlUNMQVir5FsgaK0MZwaxLJxpx4vI5tHuMl/O9l2P7I
         jdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055757; x=1685647757;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3/lYjAEpR94suEoFMeq13dtp/OQOiYfWrLAHt20/YtA=;
        b=Rv1ha18upbgvb+A9fTw5Vo3B3M7bZj2OADg6eTwmLBJtTqA2/qyXSHvEYiyeWtw55M
         0nxQcaOgRFN8gi2GRso0IzI5GaQ8SXSSmiHqiBZfcZAqDO8fnljI+I6tCPTu8Hvp7pG3
         vzuDqVq2HCOze1/nI3NtfRQ5jcR7uSIWWi/azfLfH6V8JcvUn5hty+Xvj9qP6JPgU46O
         KEvbRcf4tE/EU9xKnU+TxzLmhM2GFd65ex9ti9OrHa7Vod9HLsDFtDjWxIhHOUy8HnYE
         2u6yb4oYeYCXMBJG0qpxQmMfqnISjh+F2Qa7iWpFlvIfXfnAzZyxDcELWL6t+pH5y6Ow
         44ZA==
X-Gm-Message-State: AC+VfDwCIZW+KUj08BVIF4syJFD1XoW4sh7JjJXENaUD2bRB6KxTpyxN
        nqxPoqVu0hRQWgBIPevKvNY=
X-Google-Smtp-Source: ACHHUZ5kN8Ae9llqibigrASSVV+xD02stYf6kWCb+kHGfJReIA40ACenRzr0rttqDCf9Fhtj6g1iLg==
X-Received: by 2002:a4a:e9b9:0:b0:547:6a27:7dc0 with SMTP id t25-20020a4ae9b9000000b005476a277dc0mr8264851ood.7.1683055757371;
        Tue, 02 May 2023 12:29:17 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g13-20020a4ad84d000000b0053dfd96fa61sm1376591oov.39.2023.05.02.12.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 12:29:16 -0700 (PDT)
Date:   Tue, 02 May 2023 13:29:16 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>
Message-ID: <6451648c11a04_1ba2d2947a@chronos.notmuch>
In-Reply-To: <230501.86h6swjp3r.gmgdl@evledraar.gmail.com>
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
 <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com>
 <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1682634143.git.gitgitgadget@gmail.com>
 <230501.86h6swjp3r.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v2 1/2] cocci: add headings to and reword README
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Apr 27 2023, Glen Choo via GitGitGadget wrote:
> =

> Re subject: I don't per-se mind the "add headings" formatting change,
> but doesn't it have headings already? I.e.:
> =

> > -Git-specific tips & things to know about how we run "spatch":
> > +=3D=3D Git-specific tips & things to know about how we run "spatch":=

> >  =

> >   * The "make coccicheck" will piggy-back on
> >     "COMPUTE_HEADER_DEPENDENCIES". If you've built a given object fil=
e
> =

> I think it was clear before that that was a "heading", at least in the
> sense that it summarized what the indented part that followed was
> discussing.
> =

> I think what this is really doing is converting this part of the doc to=

> asciidoc, but is anything actually rendering it as asciidoc?

Personally I write many documents in AsciiDoc format even if I'm not
using asciidoc, as I find them easier to read.

Moreover, one can always do `:set ft=3Dasciidoc` in vim to see some synta=
x
colors for an easier read.

> If we are converting it to asciidoc shouldn't the bullet-points be
> un-indented too? (I'm not sure, but couldn't find a part of our build
> that actually feeds this through asciidoc, so spot-checking that wasn't=

> trivial...)

You can just do `asciidoctor doc.txt` with any document and it will
generate an HTML page.

-- =

Felipe Contreras=
