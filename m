Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C74BC636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 11:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjBGLxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 06:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBGLxj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 06:53:39 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA81EFBD
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 03:53:38 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4a263c4ddbaso193435427b3.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 03:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i3GXKLCLmFRiiX0abKmu8pRSX5SAm9JjyzSS5Soe53w=;
        b=Zzowz67m3y2wXLQJ75aVhO7nxMteuKzNnpyQIze4U7hVbSTgDIVn+GquvlKC8A4DSD
         mPev1ajNCF08z2k8moqPfMdkYEa+GZ87JE+fRtM2u+j3hRWXT1UytEol2XsQTETdh0fG
         vO7Npg8CF2sINt6TA/IBzW+Ig4BlXVkTRNn8jNOrMi2gl+NkUVb/h2WTrJ5hSt2DiLI7
         O59/nQ9pQvtEfEEe64SuLAuP4osSpoRB6LrkidK2NfsgDnW1XRKOBFwerlpTKUF9xTEs
         ycNWyyNio0/G3/fXK2yxoVhY9EuXyKll83NN4ZoFpAFhLLlZtlFccx3tHtZgQ/C/IS+J
         6N0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3GXKLCLmFRiiX0abKmu8pRSX5SAm9JjyzSS5Soe53w=;
        b=jh848NTTSTQiZemt0pfXPahlWceRLRJ2qxyaoNu5C8FvzWpd8pQaQOqPGhFyozEdQi
         Rhj/qSM1YoBhZjaBt8+Bz7vlSzPCXGkfPDzYD2eF/LtxjT3JvG3dg3WYfVJHq7D9vXKL
         /PPUu5okaa8ReP0Jl7iRE/mEkyI5thdJo+MVxsqgoVAzSS7wlcq/i+nOEu0hixBbPOkS
         92t7X6EBj3BejQRbXCY48AlSoKBcfH/r6+S1NVdI0oH5vJIbu2FF/n5X34C86IvWL2nn
         4k6SFh3VLnUu4LvtlXYHtt3HgwAwxOKw+YUiMkNpfCP4Pi++ZKanS0PDKAFVOO9n3wyn
         dgXg==
X-Gm-Message-State: AO0yUKXgBVm1qnES5WtI/8QheG4xFxu1LYXHkzYErRb6cfPUXTmtk86V
        FoAf3oqCG9DJmy+dRpJSbSEClmvmthIUaoPS2Sk=
X-Google-Smtp-Source: AK7set8DS3KmQgRHd9Haw4ErlzSs7ax3L9hAwlXDLIAnt3/OJeF6VDEby4seK8eHpwRtajlTvxiZGrqhl4rUsUWJQQk=
X-Received: by 2002:a81:6a46:0:b0:52a:7c6b:ce14 with SMTP id
 f67-20020a816a46000000b0052a7c6bce14mr262793ywc.365.1675770817512; Tue, 07
 Feb 2023 03:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20230203182255.lqla3hsme6riy4w7@meerkat.local>
 <Y95BEaOGJy9uBHkG@coredump.intra.peff.net> <CAP8UFD1q7-XbX4C_NjyL7A-6n6Nc4MgSbUKnzQOiRyKRMtLv_w@mail.gmail.com>
 <20230206214101.fe6rismtfzv4k75n@meerkat.local>
In-Reply-To: <20230206214101.fe6rismtfzv4k75n@meerkat.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 7 Feb 2023 12:53:26 +0100
Message-ID: <CAP8UFD3VFt-9eXbcSDgXOYsCnj1-drjYS5c2dqhCDF9fPWSbJg@mail.gmail.com>
Subject: Re: The sad state of git.wiki.kernel.org
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2023 at 10:41 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Sat, Feb 04, 2023 at 03:03:16PM +0100, Christian Couder wrote:
> > > > # Should it be archived as a static site?
> > > >
> > > > It's possible to turn git.wiki.kernel.org into a static site with a large
> > > > header on every page that it contains historical archival information, with a
> > > > link to https://git-scm.com/doc
> > >
> > > This would be my preference, just because some of the old content may
> > > still have value. Some pages (like old gsoc stuff) would better redirect
> > > to git.github.io, but it is probably not worth the time to even try to
> > > classify pages.
> >
> > This would be my preference too. I agree that some old content might
> > still have some value. We could also move or redirect some old content
> > to git.github.io, but I am not sure it's worth the time either.
>
> Okay, here's what I have:
>
> https://archive.kernel.org/oldwiki/git.wiki.kernel.org/
>
> It's just a static scrape excluding all Special: and User: pages, and carrying
> a very large "OBSOLETE CONTENT" warning.
>
> The idea is that requests to git.wiki.kernel.org will be redirected to the
> archive pages and thus hopefully preserve the content for historical reasons.
>
> Unless someone objects within the next few days, I'll proceed with this plan.

Great, thanks!
