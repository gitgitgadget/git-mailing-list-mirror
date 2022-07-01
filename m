Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF1C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 05:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiGAFVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 01:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiGAFVy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 01:21:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D04C14D10
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:21:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e2so1555920edv.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H4Bh8DGcHSgGWrTFjo/ukKXZnGfMjla51kh31yiZXBE=;
        b=k8775I4pr7yZ8+EOwTHGj5VUpWZvIKs/gUnQt+ru88Go2fBIIeb+uO7CQ2g6AM81dE
         IwBbnrbscNRO6ePrznl/J/TKRa90ntrYyKI9/RUz4sWw4dLqugyvXAfxKdxhb/3zycw1
         S8cUxDnvbRA4yfk5G2g5jxbsBO4j2iNN1/Vz7Owep0QQowXtk+jNS5z90mhsZtIkNAGp
         WISm3pdd/lj5V7fMce+I7YpfGXOI7KTCY3G3GMVnqyxxeKLr/Sf1qRmK6YeeZIOBROPS
         zsBTrog8zHeYbeRxq0PmoR+qh3kP23T9hdCbyca6EIksVOnoLZhuoZktIYyOyIO7VKzP
         fB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H4Bh8DGcHSgGWrTFjo/ukKXZnGfMjla51kh31yiZXBE=;
        b=vUQamscxcZYAqYKtwkCyCe2B5FlMHsTiyENfwca/vwaPktHaHk04maud12CVwZrhyh
         lvXH8CCfMEkIodA43958Bbe9vRUqo90wA97ASPaxhULDNdz56XqsSaUmfTUilg/qij/g
         YrGIHi9ek0DtrJtZprJMQdL8hMIcPwW4guu6UIMGPDdF/KGkVFWlL4qmsX50ecJPlkwN
         Jyp4kXTw5nfmJSgnY5aO1BSIMTiqHDc7ji/SGdt3o7XIwfCrtniY+vEFwLMlZ3ujWbzw
         UAkcS3lUwVt+JoLSv/t3oJc+F8BFKk4vSZliuvqpl3TOdPCS8qPOI9cE+RNMrXe9rDRe
         DLhQ==
X-Gm-Message-State: AJIora/iWSrCYXKIM/DZia2vBoLtw3212lD6CRHfa0jOw+mPZoOg0Mz9
        Gwp7ufx2FoLxLLhdgb+zFidhOKQ3qalnhl/1x9Q=
X-Google-Smtp-Source: AGRyM1sb0Mvgqayv59NtY/tXyGh1FoZlqY2mG/lh+upJiI7dZghQ9EnXUyAYlVLHbwSXRKveGhMdx7flxtiAX62KTrQ=
X-Received: by 2002:a05:6402:2999:b0:434:edcc:f12c with SMTP id
 eq25-20020a056402299900b00434edccf12cmr16156360edb.96.1656652910840; Thu, 30
 Jun 2022 22:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
 <pull.1194.v2.git.git.1642443955836.gitgitgadget@gmail.com>
 <20220630095357.GA2123@szeder.dev> <CABPp-BG1MARvcqgPYBNQ0P1M9jZ2b8vt9btPG1oQ5_h_YM78TQ@mail.gmail.com>
In-Reply-To: <CABPp-BG1MARvcqgPYBNQ0P1M9jZ2b8vt9btPG1oQ5_h_YM78TQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jun 2022 22:21:39 -0700
Message-ID: <CABPp-BHSJqt9+cutx5qppdT6vuQFUqCoBsmfqdGj3vzh4Z_sVg@mail.gmail.com>
Subject: Re: [PATCH v2] merge-ort: avoid assuming all renames detected
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 7:30 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Jun 30, 2022 at 2:54 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> >
> > On Mon, Jan 17, 2022 at 06:25:55PM +0000, Elijah Newren via GitGitGadge=
t wrote:
> > > diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge=
-sequence-rename-caching.sh
> > > index 035edc40b1e..f2bc8a7d2a2 100755
> > > --- a/t/t6429-merge-sequence-rename-caching.sh
> > > +++ b/t/t6429-merge-sequence-rename-caching.sh
[...]
> > > +             git ls-files -u >actual &&
> > > +             ! test_file_is_empty actual
> >
> > There is no 'test_file_is_empty' function, but because of the ! at the
> > beginning of the line it didn't fail the test.
>
> Oops, looks like I meant test_must_be_empty.
>
> > The minimal fix would be to use 'test_file_not_empty' instead, but I
> > wonder whether we should use 'test_line_count =3D 2' instead for a tad
> > tighter check.
>
> Makes sense; since this merged about half a year ago, I'll submit a
> new patch to fix this.  Thanks for catching and pointing it out!

Submitted over here:
https://lore.kernel.org/git/pull.1276.git.1656652799863.gitgitgadget@gmail.=
com/
